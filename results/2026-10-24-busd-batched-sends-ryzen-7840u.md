# busd forwarding in batches, with zbus's `Connection::send_all`, on a Ryzen 7 7840U

Measured on 2026-10-24 on the laptop of
[the time limit on a Ryzen 7 7840U](2026-10-23-busd-zruntime-clock-ryzen-7840u.md): an AMD Ryzen 7
7840U (8 cores, 16 threads), running Fedora 44 with Linux 7.1.13. It ran
`scripts/compare-batched-sends.sh` at 541d4c1, which made every build of busd with rustc 1.99.0.
dbus-broker 37 and dbus-daemon 1.16.2 are Fedora's. Compare the brokers with each other, within
this file only.

The builds of busd are those of [the run on a Xeon VM](2026-10-24-busd-batched-sends-xeon-4vcpu.md),
which describes them: **queue**, 0c52e9c, busd's main branch with a queue for each client;
**baseline**, 0b89e3a, busd's main branch since, which writes each message that it forwards to a
client with a system call of its own, within a time limit of 100 ms; and **batched**, 4f346a3,
which forwards the messages of each peer in batches, and writes those of a batch that go to a
client in one go, with `Connection::send_all` of zbus, all three on zruntime 99e2ebd.

## Summary

* batched is level with baseline on the method calls, the round trips and the connection that 100
  proxies share: within 5%, or inconclusive with intervals that reach no higher than +6.7%. It is
  faster on the signals, by 4.8% on the burst to one subscriber and 5.1% on the broadcast to 20
  (both inconclusive, from 4.1 to 6.1%), with 29.2% less CPU time of the broker, and 43.1% less
  system time. It uses 7.0% less CPU time on the latencies.
* Its delivery of signals to 20 subscribers takes 18% longer for each signal, at the median and
  p99, while the whole fan-out takes 3.0% less time: more signals are on their way at once, which
  the delay of each counts, but the subscribers get them no later. See
  [the delivery of signals to 20 subscribers](#the-delivery-of-signals-to-20-subscribers).
* Against the queue, batched is level or better, apart from the connection that 100 proxies share,
  which takes 8.5% longer, as with baseline (+10.6%). A burst of signals to one subscriber is 22.8%
  faster, the delivery of signals to 20 subscribers takes 53% less time at the median and 64% less
  at p99, and the signal workload's peak memory is 88% smaller.
* Against dbus-broker, batched is slower on one busy connection: calls take 19.0% longer, round
  trips 14.2% longer at the median and 38.0% at p99, and the connection that 100 proxies share 6.9%
  longer. With 20 connections and more, it is level or better, but for the round trips at p99, 21.8%
  longer. It is level on the signals, with as much CPU time (+1.5%), where baseline uses 43.4% more,
  and its delivery of signals to 20 subscribers takes 51% less time at the median and 62% less at
  p99. It uses 12.4 to 25.2% more CPU time on the rest. Its peak memory is 18.8 to 83.9% smaller,
  but on the shared connection, 19.2% larger.
* Against dbus-daemon, batched takes 38 to 70% less time on every workload, the whole fan-out to 20
  subscribers included, and uses 66 to 82% less CPU time, with 7.0 to 32.7% more peak memory. Its
  delivery of each signal to 20 subscribers takes 47% longer at the median and 17% at p99, as
  dbus-daemon has far fewer of them on their way at once.
* No run of any broker failed.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), with 60 rounds
of each, and 40 of the shared connection, after 3 of warm-up, all five brokers in each round. The
raw results of each run are in [runs.tar.xz](2026-10-24-busd-batched-sends-ryzen-7840u/runs.tar.xz),
from which [paired-stats.py](../scripts/paired-stats.py) makes the comparisons, with the other
metrics and the medians. A star marks a difference whose 95% interval excludes 0 but not the margin.
The whole fan-out is how long the delivery of all the signals to 20 subscribers takes.

### batched against baseline

