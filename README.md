# D-Bus Broker Benchmarking

This repository attempts to benchmark the performance of D-Bus brokers. It makes simple method calls
to its own services, using a single and multiple simultaneous service & client pairs. The service
and the client of each pair have a connection and a thread of their own, as processes of their own
would, so that neither holds the other up. The clients and the services build their messages
without a sender, as libdbus, GLib and sd-bus clients do, which leaves the bus to set it.

## Running the benchmark

Simply run `cargo run --release` in the root of the repository. This will benchmark the existing
session bus (assuming one is available). If you want to benchmark a different bus, you can set the
`DBUS_SESSION_BUS_ADDRESS` environment variable like this:

```sh
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus cargo run --release
```

Build the benchmark in release mode, as above: the client is what limits the timings of the
fastest brokers, and an unoptimised one is several times slower than any of them.

`cargo run --release --bin dicts` runs the method calls with an `a{sa{sv}}` body of 100 variants
instead of a byte array, for what checking such bodies costs a broker.

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
runs, on 2026-10-27, each of which runs the benchmarks once against every broker. They were measured
with the clients of then, which set the sender of each message, as zbus does, before 8f59742 had
them leave it out.

Method calls, from the benchmark above: 1000 calls with 16 KiB of data each, by one client to its
service, then by each of 20 clients to a service of its own, all at once:

| Broker        | Version          |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|------------------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37               |      0.061 s |        0.303 s |                       0.28 s |     8.1 MiB |
| [dbus-daemon] | 1.16.2           |      0.133 s |        1.203 s |                       1.17 s |     6.3 MiB |
| [busd]        | main<sup>1</sup> |      0.071 s |        0.322 s |                       0.30 s |     6.8 MiB |

On the method calls, busd takes 4% longer than dbus-broker with 20 clients (from +2.6 to +6.1%),
and 15% longer with one client.

Signals, from `cargo run --release --bin fanout`: a burst of 40,000 signals with 1 KiB of data each
to one subscriber, then a broadcast of 6000 of them to each of 20 subscribers, each subscriber on a
thread of its own:

| Broker        | Version          | Burst to 1 | Broadcast to 20 | CPU time of the broadcast | Peak memory |
|---------------|------------------|-----------:|----------------:|--------------------------:|------------:|
| [dbus-broker] | 37               |    0.175 s |         0.189 s |                    0.16 s |     8.2 MiB |
| [dbus-daemon] | 1.16.2           |    0.850 s |         1.949 s |                    1.92 s |     5.5 MiB |
| [busd]        | main<sup>1</sup> |    0.129 s |         0.075 s |                    0.04 s |     6.2 MiB |

busd gets the burst of signals through 26% faster than dbus-broker, and broadcasts them 60% faster,
with 74% less CPU time, as it writes several signals to a subscriber with each system call.

Latencies, from `cargo run --release --bin latency`, as the medians over the rounds of their p50 and
their p99: the round trips of 5000 calls with 64 bytes of data each, by one client to its service,
and of 1000 calls with 16 KiB each, by each of 20 clients to a service of its own, all at once, and
the delays of the signals of a fan-out:

| Broker        | Version          | Round trip, 1 client | Round trip, 20 clients | Fan-out to 20<sup>2</sup> |
|---------------|------------------|---------------------:|-----------------------:|--------------------------:|
| [dbus-broker] | 37               |          48 / 106 µs |           287 / 444 µs |              2.0 / 3.3 ms |
| [dbus-daemon] | 1.16.2           |          91 / 192 µs |         1170 / 1396 µs |            19.6 / 31.6 ms |
| [busd]        | main<sup>1</sup> |          57 / 125 µs |           290 / 439 µs |              1.1 / 1.9 ms |

busd is level with dbus-broker on the round trips of 20 clients, takes 21% longer on those of one,
and delivers the signals of the fan-out 45% sooner at the median and 42% sooner at p99. The memory
of dbus-broker is that of its two processes, its launcher and the broker proper, together.
[The results](results/2026-10-27-busd-dependency-updates-ryzen-7840u.md) have more on these, on the
shared phases, where busd takes 18% longer than dbus-broker with 100 clients and uses 50% more
memory, and on how they were measured.

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

1: Actually, the git main branch as of z-galaxy/busd#388, which builds on the latest commits of
zbus (50c54bf), which decodes the header of each message in one pass, and of zruntime (b3bd01d),
which keeps the socket of a busy client watched until its task has run. It was measured from the
commit of that pull request, f415bfd.

2: A broadcast of signals, like the one of the signals above, but timed signal by signal: one
connection sends 2000 signals with 1 KiB of data each, back to back, and each of 20 subscribers
receives all of them. Each delivery is timed from just before the sender builds the signal until the
subscriber takes it off its stream, so the p99 is how long the slowest 1% of the deliveries waited.

[dbus-broker]: https://github.com/bus1/dbus-broker
[dbus-daemon]: https://gitlab.freedesktop.org/dbus/dbus
[busd]: https://github.com/z-galaxy/busd
