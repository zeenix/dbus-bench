#!/usr/bin/env python3
r"""Compare D-Bus message brokers with the ``dbus-bench`` client.

``dbus-bench`` connects to the bus named by ``$DBUS_SESSION_BUS_ADDRESS`` and hammers it with
method calls that each carry a 16 KiB byte array: first through one service/client pair (1000
calls), then through 20 pairs at once. It prints how long each phase took::

    Hammering using a single client took 211.73473ms
    Hammering using 20 simultaneous clients took 2.725486666s

This script starts each broker you name on a private socket, runs the client against it once,
stops the broker and records the two durations together with what the broker cost (CPU time and
peak memory). That is repeated for ``--rounds`` rounds. Within a round the brokers run in a random
order (reshuffled every round, reproducibly from ``--seed``), so that drift of the machine hits all
of them alike. Every run gets a fresh broker process. The ``--warmup`` rounds run first and are
left out of the tables (the JSON file still holds them, flagged).

Usage (build the client and the brokers in release mode first)::

    scripts/compare-brokers.py --bench target/release/dbus-bench --rounds 15 --out results.json \
        --broker busd "/path/to/busd --address {address}" \
        --broker busd-1thread "TOKIO_WORKER_THREADS=1 /path/to/busd --address {address}" \
        --broker dbus-daemon "dbus-daemon --session --nofork --address={address}" \
        --broker dbus-broker "systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS={address} \
            -l {path} dbus-broker-launch --scope user"

A broker command is split into words the way a shell would (``shlex``) but never run by one: the
broker is a direct child of this script, which lets the script read its resource usage when it
reaps it. ``{address}`` in a word becomes ``unix:path=<socket>`` and ``{path}`` the socket's path
alone, and words before the program that look like ``VAR=value`` are environment variables for
that broker alone.

dbus-broker only runs under its launcher, which takes the socket to listen on from systemd's socket
activation, as ``systemd-socket-activate`` hands it over, and connects to the bus it launches
through ``$DBUS_SESSION_BUS_ADDRESS``. ``systemd-socket-activate`` passes no environment variable
on but those given with ``-E``, and without that one the launcher would connect to the session bus
of the desktop instead. It logs to the journal.

A broker may run as more than one process: dbus-broker's launcher starts the broker proper as a
process of its own. The CPU time, peak memory and context switches recorded for a broker cover all
of its processes. This script makes itself their subreaper, so that the ones a stopped broker
leaves behind come to it, to be reaped and counted, rather than to init.

Each run: start the broker; wait until it answers a D-Bus authentication (``AUTH EXTERNAL``) on its
socket, which a broker that starts on its first connection, as dbus-broker does under socket
activation, only does once it runs; run the client and parse its two lines; read the broker's peak
memory; stop the broker with SIGINT (SIGKILL after 5 seconds) and reap all of its processes; remove
the temporary directory that held its socket.

Recorded per run (``runs`` in the JSON file). The tables cover single_s, multi_s, broker_cpu_s,
broker_maxrss_kib, client_cpu_s, multi_broker_cpu_s and multi_client_cpu_s:

    single_s, multi_s   the two durations the client printed, in seconds
    broker_cpu_s        the broker's user + system CPU time over its whole life (also given as
                        broker_user_s and broker_sys_s), from wait4() of each of its processes. It
                        includes start-up and shutdown, which are small next to a run. A
                        multi-threaded broker can use more CPU time than the run takes.
    broker_maxrss_kib   the broker's peak resident memory, VmHWM in /proc/PID/status, read once
                        the client has finished, and summed over its processes if it has more
                        than one. wait4() reports a peak too
                        (broker_ru_maxrss_kib), but not a usable one: Linux carries the peak
                        of the process image from before exec() over to the new program, so it
                        never falls below this script's own peak (over 10 MiB) and every small
                        broker looks alike.
    client_wall_s       wall time of the whole client process, start-up included
    client_cpu_s        the client's user + system CPU time, from getrusage(RUSAGE_CHILDREN)
                        before and after it runs. Next to client_wall_s, it tells whether the
                        client was busy all along or waited for the broker.
    multi_broker_cpu_s, the CPU time the broker and the client used during the multi-client
    multi_client_cpu_s  phase alone, from /proc/PID/stat as the client prints the timing of
                        each phase. They are counted in clock ticks (usually 10 ms each).
    client_vcsw,        how many times the client and the broker gave up the CPU to wait
    broker_vcsw         (voluntary context switches): each is a wait that found nothing to do,
                        so a process that is handed its messages in bigger batches waits less.
    broker_exit         the broker's exit status, negative if a signal killed it (busd exits 0
                        on SIGINT, dbus-daemon is killed by it: -2)

Diagnosis: ``--strace-dir DIR`` attaches ``strace -c -f`` to the broker during every measured run
and leaves its system call summary in DIR/<label>-round<k>.txt (``k`` counts the rounds from 0,
warmup rounds included). Tracing slows the broker down a lot, so the timings and CPU times of such
runs are distorted: use it to see which system calls dominate, not to compare brokers.

Output: a progress line per run goes to stderr, Markdown tables of the measured runs go to stdout,
and ``--out`` writes everything as JSON (machine, settings, every run, failures, summary). Each
``--meta KEY=VALUE``, such as the version of a broker, goes into the JSON and the output too. A
run that fails (the broker exits early, the client fails, a timing line is missing, ...) is
reported on stderr and listed under ``failures`` in the JSON. The other runs go on, the tables
count only the runs that worked (column ``n``) and the exit status is 1. Interrupting with Ctrl-C
cleans up and reports the runs finished so far (exit status 130).

Needs Linux (``/proc``, ``wait4``, ``prctl``), Python 3.9 or later and, for ``--strace-dir``,
``strace``.
For numbers worth comparing keep the machine otherwise idle.
"""

