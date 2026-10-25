# busd's batched sends with a write for each batch, on a Ryzen 7 7840U

Measured on 2026-10-24 on the laptop of
[busd forwarding in batches on a Ryzen 7 7840U](2026-10-24-busd-batched-sends-ryzen-7840u.md), after
that run: an AMD Ryzen 7 7840U (8 cores, 16 threads), running Fedora 44 with Linux 7.1.13. It ran
`scripts/compare-batched-sends.sh` at d116547, which made every build of busd with rustc 1.99.0.
dbus-broker 37 and dbus-daemon 1.16.2 are Fedora's. Compare the brokers with each other, within
this file only.

The builds of busd are those of
[the run on a Xeon VM](2026-10-24-busd-batched-sends-one-write-xeon-4vcpu.md), which describes them:
**queue**, 0c52e9c, busd's main branch with a queue for each client; **baseline**, 0b89e3a, busd's
main branch since, which writes each message that it forwards to a client with a system call of its
own, within a time limit of 100 ms; **batched-before**, 4f346a3, which forwards the messages of each
peer in batches, on a commit of zbus that ended each write before the message that would take it
past 16 KiB; and **batched**, ac6e6fa, the same on a commit of zbus that ends each write with that
message, so that a batch goes in one write. All four run on zruntime 99e2ebd.

## Summary

* batched is level with batched-before on every workload, but for the system time of the broker on
  the signals, which is 10.9% lower (from 8.7 to 13.1%), with 4.0% less CPU time on them, a
  broadcast to 20 subscribers 2.1% faster and a burst to one 1.0% faster, all three within 5%. The
  whole fan-out of the latencies' signals to 20 subscribers takes 2.3% less time, and the delivery
  of each signal 2.2% longer at the median and 3.5% at p99.
* Against baseline, batched is faster on the signals, by 6.9% on the burst and 6.7% on the
  broadcast, with 31.7% less CPU time of the broker on them, and 48.3% less system time, and it uses
  9.1% less CPU time on the latencies. It is level on the calls, the round trips and the connection
  that 100 proxies share. The whole fan-out takes 6.9% less time, while the delivery of each signal
  takes 18.5% longer at the median and 19.1% at p99: see
  [the delivery of signals to 20 subscribers](#batched-against-baseline).
* Against the queue, batched is level or better, apart from the connection that 100 proxies share,
  which takes 7.8% longer. A burst of signals to one subscriber is 23.9% faster, a broadcast to 20
  8.0% faster, the delivery of signals to 20 subscribers takes 53% less time at the median and 63%
  less at p99, and the signal workload's peak memory is 88% smaller.
* Against dbus-broker, batched is slower on one busy connection: calls take 17.5% longer, round
  trips 15.4% longer at the median and 37.3% at p99, and the connection that 100 proxies share 6.3%
  longer. With 20 connections and more, the calls take 4.6% longer and the 100 connections 4.7%
  (both inconclusive), the round trips are 6.3% shorter at the median and 15.6% longer at p99, and
  its delivery of signals to 20 subscribers takes 50% less time at the median and 60% less at p99.
  On the signals, it is level or faster, with 6.8% less CPU time, and it uses 9.3 to 25.5% more on
  the rest. Its peak memory is 19.0 to 83.5% smaller, but on the shared connection, 22.0% larger.
* Against dbus-daemon, batched takes 38.6 to 70.7% less time on every workload, the whole fan-out
  included, and 66.6 to 83.0% less CPU time, with 7.2 to 34.2% more peak memory. Its delivery of
  each signal to 20 subscribers takes 48.5% longer at the median and 21.9% at p99, as dbus-daemon
  has far fewer of them on their way at once.
* No run of any broker failed.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), with 60 rounds
of each, and 40 of the shared connection, after 3 of warm-up, all six brokers in each round. The raw
results of each run are in
[runs.tar.xz](2026-10-24-busd-batched-sends-one-write-ryzen-7840u/runs.tar.xz), from which
[paired-stats.py](../scripts/paired-stats.py) makes the comparisons, with the other metrics and the
medians. A star marks a difference whose 95% interval excludes 0 but not the margin. The whole
fan-out is how long the delivery of all the signals to 20 subscribers takes.

