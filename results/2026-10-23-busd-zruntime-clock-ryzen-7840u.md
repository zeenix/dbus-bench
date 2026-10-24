# busd's time limit on a Ryzen 7 7840U, with zruntime reading the clock only once a send waits

Measured on 2026-10-23 on the laptop of [busd on a Ryzen 7 7840U, with the benchmark on zbus
6](2026-10-20-zbus-6-ryzen-7840u.md): an AMD Ryzen 7 7840U (8 cores, 16 threads), running Fedora 44
with Linux 7.1.13, whose clocksource is the HPET. It ran
`TIMEOUT_REV=7f3ba5a ZRUNTIME_REV=99e2ebd scripts/compare-send-timeout.sh` at d15d922, which made
every build of busd with rustc 1.99.0, on zbus 6.0.0. dbus-broker 37 and dbus-daemon 1.16.2 are
Fedora's. Compare the brokers with each other, within this file only.

zruntime's `Runtime::timeout` read the clock as it made each time limit, to work out its deadline,
and with the HPET as the clocksource, reading the clock is a system call. 99e2ebd, on the
`ccr-314882eb-9cvuxt` branch of zeenix/zruntime, starts the clock only once a poll leaves the future
waiting, so a send that completes at once never reads it. The brokers:

* **baseline**, 0c52e9c: busd's main, with a queue for each client (z-galaxy/busd#376), on zruntime
  99e2ebd.
* **timeout**, 7f3ba5a, from the `ccr-314882eb-9cvuxt` branch of zeenix/busd: the queue reverted,
  then a time limit of 100 ms on each send, with the sends of a message to all of its recipients at
  once, on zruntime 99e2ebd.
* **timeout-before**: timeout on zruntime 20771cf, the parent of 99e2ebd and the release 0.2.1.
* **dbus-broker** and **dbus-daemon**.

Each build of busd runs on its commit of zruntime in place of the release in its lock file, 0.2.0,
so that only the commit of zruntime differs between timeout-before and timeout. baseline uses no
time limit of zruntime's, so one build of it does for both.

## Summary

* The commit of zruntime takes 11 to 21% off the CPU time of busd with the time limit on every
  workload, most of it system time, of which it takes 16 to 34% off: most sends complete at once,
  and no longer read the clock.
* With it, the time limit costs no CPU time against the queue: within 2.2% on every workload, where
  it cost 12.8 to 27.0% more without it.
* Against the queue, timeout is level or better, apart from the connection that 100 proxies share,
  which is 11.3% slower (+10.0 to +12.5%), as it was on the VM. A burst of signals to one
  subscriber is 17.7% faster, the delivery of signals to 20 subscribers takes 60% less time at the
  median and 70% less at p99, and the signal workload's peak memory is 88% smaller.
* Against dbus-broker, timeout is within 5% on 20 connections, on the signals, burst and broadcast,
  and with 100 connections (+4.2%, inconclusive). It delivers signals to 20 subscribers 59 to 68%
  faster, with 84% less memory in the signal workload. With one busy connection, it is slower:
  calls take 15% longer, round trips 14% longer at the median and 30% at p99, and the connection
  that 100 proxies share 9.4% longer. It uses 20 to 45% more CPU time.
* Against dbus-daemon, timeout takes 48 to 69% less time on every workload, its round trips are 38
  to 55% shorter, and it uses 67 to 75% less CPU time, but 7.5 to 31% more peak memory. Its median
  delivery of signals to 20 subscribers takes 24% longer, and its p99 as long.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), with 60 rounds
of each, and 40 of the shared connection, after 3 of warm-up, all five brokers in each round. The
raw results of each run are in the `.json` files of
[the directory](2026-10-23-busd-zruntime-clock-ryzen-7840u), and the comparisons, with the other
metrics and the medians, in its [stats](2026-10-23-busd-zruntime-clock-ryzen-7840u/stats). A star
marks a difference whose 95% interval excludes 0 but not the margin.