from __future__ import annotations

import argparse
import contextlib
import ctypes
import json
import os
import platform
import random
import re
import resource
import shlex
import shutil
import signal
import socket
import statistics
import subprocess
import sys
import tempfile
import threading
import time
from dataclasses import asdict, dataclass
from datetime import datetime, timezone

READY_TIMEOUT = 10.0  # seconds a broker gets to start listening
ATTACH_TIMEOUT = 5.0  # seconds strace gets to attach to a broker
STOP_TIMEOUT = 5.0  # seconds a broker gets to exit after SIGINT, and again after SIGKILL
CLIENT_TIMEOUT = 600.0  # seconds the client gets to finish
TICK = 0.01  # seconds between two checks while waiting for something
CLOCK_TICKS = os.sysconf("SC_CLK_TCK")  # the unit of the CPU times in /proc/PID/stat

# What the tables and the summary cover: (field of Run, unit, digits after the decimal point).
METRICS = [
    ("single_s", "seconds", 3),
    ("multi_s", "seconds", 3),
    ("broker_cpu_s", "seconds", 3),
    ("broker_maxrss_kib", "KiB", 0),
    ("client_cpu_s", "seconds", 3),
    ("multi_broker_cpu_s", "seconds", 3),
    ("multi_client_cpu_s", "seconds", 3),
]

# Rust's Debug output of a Duration: 211.73473ms, 2.725486666s, 1.5<micro sign>s, 800ns. The Greek
# mu and a plain "us" are accepted for the micro sign.
SECONDS_PER = {"s": 1.0, "ms": 1e-3, "\u00b5s": 1e-6, "\u03bcs": 1e-6, "us": 1e-6, "ns": 1e-9}
DURATION = r"(\d+(?:\.\d+)?)(ms|[\u00b5\u03bc]s|us|ns|s)"
SINGLE_LINE = re.compile(rf"^Hammering using a single client took {DURATION}\s*$", re.M)
MULTI_LINE = re.compile(rf"^Hammering using \d+ simultaneous clients took {DURATION}\s*$", re.M)
ENV_WORD = re.compile(r"[A-Za-z_][A-Za-z0-9_]*=")


