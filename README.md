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
Fedora 44, Linux 7.2.13), as the medians of 60 rounds of [a comparison on
2026-10-30](results/2026-10-30-busd-zruntime-edge-triggered-ryzen-7840u.md), each of which ran the
benchmarks once against every broker, as `scripts/compare.sh` does. The clients leave the sender
out of their messages, as libdbus, GLib and sd-bus clients do, for the broker to set.
busd is its main branch at
[3a751a5](https://github.com/z-galaxy/busd/commit/3a751a5338f499deaa5d0acdb2b555d8b0ba9907), the
merge of z-galaxy/busd#398, which builds on zruntime's main branch with z-galaxy/zruntime#63 and
z-galaxy/zruntime#65: `block_on` polls its future only once it has been woken, and epoll reports a
socket as it turns ready, rather than on every wait for as long as it stays ready.

Method calls, from the benchmark above: 1000 calls with 16 KiB of data each, by one client to its
service, then by each of 20 clients to a service of its own, all at once:

| Broker        | Version |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|---------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37      |      0.045 s |        0.298 s |                       0.28 s |     8.1 MiB |
| [dbus-daemon] | 1.16.2  |      0.093 s |        1.097 s |                       1.07 s |     6.4 MiB |
| [busd]        | main    |      0.043 s |        0.308 s |                       0.29 s |     7.0 MiB |

On the method calls, busd takes 3.6% longer than dbus-broker with 20 clients (from +2.1 to +5.0%),
and 3.9% less time with one client, where it took 4.1% longer and 0.7% less before
z-galaxy/busd#398, in the same run.

The same calls with a dict of dicts of 100 variants, `a{sa{sv}}`, for their body, from
`cargo run --release --bin dicts`, which costs a broker that checks bodies far more to check than a
byte array:

| Broker        | Version |     1 client |     20 clients |     CPU time with 20 clients | Peak memory |
|---------------|---------|-------------:|---------------:|-----------------------------:|------------:|
| [dbus-broker] | 37      |      0.065 s |        0.504 s |                       0.48 s |     8.1 MiB |
| [dbus-daemon] | 1.16.2  |      0.103 s |        1.175 s |                       1.15 s |     5.9 MiB |
| [busd]        | main    |      0.056 s |        0.328 s |                       0.31 s |     6.9 MiB |

busd takes 35% less time than dbus-broker on the dict calls of 20 clients, and 13% less with one
client (from -14.9 to -11.1%). Checking their bodies took busd 12% more CPU time, about 2.1 µs for
each call, [when it started to](results/2026-10-27-busd-message-checks-0413582-ryzen-7840u.md).

Signals, from `cargo run --release --bin fanout`: a burst of 40,000 signals with 1 KiB of data each
to one subscriber, then a broadcast of 6000 of them to each of 20 subscribers, each subscriber on a
thread of its own:

| Broker        | Version | Burst to 1 | Broadcast to 20 | CPU time of the broadcast | Peak memory |
|---------------|---------|-----------:|----------------:|--------------------------:|------------:|
| [dbus-broker] | 37      |    0.174 s |         0.188 s |                    0.17 s |     8.1 MiB |
| [dbus-daemon] | 1.16.2  |    0.772 s |         1.918 s |                    1.90 s |     5.4 MiB |
| [busd]        | main    |    0.114 s |         0.066 s |                    0.05 s |     6.4 MiB |

busd gets the burst of signals through 35% faster than dbus-broker, and broadcasts them 65% faster,
with 72% less CPU time, as it reads several signals of the sender, and writes several to a
subscriber, with each system call.

Latencies, from `cargo run --release --bin latency`, as the medians over the rounds of their p50 and
their p99: the round trips of 5000 calls with 64 bytes of data each, by one client to its service,
and of 1000 calls with 16 KiB each, by each of 20 clients to a service of its own, all at once, and
the delays of the signals of a fan-out:

| Broker        | Version | Round trip, 1 client | Round trip, 20 clients | Fan-out to 20<sup>1</sup> |
|---------------|---------|---------------------:|-----------------------:|--------------------------:|
| [dbus-broker] | 37      |           34 / 60 µs |           274 / 456 µs |              1.9 / 3.1 ms |
| [dbus-daemon] | 1.16.2  |          63 / 136 µs |         1018 / 1352 µs |            19.7 / 30.7 ms |
| [busd]        | main    |           32 / 54 µs |           275 / 433 µs |              0.8 / 1.4 ms |

busd takes about as long as dbus-broker on the median round trip of 20 clients (-0.7%, from -2.4 to
+1.0%), 6% less on that of one client, and delivers the signals of the fan-out 57% sooner at the
median and 54% sooner at p99. The memory of dbus-broker is that of its two processes, its launcher
and the broker proper, together.
[The results](results/2026-10-30-busd-zruntime-edge-triggered-ryzen-7840u.md) have more on these,
on the shared phases, where busd takes 23% less time than dbus-broker with 100 callers on one
connection, 7% longer with 100 clients, and uses 57% more memory, on how busd compares with its
main branch before z-galaxy/busd#398, and on how they were measured.

Before these, the tables had the results of busd's main branch as of z-galaxy/busd#396,
[measured on 2026-10-28](results/2026-10-28-busd-zbus-read-ahead-ryzen-7840u.md) on Linux 7.1.13,
on which every broker took 23 to 59% longer with one client than on 7.2.13, and differed less on the
rest, and busd took 3% longer than dbus-broker on the calls of 20 clients, 17% longer with one
client, and 21% longer with 100 clients. In the run of 2026-10-30, that main branch takes 4.1%
longer than dbus-broker on the calls of 20 clients, 0.7% less time with one client, and 12.8%
longer with 100 clients. Those before them had the results of
busd's main branch as of z-galaxy/busd#391,
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