### batched against batched-before

| Measure | n | batched-before | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.071 s | 0.071 s | +0.2% | -1.0, +1.3 | within ±5% |
| calls, 20 connections | 60 | 0.465 s | 0.465 s | -0.1% | -1.2, +1.0 | within ±5% |
| signals, burst to 1 | 60 | 0.304 s | 0.301 s | -1.0% | -1.7, -0.2 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.373 s | 0.365 s | -2.1% | -3.0, -1.2 | within ±5%* |
| RTT, 1 connection, p50 | 60 | 62 µs | 62 µs | +0.6% | -0.4, +1.6 | within ±5% |
| RTT, 1 connection, p99 | 60 | 122 µs | 125 µs | +2.2% | -0.9, +5.3 | within ±5% |
| RTT, 20 connections, p50 | 60 | 485 µs | 486 µs | +0.2% | -0.3, +0.8 | within ±5% |
| RTT, 20 connections, p99 | 60 | 909 µs | 896 µs | -1.4% | -4.4, +1.7 | within ±5% |
| delivery to 20, p50 | 60 | 27.3 ms | 27.9 ms | +2.2% | +0.9, +3.7 | within ±5%* |
| delivery to 20, p99 | 60 | 35.3 ms | 36.6 ms | +3.5% | +1.4, +5.6 | inconclusive* |
| delivery to 20, whole fan-out | 60 | 0.252 s | 0.246 s | -2.3% | -3.3, -1.4 | within ±5%* |
| 100 proxies, 1 connection | 40 | 1.97 s | 1.97 s | -0.4% | -1.4, +0.7 | within ±5% |
| 100 connections | 40 | 2.16 s | 2.20 s | +1.5% | +0.4, +2.6 | within ±5%* |
| calls, broker CPU | 60 | 0.43 s | 0.43 s | -0.3% | -1.3, +0.8 | within ±5% |
| signals, broker CPU | 60 | 0.38 s | 0.36 s | -4.0% | -4.7, -3.3 | within ±5%* |
| latency, broker CPU | 60 | 0.61 s | 0.60 s | -0.8% | -1.5, -0.1 | within ±5%* |
| shared, broker CPU | 40 | 3.26 s | 3.28 s | +0.6% | -0.7, +1.9 | within ±5% |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -2.2% | -3.9, -0.5 | within ±5%* |
| signals, broker system time | 60 | 0.15 s | 0.13 s | -10.9% | -13.1, -8.7 | **better** |
| latency, broker system time | 60 | 0.31 s | 0.30 s | -2.0% | -3.8, -0.2 | within ±5%* |
| shared, broker system time | 40 | 1.71 s | 1.72 s | +0.6% | -1.5, +2.6 | within ±5% |
| calls, broker peak RSS | 60 | 6.5 MiB | 6.5 MiB | +0.3% | -0.3, +0.9 | within ±5% |
| signals, broker peak RSS | 60 | 6.4 MiB | 6.4 MiB | -0.0% | -0.7, +0.7 | within ±5% |
| latency, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | +0.1% | -0.5, +0.7 | within ±5% |
| shared, broker peak RSS | 40 | 11.2 MiB | 11.1 MiB | -1.1% | -2.6, +0.4 | within ±5% |

The signals of the benchmark, of 1,172 bytes each, go up to 14 to a batch, the 14th taking it past
16 KiB: batched writes a batch of 14 to a subscriber with one system call, where batched-before
wrote 13 and then 1. On the VM, under strace, batched-before wrote the signals of the signal
workload to their subscribers with 17,045 system calls and batched with 9,386, for 120,000
deliveries.

### batched against baseline