class RunError(Exception):
    """A run failed; the message says why."""


@dataclass
class ClientRun:
    """What one run of the client measured."""

    single_s: float
    multi_s: float
    wall_s: float
    cpu_s: float
    vcsw: int
    multi_cpu_s: float | None
    broker_multi_cpu_s: float | None


@dataclass
class Run:
    label: str
    round: int  # counted from 0, warmup rounds included
    warmup: bool
    single_s: float
    multi_s: float
    client_wall_s: float
    client_cpu_s: float
    client_vcsw: int
    multi_client_cpu_s: float | None  # None if /proc could not tell
    multi_broker_cpu_s: float | None
    broker_user_s: float
    broker_sys_s: float
    broker_cpu_s: float
    broker_vcsw: int
    broker_maxrss_kib: int | None  # VmHWM from /proc, None if that could not be read
    broker_ru_maxrss_kib: int  # ru_maxrss from wait4(): see the module docstring
    broker_exit: int


def log(message: str) -> None:
    print(message, file=sys.stderr, flush=True)


def tail(text: str, size: int = 1000) -> str:
    return text.strip()[-size:]


def read_tail(path: str) -> str:
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            return tail(f.read())
    except OSError:
        return ""


class Broker:
    """A broker process, reaped with wait4() so that its resource usage is not lost.

    Popen's poll(), wait(), kill() and send_signal() are never called on it: each of them may
    reap the process without keeping its rusage.
    """

    def __init__(self, argv: list[str], env: dict[str, str], log_path: str):
        self.log_path = log_path
        self.status: int | None = None  # exit status once reaped, negative for a signal
        self.rusage = None
        # The resource usage of the processes the broker started that it left to this script to
        # reap, as their subreaper, once it was gone.
        self.orphan_rusages: list = []
        try:
            with open(log_path, "wb") as logfile:
                self.proc = subprocess.Popen(
                    argv, env=env, stdin=subprocess.DEVNULL, stdout=logfile,
                    stderr=subprocess.STDOUT,
                    start_new_session=True,  # a Ctrl-C reaches this script only, which cleans up
                )
        except OSError as e:
            raise RunError(f"cannot start {argv[0]}: {e}") from e
        self.pid = self.proc.pid

    def exited(self) -> bool:
        """Reap the broker if it has exited (without waiting for it) and say whether it has."""
        if self.rusage is None:
            pid, status, rusage = os.wait4(self.pid, os.WNOHANG)
            if pid:
                self.status = os.waitstatus_to_exitcode(status)
                self.proc.returncode = self.status  # so that Popen does not try to reap it too
                self.rusage = rusage
        return self.rusage is not None

    def wait_ready(self, sock_path: str) -> None:
        """Wait until the broker answers a D-Bus authentication on its socket."""
        # The EXTERNAL mechanism, with our uid in hex-encoded ASCII, as every D-Bus client on a
        # unix-domain socket starts. A broker that serves the connection answers it with "OK".
        auth = b"\0AUTH EXTERNAL " + str(os.getuid()).encode().hex().encode() + b"\r\n"
        deadline = time.monotonic() + READY_TIMEOUT
        while True:
            if self.exited():
                raise RunError(f"broker exited (status {self.status}) before it was ready:\n"
                               f"{read_tail(self.log_path)}")
            try:
                with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
                    s.settimeout(max(TICK, deadline - time.monotonic()))
                    s.connect(sock_path)
                    s.sendall(auth)
                    if s.recv(256).startswith(b"OK "):
                        return
            except OSError:
                pass
            if time.monotonic() > deadline:
                raise RunError(f"broker not ready after {READY_TIMEOUT:g}s:\n"
                               f"{read_tail(self.log_path)}")
            time.sleep(TICK)

    def processes(self) -> list[int]:
        """The broker's processes that are alive: its own, and those it started."""
        return [self.pid, *descendants(self.pid)]

    def peak_rss_kib(self) -> int | None:
        """The broker's peak resident memory so far (VmHWM), summed over its processes."""
        peaks = [peak_rss_kib(pid) for pid in self.processes()]
        if peaks[0] is None:
            return None
        return sum(peak for peak in peaks if peak is not None)

    def stop(self, signals=(signal.SIGINT, signal.SIGKILL)) -> None:
        """Send the signals one at a time, until the broker has exited and been reaped.

        Then reap the processes it started that it left behind, which come to this script as
        their subreaper, killing those that do not follow it within the time it was given. Those
        are the broker's descendants as found while it still ran, and whatever is left in its
        process group, the broker's own, as start_new_session made it. A broker that exited before
        this was called has no descendants left to find, as this script adopted them, but they
        are still in its process group.
        """
        orphans = set(descendants(self.pid)) if not self.exited() else set()
        for sig in signals:
            if self.exited():
                break
            os.kill(self.pid, sig)
            deadline = time.monotonic() + STOP_TIMEOUT
            while not self.exited() and time.monotonic() < deadline:
                time.sleep(TICK)
        if not self.exited():
            raise RunError(f"broker (pid {self.pid}) would not exit")
        deadline = time.monotonic() + STOP_TIMEOUT
        while True:
            # A process that is gone is dropped for good, so that a new one that gets its pid
            # later is left alone.
            orphans = {pid for pid in orphans if proc_stat(pid)}
            left = orphans | set(group_members(self.pid))
            if not left:
                return
            if time.monotonic() > deadline + STOP_TIMEOUT:
                raise RunError(f"processes {sorted(left)} of the broker would not go")
            for pid in left:
                try:
                    reaped, _, rusage = os.wait4(pid, os.WNOHANG)
                except ChildProcessError:
                    # Not this script's child: its parent reaps it, or, once that parent is gone,
                    # it comes to this script as their subreaper.
                    reaped = 0
                if reaped:
                    self.orphan_rusages.append(rusage)
                    orphans.discard(pid)
                elif time.monotonic() > deadline:
                    try:
                        os.kill(pid, signal.SIGKILL)
                    except ProcessLookupError:
                        pass
            time.sleep(TICK)

    def usage(self) -> tuple[float, float, int, int]:
        """User and system CPU time, voluntary context switches and wait4()'s peak memory, of
        the broker and of every process of its that was reaped."""
        rusages = [self.rusage, *self.orphan_rusages]
        return (
            sum(ru.ru_utime for ru in rusages), sum(ru.ru_stime for ru in rusages),
            sum(ru.ru_nvcsw for ru in rusages), max(ru.ru_maxrss for ru in rusages),
        )

    def __enter__(self) -> Broker:
        return self

    def __exit__(self, *_) -> None:
        self.stop((signal.SIGKILL,))  # a no-op when the run stopped it already


