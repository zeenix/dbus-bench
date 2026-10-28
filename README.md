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
them a number of times in turn and reports statistics of the results (see its `--help`), as
`scripts/compare-latency.py` does with the latencies. `scripts/compare.sh` builds busd, from its
main branch or another commit, and uses them to measure it against dbus-broker and dbus-daemon on
every workload, and against another commit of busd, if asked to (see its header). The `results`
directory holds comparisons made with them, and with the scripts that came before it: a write-up of
each, and a directory with its raw results, packed into a `runs.tar.xz`, and whatever else it took
to make them. `scripts/pack-results.sh` packs the raw results of a run of `scripts/compare.sh`
that way, and `scripts/paired-stats.py` makes the comparisons in pairs from them again.

## Results

Here are the results obtained on my machine (AMD Ryzen 7 7840U w/ 8 cores & 16 threads, 64 GB RAM,
Fedora 44), as the medians of 60 rounds of [a comparison on
2026-10-28](results/2026-10-28-busd-zbus-read-ahead-ryzen-7840u.md), each of which ran the
benchmarks once against every broker, as `scripts/compare.sh` does. The clients leave the sender
out of their messages, as libdbus, GLib and sd-bus clients do, for the broker to set.
busd is its main branch at
[077f12d](https://github.com/z-galaxy/busd/commit/077f12d7f0d442b6a81b37ac3aa284ac777dae8e), the
merge of z-galaxy/busd#396, which builds on zbus's main branch with z-galaxy/zbus#2090: the
connection of each client reads as much as its socket holds into a buffer that it keeps, and takes
each message that is whole in it out of it without reading again.

Method calls, from the benchmark above: 1000 calls with 16 KiB of data each, by one client to its
service, then by each of 20 clients to a service of its own, all at once:

| Broker        | Version |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|---------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37      |      0.068 s |        0.329 s |                       0.30 s |     8.1 MiB |
| [dbus-daemon] | 1.16.2  |      0.148 s |        1.245 s |                       1.21 s |     6.4 MiB |
| [busd]        | main    |      0.080 s |        0.340 s |                       0.31 s |     7.1 MiB |

On the method calls, busd takes 3% longer than dbus-broker with 20 clients (from +1.1 to +5.5%),
and 17% longer with one client, where it took 9% and 19% longer before z-galaxy/busd#396.

The same calls with a dict of dicts of 100 variants, `a{sa{sv}}`, for their body, from
`cargo run --release --bin dicts`, which costs a broker that checks bodies far more to check than a
byte array:

| Broker        | Version |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|---------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37      |      0.080 s |        0.526 s |                       0.49 s |     8.0 MiB |
| [dbus-daemon] | 1.16.2  |      0.136 s |        1.252 s |                       1.22 s |     6.0 MiB |
| [busd]        | main    |      0.080 s |        0.363 s |                       0.33 s |     6.9 MiB |

busd takes 31% less time than dbus-broker on the dict calls of 20 clients, and about as long with
one client (+1.8%, from -0.1 to +3.7%). Checking their bodies took busd 12% more CPU time, about
2.1 µs for each call, [when it started
to](results/2026-10-27-busd-message-checks-0413582-ryzen-7840u.md).

Signals, from `cargo run --release --bin fanout`: a burst of 40,000 signals with 1 KiB of data each
to one subscriber, then a broadcast of 6000 of them to each of 20 subscribers, each subscriber on a
thread of its own:

| Broker        | Version | Burst to 1 | Broadcast to 20 | CPU time of the broadcast | Peak memory |
|---------------|---------|-----------:|----------------:|--------------------------:|------------:|
| [dbus-broker] | 37      |    0.172 s |         0.190 s |                    0.16 s |     8.2 MiB |
| [dbus-daemon] | 1.16.2  |    0.795 s |         1.955 s |                    1.93 s |     5.5 MiB |
| [busd]        | main    |    0.113 s |         0.070 s |                    0.03 s |     6.4 MiB |

busd gets the burst of signals through 34% faster than dbus-broker, and broadcasts them 62% faster,
with 79% less CPU time, as it reads several signals of the sender, and writes several to a
subscriber, with each system call.

Latencies, from `cargo run --release --bin latency`, as the medians over the rounds of their p50 and
their p99: the round trips of 5000 calls with 64 bytes of data each, by one client to its service,
and of 1000 calls with 16 KiB each, by each of 20 clients to a service of its own, all at once, and
the delays of the signals of a fan-out:

| Broker        | Version | Round trip, 1 client | Round trip, 20 clients | Fan-out to 20<sup>1</sup> |
|---------------|---------|---------------------:|-----------------------:|--------------------------:|
| [dbus-broker] | 37      |          46 / 110 µs |           287 / 430 µs |              2.0 / 3.3 ms |
| [dbus-daemon] | 1.16.2  |          90 / 185 µs |         1121 / 1362 µs |            20.2 / 31.8 ms |
| [busd]        | main    |          56 / 126 µs |           280 / 419 µs |              1.1 / 1.8 ms |

busd takes about as long as dbus-broker on the median round trip of 20 clients (-1.9%, from -3.7 to
+0.0%), 20% longer on that of one client, and delivers the signals of the fan-out 44% sooner at the
median and at p99. The memory of dbus-broker is that of its two processes, its launcher and the
broker proper, together. [The results](results/2026-10-28-busd-zbus-read-ahead-ryzen-7840u.md) have
more on these, on the shared phases, where busd takes 12% less time than dbus-broker with 100
callers on one connection, 21% longer with 100 clients, and uses 57% more memory, on how busd
compares with its main branch before z-galaxy/busd#396, and on how they were measured.

Before these, the tables had the results of busd's main branch as of z-galaxy/busd#391,
[measured on 2026-10-27](results/2026-10-27-busd-message-checks-0413582-ryzen-7840u.md), with which
busd took 8% longer than dbus-broker on the calls of 20 clients, and 28% longer with 100 clients.
Those before them had the results of
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
