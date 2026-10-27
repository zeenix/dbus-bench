# busd on the latest zbus and zruntime, on a Ryzen 7 7840U

Measured on 2026-10-27, overnight, on the laptop of
[threaded subscribers](2026-10-25-busd-batched-sends-subscriber-threads-ryzen-7840u.md): an AMD
Ryzen 7 7840U (8 cores, 16 threads), running Fedora 44 with Linux 7.1.13. It ran
`scripts/compare-dependency-updates.sh` at 3a20fff, which made every build of busd with rustc
1.99.0. dbus-broker 37 and dbus-daemon 1.16.2 are Fedora's. Compare the brokers with each other,
within this file only.

The builds of busd and the clients are those of
[the run on a 4-vCPU Xeon](2026-10-26-busd-dependency-updates-xeon-4vcpu.md), which describes them:
**before**, d69f900, busd's main branch; **zruntime**, the same commit on zruntime b3bd01d; and
**after**, f415bfd of zeenix/busd, on that zruntime and on zbus 50c54bf.

## Summary

* Against before, after uses 16 to 38% less CPU time on every workload, with 30 to 59% less user
  time and as much system time, but for the shared phases, where it uses 9.7% less. It takes 17.1%
  less time on the calls of 20 clients, 38.9% and 39.4% less on the burst and the broadcast of
  signals, 17.2% less on the median round trip of 20 clients and 17.1% less at p99, and 13.5% and
  25.7% less on the shared phases. The signals of the latencies' fan-out arrive with 43.8% shorter
  median delays and 39.2% shorter p99 delays, and the whole fan-out takes 35.7% less time. One
  client's calls take 6.0% less (inconclusive, but repeatable), and its median round trip 5.6% less.
* The zruntime build makes the 100 clients 13.6% faster, with 8.4% less CPU time and 11.1% less
  system time, as z-galaxy/zruntime#59 estimated from the 4-vCPU Xeon with the clients of then
  (12.8%), and twice what it makes them on that Xeon now (6.5%). It is within 5%, or inconclusive,
  on everything else. The rest is zbus's: after against zruntime is 14 to 44% faster on everything
  but one client, where it is 6% faster.
* Against dbus-broker, after is level on the round trips of 20 clients (+0.4% at the median, -2.7%
  at p99) and close on their calls, which take 4.3% longer (inconclusive, but repeatable), where
  before took 25.8% longer. It is faster on the signals: by 25.8% on the burst, which before took
  21.6% longer, by 60.1% on the broadcast, and by 42 to 58% on the latencies' fan-out. It is slower
  with one client, by 15.2% on the calls and 21.2% on the median round trip (before: 22.6% and
  28.4%), and with 100 clients, by 17.8% (before: 58.6%). It uses 8.4% more CPU time on the calls
  and 11.2% more on the shared phases, with about 25% more user time, as much on the latencies, and
  40.3% less on the signals. Its peak memory is 14 to 25% lower, but for the shared phases, where it
  is 49.8% higher: 13.5 MiB against 9.0 MiB.
* Against dbus-daemon, after is faster on every measure, by 35 to 96%, with 72 to 92% less CPU
  time, but uses 9 to 41% more peak memory.