def proc_stat(pid: int) -> list[str] | None:
    """The fields of /proc/PID/stat after the command name, None if there is no such process."""
    try:
        with open(f"/proc/{pid}/stat") as f:
            # The command name, in parentheses, can hold anything: count the fields after it.
            return f.read().rpartition(")")[2].split()
    except OSError:
        return None


def descendants(pid: int) -> list[int]:
    """The live processes that the process `pid` started, and that those started, and so on."""
    children: dict[int, list[int]] = {}
    for entry in os.listdir("/proc"):
        fields = proc_stat(int(entry)) if entry.isdigit() else None
        if fields:
            # The parent's pid is the 4th field, the 2nd after the command name.
            children.setdefault(int(fields[1]), []).append(int(entry))
    found, todo = [], [pid]
    while todo:
        for child in children.get(todo.pop(), []):
            found.append(child)
            todo.append(child)
    return found


def group_members(pgid: int) -> list[int]:
    """The processes, zombies included, whose process group is `pgid`."""
    members = []
    for entry in os.listdir("/proc"):
        fields = proc_stat(int(entry)) if entry.isdigit() else None
        # The process group is the 5th field, the 3rd after the command name.
        if fields and int(fields[2]) == pgid:
            members.append(int(entry))
    return members


def peak_rss_kib(pid: int) -> int | None:
    """The peak resident memory of a process so far (VmHWM), None if /proc does not say."""
    try:
        with open(f"/proc/{pid}/status") as f:
            for line in f:
                if line.startswith("VmHWM:"):
                    return int(line.split()[1])
    except OSError:
        pass
    return None


