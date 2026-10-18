#!/usr/bin/env python3
"""Measures the CPU time a broker spends while a client calls it at a steady, light rate.

Usage: measure-light-traffic.py CLIENT ROUNDS OUT LABEL=COMMAND...

CLIENT is the `light-client` binary of the crate next to this script, which reads `INTERVAL_US`,
`SECS` and `MODE` from the environment. COMMAND is split into words as a shell would, with
`{address}` replaced by the bus address; it should start with `env` to set variables for the
broker alone. For each round, the brokers run in a random order. Each run starts the broker, waits
until its socket accepts connections, runs CLIENT against it, stops the broker with SIGINT and
records the broker's CPU time (user and system, from wait4), its voluntary context switches, the
number of calls the client made and how long they took. Where the kernel lets this script read the
energy counters of the CPU packages (`/sys/class/powercap/*/energy_uj`, which only root may read
on most systems), it also records the energy the packages used while the client ran, which counts
everything else that ran meanwhile too. The runs go to OUT as JSON, and a table of medians to
standard output. A run whose client fails is recorded as a failure, with the end of what the client
printed to its standard error, and the script carries on with the next one, and exits with 1 at the
end.
"""
import glob, json, os, random, shlex, signal, socket, statistics, subprocess, sys, tempfile, time


def packages():
    """The energy counters of the CPU packages that can be read, with their ranges."""
    found = []
    for d in glob.glob("/sys/class/powercap/*"):
        try:
            with open(os.path.join(d, "name")) as f:
                if not f.read().startswith("package"):
                    continue
            with open(os.path.join(d, "max_energy_range_uj")) as f:
                top = int(f.read())
            with open(os.path.join(d, "energy_uj")) as f:
                int(f.read())
        except (OSError, ValueError):
            continue
        found.append((os.path.join(d, "energy_uj"), top))
    return found


def energy(counters):
    """The current reading of each counter, in µJ."""
    values = []
    for path, _ in counters:
        with open(path) as f:
            values.append(int(f.read()))
    return values


def stop(broker):
    """Stops the broker with SIGINT, or with SIGKILL if it still runs 10 s later, and gives back
    its resource usage, also where it has exited by itself already.

    Popen's send_signal() and kill() are not used: they poll the broker first, which reaps it if
    it has exited, without keeping its resource usage, and leaves wait4 nothing to reap.
    """
    pid, status, usage = os.wait4(broker.pid, os.WNOHANG)
    if not pid:
        os.kill(broker.pid, signal.SIGINT)
        deadline = time.monotonic() + 10
        while True:
            pid, status, usage = os.wait4(broker.pid, os.WNOHANG)
            if pid:
                break
            if time.monotonic() > deadline:
                os.kill(broker.pid, signal.SIGKILL)
                _, status, usage = os.wait4(broker.pid, 0)
                break
            time.sleep(0.01)
    # Reaped here, with its resource usage, so that Popen has nothing left to wait for.
    broker.returncode = os.waitstatus_to_exitcode(status)
    return usage


client, rounds, out = sys.argv[1], int(sys.argv[2]), sys.argv[3]
brokers = [a.split("=", 1) for a in sys.argv[4:]]
config = {k: os.environ.get(k) for k in ("INTERVAL_US", "SECS", "MODE")}
counters = packages()
runs = []
failures = []
for r in range(rounds):
    order = list(brokers)
    random.shuffle(order)
    for label, cmd in order:
        d = tempfile.mkdtemp()
        path = os.path.join(d, "bus")
        address = f"unix:path={path}"
        broker = subprocess.Popen(shlex.split(cmd.replace("{address}", address)),
                                  stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        try:
            for _ in range(500):
                try:
                    with socket.socket(socket.AF_UNIX) as s:
                        s.connect(path)
                    break
                except OSError:
                    time.sleep(0.01)
            before = energy(counters)
            calls = subprocess.run([client], capture_output=True, text=True,
                                   env={**os.environ, "DBUS_SESSION_BUS_ADDRESS": address})
            after = energy(counters)
        finally:
            usage = stop(broker)
        if calls.returncode != 0:
            failure = {"label": label, "round": r, "client_exit": calls.returncode,
                       "client_stderr": calls.stderr[-2000:]}
            failures.append(failure)
            print(json.dumps(failure), file=sys.stderr)
            continue
        joules = None
        if counters:
            used = ((b - a) % (top + 1) for a, b, (_, top) in zip(before, after, counters))
            joules = sum(used) / 1e6
        run = {"label": label, "round": r, "cpu_s": usage.ru_utime + usage.ru_stime,
               "vcsw": usage.ru_nvcsw, "energy_j": joules, **json.loads(calls.stdout)}
        runs.append(run)
        print(json.dumps(run), file=sys.stderr)
with open(out, "w") as f:
    json.dump({"config": config, "brokers": dict(brokers), "runs": runs, "failures": failures}, f,
              indent=1)
    f.write("\n")
print("| Broker | Calls | CPU per call, µs | Latency, µs | p99, µs | Sleeps | Energy, J |")
print("|---|---:|---:|---:|---:|---:|---:|")
for label, _ in brokers:
    rs = [x for x in runs if x["label"] == label]
    if not rs:
        print(f"| {label} | failed | | | | | |")
        continue
    median = lambda key: statistics.median(x[key] for x in rs)
    joules = f"{median('energy_j'):.2f}" if counters else "n/a"
    print(f"| {label} | {median('calls'):.0f} | "
          f"{statistics.median(x['cpu_s'] / x['calls'] for x in rs) * 1e6:.1f} | "
          f"{median('median_us'):.1f} | {median('p99_us'):.1f} | {median('vcsw'):.0f} | "
          f"{joules} |")
sys.exit(1 if failures else 0)