### The commit of zruntime

| Measure | n | timeout-before | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, broker CPU | 60 | 0.47 s | 0.42 s | -10.8% | -11.4, -10.2 | **better** |
| calls, broker system time | 60 | 0.26 s | 0.22 s | -16.2% | -17.5, -14.7 | **better** |
| signals, broker CPU | 60 | 0.66 s | 0.52 s | -21.3% | -21.7, -20.9 | **better** |
| signals, broker system time | 60 | 0.38 s | 0.25 s | -34.4% | -35.3, -33.5 | **better** |
| latency, broker CPU | 60 | 0.75 s | 0.64 s | -14.3% | -14.9, -13.7 | **better** |
| latency, broker system time | 60 | 0.43 s | 0.34 s | -20.7% | -21.9, -19.4 | **better** |
| shared, broker CPU | 40 | 4.28 s | 3.47 s | -18.9% | -20.0, -17.9 | **better** |
| shared, broker system time | 40 | 2.47 s | 1.83 s | -26.1% | -27.3, -25.0 | **better** |

What the time limit costs in CPU time against the queue, with the commit and without it:

| Measure | n | baseline | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, broker CPU | 60 | 0.42 s | 0.42 s | +0.6% | -0.1, +1.3 | within ±5% |
| signals, broker CPU | 60 | 0.52 s | 0.52 s | -0.1% | -0.8, +0.6 | within ±5% |
| latency, broker CPU | 60 | 0.63 s | 0.64 s | +1.3% | +0.4, +2.2 | within ±5%* |
| shared, broker CPU | 40 | 3.40 s | 3.47 s | +2.2% | +0.9, +3.6 | within ±5%* |

| Measure | n | baseline | timeout-before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, broker CPU | 60 | 0.42 s | 0.47 s | +12.8% | +12.0, +13.5 | **worse** |
| signals, broker CPU | 60 | 0.52 s | 0.66 s | +27.0% | +26.1, +27.9 | **worse** |
| latency, broker CPU | 60 | 0.63 s | 0.75 s | +18.2% | +17.3, +19.1 | **worse** |
| shared, broker CPU | 40 | 3.40 s | 4.28 s | +26.1% | +24.4, +27.9 | **worse** |

### timeout against the queue

| Measure | n | baseline | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.071 s | 0.070 s | -1.8% | -3.0, -0.5 | within ±5%* |
| calls, 20 connections | 60 | 0.452 s | 0.452 s | +0.1% | -0.8, +0.9 | within ±5% |
| signals, burst to 1 | 60 | 0.381 s | 0.313 s | -17.7% | -18.3, -17.1 | **better** |
| signals, broadcast to 20 | 60 | 0.383 s | 0.379 s | -1.1% | -2.2, +0.1 | within ±5% |
| RTT, 1 connection, p50 | 60 | 61 µs | 62 µs | +1.1% | +0.3, +1.9 | within ±5%* |
| RTT, 1 connection, p99 | 60 | 115 µs | 109 µs | -4.8% | -8.3, -1.0 | inconclusive* |
| RTT, 20 connections, p50 | 60 | 478 µs | 480 µs | +0.5% | -0.3, +1.2 | within ±5% |
| RTT, 20 connections, p99 | 60 | 789 µs | 807 µs | +2.4% | -1.7, +6.7 | inconclusive |
| delivery to 20, p50 | 60 | 57.5 ms | 22.8 ms | -60.4% | -61.0, -59.8 | **better** |
| delivery to 20, p99 | 60 | 95.8 ms | 29.1 ms | -69.6% | -70.0, -69.2 | **better** |
| 100 proxies, 1 connection | 40 | 1.87 s | 2.08 s | +11.3% | +10.0, +12.5 | **worse** |
| 100 connections | 40 | 2.25 s | 2.26 s | +0.5% | -1.3, +2.3 | within ±5% |
| calls, broker peak RSS | 60 | 6.5 MiB | 6.5 MiB | -0.1% | -0.7, +0.5 | within ±5% |
| signals, broker peak RSS | 60 | 52.9 MiB | 6.4 MiB | -87.9% | -88.0, -87.8 | **better** |
| latency, broker peak RSS | 60 | 8.0 MiB | 6.9 MiB | -13.2% | -13.8, -12.6 | **better** |
| shared, broker peak RSS | 40 | 11.5 MiB | 11.0 MiB | -4.6% | -6.4, -2.9 | inconclusive* |

