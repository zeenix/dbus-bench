# busd on zruntime's edge-triggered pollers, on a Ryzen 7 7840U

Measured on 2026-10-30 on the laptop of [the run of
2026-10-28](2026-10-28-busd-zbus-read-ahead-ryzen-7840u.md): an AMD Ryzen 7 7840U (8 cores, 16
threads), running Fedora 44 with Linux 7.2.13 and glibc 2.43. It ran `scripts/compare.sh` from
d85403c, whose scripts and clients are those of 4a3f219, which made both builds of busd with rustc
1.99.0. dbus-broker 37 and dbus-daemon 1.16.2 are Fedora's. Compare the brokers with each other,
within this file only: every broker takes 19 to 37% less time on the workloads of one client than
in the run of 2026-10-28, which ran on Linux 7.1.13, and differs less on the others.

The builds of busd differ in the commit of zruntime that they build on alone, and both build on
zbus 90a0bd1:

* **busd**: busd's main branch at 3a751a5, the merge of z-galaxy/busd#398, which builds on
  zruntime's main branch at aae96ac, the merge of z-galaxy/zruntime#65. There, epoll and kqueue
  report a socket as it turns ready, rather than on every wait for as long as it stays ready, so
  that a busy runtime's waits no longer report again the sockets of the tasks that a wait woke
  until those tasks have been polled, and, as of z-galaxy/zruntime#63, `block_on` polls its future
  only once it has been woken, rather than after every round of its tasks;
* **baseline**: b4b8efe, busd's main branch just before #398, on zruntime b3bd01d, the merge of
  z-galaxy/zruntime#60. It has the code of 077f12d, which the run of 2026-10-28 measured as after.

The clients are those of the run of 2026-10-28, on zbus 50c54bf and zruntime b3bd01d: they leave
the sender out of every message that is timed, as libdbus, GLib and sd-bus clients do, and the
`dicts` workload makes the method calls with a body of 100 variants, `a{sa{sv}}`.

## Summary

* Against baseline, busd takes 5.2% less time with 100 clients (from -6.2 to -4.2%), with 3.8% less
  CPU time over the shared phases, 4.7% less user time and 3.1% less system time: repeatable, if not
  clearly beyond the margin of ±5%. With one client, it takes 3.2% less on the calls, 3.1% less on
  the dict calls (from -6.4 to +0.1%), and 3.5% less on the median round trip and 7.3% less at p99
  (from -11.1 to -3.0%). Its CPU time is 1.7 to 2.1% less on the calls, the latencies and the dicts.
  The signals, the calls of 20 clients and their round trips, and the 100 callers on one connection
  take within 1% of baseline's time, as does the median delivery of the latencies' fan-out, whose
  p99 is inconclusive (+2.9%, from -0.7 to +7.3%).
* busd's voluntary context switches, which the tables leave out, are 27.0% more than baseline's on
  the signals (from +13.8 to +41.6%: 282 against 202 in a run of them, at the median), where its
  time and CPU time are level, and within 4.2% on the other workloads. Its peak memory is within
  0.5% of baseline's everywhere.
* Against dbus-broker, busd takes 3.6% longer on the calls of 20 clients (baseline: 4.1%), 3.9%
  less time with one client (baseline: 0.7% less), 6.9% longer with 100 clients (baseline:
  12.8%), and 23.2% less with 100 callers on one connection (baseline: 22.6% less). Its median
  round trip is 5.8% shorter with one client (baseline: 2.4%), and about as long with 20 (-0.7%,
  baseline: -0.1%). It is faster on the burst of signals, by 34.5%, on their broadcast, by 64.8%,
  on the latencies' fan-out, and on the dict calls, by 34.7% with 20 clients and 13.1% with one,
  as baseline is. Its CPU time is 2.5% more on the calls (baseline: 4.5%), and 7.8% less on the
  shared phases (baseline: 4.1% less).
