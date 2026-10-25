# busd's batched sends, with a thread for each subscriber, on a Ryzen 7 7840U

Measured on 2026-10-25 on the laptop of
[a write for each batch](2026-10-24-busd-batched-sends-one-write-ryzen-7840u.md): an AMD Ryzen 7
7840U (8 cores, 16 threads), running Fedora 44 with Linux 7.1.13. It ran
`scripts/compare-batched-sends.sh` at f3d7be9, which made every build of busd with rustc 1.99.0.
dbus-broker 37 and dbus-daemon 1.16.2 are Fedora's. Compare the brokers with each other, within
this file only.

The builds of busd are those of that file, which describes them: **queue**, 0c52e9c; **baseline**,
0b89e3a, busd's main branch; **batched-before**, 4f346a3; and **batched**, ac6e6fa, which forwards
the messages of each peer in batches, and writes a batch to each of its recipients with one system
call. What changed is the clients of the signals and of the latencies' fan-out, as in
[the same run on a Xeon VM](2026-10-24-busd-batched-sends-subscriber-threads-xeon-4vcpu.md): each
subscriber runs on a thread of its own, with a runtime of its own, as a process of its own would,
and the emitter has the main thread to itself. They ran on one thread before, which held the faster
brokers back, and the delay of each signal of the fan-out counted mostly how long it waited for that
thread. The broadcast of the signal workload sends 6000 signals rather than 4000.

## Summary

* Against baseline, busd's main branch, batched gets the signals through far faster: the broadcast
  of 6000 signals to 20 subscribers takes 65.1% less time, 0.138 s against 0.395 s, and the burst to
  one subscriber 18.2% less. In the latencies' fan-out, a signal reaches each of 20 subscribers 70%
  sooner at the median and 61% at p99, and all of them are there 60% sooner, where the clients on
  one thread had each signal take 18.5% longer at the median. The broker uses 44.8% less CPU time on
  the signals, and 60.8% less system time, and 10.9% less CPU time on the latencies. The calls, the
  round trips, the shared connection and the peak memory are level: within 5%, but for the p99 of
  the round trips on one connection, inconclusive (+2.9%, from -0.8 to +6.9%).
* Against batched-before, whose zbus ended a write before the message that would take it past
  16 KiB, so that a batch could take two writes, batched gets the signals through faster: the
  broadcast takes 11.7% less time, a signal of the fan-out reaches the subscribers 25.7% sooner at
  the median and 10.9% at p99, and all of them are there 7.8% sooner, with 6.5% less CPU time of the
  broker on the signals, and 9.1% less system time. The rest is level, within 5%.
* Against the queue, batched is level or better, apart from the connection that 100 proxies share,
  8.0% slower. The burst and the broadcast take 42.8% and 43.0% less time, a signal of the fan-out
  64% less at the median and 62% less at p99, and the signal workload's peak memory is 88% smaller.
