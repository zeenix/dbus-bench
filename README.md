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
runs, on 2026-10-27, each of which runs the benchmarks once against every broker. The clients leave
the sender out of their messages, as libdbus, GLib and sd-bus clients do, for the broker to set.
busd is its main branch at
[b0b84a1](https://github.com/z-galaxy/busd/commit/b0b84a1c77ad6189fc19b15c3c2b4627512c85d9).

Method calls, from the benchmark above: 1000 calls with 16 KiB of data each, by one client to its
service, then by each of 20 clients to a service of its own, all at once:

| Broker        | Version |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|---------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37      |      0.060 s |        0.318 s |                       0.29 s |     8.1 MiB |
| [dbus-daemon] | 1.16.2  |      0.129 s |        1.180 s |                       1.15 s |     6.4 MiB |
| [busd]        | main    |      0.070 s |        0.344 s |                       0.31 s |     7.0 MiB |

On the method calls, busd takes 8% longer than dbus-broker with 20 clients (from +6.7 to +9.6%),
and 18% longer with one client.

The same calls with a dict of dicts of 100 variants, `a{sa{sv}}`, for their body, from
`cargo run --release --bin dicts`, which costs a broker that checks bodies far more to check than a
byte array:

| Broker        | Version |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|---------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37      |      0.082 s |        0.520 s |                       0.48 s |     8.0 MiB |
| [dbus-daemon] | 1.16.2  |      0.138 s |        1.246 s |                       1.21 s |     6.0 MiB |
| [busd]        | main    |      0.082 s |        0.369 s |                       0.34 s |     6.8 MiB |

busd takes 29% less time than dbus-broker on the dict calls of 20 clients, and as long with one
client. Checking their bodies takes busd 12% more CPU time, about 2.1 µs for each call.

Signals, from `cargo run --release --bin fanout`: a burst of 40,000 signals with 1 KiB of data each
to one subscriber, then a broadcast of 6000 of them to each of 20 subscribers, each subscriber on a
thread of its own:

| Broker        | Version | Burst to 1 | Broadcast to 20 | CPU time of the broadcast | Peak memory |
|---------------|---------|-----------:|----------------:|--------------------------:|------------:|
| [dbus-broker] | 37      |    0.177 s |         0.197 s |                    0.16 s |     8.2 MiB |
| [dbus-daemon] | 1.16.2  |    0.820 s |         2.009 s |                    1.98 s |     5.5 MiB |
| [busd]        | main    |    0.140 s |         0.085 s |                    0.05 s |     6.3 MiB |

busd gets the burst of signals through 21% faster than dbus-broker, and broadcasts them 57% faster,
with 72% less CPU time, as it writes several signals to a subscriber with each system call.

Latencies, from `cargo run --release --bin latency`, as the medians over the rounds of their p50 and
their p99: the round trips of 5000 calls with 64 bytes of data each, by one client to its service,
and of 1000 calls with 16 KiB each, by each of 20 clients to a service of its own, all at once, and
the delays of the signals of a fan-out:

| Broker        | Version | Round trip, 1 client | Round trip, 20 clients | Fan-out to 20<sup>1</sup> |
|---------------|---------|---------------------:|-----------------------:|--------------------------:|
| [dbus-broker] | 37      |          49 / 104 µs |           292 / 384 µs |              2.0 / 3.3 ms |
| [dbus-daemon] | 1.16.2  |          91 / 195 µs |         1142 / 1383 µs |            20.7 / 32.4 ms |
| [busd]        | main    |          59 / 129 µs |           315 / 406 µs |              1.1 / 1.9 ms |

busd takes 5% longer than dbus-broker on the median round trip of 20 clients, 24% longer on that of
one client, and delivers the signals of the fan-out 45% sooner at the median and 42% sooner at p99.
The memory of dbus-broker is that of its two processes, its launcher and the broker proper,
together. [The results](results/2026-10-27-busd-message-checks-0413582-ryzen-7840u.md) have more on
these, on the shared phases, where busd takes 28% longer than dbus-broker with 100 clients and uses
52% more memory, on how busd compares with its main branch before z-galaxy/busd#391, and on how
they were measured.

Before these, the tables had the results of
[the latest zbus and zruntime](results/2026-10-27-busd-dependency-updates-ryzen-7840u.md), measured
with busd's main branch as of z-galaxy/busd#388 and with clients that set the sender of each
message, as zbus does, which spares busd the work of setting it: busd took 4% longer than
dbus-broker on the calls of 20 clients with them. Those of 2026-10-25, of
[threaded subscribers](results/2026-10-25-busd-batched-sends-subscriber-threads-ryzen-7840u.md),
were measured with busd's main branch as of z-galaxy/busd#383 and with the benchmark of then, whose
service and client of each pair shared a connection, and whose pairs all ran on one thread. Those
from 2026-10-20 are in
[results/2026-10-20-zbus-6-ryzen-7840u.md](results/2026-10-20-zbus-6-ryzen-7840u.md). Those from
2026-10-18 were measured with the benchmark on zbus 4.3, whose client was so much slower that every
broker but dbus-daemon took about 0.92 s with 20 connections, twice as long as on zbus 6. Those from
2024 were likely made with an unoptimised build of the benchmark, as `cargo run` makes, which would
have held every broker to about the same timings.

**Note**: If you run the benchmark on your machine, make sure that `busd` is built in release mode
(`cargo run --release` if you build+run it yourself from the source).

1: A broadcast of signals, like the one of the signals above, but timed signal by signal: one
connection sends 2000 signals with 1 KiB of data each, back to back, and each of 20 subscribers
receives all of them. Each delivery is timed from just before the sender builds the signal until the
subscriber takes it off its stream, so the p99 is how long the slowest 1% of the deliveries waited.

[dbus-broker]: https://github.com/bus1/dbus-broker
[dbus-daemon]: https://gitlab.freedesktop.org/dbus/dbus
[busd]: https://github.com/z-galaxy/busd