| Measure | n | baseline | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.070 s | 0.071 s | +1.5% | +0.1, +2.9 | within ±5%* |
| calls, 20 connections | 60 | 0.467 s | 0.465 s | -0.6% | -1.7, +0.5 | within ±5% |
| signals, burst to 1 | 60 | 0.324 s | 0.301 s | -6.9% | -7.6, -6.1 | **better** |
| signals, broadcast to 20 | 60 | 0.391 s | 0.365 s | -6.7% | -7.6, -5.8 | **better** |
| RTT, 1 connection, p50 | 60 | 62 µs | 62 µs | +0.8% | -0.1, +1.7 | within ±5% |
| RTT, 1 connection, p99 | 60 | 122 µs | 125 µs | +2.7% | -1.1, +6.6 | inconclusive |
| RTT, 20 connections, p50 | 60 | 486 µs | 486 µs | -0.0% | -0.6, +0.6 | within ±5% |
| RTT, 20 connections, p99 | 60 | 918 µs | 896 µs | -2.4% | -5.6, +1.1 | inconclusive |
| delivery to 20, p50 | 60 | 23.5 ms | 27.9 ms | +18.5% | +16.5, +20.5 | **worse** |
| delivery to 20, p99 | 60 | 30.7 ms | 36.6 ms | +19.1% | +16.1, +21.9 | **worse** |
| delivery to 20, whole fan-out | 60 | 0.264 s | 0.246 s | -6.9% | -8.0, -5.8 | **better** |
| 100 proxies, 1 connection | 40 | 2.01 s | 1.97 s | -2.2% | -3.1, -1.4 | within ±5%* |
| 100 connections | 40 | 2.19 s | 2.20 s | +0.5% | -0.8, +1.7 | within ±5% |
| calls, broker CPU | 60 | 0.43 s | 0.43 s | -0.4% | -1.4, +0.6 | within ±5% |
| signals, broker CPU | 60 | 0.53 s | 0.36 s | -31.7% | -32.2, -31.2 | **better** |
| latency, broker CPU | 60 | 0.67 s | 0.60 s | -9.1% | -9.9, -8.3 | **better** |
| shared, broker CPU | 40 | 3.34 s | 3.28 s | -1.7% | -2.7, -0.7 | within ±5%* |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -2.0% | -4.1, -0.0 | within ±5%* |
| signals, broker system time | 60 | 0.25 s | 0.13 s | -48.3% | -49.5, -47.2 | **better** |
| latency, broker system time | 60 | 0.35 s | 0.30 s | -13.2% | -14.8, -11.5 | **better** |
| shared, broker system time | 40 | 1.74 s | 1.72 s | -1.4% | -3.0, +0.3 | within ±5% |
| calls, broker peak RSS | 60 | 6.5 MiB | 6.5 MiB | -0.0% | -0.7, +0.7 | within ±5% |
| signals, broker peak RSS | 60 | 6.4 MiB | 6.4 MiB | +0.3% | -0.3, +0.9 | within ±5% |
| latency, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | +0.3% | -0.2, +0.8 | within ±5% |
| shared, broker peak RSS | 40 | 11.3 MiB | 11.1 MiB | -1.8% | -3.6, +0.1 | within ±5% |

The delivery of each signal to 20 subscribers counts how long it waits for those before it, as
[the earlier run](2026-10-24-busd-batched-sends-ryzen-7840u.md) explains, and every build that
forwards the signals faster has more of them on their way at once, and a longer delay for each,
while all of them arrive sooner. By Little's law, the 40,000 deliveries over the time that they
take, times their mean delay, the signals on their way to each subscriber are about 179 with
baseline, 211 with batched-before and 223 with batched, and the whole fan-out takes 264.2, 251.9 and
246.0 ms.

### batched against the queue