* Against dbus-broker, batched is slower on one busy connection: the calls take 16.1% longer, the
  round trips 15.0% longer at the median and 34.4% at p99, the burst to one subscriber 14.5% longer,
  and the connection that 100 proxies share 7.5% longer. With 20 connections, the calls take 3.3%
  longer (within 5%), the round trips 5.7% less at the median and 22.6% more at p99, and the 100
  connections 4.7% longer (inconclusive). On the signals to 20 subscribers, batched is faster: the
  broadcast takes 37.2% less time, and the whole fan-out 28.5% less, while each signal of it reaches
  the subscribers 7.0% later at the median and 9.8% at p99 (see
  [below](#batched-against-dbus-broker)). It uses 9.0% less CPU time on the signals, and 10.7 to
  26.4% more on the rest, with 15.1 to 57.7% less peak memory, but for the shared connection, 21.2%
  more.
* Against dbus-daemon, batched takes 38.6 to 93.1% less time on every measure, and 66.8 to 86.9%
  less CPU time, with 7.7 to 33.5% more peak memory.
* No run of any broker failed.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), but for the
clients above, with 60 rounds of each, and 40 of the shared connection, after 3 of warm-up, all six
brokers in each round. The raw results of each run are in the `.json` files of
[the directory](2026-10-25-busd-batched-sends-subscriber-threads-ryzen-7840u), and the comparisons,
with the other metrics and the medians, in its
[stats](2026-10-25-busd-batched-sends-subscriber-threads-ryzen-7840u/stats). A star marks a
difference whose 95% interval excludes 0 but not the margin. The whole fan-out is how long the
delivery of all the signals of the latencies' fan-out to 20 subscribers takes.

### batched against baseline

| Measure | n | baseline | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.070 s | 0.071 s | +1.5% | -0.1, +3.0 | within ±5% |
| calls, 20 connections | 60 | 0.449 s | 0.447 s | -0.5% | -1.4, +0.3 | within ±5% |
| signals, burst to 1 | 60 | 0.263 s | 0.216 s | -18.2% | -18.6, -17.7 | **better** |
| signals, broadcast to 20 | 60 | 0.395 s | 0.138 s | -65.1% | -65.2, -64.9 | **better** |
| RTT, 1 connection, p50 | 60 | 62 µs | 63 µs | +0.5% | -0.3, +1.5 | within ±5% |
| RTT, 1 connection, p99 | 60 | 111 µs | 114 µs | +2.9% | -0.8, +6.9 | inconclusive |
| RTT, 20 connections, p50 | 60 | 484 µs | 485 µs | +0.1% | -0.1, +0.4 | within ±5% |
| RTT, 20 connections, p99 | 60 | 882 µs | 890 µs | +0.9% | -1.8, +3.6 | within ±5% |
| delivery to 20, p50 | 60 | 7.5 ms | 2.3 ms | -70.0% | -70.2, -69.9 | **better** |
| delivery to 20, p99 | 60 | 9.9 ms | 3.8 ms | -61.2% | -61.9, -60.4 | **better** |
| delivery to 20, whole fan-out | 60 | 0.127 s | 0.050 s | -60.3% | -60.5, -60.1 | **better** |
| 100 proxies, 1 connection | 40 | 2.07 s | 2.03 s | -1.9% | -2.9, -0.9 | within ±5%* |
| 100 connections | 40 | 2.23 s | 2.24 s | +0.5% | -0.5, +1.4 | within ±5% |
| calls, broker CPU | 60 | 0.41 s | 0.41 s | +0.2% | -0.5, +1.0 | within ±5% |
| signals, broker CPU | 60 | 0.68 s | 0.38 s | -44.8% | -45.0, -44.6 | **better** |
| latency, broker CPU | 60 | 0.67 s | 0.60 s | -10.9% | -11.4, -10.5 | **better** |
| shared, broker CPU | 40 | 3.42 s | 3.40 s | -0.5% | -1.7, +0.7 | within ±5% |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -1.0% | -3.0, +1.0 | within ±5% |
| signals, broker system time | 60 | 0.36 s | 0.14 s | -60.8% | -61.5, -59.9 | **better** |
| latency, broker system time | 60 | 0.36 s | 0.30 s | -17.5% | -18.7, -16.5 | **better** |
| shared, broker system time | 40 | 1.79 s | 1.77 s | -1.0% | -2.6, +0.7 | within ±5% |
| calls, broker peak RSS | 60 | 6.5 MiB | 6.6 MiB | +0.4% | -0.2, +1.0 | within ±5% |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.2 MiB | +1.2% | +0.2, +2.2 | within ±5%* |
| latency, broker peak RSS | 60 | 6.8 MiB | 6.8 MiB | -0.1% | -0.8, +0.7 | within ±5% |
| shared, broker peak RSS | 40 | 11.2 MiB | 11.1 MiB | -1.2% | -2.7, +0.4 | within ±5% |

baseline writes each signal to each subscriber with a system call of its own, so that it uses 1.8
times the CPU time of batched on the signals, and 2.6 times the system time, 0.36 s against 0.14 s,
and the broadcast takes 2.9 times as long.

### batched against batched-before

| Measure | n | batched-before | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.071 s | 0.071 s | -0.0% | -1.3, +1.3 | within ±5% |
| calls, 20 connections | 60 | 0.448 s | 0.447 s | -0.2% | -1.0, +0.6 | within ±5% |
| signals, burst to 1 | 60 | 0.224 s | 0.216 s | -3.7% | -4.2, -3.1 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.156 s | 0.138 s | -11.7% | -12.1, -11.2 | **better** |
| RTT, 1 connection, p50 | 60 | 62 µs | 63 µs | +0.4% | -0.7, +1.6 | within ±5% |
| RTT, 1 connection, p99 | 60 | 114 µs | 114 µs | +0.0% | -3.7, +3.8 | within ±5% |
| RTT, 20 connections, p50 | 60 | 484 µs | 485 µs | +0.2% | -0.1, +0.5 | within ±5% |
| RTT, 20 connections, p99 | 60 | 891 µs | 890 µs | -0.2% | -3.3, +3.0 | within ±5% |
| delivery to 20, p50 | 60 | 3.0 ms | 2.3 ms | -25.7% | -26.2, -25.2 | **better** |
| delivery to 20, p99 | 60 | 4.3 ms | 3.8 ms | -10.9% | -12.7, -8.8 | **better** |
| delivery to 20, whole fan-out | 60 | 0.054 s | 0.050 s | -7.8% | -8.5, -7.2 | **better** |
| 100 proxies, 1 connection | 40 | 2.01 s | 2.03 s | +0.9% | -0.2, +2.0 | within ±5% |
| 100 connections | 40 | 2.23 s | 2.24 s | +0.2% | -0.9, +1.3 | within ±5% |
| calls, broker CPU | 60 | 0.41 s | 0.41 s | +0.1% | -0.7, +0.9 | within ±5% |
| signals, broker CPU | 60 | 0.40 s | 0.38 s | -6.5% | -6.9, -6.2 | **better** |
| latency, broker CPU | 60 | 0.60 s | 0.60 s | -0.9% | -1.5, -0.2 | within ±5%* |
| shared, broker CPU | 40 | 3.35 s | 3.40 s | +1.5% | +0.3, +2.9 | within ±5%* |
| calls, broker system time | 60 | 0.21 s | 0.22 s | +1.9% | -0.3, +4.1 | within ±5% |
| signals, broker system time | 60 | 0.15 s | 0.14 s | -9.1% | -11.0, -7.1 | **better** |
| latency, broker system time | 60 | 0.31 s | 0.30 s | -2.8% | -4.4, -1.3 | within ±5%* |
| shared, broker system time | 40 | 1.73 s | 1.77 s | +2.2% | +0.4, +4.2 | within ±5%* |

The two forward the same batches, but batched-before writes a batch whose last message takes it past
16 KiB in two writes, and batched in one: the signals of the benchmark, of 1,172 bytes each, go 14
to a full batch, the 14th taking it past 16 KiB.

### batched against the queue

| Measure | n | queue | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.071 s | 0.071 s | -0.8% | -2.1, +0.7 | within ±5% |
| calls, 20 connections | 60 | 0.447 s | 0.447 s | -0.1% | -0.9, +0.9 | within ±5% |
| signals, burst to 1 | 60 | 0.377 s | 0.216 s | -42.8% | -43.6, -42.0 | **better** |
| signals, broadcast to 20 | 60 | 0.242 s | 0.138 s | -43.0% | -43.5, -42.5 | **better** |
| RTT, 1 connection, p50 | 60 | 63 µs | 63 µs | -0.1% | -1.4, +1.3 | within ±5% |
| RTT, 1 connection, p99 | 60 | 116 µs | 114 µs | -1.5% | -5.4, +2.6 | within ±5% |
| RTT, 20 connections, p50 | 60 | 485 µs | 485 µs | -0.0% | -0.3, +0.3 | within ±5% |
| RTT, 20 connections, p99 | 60 | 878 µs | 890 µs | +1.4% | -1.4, +4.1 | within ±5% |
| delivery to 20, p50 | 60 | 6.3 ms | 2.3 ms | -64.1% | -64.5, -63.7 | **better** |
| delivery to 20, p99 | 60 | 10.0 ms | 3.8 ms | -61.8% | -62.6, -60.8 | **better** |
| delivery to 20, whole fan-out | 60 | 0.085 s | 0.050 s | -41.0% | -41.6, -40.4 | **better** |
| 100 proxies, 1 connection | 40 | 1.88 s | 2.03 s | +8.0% | +6.9, +9.2 | **worse** |
| 100 connections | 40 | 2.22 s | 2.24 s | +0.6% | -0.5, +1.8 | within ±5% |
| calls, broker CPU | 60 | 0.41 s | 0.41 s | +0.3% | -0.4, +1.1 | within ±5% |
| signals, broker CPU | 60 | 0.56 s | 0.38 s | -32.1% | -32.5, -31.8 | **better** |
| latency, broker CPU | 60 | 0.63 s | 0.60 s | -5.7% | -6.3, -5.1 | **better** |
| shared, broker CPU | 40 | 3.41 s | 3.40 s | -0.2% | -1.6, +1.2 | within ±5% |
| calls, broker peak RSS | 60 | 6.5 MiB | 6.6 MiB | +0.2% | -0.4, +0.9 | within ±5% |
| signals, broker peak RSS | 60 | 53.5 MiB | 6.2 MiB | -88.4% | -88.8, -87.8 | **better** |
| latency, broker peak RSS | 60 | 6.9 MiB | 6.8 MiB | -0.7% | -1.5, +0.1 | within ±5% |
| shared, broker peak RSS | 40 | 11.5 MiB | 11.1 MiB | -4.2% | -5.7, -2.7 | inconclusive* |

### batched against dbus-broker

| Measure | n | dbus-broker | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.061 s | 0.071 s | +16.1% | +14.2, +18.0 | **worse** |
| calls, 20 connections | 60 | 0.433 s | 0.447 s | +3.3% | +1.7, +4.5 | within ±5%* |
| signals, burst to 1 | 60 | 0.188 s | 0.216 s | +14.5% | +13.8, +15.2 | **worse** |
| signals, broadcast to 20 | 60 | 0.220 s | 0.138 s | -37.2% | -37.8, -36.6 | **better** |
| RTT, 1 connection, p50 | 60 | 54 µs | 63 µs | +15.0% | +13.7, +16.4 | **worse** |
| RTT, 1 connection, p99 | 60 | 85 µs | 114 µs | +34.4% | +29.0, +39.7 | **worse** |
| RTT, 20 connections, p50 | 60 | 514 µs | 485 µs | -5.7% | -6.0, -5.3 | **better** |
| RTT, 20 connections, p99 | 60 | 725 µs | 890 µs | +22.6% | +17.0, +28.0 | **worse** |
| delivery to 20, p50 | 60 | 2.1 ms | 2.3 ms | +7.0% | +5.9, +8.1 | **worse** |
| delivery to 20, p99 | 60 | 3.5 ms | 3.8 ms | +9.8% | +7.5, +12.2 | **worse** |
| delivery to 20, whole fan-out | 60 | 0.070 s | 0.050 s | -28.5% | -29.2, -27.8 | **better** |
| 100 proxies, 1 connection | 40 | 1.88 s | 2.03 s | +7.5% | +6.6, +8.6 | **worse** |
| 100 connections | 40 | 2.13 s | 2.24 s | +4.7% | +3.5, +6.0 | inconclusive* |
| calls, broker CPU | 60 | 0.34 s | 0.41 s | +20.7% | +19.6, +21.7 | **worse** |
| signals, broker CPU | 60 | 0.41 s | 0.38 s | -9.0% | -9.5, -8.4 | **better** |
| latency, broker CPU | 60 | 0.54 s | 0.60 s | +10.7% | +10.0, +11.5 | **worse** |
| shared, broker CPU | 40 | 2.69 s | 3.40 s | +26.4% | +24.9, +27.8 | **worse** |
| calls, broker peak RSS | 60 | 8.0 MiB | 6.6 MiB | -18.3% | -18.9, -17.8 | **better** |
| signals, broker peak RSS | 60 | 14.7 MiB | 6.2 MiB | -57.7% | -58.9, -56.6 | **better** |
| latency, broker peak RSS | 60 | 8.1 MiB | 6.8 MiB | -15.1% | -15.7, -14.5 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 11.1 MiB | +21.2% | +19.5, +23.1 | **worse** |

In the fan-out, of 2000 signals to each of 20 subscribers, batched delivers the signals at 1.4 times
the rate of dbus-broker, 796 a millisecond against 569, with 1.5 times as many of them on
their way at once, about 1800 against 1200, each of which waits a little longer: 2.25 ms on average
against 2.12 ms.

### batched against dbus-daemon

| Measure | n | dbus-daemon | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.135 s | 0.071 s | -47.7% | -48.4, -46.9 | **better** |
| calls, 20 connections | 60 | 1.154 s | 0.447 s | -61.3% | -61.6, -61.0 | **better** |
| signals, burst to 1 | 60 | 0.849 s | 0.216 s | -74.6% | -74.7, -74.5 | **better** |
| signals, broadcast to 20 | 60 | 2.010 s | 0.138 s | -93.1% | -93.2, -93.1 | **better** |
| RTT, 1 connection, p50 | 60 | 102 µs | 63 µs | -38.6% | -39.3, -37.9 | **better** |
| RTT, 1 connection, p99 | 60 | 201 µs | 114 µs | -43.3% | -45.6, -40.7 | **better** |
| RTT, 20 connections, p50 | 60 | 1087 µs | 485 µs | -55.4% | -55.5, -55.2 | **better** |
| RTT, 20 connections, p99 | 60 | 1704 µs | 890 µs | -47.8% | -49.4, -46.3 | **better** |
| delivery to 20, p50 | 60 | 20.4 ms | 2.3 ms | -88.9% | -89.0, -88.9 | **better** |
| delivery to 20, p99 | 60 | 32.9 ms | 3.8 ms | -88.4% | -88.6, -88.1 | **better** |
| delivery to 20, whole fan-out | 60 | 0.679 s | 0.050 s | -92.6% | -92.6, -92.6 | **better** |
| 100 proxies, 1 connection | 40 | 6.37 s | 2.03 s | -68.2% | -68.5, -67.9 | **better** |
| 100 connections | 40 | 5.78 s | 2.24 s | -61.3% | -61.6, -61.0 | **better** |
| calls, broker CPU | 60 | 1.25 s | 0.41 s | -66.8% | -67.1, -66.5 | **better** |
| signals, broker CPU | 60 | 2.87 s | 0.38 s | -86.9% | -86.9, -86.8 | **better** |
| latency, broker CPU | 60 | 2.19 s | 0.60 s | -72.8% | -72.9, -72.6 | **better** |
| shared, broker CPU | 40 | 12.16 s | 3.40 s | -72.0% | -72.3, -71.7 | **better** |
| calls, broker peak RSS | 60 | 6.1 MiB | 6.6 MiB | +7.7% | +7.0, +8.4 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.2 MiB | +13.1% | +12.2, +14.1 | **worse** |
| latency, broker peak RSS | 60 | 6.2 MiB | 6.8 MiB | +11.0% | +10.2, +11.8 | **worse** |
| shared, broker peak RSS | 40 | 8.3 MiB | 11.1 MiB | +33.5% | +31.2, +35.9 | **worse** |

### The connection that 100 proxies share

The clients of this phase didn't change. Taking the multi-client phase's CPU time out of each run's
whole, the phase's means are:

| Broker | Phase | Client CPU | Broker CPU | Client's waits | Broker's waits |
|---|---:|---:|---:|---:|---:|
| baseline | 2.07 s | 1.96 s | 1.55 s | 3234 | 14949 |
| batched-before | 2.01 s | 1.91 s | 1.44 s | 3212 | 15270 |
| batched | 2.03 s | 1.92 s | 1.46 s | 3195 | 14743 |
| queue | 1.88 s | 1.83 s | 1.45 s | 3216 | 11818 |
| dbus-broker | 1.88 s | 1.89 s | 1.18 s | 523 | 104300 |
| dbus-daemon | 6.37 s | 3.81 s | 6.41 s | 218938 | 26 |

The client's and the broker's waits are their voluntary context switches, over both phases.

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at f3d7be9 builds the brokers and runs all of this, in about 43 minutes on this laptop once the
builds are made, and writes these files to `$WORK/batched-sends-results-ac6e6fa`, with the
comparisons in pairs next to the others rather than in `stats`.
