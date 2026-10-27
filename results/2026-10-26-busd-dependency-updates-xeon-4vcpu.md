# busd on the latest zbus and zruntime, on a 4-vCPU Xeon

Measured on 2026-10-26, on the VM of
[threaded subscribers](2026-10-24-busd-batched-sends-subscriber-threads-xeon-4vcpu.md): 4 vCPUs of
an Intel Xeon @ 2.80GHz under KVM, 15 GiB, Linux 6.18, Ubuntu 24.04.5. It ran
`scripts/compare-dependency-updates.sh` at 3a20fff, which made every build of busd with rustc
1.97.0. dbus-broker is 37, built from source with its default options, rather than the 35 of Ubuntu
24.04 that the earlier files of this VM measured, and ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py). dbus-daemon is
the 1.14.10 of Ubuntu 24.04. Compare the brokers with each other, within this file only.

The builds of busd:

* **before**: d69f900, busd's main branch, on zbus 73504ba and zruntime 99e2ebd, as its lock file
  has them;
* **zruntime**: the same commit, on zruntime b3bd01d, the merge of z-galaxy/zruntime#60, which keeps
  the socket of a client that a wait found readable watched until the task that the wait woke has
  run, rather than letting go of it and watching it again for each message where many clients are
  busy;
* **after**: f415bfd of zeenix/busd, which builds on that zruntime and on zbus 50c54bf, the merge of
  z-galaxy/zbus#2083. That zbus decodes the header of each message that a connection receives in
  one pass, with a parser of its own (z-galaxy/zbus#2081), and parses signatures for less
  (z-galaxy/zbus#2083).

The clients are those of 3a20fff, on that zbus and that zruntime, against every broker. They use 11
to 35% less CPU time than the same clients on zbus 6.0.0 and zruntime 0.2.1 (see ac41d54), which
changes the timings of every broker, so the numbers here are not comparable with those of the
earlier files.

## Summary

* Against before, after uses 17 to 42% less CPU time on every workload, with 33 to 59% less user
  time. It takes 15.9% less time on the calls of 20 clients, 40.3% less on the burst of signals to
  one subscriber and 21.2% less on the broadcast to 20, 20.1% less on the median round trip of 20
  clients and 14.0% less at p99, 18.0% less on the whole fan-out, and 18.0% and 24.1% less on the
  shared phases, while one client's calls and round trips take 5 to 6% less (inconclusive, but
  repeatable). The one measure that is worse is the delay of the slowest signals of the latencies'
  fan-out: 26.5% longer at p99, 10.7 ms against 8.5 ms (see
  [below](#the-slowest-signals-of-the-fan-out)).
* Almost all of that comes from zbus: after against zruntime matches after against before on
  everything but the second shared phase, the 100 clients, which zruntime makes 6.5% faster (from
  -8.3 to -4.8%, inconclusive but repeatable), with 5.2% less CPU time, and which it leaves within
  5%, or inconclusive, on everything else. In a run of the shared client, before makes 200,007
  EPOLL_CTL_ADDs and 200,009 EPOLL_CTL_DELs, and the zruntime build 540 of each, but its epoll waits
  return 643,361 events, against 207,892, as each wait that cannot sleep reports the socket of a
  task that is still queued again: what z-galaxy/zruntime#59 said its fix leaves.
* Against dbus-broker, after is faster with one client (12.6% on the calls), on the signals (21.7%
  on the burst, which before took 31.3% longer, and 55.9% on the broadcast), on the latencies'
  fan-out (39 to 53%) and on the first shared phase (19.1%). It is slower with 20 clients, where the
  calls take 11.5% longer (before: 32.6%) and the median round trip 4.7% longer (inconclusive;
  before: 31.0%), and with 100 clients, which take 32.2% longer (before: 74.1%). Its user time is
  still 50 to 59% higher on the calls, the latencies and the shared phases, and its system time
  level or lower, so it uses 9.8% more CPU time on the calls, 10.2% more on the shared phases, 4.4%
  less on the latencies (inconclusive) and 51.5% less on the signals, with 22 to 44% less peak
  memory, but for the shared phases (+3.4%).
* Against dbus-daemon, after is faster on every measure but the p99 round trip of one client (-6.6%,
  inconclusive), and uses 50 to 87% less CPU time, with as much peak memory, or 6.8% less on the
  shared phases.
* No run of any broker failed.

## The benchmarks

The workloads, and how the comparisons work, are those of [the time limit of 1
s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), but for the clients: each service,
client and subscriber runs on a thread of its own, with a runtime of its own, as a process of its
own would (461ee04, ec0e447, 6ac5fff, fd0bcaa and 5bee346). The shared phases are a connection that
100 proxies share to call one service, then 100 services, each with a client of its own. There are
60 rounds of each workload, and 40 of the shared phases, after 3 of warm-up, all five brokers in
each round. The raw results of each run are in
[runs.tar.xz](2026-10-26-busd-dependency-updates-xeon-4vcpu/runs.tar.xz), from which
[paired-stats.py](../scripts/paired-stats.py) makes the comparisons, with the other metrics and the
medians. A star marks a difference whose 95% interval excludes 0 but not the margin. The signals are
those of the `fanout` client: a burst of 40,000 to one subscriber, and a broadcast of 6000 to each
of 20, each timed as a whole. The delivery to 20 is the fan-out of the `latency` client, another
broadcast, of 2000 signals of 1 KiB to each of 20 subscribers, which times each delivery, from just
before the emitter builds the signal until the subscriber takes it off its stream, and the whole
fan-out how long all of them take.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.166 s | 0.157 s | -5.2% | -7.8, -2.5 | inconclusive* |
| calls, 20 clients | 60 | 0.927 s | 0.779 s | -15.9% | -19.0, -12.6 | **better** |
| signals, burst to 1 | 60 | 0.333 s | 0.198 s | -40.3% | -42.9, -37.7 | **better** |
| signals, broadcast to 20 | 60 | 0.233 s | 0.184 s | -21.2% | -25.8, -16.2 | **better** |
| RTT, 1 client, p50 | 60 | 144 µs | 135 µs | -6.2% | -7.7, -4.7 | inconclusive* |
| RTT, 1 client, p99 | 60 | 293 µs | 278 µs | -5.1% | -9.2, -1.0 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 825 µs | 659 µs | -20.1% | -22.5, -17.4 | **better** |
| RTT, 20 clients, p99 | 60 | 1703 µs | 1465 µs | -14.0% | -20.1, -7.7 | **better** |
| delivery to 20, p50 | 60 | 3.3 ms | 2.7 ms | -19.2% | -24.3, -13.8 | **better** |
| delivery to 20, p99 | 60 | 8.5 ms | 10.7 ms | +26.5% | +13.5, +41.5 | **worse** |
| delivery to 20, whole fan-out | 60 | 0.078 s | 0.064 s | -18.0% | -22.4, -13.3 | **better** |
| 100 proxies, 1 connection | 40 | 2.10 s | 1.72 s | -18.0% | -20.3, -15.6 | **better** |
| 100 clients | 40 | 5.29 s | 4.02 s | -24.1% | -25.8, -22.4 | **better** |
| calls, broker CPU | 60 | 0.98 s | 0.81 s | -17.1% | -19.6, -14.6 | **better** |
| signals, broker CPU | 60 | 0.55 s | 0.32 s | -41.8% | -44.3, -39.1 | **better** |
| latency, broker CPU | 60 | 1.31 s | 1.06 s | -19.0% | -20.8, -17.0 | **better** |
| shared, broker CPU | 40 | 7.09 s | 5.37 s | -24.3% | -25.6, -22.9 | **better** |
| calls, broker user time | 60 | 0.37 s | 0.24 s | -33.2% | -35.9, -30.3 | **better** |
| signals, broker user time | 60 | 0.35 s | 0.14 s | -59.3% | -61.2, -57.4 | **better** |
| latency, broker user time | 60 | 0.52 s | 0.33 s | -36.5% | -38.8, -34.2 | **better** |
| shared, broker user time | 40 | 2.96 s | 1.86 s | -37.0% | -38.5, -35.6 | **better** |
| calls, broker system time | 60 | 0.61 s | 0.56 s | -7.5% | -11.2, -3.7 | inconclusive* |
| signals, broker system time | 60 | 0.19 s | 0.17 s | -10.1% | -16.4, -2.8 | inconclusive* |
| latency, broker system time | 60 | 0.79 s | 0.73 s | -7.3% | -10.2, -4.3 | inconclusive* |
| shared, broker system time | 40 | 4.14 s | 3.51 s | -15.2% | -17.3, -13.0 | **better** |
| calls, broker peak RSS | 60 | 5.1 MiB | 5.0 MiB | -2.0% | -2.5, -1.5 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.6 MiB | -1.1% | -1.5, -0.7 | within ±5%* |
| latency, broker peak RSS | 60 | 5.2 MiB | 5.1 MiB | -1.8% | -2.3, -1.2 | within ±5%* |
| shared, broker peak RSS | 40 | 8.0 MiB | 7.9 MiB | -1.3% | -2.5, -0.3 | within ±5%* |

### zruntime against before

| Measure | n | before | zruntime | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.166 s | 0.167 s | +0.3% | -2.1, +2.7 | within ±5% |
| calls, 20 clients | 60 | 0.927 s | 0.922 s | -0.5% | -3.1, +2.2 | within ±5% |
| signals, burst to 1 | 60 | 0.333 s | 0.332 s | -0.2% | -4.2, +4.2 | within ±5% |
| signals, broadcast to 20 | 60 | 0.233 s | 0.228 s | -2.3% | -5.9, +1.7 | inconclusive |
| RTT, 1 client, p50 | 60 | 144 µs | 144 µs | +0.4% | -1.4, +2.2 | within ±5% |
| RTT, 1 client, p99 | 60 | 293 µs | 299 µs | +2.1% | -2.5, +7.1 | inconclusive |
| RTT, 20 clients, p50 | 60 | 825 µs | 819 µs | -0.7% | -3.6, +2.2 | within ±5% |
| RTT, 20 clients, p99 | 60 | 1703 µs | 1870 µs | +9.8% | +1.1, +19.2 | inconclusive* |
| delivery to 20, p50 | 60 | 3.3 ms | 3.4 ms | +3.2% | -5.1, +11.9 | inconclusive |
| delivery to 20, p99 | 60 | 8.5 ms | 8.3 ms | -1.5% | -10.5, +8.2 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.078 s | 0.079 s | +1.7% | -4.6, +8.4 | inconclusive |
| 100 proxies, 1 connection | 40 | 2.10 s | 2.10 s | +0.2% | -3.1, +3.6 | within ±5% |
| 100 clients | 40 | 5.29 s | 4.95 s | -6.5% | -8.3, -4.8 | inconclusive* |
| calls, broker CPU | 60 | 0.98 s | 0.97 s | -0.7% | -3.0, +1.7 | within ±5% |
| signals, broker CPU | 60 | 0.55 s | 0.54 s | -0.9% | -4.1, +2.6 | within ±5% |
| latency, broker CPU | 60 | 1.31 s | 1.32 s | +0.3% | -1.9, +2.7 | within ±5% |
| shared, broker CPU | 40 | 7.09 s | 6.73 s | -5.2% | -6.9, -3.6 | inconclusive* |
| calls, broker user time | 60 | 0.37 s | 0.37 s | +0.3% | -3.2, +3.9 | within ±5% |
| signals, broker user time | 60 | 0.35 s | 0.35 s | +0.6% | -3.0, +4.4 | within ±5% |
| latency, broker user time | 60 | 0.52 s | 0.53 s | +0.9% | -2.3, +4.2 | within ±5% |
| shared, broker user time | 40 | 2.96 s | 2.85 s | -3.5% | -5.5, -1.3 | inconclusive* |
| calls, broker system time | 60 | 0.61 s | 0.60 s | -1.2% | -4.6, +2.4 | within ±5% |
| signals, broker system time | 60 | 0.19 s | 0.19 s | -3.7% | -8.8, +1.8 | inconclusive |
| latency, broker system time | 60 | 0.79 s | 0.79 s | -0.1% | -3.3, +3.3 | within ±5% |
| shared, broker system time | 40 | 4.14 s | 3.87 s | -6.4% | -8.6, -4.3 | inconclusive* |
| calls, broker peak RSS | 60 | 5.1 MiB | 5.1 MiB | +0.0% | -0.5, +0.6 | within ±5% |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.7 MiB | +0.0% | -0.4, +0.4 | within ±5% |
| latency, broker peak RSS | 60 | 5.2 MiB | 5.2 MiB | -0.3% | -0.8, +0.1 | within ±5% |
| shared, broker peak RSS | 40 | 8.0 MiB | 8.0 MiB | -0.7% | -1.9, +0.5 | within ±5% |

### after against zruntime

| Measure | n | zruntime | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.167 s | 0.157 s | -5.5% | -8.0, -3.0 | inconclusive* |
| calls, 20 clients | 60 | 0.922 s | 0.779 s | -15.5% | -18.6, -12.2 | **better** |
| signals, burst to 1 | 60 | 0.332 s | 0.198 s | -40.2% | -43.1, -37.2 | **better** |
| signals, broadcast to 20 | 60 | 0.228 s | 0.184 s | -19.3% | -23.8, -14.1 | **better** |
| RTT, 1 client, p50 | 60 | 144 µs | 135 µs | -6.6% | -7.9, -5.1 | **better** |
| RTT, 1 client, p99 | 60 | 299 µs | 278 µs | -7.1% | -11.0, -2.9 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 819 µs | 659 µs | -19.5% | -22.0, -16.8 | **better** |
| RTT, 20 clients, p99 | 60 | 1870 µs | 1465 µs | -21.7% | -28.5, -13.8 | **better** |
| delivery to 20, p50 | 60 | 3.4 ms | 2.7 ms | -21.6% | -27.3, -15.4 | **better** |
| delivery to 20, p99 | 60 | 8.3 ms | 10.7 ms | +28.4% | +13.7, +44.7 | **worse** |
| delivery to 20, whole fan-out | 60 | 0.079 s | 0.064 s | -19.3% | -24.5, -13.8 | **better** |
| 100 proxies, 1 connection | 40 | 2.10 s | 1.72 s | -18.2% | -20.9, -15.3 | **better** |
| 100 clients | 40 | 4.95 s | 4.02 s | -18.8% | -20.4, -17.2 | **better** |
| calls, broker CPU | 60 | 0.97 s | 0.81 s | -16.6% | -19.0, -14.1 | **better** |
| signals, broker CPU | 60 | 0.54 s | 0.32 s | -41.3% | -43.8, -38.3 | **better** |
| latency, broker CPU | 60 | 1.32 s | 1.06 s | -19.2% | -21.2, -17.2 | **better** |
| shared, broker CPU | 40 | 6.73 s | 5.37 s | -20.1% | -21.6, -18.6 | **better** |
| calls, broker user time | 60 | 0.37 s | 0.24 s | -33.3% | -36.1, -30.4 | **better** |
| signals, broker user time | 60 | 0.35 s | 0.14 s | -59.5% | -61.5, -57.6 | **better** |
| latency, broker user time | 60 | 0.53 s | 0.33 s | -37.1% | -39.4, -34.6 | **better** |
| shared, broker user time | 40 | 2.85 s | 1.86 s | -34.7% | -36.2, -33.2 | **better** |
| calls, broker system time | 60 | 0.60 s | 0.56 s | -6.4% | -9.9, -2.8 | inconclusive* |
| signals, broker system time | 60 | 0.19 s | 0.17 s | -6.7% | -13.4, +0.9 | inconclusive |
| latency, broker system time | 60 | 0.79 s | 0.73 s | -7.2% | -10.2, -4.0 | inconclusive* |
| shared, broker system time | 40 | 3.87 s | 3.51 s | -9.4% | -11.5, -7.2 | **better** |
| calls, broker peak RSS | 60 | 5.1 MiB | 5.0 MiB | -2.0% | -2.5, -1.6 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.6 MiB | -1.1% | -1.5, -0.8 | within ±5%* |
| latency, broker peak RSS | 60 | 5.2 MiB | 5.1 MiB | -1.5% | -2.0, -1.0 | within ±5%* |
| shared, broker peak RSS | 40 | 8.0 MiB | 7.9 MiB | -0.7% | -1.4, +0.1 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.180 s | 0.157 s | -12.6% | -14.6, -10.6 | **better** |
| calls, 20 clients | 60 | 0.699 s | 0.779 s | +11.5% | +7.2, +16.3 | **worse** |
| signals, burst to 1 | 60 | 0.253 s | 0.198 s | -21.7% | -25.4, -17.7 | **better** |
| signals, broadcast to 20 | 60 | 0.416 s | 0.184 s | -55.9% | -58.9, -52.6 | **better** |
| RTT, 1 client, p50 | 60 | 156 µs | 135 µs | -13.7% | -15.0, -12.3 | **better** |
| RTT, 1 client, p99 | 60 | 302 µs | 278 µs | -8.0% | -12.0, -3.7 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 630 µs | 659 µs | +4.7% | +0.5, +9.0 | inconclusive* |
| RTT, 20 clients, p99 | 60 | 1516 µs | 1465 µs | -3.4% | -10.8, +5.1 | inconclusive |
| delivery to 20, p50 | 60 | 4.4 ms | 2.7 ms | -39.3% | -46.2, -32.2 | **better** |
| delivery to 20, p99 | 60 | 20.2 ms | 10.7 ms | -47.1% | -58.4, -31.0 | **better** |
| delivery to 20, whole fan-out | 60 | 0.134 s | 0.064 s | -52.6% | -55.6, -49.3 | **better** |
| 100 proxies, 1 connection | 40 | 2.12 s | 1.72 s | -19.1% | -22.4, -15.8 | **better** |
| 100 clients | 40 | 3.04 s | 4.02 s | +32.2% | +28.8, +35.7 | **worse** |
| calls, broker CPU | 60 | 0.74 s | 0.81 s | +9.8% | +6.3, +13.4 | **worse** |
| signals, broker CPU | 60 | 0.66 s | 0.32 s | -51.5% | -53.8, -48.9 | **better** |
| latency, broker CPU | 60 | 1.11 s | 1.06 s | -4.4% | -6.9, -1.8 | inconclusive* |
| shared, broker CPU | 40 | 4.88 s | 5.37 s | +10.2% | +7.5, +12.9 | **worse** |
| calls, broker user time | 60 | 0.16 s | 0.24 s | +49.9% | +43.2, +57.1 | **worse** |
| signals, broker user time | 60 | 0.15 s | 0.14 s | -2.0% | -7.2, +3.4 | inconclusive |
| latency, broker user time | 60 | 0.22 s | 0.33 s | +50.2% | +44.2, +56.8 | **worse** |
| shared, broker user time | 40 | 1.17 s | 1.86 s | +58.9% | +54.2, +63.7 | **worse** |
| calls, broker system time | 60 | 0.57 s | 0.56 s | -1.6% | -5.2, +2.2 | within ±5% |
| signals, broker system time | 60 | 0.51 s | 0.17 s | -65.7% | -68.2, -62.8 | **better** |
| latency, broker system time | 60 | 0.89 s | 0.73 s | -17.9% | -20.6, -15.2 | **better** |
| shared, broker system time | 40 | 3.70 s | 3.51 s | -5.3% | -8.0, -2.4 | inconclusive* |
| calls, broker peak RSS | 60 | 6.5 MiB | 5.0 MiB | -22.2% | -22.6, -21.9 | **better** |
| signals, broker peak RSS | 60 | 8.3 MiB | 4.6 MiB | -43.8% | -47.2, -40.4 | **better** |
| latency, broker peak RSS | 60 | 7.2 MiB | 5.1 MiB | -28.9% | -32.0, -26.0 | **better** |
| shared, broker peak RSS | 40 | 7.7 MiB | 7.9 MiB | +3.4% | +2.7, +4.0 | within ±5%* |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.180 s | 0.166 s | -7.8% | -9.8, -5.7 | **better** |
| calls, 20 clients | 60 | 0.699 s | 0.927 s | +32.6% | +28.1, +37.2 | **worse** |
| signals, burst to 1 | 60 | 0.253 s | 0.333 s | +31.3% | +26.1, +36.5 | **worse** |
| signals, broadcast to 20 | 60 | 0.416 s | 0.233 s | -44.0% | -47.2, -40.7 | **better** |
| RTT, 1 client, p50 | 60 | 156 µs | 144 µs | -8.0% | -9.6, -6.3 | **better** |
| RTT, 1 client, p99 | 60 | 302 µs | 293 µs | -3.0% | -7.4, +1.4 | inconclusive |
| RTT, 20 clients, p50 | 60 | 630 µs | 825 µs | +31.0% | +26.1, +35.7 | **worse** |
| RTT, 20 clients, p99 | 60 | 1516 µs | 1703 µs | +12.4% | +4.1, +21.4 | inconclusive* |
| delivery to 20, p50 | 60 | 4.4 ms | 3.3 ms | -24.9% | -34.2, -15.3 | **better** |
| delivery to 20, p99 | 60 | 20.2 ms | 8.5 ms | -58.2% | -66.7, -46.3 | **better** |
| delivery to 20, whole fan-out | 60 | 0.134 s | 0.078 s | -42.2% | -46.3, -37.7 | **better** |
| 100 proxies, 1 connection | 40 | 2.12 s | 2.10 s | -1.3% | -4.8, +2.2 | within ±5% |
| 100 clients | 40 | 3.04 s | 5.29 s | +74.1% | +70.9, +77.5 | **worse** |
| calls, broker CPU | 60 | 0.74 s | 0.98 s | +32.5% | +28.4, +36.5 | **worse** |
| signals, broker CPU | 60 | 0.66 s | 0.55 s | -16.6% | -19.8, -13.2 | **better** |
| latency, broker CPU | 60 | 1.11 s | 1.31 s | +18.0% | +15.2, +20.7 | **worse** |
| shared, broker CPU | 40 | 4.88 s | 7.09 s | +45.5% | +42.9, +48.3 | **worse** |
| calls, broker user time | 60 | 0.16 s | 0.37 s | +124.3% | +114.4, +134.5 | **worse** |
| signals, broker user time | 60 | 0.15 s | 0.35 s | +140.8% | +129.2, +153.3 | **worse** |
| latency, broker user time | 60 | 0.22 s | 0.52 s | +136.7% | +126.8, +147.0 | **worse** |
| shared, broker user time | 40 | 1.17 s | 2.96 s | +152.4% | +146.2, +158.6 | **worse** |
| calls, broker system time | 60 | 0.57 s | 0.61 s | +6.4% | +2.2, +10.5 | inconclusive* |
| signals, broker system time | 60 | 0.51 s | 0.19 s | -61.9% | -63.8, -59.8 | **better** |
| latency, broker system time | 60 | 0.89 s | 0.79 s | -11.5% | -14.3, -8.6 | **better** |
| shared, broker system time | 40 | 3.70 s | 4.14 s | +11.7% | +8.9, +14.6 | **worse** |
| calls, broker peak RSS | 60 | 6.5 MiB | 5.1 MiB | -20.6% | -21.0, -20.3 | **better** |
| signals, broker peak RSS | 60 | 8.3 MiB | 4.7 MiB | -43.2% | -46.6, -39.7 | **better** |
| latency, broker peak RSS | 60 | 7.2 MiB | 5.2 MiB | -27.6% | -30.7, -24.7 | **better** |
| shared, broker peak RSS | 40 | 7.7 MiB | 8.0 MiB | +4.8% | +3.8, +5.9 | inconclusive* |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.184 s | 0.157 s | -14.3% | -16.5, -12.0 | **better** |
| calls, 20 clients | 60 | 1.559 s | 0.779 s | -50.0% | -51.6, -48.3 | **better** |
| signals, burst to 1 | 60 | 0.768 s | 0.198 s | -74.2% | -75.3, -72.9 | **better** |
| signals, broadcast to 20 | 60 | 1.751 s | 0.184 s | -89.5% | -90.0, -88.9 | **better** |
| RTT, 1 client, p50 | 60 | 148 µs | 135 µs | -9.0% | -10.6, -7.4 | **better** |
| RTT, 1 client, p99 | 60 | 297 µs | 278 µs | -6.6% | -10.3, -2.5 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 1448 µs | 659 µs | -54.5% | -55.8, -53.1 | **better** |
| RTT, 20 clients, p99 | 60 | 2658 µs | 1465 µs | -44.9% | -48.9, -40.4 | **better** |
| delivery to 20, p50 | 60 | 16.0 ms | 2.7 ms | -83.3% | -84.2, -82.2 | **better** |
| delivery to 20, p99 | 60 | 32.4 ms | 10.7 ms | -67.0% | -70.4, -63.2 | **better** |
| delivery to 20, whole fan-out | 60 | 0.552 s | 0.064 s | -88.5% | -89.0, -87.8 | **better** |
| 100 proxies, 1 connection | 40 | 6.57 s | 1.72 s | -73.8% | -74.6, -73.1 | **better** |
| 100 clients | 40 | 7.86 s | 4.02 s | -48.9% | -49.8, -48.0 | **better** |
| calls, broker CPU | 60 | 1.62 s | 0.81 s | -50.1% | -51.4, -48.8 | **better** |
| signals, broker CPU | 60 | 2.50 s | 0.32 s | -87.3% | -87.8, -86.7 | **better** |
| latency, broker CPU | 60 | 2.46 s | 1.06 s | -56.8% | -57.6, -56.0 | **better** |
| shared, broker CPU | 40 | 14.17 s | 5.37 s | -62.1% | -62.7, -61.5 | **better** |
| calls, broker user time | 60 | 0.79 s | 0.24 s | -69.0% | -70.2, -67.7 | **better** |
| signals, broker user time | 60 | 0.80 s | 0.14 s | -82.1% | -82.8, -81.3 | **better** |
| latency, broker user time | 60 | 1.05 s | 0.33 s | -68.2% | -69.2, -67.2 | **better** |
| shared, broker user time | 40 | 7.03 s | 1.86 s | -73.5% | -74.1, -72.9 | **better** |
| calls, broker system time | 60 | 0.83 s | 0.56 s | -32.2% | -34.2, -30.2 | **better** |
| signals, broker system time | 60 | 1.70 s | 0.17 s | -89.7% | -90.4, -88.9 | **better** |
| latency, broker system time | 60 | 1.42 s | 0.73 s | -48.4% | -49.7, -47.0 | **better** |
| shared, broker system time | 40 | 7.13 s | 3.51 s | -50.8% | -51.8, -49.8 | **better** |
| calls, broker peak RSS | 60 | 5.2 MiB | 5.0 MiB | -3.9% | -4.4, -3.4 | within ±5%* |
| signals, broker peak RSS | 60 | 4.6 MiB | 4.6 MiB | +0.6% | -0.4, +1.5 | within ±5% |
| latency, broker peak RSS | 60 | 5.3 MiB | 5.1 MiB | -2.7% | -3.2, -2.1 | within ±5%* |
| shared, broker peak RSS | 40 | 8.5 MiB | 7.9 MiB | -6.8% | -7.4, -6.3 | **better** |

### The slowest signals of the fan-out

after delivers the signals of the latencies' fan-out sooner on the whole: their median delay is
19.2% shorter, and the whole fan-out 18.0% shorter, than with before. But the slowest 1% of the
deliveries take longer: the p99 delay is 26.5% longer, and the p99.9 and the maximum 32% longer. It
is not a few bad rounds: the medians over the rounds of the p99 are 8.4 ms with before and with
zruntime, and 9.6 ms with after, and their upper quartiles 10.0, 10.1 and 12.6 ms. zbus is what
makes the difference, as the zruntime build has the p99 of before.

The signals do not queue up behind the emitter. After this run, a build of the latency client that
also noted when the emitter had sent its last signal, and the median delay of the signals of each
quarter of the sequence, ran 12 times against zruntime and after in turn. The emitter sent its 2000
signals in 52.3 ms against after and 68.8 ms against zruntime, the medians of the 12, and the median
delays of the four quarters were 2.8, 2.5, 2.5 and 2.7 ms against after, and 3.1, 3.2, 3.2 and 3.2
ms against zruntime: lower in each quarter, and no higher at the end than at the start. What makes
the slowest deliveries slower is open. One candidate is the threads of the 20 subscribers, of the
emitter and of the bus sharing 4 vCPUs within a window that is 24% shorter, so that a subscriber
that waits for a CPU falls further behind. On the Ryzen 7 7840U, with 16 threads, after delivers the
slowest signals 39.2% sooner than before at p99 ([the run of
2026-10-27](2026-10-27-busd-dependency-updates-ryzen-7840u.md)), which is consistent with it.

### One client

With one client, busd is faster than dbus-broker here, by 12.6% on the calls and 13.7% on the median
round trip, and before was too, by 7.8 and 8.0%. On the Ryzen 7 7840U it is the other way round:
after takes 15.2% longer than dbus-broker on the calls of one client, and before 22.6% longer ([the
run of 2026-10-27](2026-10-27-busd-dependency-updates-ryzen-7840u.md)). A call of one client waits
for a wake-up at each hop, whose cost differs between a VM and bare metal, which likely makes the
difference; neither machine speaks for the other there.

## Reproducing

```sh
scripts/compare-dependency-updates.sh
```

at 3a20fff builds the brokers and runs all of this, in about 51 minutes on this VM once the builds
are made, and writes its results to `$WORK/dependency-updates-results-f415bfd`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. It ran with dbus-broker 37
first on the `PATH`. The counts of epoll's calls come from bpftrace, which counted busd's
`epoll_ctl` calls by operation, and the events that its `epoll_wait` calls returned, over one run of
the shared client against each build, after the comparisons.