def tracer_of(path: str) -> int:
    """The tracer pid of a /proc/PID/task/TID/status file, 0 if there is none."""
    with open(path) as f:
        for line in f:
            if line.startswith("TracerPid:"):
                return int(line.split()[1])
    return 0


def traced(pids: list[int]) -> bool:
    """Whether every thread of the processes has a tracer."""
    try:
        return all(tracer_of(f"/proc/{pid}/task/{tid}/status")
                   for pid in pids for tid in os.listdir(f"/proc/{pid}/task"))
    except OSError:
        return False


class Tracer:
    """``strace -c -f`` attached to a broker; its summary is written once it is stopped."""

    def __init__(self, pids: list[int], out_path: str, log_path: str):
        self.out_path, self.log_path = out_path, log_path
        attach = [arg for pid in pids for arg in ("-p", str(pid))]
        with open(log_path, "wb") as logfile:
            self.proc = subprocess.Popen(
                ["strace", "-c", "-f", *attach, "-o", out_path],
                stdin=subprocess.DEVNULL, stdout=logfile, stderr=logfile, start_new_session=True,
            )
        try:  # the client must not start before strace is attached, or it would miss the start
            deadline = time.monotonic() + ATTACH_TIMEOUT
            while not traced(pids):
                if self.proc.poll() is not None:
                    raise RunError(f"strace exited (status {self.proc.returncode}) instead of "
                                   f"attaching:\n{read_tail(log_path)}")
                if time.monotonic() > deadline:
                    raise RunError(f"strace did not attach within {ATTACH_TIMEOUT:g}s:\n"
                                   f"{read_tail(log_path)}")
                time.sleep(TICK)
        except BaseException:
            self.interrupt()
            raise

    def interrupt(self) -> None:
        """SIGINT makes strace detach and write its summary: wait until it is done."""
        if self.proc.poll() is None:
            self.proc.send_signal(signal.SIGINT)
            try:
                self.proc.wait(timeout=60)
            except subprocess.TimeoutExpired:
                self.proc.kill()
                self.proc.wait()

    def stop(self) -> None:
        self.interrupt()
        if not os.path.isfile(self.out_path) or os.path.getsize(self.out_path) == 0:
            raise RunError(f"strace left no summary:\n{read_tail(self.log_path)}")

    def __enter__(self) -> Tracer:
        return self

    def __exit__(self, *_) -> None:
        self.interrupt()


def split_command(command: str, path: str) -> tuple[dict[str, str], list[str]]:
    """Split a broker command into the environment variables before the program, and argv."""
    address = f"unix:path={path}"
    words = [word.replace("{address}", address).replace("{path}", path)
             for word in shlex.split(command)]
    env = {}
    while words and ENV_WORD.match(words[0]):
        name, _, value = words.pop(0).partition("=")
        env[name] = value
    return env, words


