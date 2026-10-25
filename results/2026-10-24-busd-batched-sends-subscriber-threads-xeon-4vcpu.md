# busd's batched sends, with a thread for each subscriber, on a 4-vCPU Xeon

Measured on 2026-10-24, on the VM of
[a write for each batch](2026-10-24-busd-batched-sends-one-write-xeon-4vcpu.md), after that run: 4
vCPUs of an Intel Xeon @ 2.80GHz under KVM, 15 GiB, Linux 6.18, Ubuntu 24.04.5. It ran
`scripts/compare-batched-sends.sh` at fd0bcaa, which made every build of busd with rustc 1.97.0.
dbus-broker is the 35 of Ubuntu 24.04, which ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py), and
dbus-daemon the 1.14.10 of Ubuntu 24.04. Compare the brokers with each other, within this file only.

The builds of busd are those of the earlier file, which describes them: **queue**, 0c52e9c;
**baseline**, 0b89e3a, busd's main branch; **batched-before**, 4f346a3; and **batched**, ac6e6fa,
which forwards the messages of each peer in batches, and writes a batch to each of its recipients
with one system call. What changed is the clients of the signals and of the latencies' fan-out
(6ac5fff and fd0bcaa): each subscriber runs on a thread of its own, with a runtime of its own, as a
process of its own would, and the emitter has the main thread to itself. They ran on one thread
before, which was what limited the faster brokers, and the delay of each signal of the fan-out
counted mostly how long it waited for that thread. The broadcast of the signal workload sends 6000
signals rather than 4000, so that it takes 0.2 s or more with the fastest brokers.

## Summary

* Against baseline, busd's main branch, batched gets the signals through far faster: the broadcast
  of 6000 signals to 20 subscribers takes 70.5% less time, 0.283 s against 0.959 s, and the burst to
  one subscriber 13.6% less. In the latencies' fan-out, a signal reaches each of 20 subscribers 72%
  sooner at the median and 67% at p99, and all of them are there 66% sooner. The broker uses 60%
  less CPU time on the signals, and 79% less system time, and 16% less CPU time on the latencies.
  The calls, the round trips and the shared connection are level: within 5%, or inconclusive, with
  the calls of 20 connections 3.7% slower (from +0.4 to +7.1%) and the broker's CPU time on the
  calls 5.2% higher (from +2.0 to +8.7%).
* Against batched-before, batched is level, or inconclusive, on every measure: the broadcast takes
  3.0% less time, and the broker's system time on the signals is 5.7% lower, and on the calls 9.6%
  higher, where the two make the same system calls (see below).
* Against the queue, batched is level or better, apart from the connection that 100 proxies share,
  5.0% slower (inconclusive). The burst is 34.4% faster and the broadcast 14.5% faster, a signal of
  the fan-out takes 49% less time at the median and 50% less at p99, and the signal workload's peak
  memory is 90% smaller.
* Against dbus-broker, batched is level on one connection, and 38 to 42% faster with 20 connections
  or 100, on the calls and the round trips. It is faster on the broadcast, by 11.6%, and on the
  fan-out, by 29% at the median and 67% at p99, but 24.4% slower on the burst to one subscriber. It
  uses as much CPU time on the signals (+2.0%), and 14 to 25% more on the rest, with 18 to 78% less
  peak memory.
* Against dbus-daemon, batched is faster on every workload, but for the calls and the round trips of
  one connection, which are inconclusive (from -5.9 to -2.9%), and uses 30 to 72% less CPU time,
  with as much peak memory.
* No run of any broker failed.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), but for the
clients above, with 60 rounds of each, and 40 of the shared connection, after 3 of warm-up, all six
brokers in each round. The raw results of each run are in the `.json` files of
[the directory](2026-10-24-busd-batched-sends-subscriber-threads-xeon-4vcpu), and the comparisons,
with the other metrics and the medians, in its
[stats](2026-10-24-busd-batched-sends-subscriber-threads-xeon-4vcpu/stats). A star marks a
difference whose 95% interval excludes 0 but not the margin. The whole fan-out is how long the
delivery of all the signals of the latencies' fan-out to 20 subscribers takes.

