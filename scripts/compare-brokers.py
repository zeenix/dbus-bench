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
        --broker dbus-daemon "dbus-daemon --session --nofork --address={address}"

A broker command is split into words the way a shell would (``shlex``) but never run by one: the
broker is a direct child of this script, which lets the script read its resource usage when it
reaps it. ``{address}`` in a word becomes ``unix:path=<socket>``, and words before the program
that look like ``VAR=value`` are environment variables for that broker alone.

Each run: start the broker; wait until it accepts connections; run the client and parse its two
lines; read the broker's peak memory; stop the broker with SIGINT (SIGKILL after 5 seconds) and
reap it; remove the temporary directory that held its socket.

Recorded per run (``runs`` in the JSON file). The tables cover single_s, multi_s, broker_cpu_s,
broker_maxrss_kib and client_cpu_s:

    single_s, multi_s   the two durations the client printed, in seconds
    broker_cpu_s        the broker's user + system CPU time over its whole life (also given as
                        broker_user_s and broker_sys_s), from wait4(). It includes start-up and
                        shutdown, which are small next to a run. A multi-threaded broker can use
                        more CPU time than the run takes.
    broker_maxrss_kib   the broker's peak resident memory, VmHWM in /proc/PID/status, read once
                        the client has finished. wait4() reports a peak too
                        (broker_ru_maxrss_kib), but not a usable one: Linux carries the peak
                        of the process image from before exec() over to the new program, so it
                        never falls below this script's own peak (over 10 MiB) and every small
                        broker looks alike.
    client_wall_s       wall time of the whole client process, start-up included
    client_cpu_s        the client's user + system CPU time, from getrusage(RUSAGE_CHILDREN)
                        before and after it runs. Next to client_wall_s, it tells whether the
                        client was busy all along or waited for the broker.
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
and ``--out`` writes everything as JSON (machine, settings, every run, failures, summary). A run
that fails (the broker exits early, the client fails, a timing line is missing, ...) is reported
on stderr and listed under ``failures`` in the JSON. The other runs go on, the tables count only
the runs that worked (column ``n``) and the exit status is 1. Interrupting with Ctrl-C cleans up
and reports the runs finished so far (exit status 130).

Needs Linux (``/proc``, ``wait4``), Python 3.9 or later and, for ``--strace-dir``, ``strace``.
For numbers worth comparing keep the machine otherwise idle.
"""

from __future__ import annotations

import argparse
import contextlib
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
import time
from dataclasses import asdict, dataclass
from datetime import datetime, timezone

READY_TIMEOUT = 10.0  # seconds a broker gets to start listening
ATTACH_TIMEOUT = 5.0  # seconds strace gets to attach to a broker
STOP_TIMEOUT = 5.0  # seconds a broker gets to exit after SIGINT, and again after SIGKILL
CLIENT_TIMEOUT = 600.0  # seconds the client gets to finish
TICK = 0.01  # seconds between two checks while waiting for something

# What the tables and the summary cover: (field of Run, unit, digits after the decimal point).
METRICS = [
    ("single_s", "seconds", 3),
    ("multi_s", "seconds", 3),
    ("broker_cpu_s", "seconds", 3),
    ("broker_maxrss_kib", "KiB", 0),
    ("client_cpu_s", "seconds", 3),
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
class Run:
    label: str
    round: int  # counted from 0, warmup rounds included
    warmup: bool
    single_s: float
    multi_s: float
    client_wall_s: float
    client_cpu_s: float
    client_vcsw: int
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
        """Wait until the broker accepts connections on its socket."""
        deadline = time.monotonic() + READY_TIMEOUT
        while True:
            if self.exited():
                raise RunError(f"broker exited (status {self.status}) before it listened:\n"
                               f"{read_tail(self.log_path)}")
            try:
                with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
                    s.connect(sock_path)  # works only once the broker listens on the path
                return
            except OSError:
                if time.monotonic() > deadline:
                    raise RunError(f"broker not listening after {READY_TIMEOUT:g}s:\n"
                                   f"{read_tail(self.log_path)}") from None
            time.sleep(TICK)

    def peak_rss_kib(self) -> int | None:
        """The broker's peak resident memory so far (VmHWM), None if /proc does not say."""
        try:
            with open(f"/proc/{self.pid}/status") as f:
                for line in f:
                    if line.startswith("VmHWM:"):
                        return int(line.split()[1])
        except OSError:
            pass
        return None

    def stop(self, signals=(signal.SIGINT, signal.SIGKILL)) -> None:
        """Send the signals one at a time, until the broker has exited and been reaped."""
        for sig in signals:
            if self.exited():
                return
            os.kill(self.pid, sig)
            deadline = time.monotonic() + STOP_TIMEOUT
            while not self.exited() and time.monotonic() < deadline:
                time.sleep(TICK)
        if not self.exited():
            raise RunError(f"broker (pid {self.pid}) would not exit")

    def __enter__(self) -> Broker:
        return self

    def __exit__(self, *_) -> None:
        self.stop((signal.SIGKILL,))  # a no-op when the run stopped it already