### timeout against dbus-broker

| Measure | n | dbus-broker | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.061 s | 0.070 s | +15.2% | +13.9, +16.4 | **worse** |
| calls, 20 connections | 60 | 0.439 s | 0.452 s | +3.0% | +2.0, +4.0 | within ±5%* |
| signals, burst to 1 | 60 | 0.303 s | 0.313 s | +3.4% | +2.9, +4.1 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.374 s | 0.379 s | +1.2% | +0.3, +2.2 | within ±5%* |
| RTT, 1 connection, p50 | 60 | 54 µs | 62 µs | +14.3% | +13.1, +15.4 | **worse** |
| RTT, 1 connection, p99 | 60 | 84 µs | 109 µs | +30.3% | +25.6, +35.3 | **worse** |
| RTT, 20 connections, p50 | 60 | 513 µs | 480 µs | -6.3% | -7.1, -5.6 | **better** |
| RTT, 20 connections, p99 | 60 | 682 µs | 807 µs | +18.4% | +12.7, +24.1 | **worse** |
| delivery to 20, p50 | 60 | 55.6 ms | 22.8 ms | -59.1% | -59.6, -58.6 | **better** |
| delivery to 20, p99 | 60 | 90.3 ms | 29.1 ms | -67.7% | -68.2, -67.2 | **better** |
| 100 proxies, 1 connection | 40 | 1.90 s | 2.08 s | +9.4% | +8.3, +10.4 | **worse** |
| 100 connections | 40 | 2.17 s | 2.26 s | +4.2% | +2.4, +6.0 | inconclusive* |
| calls, broker CPU | 60 | 0.35 s | 0.42 s | +20.3% | +19.2, +21.3 | **worse** |
| signals, broker CPU | 60 | 0.36 s | 0.52 s | +44.7% | +43.4, +45.9 | **worse** |
| latency, broker CPU | 60 | 0.53 s | 0.64 s | +21.1% | +20.0, +22.3 | **worse** |
| shared, broker CPU | 40 | 2.71 s | 3.47 s | +28.1% | +26.6, +29.5 | **worse** |
| calls, broker peak RSS | 60 | 8.0 MiB | 6.5 MiB | -19.0% | -19.5, -18.5 | **better** |
| signals, broker peak RSS | 60 | 40.1 MiB | 6.4 MiB | -84.0% | -84.1, -83.9 | **better** |
| latency, broker peak RSS | 60 | 11.6 MiB | 6.9 MiB | -40.5% | -40.9, -40.1 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 11.0 MiB | +20.2% | +18.1, +22.2 | **worse** |

baseline is as far from dbus-broker on the calls, the round trips and the CPU time (calls on 1
connection +17.3%, round trips +13.1% at the median, CPU time +19.5 to +44.9%), and further on the
signal burst (+25.7%) and the delivery to 20 subscribers (+3.4%), but level with it on the
connection that 100 proxies share: 1.87 s against 1.90 s (-1.7%, from -2.6 to -0.7).

### timeout against dbus-daemon