### batched against baseline

| Measure | n | baseline | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.199 s | 0.203 s | +2.2% | -0.3, +4.9 | within ±5% |
| calls, 20 connections | 60 | 0.756 s | 0.784 s | +3.7% | +0.4, +7.1 | inconclusive* |
| signals, burst to 1 | 60 | 0.379 s | 0.328 s | -13.6% | -17.0, -9.8 | **better** |
| signals, broadcast to 20 | 60 | 0.959 s | 0.283 s | -70.5% | -72.2, -68.6 | **better** |
| RTT, 1 connection, p50 | 60 | 171 µs | 172 µs | +0.7% | -0.8, +2.3 | within ±5% |
| RTT, 1 connection, p99 | 60 | 302 µs | 299 µs | -0.8% | -6.4, +4.5 | inconclusive |
| RTT, 20 connections, p50 | 60 | 686 µs | 694 µs | +1.2% | -1.6, +4.0 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1380 µs | 1465 µs | +6.2% | -2.2, +14.9 | inconclusive |
| delivery to 20, p50 | 60 | 16.5 ms | 4.6 ms | -72.1% | -74.1, -69.8 | **better** |
| delivery to 20, p99 | 60 | 37.2 ms | 12.1 ms | -67.3% | -70.1, -64.2 | **better** |
| delivery to 20, whole fan-out | 60 | 0.296 s | 0.101 s | -65.8% | -67.9, -63.3 | **better** |
| 100 proxies, 1 connection | 40 | 3.42 s | 3.39 s | -0.7% | -2.7, +1.4 | within ±5% |
| 100 connections | 40 | 3.85 s | 3.82 s | -1.0% | -4.3, +2.3 | within ±5% |
| calls, broker CPU | 60 | 0.64 s | 0.68 s | +5.2% | +2.0, +8.7 | inconclusive* |
| signals, broker CPU | 60 | 1.30 s | 0.52 s | -59.8% | -61.6, -57.9 | **better** |
| latency, broker CPU | 60 | 1.28 s | 1.08 s | -15.9% | -18.0, -13.7 | **better** |
| shared, broker CPU | 40 | 5.01 s | 4.98 s | -0.5% | -2.7, +1.9 | within ±5% |
| calls, broker system time | 60 | 0.31 s | 0.33 s | +7.4% | +1.6, +13.8 | inconclusive* |
| signals, broker system time | 60 | 0.86 s | 0.18 s | -79.5% | -80.8, -78.0 | **better** |
| latency, broker system time | 60 | 0.77 s | 0.58 s | -24.5% | -27.6, -21.2 | **better** |
| shared, broker system time | 40 | 2.31 s | 2.28 s | -1.3% | -5.2, +3.0 | within ±5% |
| calls, broker peak RSS | 60 | 4.7 MiB | 4.8 MiB | +1.4% | +0.8, +2.0 | within ±5%* |
| signals, broker peak RSS | 60 | 4.6 MiB | 4.7 MiB | +1.1% | +0.8, +1.5 | within ±5%* |
| latency, broker peak RSS | 60 | 4.9 MiB | 5.0 MiB | +1.2% | +0.4, +2.0 | within ±5%* |
| shared, broker peak RSS | 40 | 6.9 MiB | 6.9 MiB | +0.1% | -1.4, +1.5 | within ±5% |

baseline writes each signal to each subscriber with a system call of its own, which now wakes the
subscriber's thread, so that it uses 2.5 times the CPU time of batched on the signals, most of it
system time, 0.86 s against 0.18 s, and the broadcast takes 3.4 times as long. batched writes up to
14 of the benchmark's signals to a subscriber with one system call.

### batched against batched-before