def run_client(bench: str, address: str, broker: Broker, log_path: str) -> ClientRun:
    """Run the client once, and measure it and the broker while it runs."""
    env = {**os.environ, "DBUS_SESSION_BUS_ADDRESS": address}
    # The client is the only child reaped in between, so the difference is its own usage.
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    start = time.perf_counter()
    with open(log_path, "wb") as stderr:
        client = subprocess.Popen(
            [bench], env=env, stdin=subprocess.DEVNULL, stdout=subprocess.PIPE, stderr=stderr,
            encoding="utf-8", errors="replace",
        )
    watchdog = threading.Timer(CLIENT_TIMEOUT, client.kill)
    watchdog.start()
    output = []
    # The CPU times of the client and of the broker as each phase ends, as the client prints its
    # timing line: the multi-client phase starts right after the single-client line.
    marks = {}
    try:
        for line in client.stdout:
            output.append(line)
            for phase, pattern in (("single", SINGLE_LINE), ("multi", MULTI_LINE)):
                if pattern.match(line):
                    marks[phase] = (cpu_seconds(client.pid), cpu_seconds(broker.pid))
        client.wait()
    finally:
        watchdog.cancel()
        if client.poll() is None:
            client.kill()
            client.wait()
    wall = time.perf_counter() - start
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    stdout = "".join(output)
    if wall >= CLIENT_TIMEOUT:
        raise RunError(f"client still running after {CLIENT_TIMEOUT:g}s")
    if client.returncode != 0:
        raise RunError(f"client exited with status {client.returncode}:\n"
                       f"{read_tail(log_path)}\nbroker log:\n{read_tail(broker.log_path)}")
    durations = []
    for what, pattern in (("single-client", SINGLE_LINE), ("multi-client", MULTI_LINE)):
        match = pattern.search(stdout)
        if not match:
            raise RunError(f"no {what} timing line in the client's output:\n{tail(stdout)}")
        durations.append(float(match[1]) * SECONDS_PER[match[2]])
    multi = [None, None]
    if "single" in marks and "multi" in marks:
        multi = [None if a is None or b is None else b - a
                 for a, b in zip(marks["single"], marks["multi"])]
    return ClientRun(
        single_s=durations[0], multi_s=durations[1], wall_s=wall,
        cpu_s=(after.ru_utime - before.ru_utime) + (after.ru_stime - before.ru_stime),
        vcsw=after.ru_nvcsw - before.ru_nvcsw, multi_cpu_s=multi[0],
        broker_multi_cpu_s=multi[1],
    )


def cpu_seconds(pid: int) -> float | None:
    """The CPU time (user + system) that a process and those it started have used so far.

    That is the time of each of them that is alive, its threads included, and of those that one of
    them reaped, which /proc gives as its children's time.
    """
    total = 0
    for process in [pid, *descendants(pid)]:
        fields = proc_stat(process)
        if fields is None:
            if process == pid:
                return None
            continue
        # utime, stime, cutime and cstime are the 14th to 17th fields, the 12th to 15th after
        # the command name.
        total += sum(int(field) for field in fields[11:15])
    return total / CLOCK_TICKS


def run_once(label: str, command: str, bench: str, rnd: int, warmup: bool,
             strace_dir: str | None) -> Run:
    """Start a broker, run the client against it once and stop the broker."""
    tmp = tempfile.mkdtemp(prefix="dbus-bench-")
    try:
        sock = os.path.join(tmp, "bus")
        address = f"unix:path={sock}"
        env, argv = split_command(command, sock)
        with contextlib.ExitStack() as stack:  # on any exit: strace first, then the broker
            broker = stack.enter_context(
                Broker(argv, {**os.environ, **env}, os.path.join(tmp, "broker.log")))
            broker.wait_ready(sock)
            tracer = None
            if strace_dir and not warmup:
                name = re.sub(r"[^A-Za-z0-9._+-]", "_", label)
                tracer = stack.enter_context(Tracer(
                    broker.processes(), os.path.join(strace_dir, f"{name}-round{rnd}.txt"),
                    os.path.join(tmp, "strace.log")))
            client = run_client(bench, address, broker, os.path.join(tmp, "client.log"))
            peak_kib = broker.peak_rss_kib()
            if tracer:
                tracer.stop()  # detach and write the summary before the broker goes away
            broker.stop()
        user, system, vcsw, ru_maxrss = broker.usage()
        return Run(
            label=label, round=rnd, warmup=warmup, single_s=client.single_s,
            multi_s=client.multi_s, client_wall_s=client.wall_s, client_cpu_s=client.cpu_s,
            client_vcsw=client.vcsw, multi_client_cpu_s=client.multi_cpu_s,
            multi_broker_cpu_s=client.broker_multi_cpu_s, broker_user_s=user,
            broker_sys_s=system, broker_cpu_s=user + system, broker_vcsw=vcsw,
            broker_maxrss_kib=peak_kib, broker_ru_maxrss_kib=ru_maxrss,
            broker_exit=broker.status,
        )
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def describe(values: list[float]) -> dict:
    n = len(values)
    return {
        "n": n,
        "mean": statistics.fmean(values) if n else None,
        "stddev": statistics.stdev(values) if n > 1 else None,  # sample standard deviation
        "median": statistics.median(values) if n else None,
        "min": min(values) if n else None,
        "max": max(values) if n else None,
    }


