# D-Bus Broker Benchmarking

This repository attempts to benchmark the performance of D-Bus brokers. It makes simple method calls
to its own services, using a single and multiple simultaneous service & client pairs. The service
and the client of each pair have a connection and a thread of their own, as processes of their own
would, so that neither holds the other up.

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
Fedora 44), as the medians of 60 rounds of the comparison that `scripts/compare-batched-sends.sh`
runs, on 2026-10-27, each of which runs the benchmarks once against every broker.

Method calls, from the benchmark above: 1000 calls with 16 KiB of data each, by one client to its
service, then by each of 20 clients to a service of its own, all at once:

| Broker        | Version          |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|------------------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37               |      0.061 s |        0.303 s |                       0.28 s |     8.1 MiB |
| [dbus-daemon] | 1.16.2           |      0.133 s |        1.203 s |                       1.17 s |     6.3 MiB |
| [busd]        | main<sup>1</sup> |      0.071 s |        0.322 s |                       0.30 s |     6.8 MiB |

Signals, from `cargo run --release --bin fanout`: a burst of 40,000 signals with 1 KiB of data each
to one subscriber, then a broadcast of 6000 of them to each of 20 subscribers, each subscriber on a
thread of its own:

| Broker        | Version          | Burst to 1 | Broadcast to 20 | CPU time of the broadcast | Peak memory |
|---------------|------------------|-----------:|----------------:|--------------------------:|------------:|
| [dbus-broker] | 37               |    0.175 s |         0.189 s |                    0.16 s |     8.2 MiB |
| [dbus-daemon] | 1.16.2           |    0.850 s |         1.949 s |                    1.92 s |     5.5 MiB |
| [busd]        | main<sup>1</sup> |    0.129 s |         0.075 s |                    0.04 s |     6.2 MiB |

busd takes 4% longer than dbus-broker with 20 clients (from +2.6 to +6.1%), where it took 26% longer
on the zbus and the zruntime that its main branch pins, and 15% longer with one client. It gets the
signals through faster than dbus-broker: the burst by 26%, where it took 22% longer on that zbus and
zruntime, and the broadcast by 60%, with 74% less CPU time, as it writes several signals to a
subscriber with each system call. The memory of dbus-broker is that of its two processes, its
launcher and the broker proper, together.
[The results](results/2026-10-27-busd-dependency-updates-ryzen-7840u.md) have more on these, on the
latencies and on the shared phases, where busd takes 18% longer than dbus-broker with 100 clients
and uses 50% more memory, and on how they were measured.

Before these, the tables had the results of 2026-10-25, of
[threaded subscribers](results/2026-10-25-busd-batched-sends-subscriber-threads-ryzen-7840u.md),
measured with busd's main branch as of z-galaxy/busd#383 and with the benchmark of then, whose
service and client of each pair shared a connection, and whose pairs all ran on one thread. Those
from 2026-10-20 are in
[results/2026-10-20-zbus-6-ryzen-7840u.md](results/2026-10-20-zbus-6-ryzen-7840u.md). Those from
2026-10-18 were measured with the benchmark on zbus 4.3, whose client was so much slower that every
broker but dbus-daemon took about 0.92 s with 20 connections, twice as long as on zbus 6. Those from
2024 were likely made with an unoptimised build of the benchmark, as `cargo run` makes, which would
have held every broker to about the same timings.

**Note**: If you run the benchmark on your machine, make sure that `busd` is built in release mode
(`cargo run --release` if you build+run it yourself from the source).

1: Actually, busd's main branch at d69f900 with zbus and zruntime moved to their latest commits,
50c54bf and b3bd01d, as f415bfd of zeenix/busd pins them, which busd's main branch doesn't have yet:
zbus decodes the header of each message in one pass there, and zruntime keeps the socket of a busy
client watched until its task has run.

[dbus-broker]: https://github.com/bus1/dbus-broker
[dbus-daemon]: https://gitlab.freedesktop.org/dbus/dbus
[busd]: https://github.com/z-galaxy/busd
