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
| [dbus-broker] | 37                |      0.082 s |        0.930 s |                       0.41 s |
| [dbus-daemon] | 1.16.2            |      0.160 s |        1.185 s |                       1.14 s |
| [busd]        | 0.5.0<sup>1</sup> |      0.092 s |        0.917 s |                       0.91 s |
| [busd]        | 0.5.0<sup>2</sup> |      0.088 s |        0.926 s |                       0.42 s |

With 20 connections, the client keeps its own CPU busy with every broker but dbus-daemon, so their
timings there say more about the client than about them, and the CPU time of the broker is what
tells them apart. [The results](results/2026-10-18-busd-zruntime-ryzen-7840u.md) have more on
these, and on how they were measured. The results this table had before, from 2024, were likely
made with an unoptimised build of the benchmark, as `cargo run` makes, which would have held every
broker to about the same timings.

**Note**: If you run the benchmark on your machine, make sure that `busd` is built in release mode
(`cargo run --release` if you build+run it yourself from the source).

1: Actually, git main branch (commit 840d728), on Tokio.

2: Actually, the port of busd to zruntime (commit 0d22862).

[dbus-broker]: https://github.com/bus1/dbus-broker
[dbus-daemon]: https://gitlab.freedesktop.org/dbus/dbus
[busd]: https://github.com/z-galaxy/busd