def summarize(runs: list[Run], labels: list[str]) -> dict:
    """Per metric and broker, the statistics of the measured (not warmup) runs."""
    summary = {}
    for field, _unit, _digits in METRICS:
        summary[field] = {}
        for label in labels:
            values = [getattr(run, field) for run in runs if run.label == label and not run.warmup]
            summary[field][label] = describe([v for v in values if v is not None])
    return summary


def print_tables(summary: dict, labels: list[str]) -> None:
    for field, unit, digits in METRICS:
        print(f"\n### {field} ({unit})\n")
        print("| broker | n | mean | stddev | median | min | max |")
        print("|---|---:|---:|---:|---:|---:|---:|")
        for label in labels:
            stats = summary[field][label]
            cells = [
                "-" if stats[key] is None else f"{stats[key]:.{digits}f}"
                for key in ("mean", "stddev", "median", "min", "max")
            ]
            print(f"| {label} | {stats['n']} | " + " | ".join(cells) + " |")


def cpu_model() -> str:
    try:
        with open("/proc/cpuinfo", encoding="utf-8", errors="replace") as f:
            for line in f:
                if line.startswith("model name"):
                    return line.partition(":")[2].strip()
    except OSError:
        pass
    return platform.processor() or platform.machine()


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--bench", required=True, metavar="PATH", help="the dbus-bench client binary")
    p.add_argument("--broker", nargs=2, action="append", required=True,
                   metavar=("LABEL", "COMMAND"),
                   help="a broker to compare, repeat for each; {address} in COMMAND stands for "
                        "unix:path=SOCKET, and {path} for SOCKET")
    p.add_argument("--rounds", type=int, default=15, help="measured rounds (default: %(default)s)")
    p.add_argument("--warmup", type=int, default=1,
                   help="rounds run first and left out of the tables (default: %(default)s)")
    p.add_argument("--seed", type=int, default=0,
                   help="seed of the per-round shuffle of the brokers (default: %(default)s)")
    p.add_argument("--out", metavar="PATH", help="write the runs and the summary here, as JSON")
    p.add_argument("--meta", action="append", default=[], metavar="KEY=VALUE",
                   help="a note to keep with the results, such as the version of a broker")
    p.add_argument("--strace-dir", metavar="DIR",
                   help="diagnosis: leave an strace -c summary of each measured run here")
    args = p.parse_args()

    if args.rounds < 1 or args.warmup < 0:
        p.error("--rounds must be at least 1 and --warmup at least 0")
    bench = shutil.which(args.bench)
    if bench is None:
        p.error("--bench is not an executable file")
    args.bench = os.path.abspath(bench)
    labels = [label for label, _ in args.broker]
    if len(set(labels)) != len(labels):
        p.error("the broker labels must be different from each other")
    for label, command in args.broker:
        if "{address}" not in command and "{path}" not in command:
            p.error(f"the command of broker {label!r} has neither {{address}} nor {{path}}")
        try:
            argv = split_command(command, "/x")[1]
        except ValueError as e:
            p.error(f"the command of broker {label!r} cannot be split: {e}")
        if not argv or not shutil.which(argv[0]):
            p.error(f"the command of broker {label!r} does not name a program that can be run")
    if args.strace_dir and not shutil.which("strace"):
        p.error("--strace-dir needs strace, which was not found")
    meta = {}
    for note in args.meta:
        key, sep, value = note.partition("=")
        if not sep or not key:
            p.error(f"--meta {note!r} is not of the form KEY=VALUE")
        meta[key] = value
    args.meta = meta
    return args