* No run of any broker failed.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the run on the 4-vCPU Xeon](2026-10-26-busd-dependency-updates-xeon-4vcpu.md#the-benchmarks). The
raw results of each run are in
[runs.tar.xz](2026-10-27-busd-dependency-updates-ryzen-7840u/runs.tar.xz), from which
[paired-stats.py](../scripts/paired-stats.py) makes the comparisons, with the other metrics and the
medians. A star marks a difference whose 95% interval excludes 0 but not the margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.075 s | 0.070 s | -6.0% | -7.1, -4.9 | inconclusive* |
| calls, 20 clients | 60 | 0.394 s | 0.326 s | -17.1% | -18.0, -16.1 | **better** |
| signals, burst to 1 | 60 | 0.213 s | 0.130 s | -38.9% | -39.5, -38.4 | **better** |
| signals, broadcast to 20 | 60 | 0.126 s | 0.076 s | -39.4% | -40.1, -38.6 | **better** |
| RTT, 1 client, p50 | 60 | 61 µs | 58 µs | -5.6% | -6.0, -5.1 | **better** |
| RTT, 1 client, p99 | 60 | 135 µs | 123 µs | -9.2% | -13.8, -4.5 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 354 µs | 293 µs | -17.2% | -18.1, -16.3 | **better** |
| RTT, 20 clients, p99 | 60 | 524 µs | 435 µs | -17.1% | -18.2, -15.9 | **better** |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -43.8% | -44.5, -43.1 | **better** |
| delivery to 20, p99 | 60 | 3.2 ms | 1.9 ms | -39.2% | -40.7, -37.5 | **better** |
| delivery to 20, whole fan-out | 60 | 0.044 s | 0.028 s | -35.7% | -36.4, -35.0 | **better** |
| 100 proxies, 1 connection | 40 | 1.46 s | 1.26 s | -13.5% | -15.3, -11.7 | **better** |
| 100 clients | 40 | 2.75 s | 2.04 s | -25.7% | -27.4, -24.0 | **better** |
| calls, broker CPU | 60 | 0.43 s | 0.36 s | -16.0% | -16.7, -15.2 | **better** |
| signals, broker CPU | 60 | 0.37 s | 0.23 s | -37.6% | -38.0, -37.2 | **better** |
| latency, broker CPU | 60 | 0.59 s | 0.49 s | -16.0% | -16.6, -15.5 | **better** |
| shared, broker CPU | 40 | 4.11 s | 3.21 s | -21.9% | -23.1, -20.5 | **better** |
| calls, broker user time | 60 | 0.21 s | 0.15 s | -30.4% | -32.3, -28.5 | **better** |
| signals, broker user time | 60 | 0.23 s | 0.09 s | -59.0% | -60.0, -58.0 | **better** |
| latency, broker user time | 60 | 0.29 s | 0.20 s | -32.8% | -34.1, -31.4 | **better** |
| shared, broker user time | 40 | 1.90 s | 1.22 s | -35.9% | -37.4, -34.4 | **better** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -2.2% | -4.2, -0.1 | within ±5%* |
| signals, broker system time | 60 | 0.14 s | 0.13 s | -1.9% | -4.0, +0.4 | within ±5% |
| latency, broker system time | 60 | 0.30 s | 0.30 s | +0.5% | -1.0, +1.9 | within ±5% |
| shared, broker system time | 40 | 2.20 s | 1.99 s | -9.7% | -11.2, -8.1 | **better** |
| calls, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | -0.5% | -1.1, +0.1 | within ±5% |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.2 MiB | -0.2% | -1.0, +0.5 | within ±5% |
| latency, broker peak RSS | 60 | 7.1 MiB | 7.1 MiB | -0.9% | -1.5, -0.3 | within ±5%* |
| shared, broker peak RSS | 40 | 13.7 MiB | 13.5 MiB | -1.6% | -2.9, -0.3 | within ±5%* |

### zruntime against before

| Measure | n | before | zruntime | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.075 s | 0.075 s | -0.1% | -1.4, +1.2 | within ±5% |
| calls, 20 clients | 60 | 0.394 s | 0.395 s | +0.3% | -0.9, +1.5 | within ±5% |
| signals, burst to 1 | 60 | 0.213 s | 0.211 s | -0.7% | -1.2, -0.3 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.126 s | 0.124 s | -1.2% | -1.8, -0.5 | within ±5%* |
| RTT, 1 client, p50 | 60 | 61 µs | 61 µs | +0.0% | -0.5, +0.5 | within ±5% |
| RTT, 1 client, p99 | 60 | 135 µs | 131 µs | -3.3% | -8.0, +1.5 | inconclusive |
| RTT, 20 clients, p50 | 60 | 354 µs | 360 µs | +1.5% | +0.5, +2.5 | within ±5%* |
| RTT, 20 clients, p99 | 60 | 524 µs | 518 µs | -1.2% | -3.6, +1.5 | within ±5% |
| delivery to 20, p50 | 60 | 2.0 ms | 2.0 ms | +0.2% | -1.1, +1.4 | within ±5% |
| delivery to 20, p99 | 60 | 3.2 ms | 3.2 ms | +1.0% | -0.9, +3.3 | within ±5% |
| delivery to 20, whole fan-out | 60 | 0.044 s | 0.044 s | +0.3% | -1.0, +1.6 | within ±5% |
| 100 proxies, 1 connection | 40 | 1.46 s | 1.48 s | +0.9% | -2.1, +4.0 | within ±5% |
| 100 clients | 40 | 2.75 s | 2.37 s | -13.6% | -15.5, -11.5 | **better** |
| calls, broker CPU | 60 | 0.43 s | 0.44 s | +0.7% | -0.4, +1.8 | within ±5% |
| signals, broker CPU | 60 | 0.37 s | 0.36 s | -0.7% | -1.1, -0.4 | within ±5%* |
| latency, broker CPU | 60 | 0.59 s | 0.59 s | +0.7% | -0.0, +1.4 | within ±5% |
| shared, broker CPU | 40 | 4.11 s | 3.76 s | -8.4% | -10.0, -6.6 | **better** |
| calls, broker user time | 60 | 0.21 s | 0.22 s | +2.9% | +0.7, +5.2 | within ±5%* |
| signals, broker user time | 60 | 0.23 s | 0.22 s | -2.5% | -4.1, -0.9 | within ±5%* |
| latency, broker user time | 60 | 0.29 s | 0.29 s | +0.1% | -1.7, +1.9 | within ±5% |
| shared, broker user time | 40 | 1.90 s | 1.80 s | -5.2% | -6.9, -3.6 | inconclusive* |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -1.4% | -3.3, +0.5 | within ±5% |
| signals, broker system time | 60 | 0.14 s | 0.14 s | +2.2% | -0.4, +5.0 | within ±5% |
| latency, broker system time | 60 | 0.30 s | 0.30 s | +1.2% | -0.5, +3.0 | within ±5% |
| shared, broker system time | 40 | 2.20 s | 1.96 s | -11.1% | -13.0, -9.0 | **better** |
| calls, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | -0.5% | -1.1, +0.1 | within ±5% |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.2 MiB | +0.4% | -0.3, +1.1 | within ±5% |
| latency, broker peak RSS | 60 | 7.1 MiB | 7.1 MiB | +0.1% | -0.5, +0.8 | within ±5% |
| shared, broker peak RSS | 40 | 13.7 MiB | 13.7 MiB | -0.1% | -1.9, +1.6 | within ±5% |

### after against zruntime

| Measure | n | zruntime | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.075 s | 0.070 s | -5.9% | -6.9, -4.9 | inconclusive* |
| calls, 20 clients | 60 | 0.395 s | 0.326 s | -17.3% | -18.4, -16.3 | **better** |
| signals, burst to 1 | 60 | 0.211 s | 0.130 s | -38.5% | -39.0, -37.9 | **better** |
| signals, broadcast to 20 | 60 | 0.124 s | 0.076 s | -38.7% | -39.4, -37.9 | **better** |
| RTT, 1 client, p50 | 60 | 61 µs | 58 µs | -5.6% | -6.1, -5.1 | **better** |
| RTT, 1 client, p99 | 60 | 131 µs | 123 µs | -6.1% | -11.3, -0.6 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 360 µs | 293 µs | -18.4% | -19.4, -17.6 | **better** |
| RTT, 20 clients, p99 | 60 | 518 µs | 435 µs | -16.1% | -18.3, -14.0 | **better** |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -43.9% | -44.6, -43.1 | **better** |
| delivery to 20, p99 | 60 | 3.2 ms | 1.9 ms | -39.8% | -41.8, -37.8 | **better** |
| delivery to 20, whole fan-out | 60 | 0.044 s | 0.028 s | -35.9% | -36.6, -35.1 | **better** |
| 100 proxies, 1 connection | 40 | 1.48 s | 1.26 s | -14.3% | -16.8, -11.8 | **better** |
| 100 clients | 40 | 2.37 s | 2.04 s | -14.1% | -16.0, -12.1 | **better** |
| calls, broker CPU | 60 | 0.44 s | 0.36 s | -16.5% | -17.5, -15.6 | **better** |
| signals, broker CPU | 60 | 0.36 s | 0.23 s | -37.2% | -37.5, -36.8 | **better** |
| latency, broker CPU | 60 | 0.59 s | 0.49 s | -16.6% | -17.2, -16.0 | **better** |
| shared, broker CPU | 40 | 3.76 s | 3.21 s | -14.7% | -16.3, -13.1 | **better** |
| calls, broker user time | 60 | 0.22 s | 0.15 s | -32.4% | -34.3, -30.5 | **better** |
| signals, broker user time | 60 | 0.22 s | 0.09 s | -58.0% | -59.0, -56.9 | **better** |
| latency, broker user time | 60 | 0.29 s | 0.20 s | -32.8% | -34.2, -31.5 | **better** |
| shared, broker user time | 40 | 1.80 s | 1.22 s | -32.4% | -33.8, -30.9 | **better** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -0.8% | -2.7, +1.1 | within ±5% |
| signals, broker system time | 60 | 0.14 s | 0.13 s | -4.0% | -6.0, -2.0 | inconclusive* |
| latency, broker system time | 60 | 0.30 s | 0.30 s | -0.8% | -2.4, +0.9 | within ±5% |
| shared, broker system time | 40 | 1.96 s | 1.99 s | +1.6% | -0.9, +3.9 | within ±5% |
| calls, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | -0.0% | -0.7, +0.7 | within ±5% |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.2 MiB | -0.6% | -1.3, +0.0 | within ±5% |
| latency, broker peak RSS | 60 | 7.1 MiB | 7.1 MiB | -1.0% | -1.6, -0.4 | within ±5%* |
| shared, broker peak RSS | 40 | 13.7 MiB | 13.5 MiB | -1.5% | -3.0, +0.1 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.061 s | 0.070 s | +15.2% | +13.7, +16.8 | **worse** |
| calls, 20 clients | 60 | 0.313 s | 0.326 s | +4.3% | +2.6, +6.1 | inconclusive* |
| signals, burst to 1 | 60 | 0.175 s | 0.130 s | -25.8% | -26.6, -25.0 | **better** |
| signals, broadcast to 20 | 60 | 0.191 s | 0.076 s | -60.1% | -60.6, -59.5 | **better** |
| RTT, 1 client, p50 | 60 | 48 µs | 58 µs | +21.2% | +20.7, +21.7 | **worse** |
| RTT, 1 client, p99 | 60 | 107 µs | 123 µs | +15.0% | +8.8, +21.8 | **worse** |
| RTT, 20 clients, p50 | 60 | 292 µs | 293 µs | +0.4% | -1.0, +1.6 | within ±5% |
| RTT, 20 clients, p99 | 60 | 447 µs | 435 µs | -2.7% | -5.0, -0.4 | within ±5%* |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -45.5% | -46.3, -44.7 | **better** |
| delivery to 20, p99 | 60 | 3.3 ms | 1.9 ms | -41.5% | -43.0, -39.7 | **better** |
| delivery to 20, whole fan-out | 60 | 0.067 s | 0.028 s | -57.7% | -58.3, -57.1 | **better** |
| 100 proxies, 1 connection | 40 | 1.20 s | 1.26 s | +5.4% | +3.8, +7.1 | inconclusive* |
| 100 clients | 40 | 1.73 s | 2.04 s | +17.8% | +15.3, +20.4 | **worse** |
| calls, broker CPU | 60 | 0.34 s | 0.36 s | +8.4% | +6.7, +10.0 | **worse** |
| signals, broker CPU | 60 | 0.38 s | 0.23 s | -40.3% | -40.8, -39.8 | **better** |
| latency, broker CPU | 60 | 0.48 s | 0.49 s | +3.8% | +2.9, +4.7 | within ±5%* |
| shared, broker CPU | 40 | 2.89 s | 3.21 s | +11.2% | +9.8, +12.7 | **worse** |
| calls, broker user time | 60 | 0.12 s | 0.15 s | +26.0% | +22.4, +30.0 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.09 s | -25.3% | -27.2, -23.3 | **better** |
| latency, broker user time | 60 | 0.16 s | 0.20 s | +24.2% | +20.7, +27.8 | **worse** |
| shared, broker user time | 40 | 0.97 s | 1.22 s | +25.6% | +23.2, +28.3 | **worse** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -1.0% | -3.6, +1.7 | within ±5% |
| signals, broker system time | 60 | 0.26 s | 0.13 s | -47.7% | -48.5, -46.8 | **better** |
| latency, broker system time | 60 | 0.32 s | 0.30 s | -6.3% | -7.9, -4.7 | inconclusive* |
| shared, broker system time | 40 | 1.91 s | 1.99 s | +3.9% | +2.4, +5.5 | inconclusive* |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.9 MiB | -15.3% | -15.9, -14.7 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.2 MiB | -24.9% | -25.8, -24.0 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.1 MiB | -13.6% | -14.1, -13.1 | **better** |
| shared, broker peak RSS | 40 | 9.0 MiB | 13.5 MiB | +49.8% | +47.5, +52.0 | **worse** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.061 s | 0.075 s | +22.6% | +21.3, +23.9 | **worse** |
| calls, 20 clients | 60 | 0.313 s | 0.394 s | +25.8% | +23.2, +28.5 | **worse** |
| signals, burst to 1 | 60 | 0.175 s | 0.213 s | +21.6% | +20.8, +22.4 | **worse** |
| signals, broadcast to 20 | 60 | 0.191 s | 0.126 s | -34.2% | -35.1, -33.4 | **better** |
| RTT, 1 client, p50 | 60 | 48 µs | 61 µs | +28.4% | +27.6, +29.1 | **worse** |
| RTT, 1 client, p99 | 60 | 107 µs | 135 µs | +26.7% | +20.5, +33.2 | **worse** |
| RTT, 20 clients, p50 | 60 | 292 µs | 354 µs | +21.2% | +19.4, +22.9 | **worse** |
| RTT, 20 clients, p99 | 60 | 447 µs | 524 µs | +17.3% | +14.3, +20.3 | **worse** |
| delivery to 20, p50 | 60 | 2.0 ms | 2.0 ms | -3.1% | -4.6, -1.6 | within ±5%* |
| delivery to 20, p99 | 60 | 3.3 ms | 3.2 ms | -3.8% | -5.6, -1.8 | inconclusive* |
| delivery to 20, whole fan-out | 60 | 0.067 s | 0.044 s | -34.3% | -35.3, -33.2 | **better** |
| 100 proxies, 1 connection | 40 | 1.20 s | 1.46 s | +21.8% | +19.9, +23.9 | **worse** |
| 100 clients | 40 | 1.73 s | 2.75 s | +58.6% | +56.0, +61.3 | **worse** |
| calls, broker CPU | 60 | 0.34 s | 0.43 s | +29.0% | +26.6, +31.5 | **worse** |
| signals, broker CPU | 60 | 0.38 s | 0.37 s | -4.3% | -5.1, -3.5 | within ±5%* |
| latency, broker CPU | 60 | 0.48 s | 0.59 s | +23.6% | +22.4, +24.9 | **worse** |
| shared, broker CPU | 40 | 2.89 s | 4.11 s | +42.3% | +40.5, +44.2 | **worse** |
| calls, broker user time | 60 | 0.12 s | 0.21 s | +81.1% | +75.3, +87.3 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.23 s | +82.3% | +78.4, +86.5 | **worse** |
| latency, broker user time | 60 | 0.16 s | 0.29 s | +84.8% | +80.1, +89.7 | **worse** |
| shared, broker user time | 40 | 0.97 s | 1.90 s | +96.1% | +92.9, +99.4 | **worse** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | +1.2% | -1.8, +4.2 | within ±5% |
| signals, broker system time | 60 | 0.26 s | 0.14 s | -46.7% | -47.9, -45.4 | **better** |
| latency, broker system time | 60 | 0.32 s | 0.30 s | -6.7% | -8.5, -5.0 | inconclusive* |
| shared, broker system time | 40 | 1.91 s | 2.20 s | +15.1% | +13.2, +17.0 | **worse** |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.9 MiB | -14.9% | -15.4, -14.3 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.2 MiB | -24.7% | -25.6, -23.9 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.1 MiB | -12.8% | -13.3, -12.2 | **better** |
| shared, broker peak RSS | 40 | 9.0 MiB | 13.7 MiB | +52.2% | +50.3, +54.0 | **worse** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.133 s | 0.070 s | -47.2% | -47.8, -46.6 | **better** |
| calls, 20 clients | 60 | 1.218 s | 0.326 s | -73.2% | -73.4, -72.9 | **better** |
| signals, burst to 1 | 60 | 0.853 s | 0.130 s | -84.8% | -84.9, -84.6 | **better** |
| signals, broadcast to 20 | 60 | 1.957 s | 0.076 s | -96.1% | -96.1, -96.1 | **better** |
| RTT, 1 client, p50 | 60 | 92 µs | 58 µs | -37.1% | -37.7, -36.7 | **better** |
| RTT, 1 client, p99 | 60 | 190 µs | 123 µs | -35.2% | -37.8, -32.4 | **better** |
| RTT, 20 clients, p50 | 60 | 1174 µs | 293 µs | -75.0% | -75.2, -74.8 | **better** |
| RTT, 20 clients, p99 | 60 | 1433 µs | 435 µs | -69.7% | -70.4, -68.9 | **better** |
| delivery to 20, p50 | 60 | 19.7 ms | 1.1 ms | -94.4% | -94.5, -94.4 | **better** |
| delivery to 20, p99 | 60 | 31.8 ms | 1.9 ms | -93.9% | -94.0, -93.7 | **better** |
| delivery to 20, whole fan-out | 60 | 0.657 s | 0.028 s | -95.7% | -95.7, -95.6 | **better** |
| 100 proxies, 1 connection | 40 | 6.50 s | 1.26 s | -80.5% | -80.8, -80.2 | **better** |
| 100 clients | 40 | 6.35 s | 2.04 s | -67.9% | -68.5, -67.2 | **better** |
| calls, broker CPU | 60 | 1.31 s | 0.36 s | -72.0% | -72.3, -71.8 | **better** |
| signals, broker CPU | 60 | 2.82 s | 0.23 s | -91.9% | -92.0, -91.9 | **better** |
| latency, broker CPU | 60 | 2.16 s | 0.49 s | -77.1% | -77.3, -77.0 | **better** |
| shared, broker CPU | 40 | 12.82 s | 3.21 s | -75.0% | -75.3, -74.6 | **better** |
| calls, broker user time | 60 | 0.52 s | 0.15 s | -71.6% | -72.3, -71.0 | **better** |
| signals, broker user time | 60 | 0.92 s | 0.09 s | -89.8% | -90.0, -89.5 | **better** |
| latency, broker user time | 60 | 0.79 s | 0.20 s | -75.1% | -75.6, -74.6 | **better** |
| shared, broker user time | 40 | 4.92 s | 1.22 s | -75.2% | -75.6, -74.7 | **better** |
| calls, broker system time | 60 | 0.79 s | 0.22 s | -72.3% | -72.7, -71.9 | **better** |
| signals, broker system time | 60 | 1.90 s | 0.13 s | -93.0% | -93.1, -92.9 | **better** |
| latency, broker system time | 60 | 1.37 s | 0.30 s | -78.3% | -78.6, -78.1 | **better** |
| shared, broker system time | 40 | 7.90 s | 1.99 s | -74.8% | -75.1, -74.5 | **better** |
| calls, broker peak RSS | 60 | 6.3 MiB | 6.9 MiB | +8.9% | +8.2, +9.7 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.2 MiB | +12.6% | +11.8, +13.4 | **worse** |
| latency, broker peak RSS | 60 | 6.3 MiB | 7.1 MiB | +11.7% | +10.9, +12.5 | **worse** |
| shared, broker peak RSS | 40 | 9.6 MiB | 13.5 MiB | +40.8% | +38.5, +43.0 | **worse** |

### The slowest signals of the fan-out

On the 4-vCPU Xeon, after delivered the slowest signals of the latencies' fan-out later than
before, by 26.5% at p99, though their median delay was shorter, and that file left open why, with
one candidate: the threads of the 20 subscribers, of the emitter and of the bus sharing 4 vCPUs
within a shorter window. Here, with 16 threads for them, after delivers them 39.2% sooner at p99,
1.9 ms against 3.2 ms, as it does at the median, which is consistent with that candidate.

### One client

busd stays slower than dbus-broker with one client here, where it is faster on the Xeon: by 15.2% on
the calls and 21.2% on the median round trip, where before took 22.6% and 28.4% longer.

## Reproducing

```sh
scripts/compare-dependency-updates.sh
```

at 3a20fff builds the brokers and runs all of this, in about 35 minutes on this laptop once the
builds are made, and writes its results to `$WORK/dependency-updates-results-f415bfd`, whose raw
runs [pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`.