| Measure | n | baseline | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.071 s | 0.072 s | +2.1% | +0.7, +3.6 | within ±5%* |
| calls, 20 connections | 60 | 0.451 s | 0.453 s | +0.5% | -0.3, +1.3 | within ±5% |
| signals, burst to 1 | 60 | 0.314 s | 0.299 s | -4.8% | -5.4, -4.2 | inconclusive* |
| signals, broadcast to 20 | 60 | 0.377 s | 0.358 s | -5.1% | -6.1, -4.1 | inconclusive* |
| RTT, 1 connection, p50 | 60 | 61 µs | 62 µs | +0.7% | -0.1, +1.7 | within ±5% |
| RTT, 1 connection, p99 | 60 | 114 µs | 117 µs | +2.4% | -1.7, +6.7 | inconclusive |
| RTT, 20 connections, p50 | 60 | 480 µs | 480 µs | +0.2% | -0.7, +1.0 | within ±5% |
| RTT, 20 connections, p99 | 60 | 800 µs | 823 µs | +2.9% | -0.5, +6.3 | inconclusive |
| delivery to 20, p50 | 60 | 22.8 ms | 26.9 ms | +18.4% | +17.0, +19.8 | **worse** |
| delivery to 20, p99 | 60 | 29.1 ms | 34.4 ms | +18.2% | +15.8, +20.6 | **worse** |
| delivery to 20, whole fan-out | 60 | 0.256 s | 0.248 s | -3.0% | -4.0, -2.0 | within ±5%* |
| 100 proxies, 1 connection | 40 | 2.08 s | 2.04 s | -1.9% | -3.0, -0.8 | within ±5%* |
| 100 connections | 40 | 2.25 s | 2.24 s | -0.4% | -1.6, +1.0 | within ±5% |
| calls, broker CPU | 60 | 0.41 s | 0.42 s | +1.8% | +1.1, +2.5 | within ±5%* |
| signals, broker CPU | 60 | 0.53 s | 0.37 s | -29.2% | -29.7, -28.8 | **better** |
| latency, broker CPU | 60 | 0.64 s | 0.59 s | -7.0% | -7.8, -6.2 | **better** |
| shared, broker CPU | 40 | 3.45 s | 3.40 s | -1.4% | -2.5, -0.3 | within ±5%* |
| calls, broker system time | 60 | 0.22 s | 0.22 s | +1.1% | -0.6, +2.8 | within ±5% |
| signals, broker system time | 60 | 0.25 s | 0.14 s | -43.1% | -44.3, -41.9 | **better** |
| latency, broker system time | 60 | 0.34 s | 0.30 s | -10.7% | -11.9, -9.4 | **better** |
| shared, broker system time | 40 | 1.81 s | 1.76 s | -2.5% | -4.1, -0.8 | within ±5%* |
| calls, broker peak RSS | 60 | 6.5 MiB | 6.5 MiB | -0.0% | -0.7, +0.6 | within ±5% |
| signals, broker peak RSS | 60 | 6.5 MiB | 6.5 MiB | +0.3% | -0.3, +0.9 | within ±5% |
| latency, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | +0.4% | -0.1, +0.8 | within ±5% |
| shared, broker peak RSS | 40 | 11.1 MiB | 11.0 MiB | -1.1% | -2.7, +0.6 | within ±5% |

### batched against the queue

| Measure | n | queue | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.072 s | 0.072 s | +0.8% | -0.2, +2.0 | within ±5% |
| calls, 20 connections | 60 | 0.453 s | 0.453 s | +0.0% | -0.8, +0.8 | within ±5% |
| signals, burst to 1 | 60 | 0.387 s | 0.299 s | -22.8% | -23.3, -22.2 | **better** |
| signals, broadcast to 20 | 60 | 0.380 s | 0.358 s | -5.8% | -6.7, -4.9 | inconclusive* |
| RTT, 1 connection, p50 | 60 | 62 µs | 62 µs | -0.5% | -1.7, +0.6 | within ±5% |
| RTT, 1 connection, p99 | 60 | 115 µs | 117 µs | +1.5% | -2.7, +6.0 | inconclusive |
| RTT, 20 connections, p50 | 60 | 479 µs | 480 µs | +0.3% | -0.6, +1.2 | within ±5% |
| RTT, 20 connections, p99 | 60 | 807 µs | 823 µs | +1.9% | -2.5, +6.5 | inconclusive |
| delivery to 20, p50 | 60 | 57.8 ms | 26.9 ms | -53.3% | -54.1, -52.6 | **better** |
| delivery to 20, p99 | 60 | 96.3 ms | 34.4 ms | -64.3% | -64.8, -63.8 | **better** |
| delivery to 20, whole fan-out | 60 | 0.256 s | 0.248 s | -3.1% | -4.1, -2.2 | within ±5%* |
| 100 proxies, 1 connection | 40 | 1.88 s | 2.04 s | +8.5% | +7.0, +9.8 | **worse** |
| 100 connections | 40 | 2.26 s | 2.24 s | -0.7% | -2.2, +0.8 | within ±5% |
| calls, broker CPU | 60 | 0.42 s | 0.42 s | +1.0% | +0.3, +1.8 | within ±5%* |
| signals, broker CPU | 60 | 0.53 s | 0.37 s | -29.5% | -30.0, -28.9 | **better** |
| latency, broker CPU | 60 | 0.64 s | 0.59 s | -7.0% | -7.9, -6.1 | **better** |
| shared, broker CPU | 40 | 3.42 s | 3.40 s | -0.6% | -2.0, +0.7 | within ±5% |
| calls, broker peak RSS | 60 | 6.6 MiB | 6.5 MiB | -0.4% | -1.1, +0.3 | within ±5% |
| signals, broker peak RSS | 60 | 53.9 MiB | 6.5 MiB | -88.0% | -88.1, -87.9 | **better** |
| latency, broker peak RSS | 60 | 7.9 MiB | 6.9 MiB | -12.3% | -13.1, -11.5 | **better** |
| shared, broker peak RSS | 40 | 11.5 MiB | 11.0 MiB | -4.7% | -6.0, -3.3 | inconclusive* |