def become_subreaper() -> None:
    """Have the processes that a broker leaves behind as it stops come to this script, rather than
    to init, so that they get reaped and their resource usage counted."""
    libc = ctypes.CDLL(None, use_errno=True)
    pr_set_child_subreaper = 36  # from <linux/prctl.h>
    if libc.prctl(pr_set_child_subreaper, 1, 0, 0, 0) != 0:
        errno = ctypes.get_errno()
        raise OSError(errno, f"prctl(PR_SET_CHILD_SUBREAPER): {os.strerror(errno)}")


def main() -> int:
    args = parse_args()
    become_subreaper()
    for sig in (signal.SIGINT, signal.SIGTERM, signal.SIGHUP):
        # Make each of them a KeyboardInterrupt, so that the brokers get cleaned up, but leave
        # alone what was ignored on purpose (nohup ignores SIGHUP). SIGINT is taken regardless:
        # a start in the background leaves it ignored, the brokers would inherit that and not
        # stop on the SIGINT that is meant to stop them.
        if sig == signal.SIGINT or signal.getsignal(sig) != signal.SIG_IGN:
            signal.signal(sig, signal.default_int_handler)
    if args.strace_dir:
        args.strace_dir = os.path.abspath(args.strace_dir)
        os.makedirs(args.strace_dir, exist_ok=True)
        log("warning: --strace-dir is on: strace slows the brokers down, so the timings and CPU\n"
            "times of the measured runs are distorted. Use them to see system calls only.")
    if args.out:
        os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)

    brokers = [(label, command) for label, command in args.broker]
    labels = [label for label, _ in brokers]
    machine = {"nproc": os.cpu_count(), "cpu_model": cpu_model(), "kernel": platform.release()}
    started = datetime.now(timezone.utc).isoformat(timespec="seconds")
    runs: list[Run] = []
    failures: list[dict] = []
    total = (args.warmup + args.rounds) * len(brokers)
    interrupted = False
    try:
        for rnd in range(args.warmup + args.rounds):
            order = list(brokers)
            random.Random(args.seed + rnd).shuffle(order)  # reproducible, differs per round
            for label, command in order:
                warmup = rnd < args.warmup
                position = f"[{len(runs) + len(failures) + 1}/{total}] round {rnd} {label}"
                try:
                    run = run_once(label, command, args.bench, rnd, warmup, args.strace_dir)
                except RunError as e:
                    failures.append({"label": label, "round": rnd, "warmup": warmup,
                                     "error": str(e)})
                    log(f"{position}: FAILED: {e}")
                    continue
                runs.append(run)
                log(f"{position}: single {run.single_s:.3f}s multi {run.multi_s:.3f}s "
                    f"broker cpu {run.broker_cpu_s:.2f}s rss {run.broker_maxrss_kib} KiB "
                    f"exit {run.broker_exit}" + (" (warmup)" if warmup else ""))
    except KeyboardInterrupt:
        interrupted = True
        log("interrupted: reporting the runs that finished")

    summary = summarize(runs, labels)
    if args.out:  # before the tables, so that a closed stdout cannot lose it
        config = {
            "brokers": [{"label": label, "command": command} for label, command in brokers],
            "bench": args.bench, "rounds": args.rounds, "warmup": args.warmup,
            "seed": args.seed, "strace_dir": args.strace_dir, "meta": args.meta,
        }
        with open(args.out, "w", encoding="utf-8") as f:
            json.dump({"machine": machine, "config": config, "started": started,
                       "runs": [asdict(run) for run in runs], "failures": failures,
                       "summary": summary}, f, indent=2)
            f.write("\n")
    print(f"rounds: {args.rounds} measured after {args.warmup} warmup; {machine['nproc']} CPUs, "
          f"{machine['cpu_model']}")
    for key, value in args.meta.items():
        print(f"{key}: {value}")
    print_tables(summary, labels)
    if failures:
        log(f"{len(failures)} run(s) failed (see above); the tables leave them out")
    return 130 if interrupted else 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
