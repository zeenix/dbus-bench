#!/usr/bin/env python3
r"""Compare D-Bus message brokers by the latency of their messages, with a latency client.

This is compare-brokers.py for a client that measures latency: it starts each broker you name on a
private socket, runs the client against it once, stops the broker and records what the client
measured together with what the broker cost (CPU time and peak memory). That is repeated for
``--rounds`` rounds. Within a round the brokers run in a random order (reshuffled every round,
reproducibly from ``--seed``, the same order as compare-brokers.py makes), so that drift of the
machine hits all of them alike, and every run gets a fresh broker process. The ``--warmup`` rounds
run first and are left out of the tables (the JSON file still holds them, flagged). The brokers
are started, waited for, stopped and measured by the code of compare-brokers.py, which this script
loads: see its ``--help`` for how a broker command is written (``{address}`` and ``{path}``,
``VAR=value`` words before the program, dbus-broker under ``systemd-socket-activate``) and for
what its CPU time, peak memory and context switches mean.

Usage (build the client and the brokers in release mode first)::

    scripts/compare-latency.py --bench target/release/latency --rounds 15 --out latency.json \
        --broker busd "/path/to/busd --address {address}" \
        --broker busd-1thread "TOKIO_WORKER_THREADS=1 /path/to/busd --address {address}" \
        --broker dbus-daemon "dbus-daemon --session --nofork --address={address}"

The client is run with ``$DBUS_SESSION_BUS_ADDRESS`` set to the broker's address, no arguments
(it gets this script's environment, so settings can go through that) and a limit of 600 seconds,
and prints one JSON object on standard output: a member for each scenario it ran, with the
statistics of that scenario's latencies. Anything else it prints should go to standard error,
which is kept for the report of a failure::

    {"single_rtt": {"count": 10000, "elapsed_s": 0.91, "mean_us": 91.2, "p50_us": 88.0,
                    "p90_us": 101.5, "p99_us": 140.2, "p999_us": 310.8, "max_us": 1204.3},
     "multi_rtt": {...}, "fanout_delivery": {...}}

Each number of each scenario (any name will do, but a number it must be) becomes a metric
named ``<scenario>_<key>``, such as ``single_rtt_p99_us``.

Recorded per run (``runs`` in the JSON file, one flat object, so that paired-stats.py reads it):

    label, round, warmup   as in compare-brokers.py: rounds count from 0, warmup rounds included
    <scenario>_<key>       every number the client printed
    client_wall_s          wall time of the whole client process, start-up included
    client_cpu_s           the client's user + system CPU time
    broker_cpu_s           the broker's user + system CPU time over its whole life (also given as
                           broker_user_s and broker_sys_s), from wait4() of each of its processes
    broker_vcsw            the voluntary context switches of the broker
    broker_maxrss_kib      the broker's peak resident memory (VmHWM), read once the client has
                           finished, summed over its processes if it has more than one
    broker_exit            the broker's exit status, negative if a signal killed it

Output: a progress line per run goes to stderr, Markdown tables go to stdout and ``--out`` writes
everything as JSON in the shape of compare-brokers.py (machine, config, started, runs, failures,
summary; config also lists the scenarios). The tables show, per scenario and broker, the mean and
the median over the measured rounds of the median (p50), the 99th percentile (p99) and the
maximum latency of a run, in microseconds, then the broker's CPU time and peak memory and the
client's wall time. The summary has the statistics of every metric. Each ``--meta KEY=VALUE``,
such as the version of a broker, goes into the JSON and the output too. A run that fails (the
broker exits early, the client fails or prints something else than the JSON above, ...) is reported
on stderr and listed under ``failures`` in the JSON; the other runs go on, the tables count only the
runs that worked (column ``n``) and the exit status is 1. Interrupting with Ctrl-C cleans up and
reports the runs finished so far (exit status 130).

To tell whether a change of a broker moved a metric, give the JSON file to paired-stats.py, which
compares two labels round by round.

Needs Linux, Python 3.9 or later and compare-brokers.py next to this script. For numbers worth
comparing keep the machine otherwise idle.
"""

from __future__ import annotations