* No run of any broker failed.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | baseline | busd |
|---|---:|---:|
| calls, 1 client | -0.7% | -3.9% |
| calls, 20 clients | +4.1% | +3.6% |
| dict calls, 1 client | -10.3% | -13.1% |
| dict calls, 20 clients | -34.1% | -34.7% |
| signals, burst to 1 | -34.4% | -34.5% |
| signals, broadcast to 20 | -64.9% | -64.8% |
| RTT, 1 client, p50 | -2.4% | -5.8% |
| RTT, 20 clients, p50 | -0.1% | -0.7% |
| RTT, 20 clients, p99 | -3.4% | -4.1% |
| delivery to 20, whole fan-out | -63.8% | -63.5% |
| 100 callers, 1 connection | -22.6% | -23.2% |
| 100 clients | +12.8% | +6.9% |
| calls, broker CPU | +4.5% | +2.5% |
| shared, broker CPU | -4.1% | -7.8% |
| latency, broker CPU | -7.9% | -9.8% |
| shared, broker peak RSS | +57.5% | +56.6% |

## The benchmarks

The workloads and the comparisons are those of [the run on the
Xeon](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md#the-benchmarks): 60 rounds of each workload,
and 40 of the shared phases, after 3 of warm-up, all four brokers in each round. The raw results
are in [runs.tar.xz](2026-10-30-busd-zruntime-edge-triggered-ryzen-7840u/runs.tar.xz), from which
`scripts/paired-stats.py` made baseline against dbus-broker, which the script does not make. The
values are means over the rounds, and a star marks a difference whose 95% interval excludes 0 but
not the margin.

### busd against baseline

| Measure | n | baseline | busd | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.045 s | 0.043 s | -3.2% | -4.2, -2.1 | within ±5%* |
| calls, 20 clients | 60 | 0.311 s | 0.309 s | -0.5% | -1.9, +0.9 | within ±5% |
| signals, burst to 1 | 60 | 0.114 s | 0.114 s | -0.1% | -0.9, +0.7 | within ±5% |
| signals, broadcast to 20 | 60 | 0.066 s | 0.066 s | +0.3% | -0.4, +1.0 | within ±5% |
| RTT, 1 client, p50 | 60 | 33 µs | 32 µs | -3.5% | -4.4, -2.6 | within ±5%* |
| RTT, 1 client, p99 | 60 | 61 µs | 56 µs | -7.3% | -11.1, -3.0 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 279 µs | 277 µs | -0.6% | -1.7, +0.7 | within ±5% |
| RTT, 20 clients, p99 | 60 | 439 µs | 436 µs | -0.7% | -2.8, +1.3 | within ±5% |
| delivery to 20, p50 | 60 | 0.8 ms | 0.8 ms | +0.6% | -0.7, +1.9 | within ±5% |
| delivery to 20, p99 | 60 | 1.4 ms | 1.4 ms | +2.9% | -0.7, +7.3 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.023 s | 0.023 s | +0.6% | -0.5, +1.8 | within ±5% |
| 100 callers, 1 connection | 40 | 0.98 s | 0.97 s | -0.7% | -4.2, +3.0 | within ±5% |
| 100 clients | 40 | 1.79 s | 1.70 s | -5.2% | -6.2, -4.2 | inconclusive* |
| dict calls, 1 client | 60 | 0.058 s | 0.056 s | -3.1% | -6.4, +0.1 | inconclusive |
| dict calls, 20 clients | 60 | 0.333 s | 0.330 s | -0.9% | -1.9, +0.1 | within ±5% |
| calls, broker CPU | 60 | 0.33 s | 0.33 s | -1.9% | -2.7, -1.1 | within ±5%* |
| signals, broker CPU | 60 | 0.20 s | 0.20 s | -0.4% | -1.0, +0.3 | within ±5% |
| latency, broker CPU | 60 | 0.43 s | 0.42 s | -2.1% | -3.1, -1.0 | within ±5%* |
| shared, broker CPU | 40 | 2.69 s | 2.58 s | -3.8% | -5.3, -2.3 | inconclusive* |
| dicts, broker CPU | 60 | 0.36 s | 0.35 s | -1.7% | -2.3, -1.2 | within ±5%* |
| calls, broker user time | 60 | 0.14 s | 0.14 s | -4.1% | -6.3, -1.9 | inconclusive* |
| signals, broker user time | 60 | 0.09 s | 0.09 s | +1.3% | -1.5, +4.3 | within ±5% |
| latency, broker user time | 60 | 0.18 s | 0.18 s | -2.5% | -4.3, -0.6 | within ±5%* |
| shared, broker user time | 40 | 1.17 s | 1.11 s | -4.7% | -5.6, -3.8 | inconclusive* |
| dicts, broker user time | 60 | 0.18 s | 0.18 s | -1.6% | -3.3, +0.1 | within ±5% |
| calls, broker system time | 60 | 0.19 s | 0.19 s | -0.2% | -2.0, +1.6 | within ±5% |
| signals, broker system time | 60 | 0.11 s | 0.11 s | -1.7% | -4.1, +0.6 | within ±5% |
| latency, broker system time | 60 | 0.25 s | 0.24 s | -1.7% | -3.5, +0.1 | within ±5% |
| shared, broker system time | 40 | 1.52 s | 1.47 s | -3.1% | -5.6, -0.6 | inconclusive* |
| dicts, broker system time | 60 | 0.17 s | 0.17 s | -1.9% | -3.7, +0.0 | within ±5% |
| calls, broker peak RSS | 60 | 7.1 MiB | 7.0 MiB | -0.3% | -0.8, +0.3 | within ±5% |
| signals, broker peak RSS | 60 | 6.3 MiB | 6.3 MiB | +0.5% | -0.2, +1.3 | within ±5% |
| latency, broker peak RSS | 60 | 7.3 MiB | 7.3 MiB | -0.3% | -0.9, +0.3 | within ±5% |
| shared, broker peak RSS | 40 | 14.3 MiB | 14.2 MiB | -0.5% | -2.2, +1.1 | within ±5% |
| dicts, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | +0.4% | -0.3, +1.2 | within ±5% |

### busd against dbus-broker

| Measure | n | dbus-broker | busd | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.045 s | 0.043 s | -3.9% | -5.0, -2.8 | within ±5%* |
| calls, 20 clients | 60 | 0.298 s | 0.309 s | +3.6% | +2.1, +5.0 | within ±5%* |
| signals, burst to 1 | 60 | 0.174 s | 0.114 s | -34.5% | -35.0, -34.0 | **better** |
| signals, broadcast to 20 | 60 | 0.188 s | 0.066 s | -64.8% | -65.1, -64.5 | **better** |
| RTT, 1 client, p50 | 60 | 34 µs | 32 µs | -5.8% | -6.5, -5.0 | **better** |
| RTT, 1 client, p99 | 60 | 61 µs | 56 µs | -7.1% | -12.0, -1.8 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 279 µs | 277 µs | -0.7% | -2.4, +1.0 | within ±5% |
| RTT, 20 clients, p99 | 60 | 454 µs | 436 µs | -4.1% | -6.3, -1.8 | inconclusive* |
| delivery to 20, p50 | 60 | 1.9 ms | 0.8 ms | -56.7% | -57.2, -56.2 | **better** |
| delivery to 20, p99 | 60 | 3.1 ms | 1.4 ms | -54.2% | -55.8, -52.2 | **better** |
| delivery to 20, whole fan-out | 60 | 0.064 s | 0.023 s | -63.5% | -63.9, -63.2 | **better** |
| 100 callers, 1 connection | 40 | 1.26 s | 0.97 s | -23.2% | -24.7, -21.4 | **better** |
| 100 clients | 40 | 1.59 s | 1.70 s | +6.9% | +6.1, +7.7 | **worse** |
| dict calls, 1 client | 60 | 0.065 s | 0.056 s | -13.1% | -14.9, -11.1 | **better** |
| dict calls, 20 clients | 60 | 0.506 s | 0.330 s | -34.7% | -35.4, -34.0 | **better** |
| calls, broker CPU | 60 | 0.32 s | 0.33 s | +2.5% | +1.5, +3.4 | within ±5%* |
| signals, broker CPU | 60 | 0.37 s | 0.20 s | -47.7% | -48.1, -47.4 | **better** |
| latency, broker CPU | 60 | 0.47 s | 0.42 s | -9.8% | -10.8, -8.9 | **better** |
| shared, broker CPU | 40 | 2.80 s | 2.58 s | -7.8% | -8.6, -6.9 | **better** |
| dicts, broker CPU | 60 | 0.54 s | 0.35 s | -34.5% | -35.1, -34.0 | **better** |
| calls, broker user time | 60 | 0.11 s | 0.14 s | +22.4% | +19.6, +25.3 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.09 s | -29.7% | -31.8, -27.6 | **better** |
| latency, broker user time | 60 | 0.16 s | 0.18 s | +13.1% | +10.5, +15.9 | **worse** |
| shared, broker user time | 40 | 0.98 s | 1.11 s | +13.2% | +12.2, +14.3 | **worse** |
| dicts, broker user time | 60 | 0.35 s | 0.18 s | -48.2% | -49.2, -47.3 | **better** |
| calls, broker system time | 60 | 0.21 s | 0.19 s | -8.5% | -10.2, -6.8 | **better** |
| signals, broker system time | 60 | 0.25 s | 0.11 s | -56.8% | -57.7, -55.9 | **better** |
| latency, broker system time | 60 | 0.31 s | 0.24 s | -21.4% | -22.9, -19.8 | **better** |
| shared, broker system time | 40 | 1.82 s | 1.47 s | -19.1% | -20.3, -17.8 | **better** |
| dicts, broker system time | 60 | 0.19 s | 0.17 s | -9.2% | -10.9, -7.5 | **better** |
| calls, broker peak RSS | 60 | 8.2 MiB | 7.0 MiB | -13.8% | -14.3, -13.3 | **better** |
| signals, broker peak RSS | 60 | 8.1 MiB | 6.3 MiB | -22.1% | -22.9, -21.2 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.3 MiB | -11.0% | -11.6, -10.3 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 14.2 MiB | +56.6% | +54.3, +58.9 | **worse** |
| dicts, broker peak RSS | 60 | 8.1 MiB | 6.9 MiB | -14.5% | -15.0, -14.0 | **better** |

### baseline against dbus-broker

| Measure | n | dbus-broker | baseline | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.045 s | 0.045 s | -0.7% | -2.0, +0.5 | within ±5% |
| calls, 20 clients | 60 | 0.298 s | 0.311 s | +4.1% | +2.8, +5.5 | inconclusive* |
| signals, burst to 1 | 60 | 0.174 s | 0.114 s | -34.4% | -35.0, -33.9 | **better** |
| signals, broadcast to 20 | 60 | 0.188 s | 0.066 s | -64.9% | -65.2, -64.6 | **better** |
| RTT, 1 client, p50 | 60 | 34 µs | 33 µs | -2.4% | -3.3, -1.4 | within ±5%* |
| RTT, 1 client, p99 | 60 | 61 µs | 61 µs | +0.2% | -4.5, +5.2 | within ±5% |
| RTT, 20 clients, p50 | 60 | 279 µs | 279 µs | -0.1% | -1.7, +1.4 | within ±5% |
| RTT, 20 clients, p99 | 60 | 454 µs | 439 µs | -3.4% | -5.2, -1.6 | within ±5%* |
| delivery to 20, p50 | 60 | 1.9 ms | 0.8 ms | -57.0% | -57.5, -56.4 | **better** |
| delivery to 20, p99 | 60 | 3.1 ms | 1.4 ms | -55.4% | -56.6, -54.3 | **better** |
| delivery to 20, whole fan-out | 60 | 0.064 s | 0.023 s | -63.8% | -64.2, -63.4 | **better** |
| 100 callers, 1 connection | 40 | 1.26 s | 0.98 s | -22.6% | -24.5, -20.6 | **better** |
| 100 clients | 40 | 1.59 s | 1.79 s | +12.8% | +11.7, +13.8 | **worse** |
| dict calls, 1 client | 60 | 0.065 s | 0.058 s | -10.3% | -12.4, -7.9 | **better** |
| dict calls, 20 clients | 60 | 0.506 s | 0.333 s | -34.1% | -34.8, -33.4 | **better** |
| calls, broker CPU | 60 | 0.32 s | 0.33 s | +4.5% | +3.5, +5.4 | inconclusive* |
| signals, broker CPU | 60 | 0.37 s | 0.20 s | -47.5% | -47.8, -47.2 | **better** |
| latency, broker CPU | 60 | 0.47 s | 0.43 s | -7.9% | -8.8, -7.0 | **better** |
| shared, broker CPU | 40 | 2.80 s | 2.69 s | -4.1% | -5.1, -3.1 | within ±5%* |
| dicts, broker CPU | 60 | 0.54 s | 0.36 s | -33.4% | -33.9, -32.9 | **better** |
| calls, broker user time | 60 | 0.11 s | 0.14 s | +27.6% | +24.9, +30.5 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.09 s | -30.6% | -32.7, -28.5 | **better** |
| latency, broker user time | 60 | 0.16 s | 0.18 s | +16.1% | +13.4, +18.9 | **worse** |
| shared, broker user time | 40 | 0.98 s | 1.17 s | +18.8% | +17.6, +20.1 | **worse** |
| dicts, broker user time | 60 | 0.35 s | 0.18 s | -47.4% | -48.2, -46.5 | **better** |
| calls, broker system time | 60 | 0.21 s | 0.19 s | -8.3% | -10.1, -6.5 | **better** |
| signals, broker system time | 60 | 0.25 s | 0.11 s | -56.0% | -56.9, -55.2 | **better** |
| latency, broker system time | 60 | 0.31 s | 0.25 s | -20.0% | -21.3, -18.7 | **better** |
| shared, broker system time | 40 | 1.82 s | 1.52 s | -16.5% | -17.9, -15.0 | **better** |
| dicts, broker system time | 60 | 0.19 s | 0.17 s | -7.5% | -9.2, -5.8 | **better** |
| calls, broker peak RSS | 60 | 8.2 MiB | 7.1 MiB | -13.6% | -14.1, -13.0 | **better** |
| signals, broker peak RSS | 60 | 8.1 MiB | 6.3 MiB | -22.5% | -23.3, -21.7 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.3 MiB | -10.7% | -11.3, -10.1 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 14.3 MiB | +57.5% | +55.8, +59.1 | **worse** |
| dicts, broker peak RSS | 60 | 8.1 MiB | 6.9 MiB | -14.8% | -15.4, -14.3 | **better** |

### busd against dbus-daemon

| Measure | n | dbus-daemon | busd | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.093 s | 0.043 s | -53.2% | -53.8, -52.6 | **better** |
| calls, 20 clients | 60 | 1.099 s | 0.309 s | -71.9% | -72.2, -71.6 | **better** |
| signals, burst to 1 | 60 | 0.773 s | 0.114 s | -85.2% | -85.3, -85.1 | **better** |
| signals, broadcast to 20 | 60 | 1.929 s | 0.066 s | -96.6% | -96.6, -96.6 | **better** |
| RTT, 1 client, p50 | 60 | 63 µs | 32 µs | -49.5% | -50.1, -48.9 | **better** |
| RTT, 1 client, p99 | 60 | 125 µs | 56 µs | -55.0% | -57.7, -52.1 | **better** |
| RTT, 20 clients, p50 | 60 | 1022 µs | 277 µs | -72.9% | -73.2, -72.6 | **better** |
| RTT, 20 clients, p99 | 60 | 1379 µs | 436 µs | -68.4% | -69.1, -67.8 | **better** |
| delivery to 20, p50 | 60 | 19.6 ms | 0.8 ms | -95.7% | -95.8, -95.7 | **better** |
| delivery to 20, p99 | 60 | 30.7 ms | 1.4 ms | -95.3% | -95.4, -95.1 | **better** |
| delivery to 20, whole fan-out | 60 | 0.633 s | 0.023 s | -96.3% | -96.4, -96.3 | **better** |
| 100 callers, 1 connection | 40 | 5.00 s | 0.97 s | -80.6% | -81.0, -80.2 | **better** |
| 100 clients | 40 | 5.58 s | 1.70 s | -69.5% | -69.7, -69.3 | **better** |
| dict calls, 1 client | 60 | 0.103 s | 0.056 s | -45.2% | -46.3, -44.1 | **better** |
| dict calls, 20 clients | 60 | 1.182 s | 0.330 s | -72.0% | -72.4, -71.7 | **better** |
| calls, broker CPU | 60 | 1.15 s | 0.33 s | -71.5% | -71.7, -71.3 | **better** |
| signals, broker CPU | 60 | 2.70 s | 0.20 s | -92.8% | -92.8, -92.7 | **better** |
| latency, broker CPU | 60 | 1.93 s | 0.42 s | -78.2% | -78.4, -78.0 | **better** |
| shared, broker CPU | 40 | 10.51 s | 2.58 s | -75.4% | -75.6, -75.2 | **better** |
| dicts, broker CPU | 60 | 1.24 s | 0.35 s | -71.6% | -71.8, -71.4 | **better** |
| calls, broker user time | 60 | 0.48 s | 0.14 s | -70.9% | -71.5, -70.3 | **better** |
| signals, broker user time | 60 | 0.88 s | 0.09 s | -90.0% | -90.2, -89.8 | **better** |
| latency, broker user time | 60 | 0.72 s | 0.18 s | -75.5% | -75.9, -75.0 | **better** |
| shared, broker user time | 40 | 4.29 s | 1.11 s | -74.1% | -74.3, -73.9 | **better** |
| dicts, broker user time | 60 | 0.66 s | 0.18 s | -72.7% | -73.2, -72.2 | **better** |
| calls, broker system time | 60 | 0.67 s | 0.19 s | -72.0% | -72.4, -71.5 | **better** |
| signals, broker system time | 60 | 1.82 s | 0.11 s | -94.1% | -94.2, -94.0 | **better** |
| latency, broker system time | 60 | 1.21 s | 0.24 s | -79.9% | -80.2, -79.5 | **better** |
| shared, broker system time | 40 | 6.22 s | 1.47 s | -76.3% | -76.7, -76.0 | **better** |
| dicts, broker system time | 60 | 0.58 s | 0.17 s | -70.4% | -70.9, -69.8 | **better** |
| calls, broker peak RSS | 60 | 6.4 MiB | 7.0 MiB | +9.4% | +8.6, +10.2 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.3 MiB | +15.2% | +14.3, +16.2 | **worse** |
| latency, broker peak RSS | 60 | 6.3 MiB | 7.3 MiB | +14.8% | +14.1, +15.6 | **worse** |
| shared, broker peak RSS | 40 | 9.7 MiB | 14.2 MiB | +45.6% | +43.4, +47.8 | **worse** |
| dicts, broker peak RSS | 60 | 6.0 MiB | 6.9 MiB | +15.3% | +14.4, +16.1 | **worse** |

## Reproducing

```sh
BASELINE_REV=b4b8efe476a345f89cd705b8c9330690068eba64 scripts/compare.sh
```

builds both builds of busd and runs all of this, in about 28 minutes on this laptop once the
builds are made, and writes its results to `$WORK/results-3a751a5-vs-b4b8efe`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. It fetches busd's main
branch afresh; once that moves on, `BUSD_REV=3a751a5338f499deaa5d0acdb2b555d8b0ba9907` names the
commit of this run.