| Measure | n | batched-before | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.198 s | 0.203 s | +2.6% | +0.3, +5.0 | within ±5%* |
| calls, 20 connections | 60 | 0.752 s | 0.784 s | +4.2% | +0.8, +7.7 | inconclusive* |
| signals, burst to 1 | 60 | 0.336 s | 0.328 s | -2.4% | -6.4, +2.0 | inconclusive |
| signals, broadcast to 20 | 60 | 0.292 s | 0.283 s | -3.0% | -6.3, +0.5 | inconclusive |
| RTT, 1 connection, p50 | 60 | 174 µs | 172 µs | -1.2% | -2.5, +0.2 | within ±5% |
| RTT, 1 connection, p99 | 60 | 314 µs | 299 µs | -4.6% | -8.5, -0.6 | inconclusive* |
| RTT, 20 connections, p50 | 60 | 702 µs | 694 µs | -1.0% | -3.3, +1.3 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1526 µs | 1465 µs | -4.0% | -11.9, +4.3 | inconclusive |
| delivery to 20, p50 | 60 | 5.0 ms | 4.6 ms | -8.0% | -13.5, -2.2 | inconclusive* |
| delivery to 20, p99 | 60 | 11.5 ms | 12.1 ms | +5.6% | -1.1, +13.5 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.100 s | 0.101 s | +1.3% | -2.9, +5.6 | within ±5% |
| 100 proxies, 1 connection | 40 | 3.43 s | 3.39 s | -1.0% | -3.2, +1.3 | within ±5% |
| 100 connections | 40 | 3.87 s | 3.82 s | -1.4% | -4.4, +1.6 | within ±5% |
| calls, broker CPU | 60 | 0.64 s | 0.68 s | +5.7% | +2.6, +8.9 | inconclusive* |
| signals, broker CPU | 60 | 0.54 s | 0.52 s | -3.9% | -6.9, -0.9 | inconclusive* |
| latency, broker CPU | 60 | 1.10 s | 1.08 s | -2.0% | -3.7, -0.2 | within ±5%* |
| shared, broker CPU | 40 | 5.05 s | 4.98 s | -1.3% | -3.7, +1.4 | within ±5% |
| calls, broker system time | 60 | 0.30 s | 0.33 s | +9.6% | +3.4, +16.1 | inconclusive* |
| signals, broker system time | 60 | 0.19 s | 0.18 s | -5.7% | -10.5, -0.6 | inconclusive* |
| latency, broker system time | 60 | 0.60 s | 0.58 s | -3.3% | -6.5, +0.1 | inconclusive |
| shared, broker system time | 40 | 2.32 s | 2.28 s | -1.5% | -5.7, +3.0 | inconclusive |

On the calls, the bus forwards one message at a time, as each connection waits for the reply to a
call before it makes the next, and batched-before and batched make the same system calls: in a run
of the calls client against each, under strace, 42,147 sends, 42,126 of them of one message, and
126,252 receives. The 9.6% more system time of batched on the calls (from +3.4 to +16.1%) is the
VM's, then, rather than the zbus commit's, and the same pair on the Ryzen 7 7840U had 2.2% less
(from -3.9 to -0.5%).

### batched against the queue