import argparse
import importlib.util
import json
import math
import os
import platform
import random
import resource
import shutil
import signal
import subprocess
import sys
import tempfile
import time
from datetime import datetime, timezone

# The percentiles that the tables show (a scenario's keys), and the columns of the last table.
TABLE_KEYS = ("p50_us", "p99_us", "max_us")
COST_FIELDS = (("broker_cpu_s", 3), ("broker_maxrss_kib", 0), ("client_wall_s", 3))
# The names of a run's own fields, which no metric of the client may take, and those of them that
# the summary leaves out.
RESERVED = {"label", "round", "warmup", "client_wall_s", "client_cpu_s", "broker_user_s",
            "broker_sys_s", "broker_cpu_s", "broker_vcsw", "broker_maxrss_kib", "broker_exit"}
NOT_SUMMARIZED = {"label", "round", "warmup", "broker_exit"}


def load_compare_brokers():
    """Load compare-brokers.py, next to this script, as a module (its name has a hyphen)."""
    path = os.path.join(os.path.dirname(os.path.realpath(__file__)), "compare-brokers.py")
    spec = importlib.util.spec_from_file_location("compare_brokers", path)
    if spec is None or spec.loader is None:
        sys.exit(f"{sys.argv[0]}: error: cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    # Registered before it runs: its dataclasses look their module up here.
    sys.modules[spec.name] = module
    keep = sys.dont_write_bytecode
    sys.dont_write_bytecode = True  # no __pycache__ next to the scripts
    try:
        spec.loader.exec_module(module)
    except OSError as e:
        sys.exit(f"{sys.argv[0]}: error: cannot load {path}: {e}")
    finally:
        sys.dont_write_bytecode = keep
    return module


cb = load_compare_brokers()


def is_number(value: object) -> bool:
    return (isinstance(value, (int, float)) and not isinstance(value, bool)
            and math.isfinite(value))


def flatten(stdout: str) -> tuple[dict[str, float], list[str]]:
    """The numbers of the client's report as {scenario_key: number}, and the scenarios' names."""
    try:
        report = json.loads(stdout)
    except ValueError as e:
        raise cb.RunError(f"the client's output is not JSON ({e}):\n{cb.tail(stdout)}") from e
    if not isinstance(report, dict) or not report:
        raise cb.RunError(f"the client's output is not a JSON object of scenarios:\n"
                          f"{cb.tail(stdout)}")
    metrics: dict[str, float] = {}
    scenarios = []
    for scenario, stats in report.items():
        if not isinstance(stats, dict):
            raise cb.RunError(f"scenario {scenario!r} of the client's output is not a JSON "
                              f"object: {cb.tail(json.dumps(stats), 200)}")
        found = 0
        for key, value in stats.items():
            if isinstance(value, float) and not math.isfinite(value):
                raise cb.RunError(f"{scenario}.{key} of the client's output is {value}")
            if not is_number(value):
                continue  # descriptive, not a metric
            name = f"{scenario}_{key}"
            if name in metrics or name in RESERVED:
                raise cb.RunError(f"two metrics of the client are named {name!r}")
            metrics[name] = value
            found += 1
        if not found:
            raise cb.RunError(f"scenario {scenario!r} of the client's output has no number")
        scenarios.append(scenario)
    return metrics, scenarios


def run_client(bench: str, address: str, log_path: str
               ) -> tuple[dict[str, float], list[str], float, float]:
    """Run the client once. Give its metrics, its scenarios, its wall time and its CPU time."""
    env = {**os.environ, "DBUS_SESSION_BUS_ADDRESS": address}
    # The client is the only child reaped in between, so the difference is its own usage.
    before = resource.getrusage(resource.RUSAGE_CHILDREN)
    start = time.perf_counter()
    with open(log_path, "wb") as stderr:
        client = subprocess.Popen(
            [bench], env=env, stdin=subprocess.DEVNULL, stdout=subprocess.PIPE, stderr=stderr,
            encoding="utf-8", errors="replace",
        )
        try:
            stdout, _ = client.communicate(timeout=cb.CLIENT_TIMEOUT)
        except subprocess.TimeoutExpired:
            client.kill()
            client.communicate()
            raise cb.RunError(f"client still running after {cb.CLIENT_TIMEOUT:g}s") from None
        finally:
            if client.poll() is None:  # an interrupt, say
                client.kill()
                client.wait()
    wall = time.perf_counter() - start
    after = resource.getrusage(resource.RUSAGE_CHILDREN)
    if client.returncode != 0:
        raise cb.RunError(f"client exited with status {client.returncode}:\n"
                          f"{cb.read_tail(log_path)}")
    metrics, scenarios = flatten(stdout)
    cpu = (after.ru_utime - before.ru_utime) + (after.ru_stime - before.ru_stime)
    return metrics, scenarios, wall, cpu


def run_once(label: str, command: str, bench: str, rnd: int, warmup: bool
             ) -> tuple[dict, list[str]]:
    """Start a broker, run the client against it once and stop the broker."""
    tmp = tempfile.mkdtemp(prefix="dbus-latency-")
    try:
        sock = os.path.join(tmp, "bus")
        env, argv = cb.split_command(command, sock)
        broker_log = os.path.join(tmp, "broker.log")
        with cb.Broker(argv, {**os.environ, **env}, broker_log) as broker:
            broker.wait_ready(sock)
            try:
                metrics, scenarios, wall, cpu = run_client(
                    bench, f"unix:path={sock}", os.path.join(tmp, "client.log"))
            except cb.RunError as e:
                raise cb.RunError(f"{e}\nbroker log:\n{cb.read_tail(broker_log)}") from None
            peak_kib = broker.peak_rss_kib()
            broker.stop()
        user, system, vcsw, _ = broker.usage()
        run = {"label": label, "round": rnd, "warmup": warmup, **metrics,
               "client_wall_s": wall, "client_cpu_s": cpu, "broker_user_s": user,
               "broker_sys_s": system, "broker_cpu_s": user + system, "broker_vcsw": vcsw,
               "broker_maxrss_kib": peak_kib, "broker_exit": broker.status}
        return run, scenarios
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def summarize(runs: list[dict], labels: list[str]) -> dict:
    """Per metric and broker, the statistics of the measured (not warmup) runs."""
    measured = [run for run in runs if not run["warmup"]]
    fields: dict[str, None] = {}  # in the order they are first seen
    for run in measured:
        fields.update((key, None) for key, value in run.items()
                      if key not in NOT_SUMMARIZED and is_number(value))
    return {
        field: {label: cb.describe([run[field] for run in measured
                                    if run["label"] == label and is_number(run.get(field))])
                for label in labels}
        for field in fields
    }


def cell(summary: dict, field: str, label: str, stat: str, decimals: int) -> str:
    value = summary.get(field, {}).get(label, {}).get(stat)
    return "-" if value is None else f"{value:.{decimals}f}"


def print_tables(summary: dict, scenarios: list[str], labels: list[str]) -> None:
    for scenario in scenarios:
        print(f"\n### {scenario} (microseconds, over the measured rounds)\n")
        columns = [f"{key.removesuffix('_us')} {stat}" for key in TABLE_KEYS
                   for stat in ("mean", "median")]
        print("| broker | n | " + " | ".join(columns) + " |")
        print("|---|---:|" + "---:|" * len(columns))
        for label in labels:
            fields = [f"{scenario}_{key}" for key in TABLE_KEYS]
            n = max((summary.get(field, {}).get(label, {}).get("n", 0) for field in fields),
                    default=0)
            cells = [cell(summary, field, label, stat, 1) for field in fields
                     for stat in ("mean", "median")]
            print(f"| {label} | {n} | " + " | ".join(cells) + " |")
    print("\n### broker and client (over the measured rounds)\n")
    columns = [f"{field} {stat}" for field, _ in COST_FIELDS for stat in ("mean", "median")]
    print("| broker | n | " + " | ".join(columns) + " |")
    print("|---|---:|" + "---:|" * len(columns))
    for label in labels:
        n = summary.get("broker_cpu_s", {}).get(label, {}).get("n", 0)
        cells = [cell(summary, field, label, stat, decimals) for field, decimals in COST_FIELDS
                 for stat in ("mean", "median")]
        print(f"| {label} | {n} | " + " | ".join(cells) + " |")


def progress(run: dict, scenarios: list[str]) -> str:
    """The numbers of a run for the progress line: p50/p99/max of each scenario, and the cost."""
    shown = ", ".join(
        scenario + " " + "/".join(
            "-" if run.get(f"{scenario}_{key}") is None else f"{run[f'{scenario}_{key}']:.1f}"
            for key in TABLE_KEYS)
        for scenario in scenarios if any(f"{scenario}_{key}" in run for key in TABLE_KEYS))
    return (f"p50/p99/max us: {shown}; broker cpu {run['broker_cpu_s']:.2f}s "
            f"rss {run['broker_maxrss_kib']} KiB exit {run['broker_exit']}")


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--bench", required=True, metavar="PATH",
                   help="the latency client, which prints its report as JSON")
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
            argv = cb.split_command(command, "/x")[1]
        except ValueError as e:
            p.error(f"the command of broker {label!r} cannot be split: {e}")
        if not argv or not shutil.which(argv[0]):
            p.error(f"the command of broker {label!r} does not name a program that can be run")
    meta = {}
    for note in args.meta:
        key, sep, value = note.partition("=")
        if not sep or not key:
            p.error(f"--meta {note!r} is not of the form KEY=VALUE")
        meta[key] = value
    args.meta = meta
    return args