| Measure | n | dbus-daemon | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.136 s | 0.070 s | -48.4% | -49.1, -47.8 | **better** |
| calls, 20 connections | 60 | 1.159 s | 0.452 s | -61.0% | -61.3, -60.7 | **better** |
| signals, burst to 1 | 60 | 0.860 s | 0.313 s | -63.6% | -63.8, -63.4 | **better** |
| signals, broadcast to 20 | 60 | 1.206 s | 0.379 s | -68.6% | -68.9, -68.3 | **better** |
| RTT, 1 connection, p50 | 60 | 100 µs | 62 µs | -38.4% | -39.1, -37.7 | **better** |
| RTT, 1 connection, p99 | 60 | 194 µs | 109 µs | -43.8% | -45.8, -41.7 | **better** |
| RTT, 20 connections, p50 | 60 | 1063 µs | 480 µs | -54.8% | -55.1, -54.5 | **better** |
| RTT, 20 connections, p99 | 60 | 1669 µs | 807 µs | -51.6% | -53.3, -50.0 | **better** |
| delivery to 20, p50 | 60 | 18.4 ms | 22.8 ms | +24.0% | +22.9, +25.2 | **worse** |
| delivery to 20, p99 | 60 | 29.4 ms | 29.1 ms | -0.8% | -2.0, +0.5 | within ±5% |
| 100 proxies, 1 connection | 40 | 6.37 s | 2.08 s | -67.4% | -67.7, -67.2 | **better** |
| 100 connections | 40 | 5.74 s | 2.26 s | -60.7% | -61.2, -60.1 | **better** |
| calls, broker CPU | 60 | 1.26 s | 0.42 s | -66.7% | -66.9, -66.5 | **better** |
| signals, broker CPU | 60 | 2.08 s | 0.52 s | -74.9% | -75.0, -74.7 | **better** |
| latency, broker CPU | 60 | 2.08 s | 0.64 s | -69.2% | -69.4, -68.9 | **better** |
| shared, broker CPU | 40 | 12.11 s | 3.47 s | -71.3% | -71.6, -71.0 | **better** |
| calls, broker peak RSS | 60 | 6.1 MiB | 6.5 MiB | +7.5% | +6.7, +8.2 | **worse** |
| signals, broker peak RSS | 60 | 5.4 MiB | 6.4 MiB | +17.7% | +16.7, +18.5 | **worse** |
| latency, broker peak RSS | 60 | 6.2 MiB | 6.9 MiB | +12.0% | +11.3, +12.7 | **worse** |
| shared, broker peak RSS | 40 | 8.3 MiB | 11.0 MiB | +31.3% | +29.1, +33.6 | **worse** |

### The connection that 100 proxies share

In this phase, one connection serves an object and makes 100,000 calls to it through the bus, 100 at
a time, each with 16 KiB of data: about 100,000 messages a second, and 0.8 GB a second each way.
The client, on one thread, is what limits it: it is busy 98% of the time with baseline. Taking the
multi-client phase's CPU time out of each run's whole, the phase's means are:

| Broker | Phase | Client CPU | Broker CPU |
|---|---:|---:|---:|
| baseline | 1.87 s | 1.83 s | 1.44 s |
| timeout | 2.08 s | 1.97 s | 1.57 s |
| dbus-broker | 1.90 s | 1.90 s | 1.19 s |

So the client does 8% more work with timeout than with baseline, for the same messages, and 4% more
with dbus-broker, which is quick enough that the client never waits for it. timeout writes each
message to the client's socket as it forwards it. baseline left that to a task of each client's
own, which wrote whatever the bus had queued for the client by the time it ran, and dbus-broker
queues the messages of each client too, and writes up to 16 of them with each `sendmmsg()`
(`SOCKET_MMSG_MAX` in its `src/dbus/socket.h`).

## Reproducing

`TIMEOUT_REV=7f3ba5a ZRUNTIME_REV=99e2ebd scripts/compare-send-timeout.sh`, as it is at d15d922,
builds the brokers and runs all of this, in about 39 minutes on this laptop once the builds are
made, and writes these files to `$WORK/send-timeout-results-7f3ba5a-zruntime-99e2ebd`, with the
comparisons in pairs next to the others rather than in `stats`. busd's commits are those that the
`ccr-314882eb-9cvuxt` branch of zeenix/busd had then: the branch was rebased onto busd's main since.