| Measure | n | queue | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.200 s | 0.203 s | +1.5% | -1.2, +4.5 | within ±5% |
| calls, 20 connections | 60 | 0.774 s | 0.784 s | +1.3% | -2.0, +4.6 | within ±5% |
| signals, burst to 1 | 60 | 0.500 s | 0.328 s | -34.4% | -36.7, -31.9 | **better** |
| signals, broadcast to 20 | 60 | 0.331 s | 0.283 s | -14.5% | -17.1, -11.9 | **better** |
| RTT, 1 connection, p50 | 60 | 174 µs | 172 µs | -1.6% | -2.9, -0.1 | within ±5%* |
| RTT, 1 connection, p99 | 60 | 319 µs | 299 µs | -6.0% | -10.2, -1.5 | inconclusive* |
| RTT, 20 connections, p50 | 60 | 694 µs | 694 µs | +0.0% | -2.6, +2.7 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1439 µs | 1465 µs | +1.8% | -6.1, +10.5 | inconclusive |
| delivery to 20, p50 | 60 | 9.1 ms | 4.6 ms | -49.1% | -53.7, -44.6 | **better** |
| delivery to 20, p99 | 60 | 24.4 ms | 12.1 ms | -50.2% | -55.5, -44.0 | **better** |
| delivery to 20, whole fan-out | 60 | 0.117 s | 0.101 s | -13.5% | -17.3, -9.6 | **better** |
| 100 proxies, 1 connection | 40 | 3.23 s | 3.39 s | +5.0% | +1.8, +8.4 | inconclusive* |
| 100 connections | 40 | 3.93 s | 3.82 s | -2.9% | -5.8, +0.2 | inconclusive |
| calls, broker CPU | 60 | 0.66 s | 0.68 s | +1.6% | -1.7, +5.0 | within ±5% |
| signals, broker CPU | 60 | 0.71 s | 0.52 s | -26.9% | -28.4, -25.3 | **better** |
| latency, broker CPU | 60 | 1.12 s | 1.08 s | -4.2% | -6.1, -2.3 | inconclusive* |
| shared, broker CPU | 40 | 5.29 s | 4.98 s | -5.8% | -8.5, -2.9 | inconclusive* |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.8 MiB | +0.0% | -0.7, +0.7 | within ±5% |
| signals, broker peak RSS | 60 | 45.9 MiB | 4.7 MiB | -89.8% | -90.5, -88.9 | **better** |
| latency, broker peak RSS | 60 | 5.6 MiB | 5.0 MiB | -10.7% | -12.5, -9.0 | **better** |
| shared, broker peak RSS | 40 | 7.4 MiB | 6.9 MiB | -6.2% | -7.7, -4.6 | inconclusive* |

### batched against dbus-broker

| Measure | n | dbus-broker | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.198 s | 0.203 s | +2.5% | +0.1, +5.3 | within ±5%* |
| calls, 20 connections | 60 | 1.267 s | 0.784 s | -38.1% | -39.6, -36.6 | **better** |
| signals, burst to 1 | 60 | 0.263 s | 0.328 s | +24.4% | +20.0, +29.3 | **worse** |
| signals, broadcast to 20 | 60 | 0.320 s | 0.283 s | -11.6% | -15.4, -7.7 | **better** |
| RTT, 1 connection, p50 | 60 | 171 µs | 172 µs | +0.5% | -1.0, +2.0 | within ±5% |
| RTT, 1 connection, p99 | 60 | 308 µs | 299 µs | -2.7% | -6.1, +0.9 | inconclusive |
| RTT, 20 connections, p50 | 60 | 1206 µs | 694 µs | -42.4% | -43.7, -41.1 | **better** |
| RTT, 20 connections, p99 | 60 | 2509 µs | 1465 µs | -41.6% | -45.3, -37.4 | **better** |
| delivery to 20, p50 | 60 | 6.5 ms | 4.6 ms | -29.4% | -40.1, -18.0 | **better** |
| delivery to 20, p99 | 60 | 37.2 ms | 12.1 ms | -67.3% | -70.8, -63.3 | **better** |
| delivery to 20, whole fan-out | 60 | 0.117 s | 0.101 s | -13.7% | -17.4, -10.0 | **better** |
| 100 proxies, 1 connection | 40 | 3.61 s | 3.39 s | -6.1% | -7.9, -4.2 | inconclusive* |
| 100 connections | 40 | 6.34 s | 3.82 s | -39.8% | -41.2, -38.3 | **better** |
| calls, broker CPU | 60 | 0.59 s | 0.68 s | +15.2% | +12.2, +18.6 | **worse** |
| signals, broker CPU | 60 | 0.51 s | 0.52 s | +2.0% | -1.3, +5.3 | within ±5% |
| latency, broker CPU | 60 | 0.94 s | 1.08 s | +13.9% | +12.2, +15.7 | **worse** |
| shared, broker CPU | 40 | 3.98 s | 4.98 s | +25.2% | +22.5, +28.0 | **worse** |
| calls, broker peak RSS | 60 | 7.1 MiB | 4.8 MiB | -32.5% | -32.9, -32.0 | **better** |
| signals, broker peak RSS | 60 | 20.8 MiB | 4.7 MiB | -77.5% | -79.2, -75.6 | **better** |
| latency, broker peak RSS | 60 | 9.8 MiB | 5.0 MiB | -49.4% | -51.4, -47.4 | **better** |
| shared, broker peak RSS | 40 | 8.4 MiB | 6.9 MiB | -18.0% | -19.1, -16.9 | **better** |