def tracer_of(path: str) -> int:
    """The tracer pid of a /proc/PID/task/TID/status file, 0 if there is none."""
    with open(path) as f:
        for line in f:
            if line.startswith("TracerPid:"):
                return int(line.split()[1])
    return 0


def traced(pid: int) -> bool:
    """Whether every thread of the process has a tracer."""
    try:
        return all(tracer_of(f"/proc/{pid}/task/{tid}/status")
                   for tid in os.listdir(f"/proc/{pid}/task"))
    except OSError:
        return False


class Tracer:
    """``strace -c -f`` attached to a broker; its summary is written once it is stopped."""

    def __init__(self, pid: int, out_path: str, log_path: str):
        self.out_path, self.log_path = out_path, log_path
        with open(log_path, "wb") as logfile:
            self.proc = subprocess.Popen(
                ["strace", "-c", "-f", "-p", str(pid), "-o", out_path],
                stdin=subprocess.DEVNULL, stdout=logfile, stderr=logfile, start_new_session=True,
            )
        try:  # the client must not start before strace is attached, or it would miss the start
            deadline = time.monotonic() + ATTACH_TIMEOUT
            while not traced(pid):
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


def split_command(command: str, address: str) -> tuple[dict[str, str], list[str]]:
    """Split a broker command into the environment variables before the program, and argv."""
    words = [word.replace("{address}", address) for word in shlex.split(command)]
    env = {}
    while words and ENV_WORD.match(words[0]):
        name, _, value = words.pop(0).partition("=")
        env[name] = value
    return env, words


def run_client(bench: str, address: str,
               broker: Broker) -> tuple[float, float, float, float, int]:
    """Run the client once.

    Return the two durations it printed, its wall time, its CPU time and how many voluntary
    context switches it made.
    """
    env = {**os.environ, "DBUS_SESSION_BUS_ADDRESS": address}
    # The client is the only child reaped in between, so the difference is its own usage.
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    start = time.perf_counter()
    try:
        done = subprocess.run(
            [bench], env=env, stdin=subprocess.DEVNULL, capture_output=True,
            encoding="utf-8", errors="replace", timeout=CLIENT_TIMEOUT,
        )
    except subprocess.TimeoutExpired:
        raise RunError(f"client still running after {CLIENT_TIMEOUT:g}s") from None
    wall = time.perf_counter() - start
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    cpu = (after.ru_utime - before.ru_utime) + (after.ru_stime - before.ru_stime)
    if done.returncode != 0:
        raise RunError(f"client exited with status {done.returncode}:\n{tail(done.stderr)}\n"
                       f"broker log:\n{read_tail(broker.log_path)}")
    durations = []
    for what, pattern in (("single-client", SINGLE_LINE), ("multi-client", MULTI_LINE)):
        match = pattern.search(done.stdout)
        if not match:
            raise RunError(f"no {what} timing line in the client's output:\n{tail(done.stdout)}")
        durations.append(float(match[1]) * SECONDS_PER[match[2]])
    return durations[0], durations[1], wall, cpu, after.ru_nvcsw - before.ru_nvcsw