baseline is further behind the queue on the shared connection, +10.6% (from +8.9 to +12.0), less far
ahead of it on the burst of signals, -18.9%, and level with it on the broadcast, -0.7%.

### batched against dbus-broker

| Measure | n | dbus-broker | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.061 s | 0.072 s | +19.0% | +17.5, +20.5 | **worse** |
| calls, 20 connections | 60 | 0.435 s | 0.453 s | +4.1% | +3.1, +5.2 | inconclusive* |
| signals, burst to 1 | 60 | 0.303 s | 0.299 s | -1.5% | -2.0, -0.9 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.375 s | 0.358 s | -4.5% | -5.2, -3.8 | inconclusive* |
| RTT, 1 connection, p50 | 60 | 54 µs | 62 µs | +14.2% | +13.2, +15.3 | **worse** |
| RTT, 1 connection, p99 | 60 | 85 µs | 117 µs | +38.0% | +32.7, +43.4 | **worse** |
| RTT, 20 connections, p50 | 60 | 511 µs | 480 µs | -6.0% | -6.7, -5.2 | **better** |
| RTT, 20 connections, p99 | 60 | 675 µs | 823 µs | +21.8% | +17.0, +26.9 | **worse** |
| delivery to 20, p50 | 60 | 55.3 ms | 26.9 ms | -51.3% | -51.9, -50.6 | **better** |
| delivery to 20, p99 | 60 | 89.9 ms | 34.4 ms | -61.8% | -62.4, -61.1 | **better** |
| delivery to 20, whole fan-out | 60 | 0.255 s | 0.248 s | -2.6% | -3.7, -1.5 | within ±5%* |
| 100 proxies, 1 connection | 40 | 1.91 s | 2.04 s | +6.9% | +5.7, +8.0 | **worse** |
| 100 connections | 40 | 2.17 s | 2.24 s | +3.1% | +1.6, +4.6 | within ±5%* |
| calls, broker CPU | 60 | 0.35 s | 0.42 s | +22.0% | +20.9, +23.0 | **worse** |
| signals, broker CPU | 60 | 0.37 s | 0.37 s | +1.5% | +0.5, +2.6 | within ±5%* |
| latency, broker CPU | 60 | 0.53 s | 0.59 s | +12.4% | +11.3, +13.5 | **worse** |
| shared, broker CPU | 40 | 2.72 s | 3.40 s | +25.2% | +23.9, +26.6 | **worse** |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.5 MiB | -18.8% | -19.4, -18.2 | **better** |
| signals, broker peak RSS | 60 | 40.1 MiB | 6.5 MiB | -83.9% | -84.0, -83.7 | **better** |
| latency, broker peak RSS | 60 | 11.6 MiB | 6.9 MiB | -40.2% | -40.6, -39.9 | **better** |
| shared, broker peak RSS | 40 | 9.2 MiB | 11.0 MiB | +19.2% | +17.5, +21.0 | **worse** |

baseline is where batched is against dbus-broker, but on the signals, +3.5% on the burst and +0.6%
on the broadcast, with 43.4% more CPU time, and on the delivery of each signal to 20 subscribers,
which takes 59% less time at the median and 68% less at p99.

### batched against dbus-daemon