### batched against dbus-daemon

| Measure | n | dbus-daemon | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.216 s | 0.203 s | -5.9% | -8.8, -3.0 | inconclusive* |
| calls, 20 connections | 60 | 0.897 s | 0.784 s | -12.6% | -15.0, -10.2 | **better** |
| signals, burst to 1 | 60 | 0.689 s | 0.328 s | -52.4% | -54.5, -50.2 | **better** |
| signals, broadcast to 20 | 60 | 1.222 s | 0.283 s | -76.8% | -78.0, -75.6 | **better** |
| RTT, 1 connection, p50 | 60 | 180 µs | 172 µs | -4.6% | -5.8, -3.4 | inconclusive* |
| RTT, 1 connection, p99 | 60 | 309 µs | 299 µs | -2.9% | -6.0, +0.3 | inconclusive |
| RTT, 20 connections, p50 | 60 | 780 µs | 694 µs | -11.0% | -13.0, -8.8 | **better** |
| RTT, 20 connections, p99 | 60 | 1925 µs | 1465 µs | -23.9% | -29.9, -17.1 | **better** |
| delivery to 20, p50 | 60 | 10.6 ms | 4.6 ms | -56.5% | -59.8, -52.6 | **better** |
| delivery to 20, p99 | 60 | 27.7 ms | 12.1 ms | -56.2% | -61.0, -51.4 | **better** |
| delivery to 20, whole fan-out | 60 | 0.382 s | 0.101 s | -73.5% | -75.4, -71.4 | **better** |
| 100 proxies, 1 connection | 40 | 3.87 s | 3.39 s | -12.3% | -14.3, -10.1 | **better** |
| 100 connections | 40 | 5.20 s | 3.82 s | -26.6% | -28.6, -24.4 | **better** |
| calls, broker CPU | 60 | 0.97 s | 0.68 s | -30.5% | -32.4, -28.6 | **better** |
| signals, broker CPU | 60 | 1.89 s | 0.52 s | -72.4% | -73.3, -71.3 | **better** |
| latency, broker CPU | 60 | 1.71 s | 1.08 s | -37.3% | -38.6, -35.9 | **better** |
| shared, broker CPU | 40 | 8.61 s | 4.98 s | -42.2% | -43.4, -40.8 | **better** |
| calls, broker peak RSS | 60 | 4.9 MiB | 4.8 MiB | -1.8% | -2.3, -1.3 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.7 MiB | -0.4% | -1.6, +0.8 | within ±5% |
| latency, broker peak RSS | 60 | 4.9 MiB | 5.0 MiB | +1.1% | +0.3, +1.9 | within ±5%* |
| shared, broker peak RSS | 40 | 7.1 MiB | 6.9 MiB | -2.7% | -3.8, -1.5 | within ±5%* |

### The connection that 100 proxies share

The clients of this phase didn't change. Taking the multi-client phase's CPU time out of each run's
whole, the phase's means are:

| Broker | Phase | Client CPU | Broker CPU | Client's waits | Broker's waits |
|---|---:|---:|---:|---:|---:|
| baseline | 3.42 s | 3.19 s | 2.13 s | 9338 | 19248 |
| batched-before | 3.43 s | 3.18 s | 2.14 s | 9372 | 18891 |
| batched | 3.39 s | 3.15 s | 2.11 s | 8681 | 18966 |
| queue | 3.23 s | 3.01 s | 2.26 s | 13969 | 16508 |
| dbus-broker | 3.61 s | 3.57 s | 1.59 s | 254 | 199154 |
| dbus-daemon | 3.87 s | 3.40 s | 3.63 s | 59181 | 3209 |

The client's and the broker's waits are their voluntary context switches, over both phases.

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at fd0bcaa builds the brokers and runs all of this, in about 61 minutes on this VM once the
builds are made, and writes these files to `$WORK/batched-sends-results-ac6e6fa`, with the
comparisons in pairs next to the others rather than in `stats`.