def run_once(label: str, command: str, bench: str, rnd: int, warmup: bool,
             strace_dir: str | None) -> Run:
    """Start a broker, run the client against it once and stop the broker."""
    tmp = tempfile.mkdtemp(prefix="dbus-bench-")
    try:
        sock = os.path.join(tmp, "bus")
        address = f"unix:path={sock}"
        env, argv = split_command(command, address)
        with contextlib.ExitStack() as stack:  # on any exit: strace first, then the broker
            broker = stack.enter_context(
                Broker(argv, {**os.environ, **env}, os.path.join(tmp, "broker.log")))
            broker.wait_ready(sock)
            tracer = None
            if strace_dir and not warmup:
                name = re.sub(r"[^A-Za-z0-9._+-]", "_", label)
                tracer = stack.enter_context(Tracer(
                    broker.pid, os.path.join(strace_dir, f"{name}-round{rnd}.txt"),
                    os.path.join(tmp, "strace.log")))
            single, multi, wall, client_cpu, client_vcsw = run_client(bench, address, broker)
            peak_kib = broker.peak_rss_kib()
            if tracer:
                tracer.stop()  # detach and write the summary before the broker goes away
            broker.stop()
        ru = broker.rusage
        return Run(
            label=label, round=rnd, warmup=warmup, single_s=single, multi_s=multi,
            client_wall_s=wall, client_cpu_s=client_cpu, client_vcsw=client_vcsw,
            broker_user_s=ru.ru_utime, broker_sys_s=ru.ru_stime,
            broker_cpu_s=ru.ru_utime + ru.ru_stime, broker_vcsw=ru.ru_nvcsw,
            broker_maxrss_kib=peak_kib,
            broker_ru_maxrss_kib=ru.ru_maxrss, broker_exit=broker.status,
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
                        "unix:path=SOCKET")
    p.add_argument("--rounds", type=int, default=15, help="measured rounds (default: %(default)s)")
    p.add_argument("--warmup", type=int, default=1,
                   help="rounds run first and left out of the tables (default: %(default)s)")
    p.add_argument("--seed", type=int, default=0,
                   help="seed of the per-round shuffle of the brokers (default: %(default)s)")
    p.add_argument("--out", metavar="PATH", help="write the runs and the summary here, as JSON")
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
        if "{address}" not in command:
            p.error(f"the command of broker {label!r} lacks the {{address}} placeholder")
        try:
            argv = split_command(command, "unix:path=/x")[1]
        except ValueError as e:
            p.error(f"the command of broker {label!r} cannot be split: {e}")
        if not argv or not shutil.which(argv[0]):
            p.error(f"the command of broker {label!r} does not name a program that can be run")
    if args.strace_dir and not shutil.which("strace"):
        p.error("--strace-dir needs strace, which was not found")
    return args


def main() -> int:
    args = parse_args()
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
            "seed": args.seed, "strace_dir": args.strace_dir,
        }
        with open(args.out, "w", encoding="utf-8") as f:
            json.dump({"machine": machine, "config": config, "started": started,
                       "runs": [asdict(run) for run in runs], "failures": failures,
                       "summary": summary}, f, indent=2)
            f.write("\n")
    print(f"rounds: {args.rounds} measured after {args.warmup} warmup; {machine['nproc']} CPUs, "
          f"{machine['cpu_model']}")
    print_tables(summary, labels)
    if failures:
        log(f"{len(failures)} run(s) failed (see above); the tables leave them out")
    return 130 if interrupted else 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