def main() -> int:
    args = parse_args()
    cb.become_subreaper()
    for sig in (signal.SIGINT, signal.SIGTERM, signal.SIGHUP):
        # As compare-brokers.py does: each is a KeyboardInterrupt, so that the brokers get cleaned
        # up, but what was ignored on purpose (nohup ignores SIGHUP) stays so. SIGINT is taken
        # regardless, for the brokers would inherit it ignored if this was started in the
        # background, and not stop on the SIGINT that is meant to stop them.
        if sig == signal.SIGINT or signal.getsignal(sig) != signal.SIG_IGN:
            signal.signal(sig, signal.default_int_handler)
    if args.out:
        os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)

    brokers = [(label, command) for label, command in args.broker]
    labels = [label for label, _ in brokers]
    machine = {"nproc": os.cpu_count(), "cpu_model": cb.cpu_model(), "kernel": platform.release()}
    started = datetime.now(timezone.utc).isoformat(timespec="seconds")
    runs: list[dict] = []
    failures: list[dict] = []
    scenarios: dict[str, None] = {}  # in the order the client prints them
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
                    run, found = run_once(label, command, args.bench, rnd, warmup)
                except cb.RunError as e:
                    failures.append({"label": label, "round": rnd, "warmup": warmup,
                                     "error": str(e)})
                    cb.log(f"{position}: FAILED: {e}")
                    continue
                runs.append(run)
                scenarios.update((scenario, None) for scenario in found)
                cb.log(f"{position}: {progress(run, found)}" + (" (warmup)" if warmup else ""))
    except KeyboardInterrupt:
        interrupted = True
        cb.log("interrupted: reporting the runs that finished")

    summary = summarize(runs, labels)
    if args.out:  # before the tables, so that a closed stdout cannot lose it
        config = {
            "brokers": [{"label": label, "command": command} for label, command in brokers],
            "bench": args.bench, "rounds": args.rounds, "warmup": args.warmup,
            "seed": args.seed, "meta": args.meta, "scenarios": list(scenarios),
        }
        with open(args.out, "w", encoding="utf-8") as f:
            json.dump({"machine": machine, "config": config, "started": started,
                       "runs": runs, "failures": failures, "summary": summary}, f, indent=2)
            f.write("\n")
    print(f"rounds: {args.rounds} measured after {args.warmup} warmup; {machine['nproc']} CPUs, "
          f"{machine['cpu_model']}")
    for key, value in args.meta.items():
        print(f"{key}: {value}")
    print_tables(summary, list(scenarios), labels)
    if failures:
        cb.log(f"{len(failures)} run(s) failed (see above); the tables leave them out")
    return 130 if interrupted else 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
