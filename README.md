# D-Bus Broker Benchmarking

This repository attempts to benchmark the performance of D-Bus brokers. It make simple method calls
to its own service, using a single and multiple simultaneous service & client pairs. Each pair share
the same connection.

## Running the benchmark

Simply run `cargo run --release` in the root of the repository. This will benchmark the existing
session bus (assuming one is available). If you want to benchmark a different bus, you can set the
`DBUS_SESSION_BUS_ADDRESS` environment variable like this:

```sh
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus cargo run --release
```

Build the benchmark in release mode, as above: the client is what limits the timings of the
fastest brokers, and an unoptimised one is several times slower than any of them.

To compare brokers, `scripts/compare-brokers.py` starts each of them, runs the benchmark against
them a number of times in turn and reports statistics of the results (see its `--help`).
`scripts/compare-busd-builds.sh` uses it to compare builds of busd with dbus-daemon and
dbus-broker. The `results` directory holds comparisons made with them.

## Results

Here are the results obtained on my machine (AMD Ryzen 7 7840U w/ 8 cores & 16 threads, 64 GB RAM,
Fedora 44), as the medians of 15 rounds of `scripts/compare-busd-builds.sh`, each of which runs the
benchmark once against every broker:

| Broker        |      Version      | 1 connection | 20 connections | CPU time with 20 connections |
|---------------|-------------------|-------------:|---------------:|-----------------------------:|
| [dbus-broker] | 37                |      0.062 s |        0.451 s |                       0.31 s |
| [dbus-daemon] | 1.16.2            |      0.142 s |        1.195 s |                       1.17 s |
| [busd]        | 0.5.0<sup>1</sup> |      0.075 s |        0.468 s |                       0.80 s |
| [busd]        | 0.5.0<sup>2</sup> |      0.070 s |        0.475 s |                       0.37 s |

With 20 connections, the client keeps its own CPU busy, 95 to 97% of the time, with every broker but
dbus-daemon, so their timings there are within 6% of each other, and the CPU time of the broker is
what tells them apart. [The results](results/2026-10-20-zbus-6-ryzen-7840u.md) have more on these,
and on how they were measured. The results this table had before, from 2026-10-18, were measured
with the benchmark on zbus 4.3, whose client was so much slower that every broker but dbus-daemon
took about 0.92 s with 20 connections, twice as long as now. Those it had before that, from 2024,
were likely made with an unoptimised build of the benchmark, as `cargo run` makes, which would have
held every broker to about the same timings.

**Note**: If you run the benchmark on your machine, make sure that `busd` is built in release mode
(`cargo run --release` if you build+run it yourself from the source).

1: Actually, the last commit of the git main branch on Tokio (840d728).

2: Actually, the git main branch (commit a982812), on zruntime. It was measured from the commit that
ported busd to zruntime (0d22862), which builds the same code.

[dbus-broker]: https://github.com/bus1/dbus-broker
[dbus-daemon]: https://gitlab.freedesktop.org/dbus/dbus
[busd]: https://github.com/z-galaxy/busd
