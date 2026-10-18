#!/usr/bin/env python3
"""Measures the CPU time a broker spends while a client calls it at a steady, light rate.

Usage: measure-light-traffic.py CLIENT ROUNDS OUT LABEL=COMMAND...

CLIENT is the `light-client` binary of the crate next to this script, which reads `INTERVAL_US`,
`SECS` and `MODE` from the environment. COMMAND is split into words as a shell would, with
`{address}` replaced by the bus address; it should start with `env` to set variables for the
broker alone. For each round, the brokers run in a random order. Each run starts the broker, waits
until its socket accepts connections, runs CLIENT against it, stops the broker with SIGINT and
records the broker's CPU time (user and system, from wait4), its voluntary context switches and
the number of calls the client made. The runs go to OUT as JSON, and a table of medians to
standard output.
"""
import json, os, random, shlex, signal, socket, statistics, subprocess, sys, tempfile, time

client, rounds, out = sys.argv[1], int(sys.argv[2]), sys.argv[3]
brokers = [a.split("=", 1) for a in sys.argv[4:]]
config = {k: os.environ.get(k) for k in ("INTERVAL_US", "SECS", "MODE")}
runs = []
for r in range(rounds):
    order = list(brokers)
    random.shuffle(order)
    for label, cmd in order:
        d = tempfile.mkdtemp()
        path = os.path.join(d, "bus")
        address = f"unix:path={path}"
        p = subprocess.Popen(shlex.split(cmd.replace("{address}", address)),
                             stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        for _ in range(500):
            try:
                with socket.socket(socket.AF_UNIX) as s:
                    s.connect(path)
                break
            except OSError:
                time.sleep(0.01)
        calls = subprocess.run([client], env={**os.environ, "DBUS_SESSION_BUS_ADDRESS": address},
                               capture_output=True, text=True, check=True).stdout.strip()
        p.send_signal(signal.SIGINT)
        _, _, ru = os.wait4(p.pid, 0)
        run = {"label": label, "round": r, "cpu_s": ru.ru_utime + ru.ru_stime,
               "calls": int(calls), "vcsw": ru.ru_nvcsw}
        runs.append(run)
        print(json.dumps(run), file=sys.stderr)
with open(out, "w") as f:
    json.dump({"config": config, "brokers": dict(brokers), "runs": runs}, f, indent=1)
print("| Broker | CPU, s | Calls | CPU per call, µs | Sleeps |")
print("|---|---:|---:|---:|---:|")
for label, _ in brokers:
    rs = [x for x in runs if x["label"] == label]
    cpu = statistics.median(x["cpu_s"] for x in rs)
    calls = statistics.median(x["calls"] for x in rs)
    vcsw = statistics.median(x["vcsw"] for x in rs)
    print(f"| {label} | {cpu:.3f} | {calls:.0f} | {cpu / calls * 1e6:.1f} | {vcsw:.0f} |")