| Measure | n | dbus-daemon | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.138 s | 0.072 s | -47.7% | -48.4, -46.9 | **better** |
| calls, 20 connections | 60 | 1.155 s | 0.453 s | -60.8% | -61.1, -60.5 | **better** |
| signals, burst to 1 | 60 | 0.858 s | 0.299 s | -65.2% | -65.4, -65.0 | **better** |
| signals, broadcast to 20 | 60 | 1.207 s | 0.358 s | -70.3% | -70.5, -70.1 | **better** |
| RTT, 1 connection, p50 | 60 | 100 µs | 62 µs | -38.3% | -38.8, -37.7 | **better** |
| RTT, 1 connection, p99 | 60 | 204 µs | 117 µs | -42.6% | -44.6, -40.5 | **better** |
| RTT, 20 connections, p50 | 60 | 1065 µs | 480 µs | -54.9% | -55.2, -54.6 | **better** |
| RTT, 20 connections, p99 | 60 | 1676 µs | 823 µs | -50.9% | -52.3, -49.6 | **better** |
| delivery to 20, p50 | 60 | 18.3 ms | 26.9 ms | +47.0% | +45.7, +48.4 | **worse** |
| delivery to 20, p99 | 60 | 29.4 ms | 34.4 ms | +17.0% | +15.3, +18.8 | **worse** |
| delivery to 20, whole fan-out | 60 | 0.607 s | 0.248 s | -59.2% | -59.5, -58.8 | **better** |
| 100 proxies, 1 connection | 40 | 6.39 s | 2.04 s | -68.1% | -68.4, -67.9 | **better** |
| 100 connections | 40 | 5.75 s | 2.24 s | -61.0% | -61.4, -60.6 | **better** |
| calls, broker CPU | 60 | 1.25 s | 0.42 s | -66.4% | -66.6, -66.1 | **better** |
| signals, broker CPU | 60 | 2.08 s | 0.37 s | -82.1% | -82.2, -82.0 | **better** |
| latency, broker CPU | 60 | 2.08 s | 0.59 s | -71.5% | -71.7, -71.3 | **better** |
| shared, broker CPU | 40 | 12.15 s | 3.40 s | -72.0% | -72.2, -71.8 | **better** |
| calls, broker peak RSS | 60 | 6.1 MiB | 6.5 MiB | +7.0% | +6.3, +7.7 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.5 MiB | +17.1% | +16.2, +18.0 | **worse** |
| latency, broker peak RSS | 60 | 6.2 MiB | 6.9 MiB | +11.7% | +11.0, +12.4 | **worse** |
| shared, broker peak RSS | 40 | 8.3 MiB | 11.0 MiB | +32.7% | +30.9, +34.5 | **worse** |

### The delivery of signals to 20 subscribers

In this scenario of the latencies, one connection broadcasts 2000 signals back to back, and 20
others receive each of them, all on the client's one thread. The delay of a signal counts from just
before the emitter builds it until a subscriber has taken it off its stream, so it is mostly how
long the signal waits for those before it. batched forwards the emitter's signals with fewer system
calls for each, and more of them are on their way at once: by Little's law, the 40,000 deliveries
over the time that they take, times their mean delay, about 211 signals for each subscriber, against
179 with baseline. The subscribers get them no later: all of the fan-out takes 3.0% less time, 248.1
ms against 255.9 ms. On the VM, batched had as many more signals on their way, 206 against 178, but
there the whole fan-out took 15.6% less time with it, which made up for that: its delays were
level with baseline's.

The other brokers show the same: dbus-daemon, which takes 2.4 times as long as batched over all of
the fan-out, has the shortest delays, 18.3 ms at the median, with about 60 signals for each
subscriber on their way, and the queue and dbus-broker, which take as long as baseline, the longest,
with more than 400.

### The connection that 100 proxies share

In this phase, one connection serves an object and makes 100,000 calls to it through the bus, 100 at
a time, each with 16 KiB of data. A call takes a batch past 16 KiB, so a batch of batched holds one
call at most, after replies. Taking the multi-client phase's CPU time out of each run's whole, the
phase's means are:

| Broker | Phase | Client CPU | Broker CPU | Client's waits | Broker's waits |
|---|---:|---:|---:|---:|---:|
| baseline | 2.08 s | 1.97 s | 1.57 s | 2872 | 14887 |
| batched | 2.04 s | 1.94 s | 1.46 s | 2832 | 14890 |
| queue | 1.88 s | 1.84 s | 1.46 s | 2668 | 12133 |
| dbus-broker | 1.91 s | 1.91 s | 1.19 s | 430 | 107222 |
| dbus-daemon | 6.39 s | 3.82 s | 6.43 s | 212677 | 26 |

The client's and the broker's waits are their voluntary context switches, over both phases.

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at 541d4c1 builds the brokers and runs all of this, in about 39 minutes on this laptop once the
builds are made, and writes its results to `$WORK/batched-sends-results-4f346a3`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`.