| Measure | n | queue | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.072 s | 0.071 s | -0.6% | -1.6, +0.5 | within ±5% |
| calls, 20 connections | 60 | 0.464 s | 0.465 s | +0.2% | -0.9, +1.3 | within ±5% |
| signals, burst to 1 | 60 | 0.396 s | 0.301 s | -23.9% | -24.5, -23.3 | **better** |
| signals, broadcast to 20 | 60 | 0.396 s | 0.365 s | -8.0% | -8.8, -7.1 | **better** |
| RTT, 1 connection, p50 | 60 | 62 µs | 62 µs | +0.8% | -0.1, +1.7 | within ±5% |
| RTT, 1 connection, p99 | 60 | 121 µs | 125 µs | +2.8% | -1.6, +7.6 | inconclusive |
| RTT, 20 connections, p50 | 60 | 485 µs | 486 µs | +0.2% | -0.2, +0.7 | within ±5% |
| RTT, 20 connections, p99 | 60 | 889 µs | 896 µs | +0.7% | -2.7, +4.3 | within ±5% |
| delivery to 20, p50 | 60 | 59.2 ms | 27.9 ms | -52.9% | -53.7, -52.2 | **better** |
| delivery to 20, p99 | 60 | 98.9 ms | 36.6 ms | -63.1% | -63.7, -62.5 | **better** |
| delivery to 20, whole fan-out | 60 | 0.264 s | 0.246 s | -6.7% | -7.5, -5.9 | **better** |
| 100 proxies, 1 connection | 40 | 1.82 s | 1.97 s | +7.8% | +6.6, +9.0 | **worse** |
| 100 connections | 40 | 2.19 s | 2.20 s | +0.5% | -0.7, +1.7 | within ±5% |
| calls, broker CPU | 60 | 0.43 s | 0.43 s | +0.1% | -0.8, +1.1 | within ±5% |
| signals, broker CPU | 60 | 0.55 s | 0.36 s | -33.4% | -34.0, -32.8 | **better** |
| latency, broker CPU | 60 | 0.66 s | 0.60 s | -8.6% | -9.3, -7.9 | **better** |
| shared, broker CPU | 40 | 3.30 s | 3.28 s | -0.7% | -1.7, +0.4 | within ±5% |
| calls, broker peak RSS | 60 | 6.6 MiB | 6.5 MiB | -0.2% | -0.9, +0.5 | within ±5% |
| signals, broker peak RSS | 60 | 53.9 MiB | 6.4 MiB | -88.1% | -88.1, -88.0 | **better** |
| latency, broker peak RSS | 60 | 8.0 MiB | 6.9 MiB | -13.0% | -13.7, -12.3 | **better** |
| shared, broker peak RSS | 40 | 11.5 MiB | 11.1 MiB | -3.7% | -5.5, -1.7 | inconclusive* |

### batched against dbus-broker

| Measure | n | dbus-broker | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.061 s | 0.071 s | +17.5% | +16.1, +18.8 | **worse** |
| calls, 20 connections | 60 | 0.444 s | 0.465 s | +4.6% | +3.4, +5.8 | inconclusive* |
| signals, burst to 1 | 60 | 0.309 s | 0.301 s | -2.5% | -3.2, -1.8 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.387 s | 0.365 s | -5.8% | -6.6, -4.9 | inconclusive* |
| RTT, 1 connection, p50 | 60 | 54 µs | 62 µs | +15.4% | +14.4, +16.4 | **worse** |
| RTT, 1 connection, p99 | 60 | 91 µs | 125 µs | +37.3% | +32.7, +41.9 | **worse** |
| RTT, 20 connections, p50 | 60 | 519 µs | 486 µs | -6.3% | -6.8, -5.8 | **better** |
| RTT, 20 connections, p99 | 60 | 775 µs | 896 µs | +15.6% | +10.5, +20.8 | **worse** |
| delivery to 20, p50 | 60 | 56.3 ms | 27.9 ms | -50.5% | -51.2, -49.7 | **better** |
| delivery to 20, p99 | 60 | 92.3 ms | 36.6 ms | -60.4% | -61.0, -59.8 | **better** |
| delivery to 20, whole fan-out | 60 | 0.260 s | 0.246 s | -5.5% | -6.3, -4.7 | inconclusive* |
| 100 proxies, 1 connection | 40 | 1.85 s | 1.97 s | +6.3% | +5.3, +7.3 | **worse** |
| 100 connections | 40 | 2.10 s | 2.20 s | +4.7% | +3.7, +5.7 | inconclusive* |
| calls, broker CPU | 60 | 0.35 s | 0.43 s | +20.4% | +19.2, +21.5 | **worse** |
| signals, broker CPU | 60 | 0.39 s | 0.36 s | -6.8% | -7.5, -6.0 | **better** |
| latency, broker CPU | 60 | 0.55 s | 0.60 s | +9.3% | +8.5, +10.1 | **worse** |
| shared, broker CPU | 40 | 2.61 s | 3.28 s | +25.5% | +24.2, +26.8 | **worse** |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.5 MiB | -19.0% | -19.6, -18.4 | **better** |
| signals, broker peak RSS | 60 | 39.1 MiB | 6.4 MiB | -83.5% | -83.8, -83.3 | **better** |
| latency, broker peak RSS | 60 | 11.5 MiB | 6.9 MiB | -39.7% | -40.0, -39.3 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 11.1 MiB | +22.0% | +20.1, +24.0 | **worse** |

