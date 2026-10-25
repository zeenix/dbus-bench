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
dbus-broker. The `results` directory holds comparisons made with them: a write-up of each, and a
directory with its raw results, packed into a `runs.tar.xz`, and whatever else it took to make
them. `scripts/pack-results.sh` packs the raw results of a run of the compare scripts that way, and
`scripts/paired-stats.py` makes the comparisons in pairs from them again.

## Results

Here are the results obtained on my machine (AMD Ryzen 7 7840U w/ 8 cores & 16 threads, 64 GB RAM,
Fedora 44), as the medians of 60 rounds of `scripts/compare-batched-sends.sh` on 2026-10-25, each of
which runs the benchmarks once against every broker.

Method calls, from the benchmark above: 1000 calls with 16 KiB of data each, through one connection,
then through 20 connections at once:

| Broker        | Version          | 1 connection | 20 connections | CPU time with 20 connections | Peak memory |
|---------------|------------------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37               |      0.060 s |        0.427 s |                       0.28 s |     8.0 MiB |
| [dbus-daemon] | 1.16.2           |      0.134 s |        1.143 s |                       1.12 s |     6.1 MiB |
| [busd]        | main<sup>1</sup> |      0.071 s |        0.443 s |                       0.35 s |     6.6 MiB |

Signals, from `cargo run --release --bin fanout`: a burst of 40,000 signals with 1 KiB of data each
to one subscriber, then a broadcast of 6000 of them to each of 20 subscribers:

| Broker        | Version          | Burst to 1 | Broadcast to 20 | CPU time of the broadcast | Peak memory |
|---------------|------------------|-----------:|----------------:|--------------------------:|------------:|
| [dbus-broker] | 37               |    0.188 s |         0.219 s |                    0.19 s |    14.6 MiB |
| [dbus-daemon] | 1.16.2           |    0.847 s |         2.006 s |                    1.98 s |     5.5 MiB |
| [busd]        | main<sup>1</sup> |    0.216 s |         0.138 s |                    0.11 s |     6.2 MiB |

With 20 connections, the client of the method calls keeps its own CPU busy, 96% of the time, with
busd and dbus-broker, so the CPU time of the broker is what tells those two apart there. busd
broadcasts the signals 37% faster than dbus-broker, with about 40% less CPU time, as it writes
several of them to a subscriber with each system call. The memory of dbus-broker is that of its two
processes, its launcher and the broker proper, together.
[The results](results/2026-10-25-busd-batched-sends-subscriber-threads-ryzen-7840u.md) have more on
these, the latencies and the connection that 100 proxies share among them, and on how they were
measured.

The results that the table of method calls had before, from 2026-10-20, are in
[results/2026-10-20-zbus-6-ryzen-7840u.md](results/2026-10-20-zbus-6-ryzen-7840u.md). Those from
2026-10-18 were measured with the benchmark on zbus 4.3, whose client was so much slower that every
broker but dbus-daemon took about 0.92 s with 20 connections, twice as long as now. Those from 2024
were likely made with an unoptimised build of the benchmark, as `cargo run` makes, which would have
held every broker to about the same timings.

**Note**: If you run the benchmark on your machine, make sure that `busd` is built in release mode
(`cargo run --release` if you build+run it yourself from the source).

1: Actually, the git main branch as of z-galaxy/busd#383 (fe38f44), which forwards the messages of
each peer in batches. It was measured from ac6e6fa, an earlier version of it, whose code is the same
but for comments.

[dbus-broker]: https://github.com/bus1/dbus-broker
[dbus-daemon]: https://gitlab.freedesktop.org/dbus/dbus
[busd]: https://github.com/z-galaxy/busd