### batched against dbus-daemon

| Measure | n | dbus-daemon | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.139 s | 0.071 s | -48.5% | -49.2, -47.8 | **better** |
| calls, 20 connections | 60 | 1.182 s | 0.465 s | -60.7% | -61.0, -60.3 | **better** |
| signals, burst to 1 | 60 | 0.882 s | 0.301 s | -65.8% | -66.1, -65.6 | **better** |
| signals, broadcast to 20 | 60 | 1.246 s | 0.365 s | -70.7% | -70.9, -70.5 | **better** |
| RTT, 1 connection, p50 | 60 | 102 µs | 62 µs | -38.6% | -39.1, -38.1 | **better** |
| RTT, 1 connection, p99 | 60 | 219 µs | 125 µs | -42.9% | -44.6, -41.0 | **better** |
| RTT, 20 connections, p50 | 60 | 1095 µs | 486 µs | -55.6% | -55.8, -55.4 | **better** |
| RTT, 20 connections, p99 | 60 | 1788 µs | 896 µs | -49.9% | -51.5, -48.3 | **better** |
| delivery to 20, p50 | 60 | 18.8 ms | 27.9 ms | +48.5% | +46.8, +50.3 | **worse** |
| delivery to 20, p99 | 60 | 30.0 ms | 36.6 ms | +21.9% | +20.0, +23.7 | **worse** |
| delivery to 20, whole fan-out | 60 | 0.621 s | 0.246 s | -60.4% | -60.6, -60.1 | **better** |
| 100 proxies, 1 connection | 40 | 6.32 s | 1.97 s | -68.9% | -69.1, -68.7 | **better** |
| 100 connections | 40 | 5.71 s | 2.20 s | -61.5% | -61.9, -61.2 | **better** |
| calls, broker CPU | 60 | 1.28 s | 0.43 s | -66.6% | -66.9, -66.3 | **better** |
| signals, broker CPU | 60 | 2.14 s | 0.36 s | -83.0% | -83.1, -82.9 | **better** |
| latency, broker CPU | 60 | 2.14 s | 0.60 s | -71.8% | -72.0, -71.6 | **better** |
| shared, broker CPU | 40 | 12.04 s | 3.28 s | -72.8% | -73.0, -72.5 | **better** |
| calls, broker peak RSS | 60 | 6.1 MiB | 6.5 MiB | +7.2% | +6.5, +7.9 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.4 MiB | +17.8% | +16.8, +18.7 | **worse** |
| latency, broker peak RSS | 60 | 6.2 MiB | 6.9 MiB | +12.1% | +11.4, +12.8 | **worse** |
| shared, broker peak RSS | 40 | 8.2 MiB | 11.1 MiB | +34.2% | +31.7, +36.5 | **worse** |

### The connection that 100 proxies share

In this phase, one connection serves an object and makes 100,000 calls to it through the bus, 100 at
a time, each with 16 KiB of data. A call takes a batch past 16 KiB, so a batch holds one call at
most, after replies. Taking the multi-client phase's CPU time out of each run's whole, the phase's
means are:

| Broker | Phase | Client CPU | Broker CPU | Client's waits | Broker's waits |
|---|---:|---:|---:|---:|---:|
| baseline | 2.01 s | 1.92 s | 1.51 s | 2366 | 15130 |
| batched-before | 1.97 s | 1.89 s | 1.42 s | 2050 | 15388 |
| batched | 1.97 s | 1.88 s | 1.40 s | 2273 | 15269 |
| queue | 1.82 s | 1.80 s | 1.41 s | 1865 | 12067 |
| dbus-broker | 1.85 s | 1.86 s | 1.14 s | 252 | 103067 |
| dbus-daemon | 6.32 s | 3.73 s | 6.36 s | 215731 | 23 |

The client's and the broker's waits are their voluntary context switches, over both phases.

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at d116547 builds the brokers and runs all of this, in about 44 minutes on this laptop once the
builds are made, and writes its results to `$WORK/batched-sends-results-ac6e6fa`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`.