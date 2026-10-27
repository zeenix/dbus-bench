# busd at the latest head of busd#391, on a Ryzen 7 7840U

Measured on 2026-10-27 on the laptop of [what checking bodies costs
busd](2026-10-27-busd-body-checks-dicts-ryzen-7840u.md): an AMD Ryzen 7 7840U (8 cores, 16
threads), running Fedora 44 with Linux 7.1.13. It ran `scripts/compare-batched-sends.sh` at
bc40cf0, which made every build of busd with rustc 1.99.0. dbus-broker 37 and dbus-daemon 1.16.2
are Fedora's. Compare the brokers with each other, within this file only.

The builds of busd and the clients are those of [the run on a 4-vCPU
Xeon](2026-10-27-busd-message-checks-0413582-xeon-4vcpu.md), which describes them: **before**,
227254e, busd's main branch, on zbus 50c54bf; **after**, 0413582 of zeenix/busd, the head of
z-galaxy/busd#391, on zbus 7ad87f4, the head of z-galaxy/zbus#2086, which checks the messages of its
clients as a whole, their headers as strictly as libdbus does, and their bodies against their
signatures, passes on only the replies that answer a call that waits for one, and sets the sender
of a message that a client leaves it out of with `Message::with_sender`; and **unchecked**, after
without the check of bodies. The clients leave the sender out of every message that is timed, as
libdbus, GLib and sd-bus clients do, and the `dicts` workload makes the method calls with a body of
100 variants, `a{sa{sv}}`.

## Summary

* After against before, busd takes 12.5% less time on the calls of 20 clients, 24.4% less on the
  burst of signals and 8.5% less on the broadcast, 14.4% less on the median round trip of 20 clients
  and 15.1% less at p99, 9.4% less on the latencies' fan-out, and 10.7% and 9.1% less on the shared
  phases, with 11 to 19% less CPU time and 21 to 36% less user time on those workloads. With one
  client, it takes 3.8% less on the calls and 4.3% less on the median round trip, within ±5%. On
  the dicts, it takes as long as before, within ±5%: 2.1% less with one client, and 1.9% more with
  20, with 1.1% more CPU time.
* Checking the bodies costs busd nothing measurable on the workloads of byte arrays: after against
  unchecked is within ±5% on every measure of them but the user time of the shared phases, 2.5%
  more (inconclusive), from -1.1 to +1.4% on the times and from +0.5 to +0.7% on the CPU time. On
  the dicts, it costs 12.0% more CPU time and 28.1% more user time, 0.044 s for the 21,000 calls of
  a run (from 0.041 to 0.048 s), about 2.1 µs for each, and makes the calls of 20 clients take
  13.1% longer, and those of one as long, within ±5%.
* Against dbus-broker, after takes 8.2% longer on the calls of 20 clients, where before takes 23.6%
  longer, 5.1% longer on their median round trip (before: 22.8%), 4.0% longer on the first shared
  phase (before: 16.4%), and 27.6% longer with 100 clients (before: 40.3%). With one client, after
  takes 17.9% longer on the calls (before: 22.6%), and 24.1% longer on the median round trip
  (before: 29.7%). It is faster on the burst of signals, by 20.7%, where before is 4.9% slower, on
  the broadcast, by 57.2%, on the latencies' fan-out, by 45.0% at the median, and on the dicts of 20
  clients, by 28.7% (before: 30.0%), and level with dbus-broker on those of one client.
* The new commits of zbus make no difference that this run and [that of
  fd577a2](2026-10-27-busd-body-checks-dicts-ryzen-7840u.md) can tell apart: from one run to the
  other, after's means moved by -9.7 to +6.2% across the workloads, and before's, which is the same
  build in both, by as much, within 2.5 points on each, as the laptop's timings differ from one run
  to the next.
* No run of any broker failed.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | +22.6% | +17.9% |
| calls, 20 clients | +23.6% | +8.2% |
| dict calls, 1 client | +2.6% | +0.5% |
| dict calls, 20 clients | -30.0% | -28.7% |
| signals, burst to 1 | +4.9% | -20.7% |
| signals, broadcast to 20 | -53.3% | -57.2% |
| RTT, 1 client, p50 | +29.7% | +24.1% |
| RTT, 20 clients, p50 | +22.8% | +5.1% |
| RTT, 20 clients, p99 | +24.5% | +5.6% |
| delivery to 20, whole fan-out | -53.0% | -57.4% |
| 100 callers, 1 connection | +16.4% | +4.0% |
| 100 clients | +40.3% | +27.6% |
| calls, broker CPU | +27.4% | +12.4% |
| dicts, broker CPU | -26.8% | -26.0% |
| signals, broker CPU | -22.1% | -36.8% |
| latency, broker CPU | +19.6% | +6.1% |
| shared, broker CPU | +31.6% | +17.2% |

## The benchmarks

The workloads and the comparisons are those of [the run on the
Xeon](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md#the-benchmarks): 60 rounds of each workload,
and 40 of the shared phases, after 3 of warm-up, all five brokers in each round. The raw results are
in [runs.tar.xz](2026-10-27-busd-message-checks-0413582-ryzen-7840u/runs.tar.xz). The values are
means over the rounds, and a star marks a difference whose 95% interval excludes 0 but not the
margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.073 s | 0.070 s | -3.8% | -4.7, -2.9 | within ±5%* |
| calls, 20 clients | 60 | 0.397 s | 0.347 s | -12.5% | -13.5, -11.5 | **better** |
| signals, burst to 1 | 60 | 0.186 s | 0.140 s | -24.4% | -25.1, -23.7 | **better** |
| signals, broadcast to 20 | 60 | 0.092 s | 0.084 s | -8.5% | -9.8, -7.2 | **better** |
| RTT, 1 client, p50 | 60 | 62 µs | 60 µs | -4.3% | -5.0, -3.7 | within ±5%* |
| RTT, 1 client, p99 | 60 | 134 µs | 126 µs | -5.8% | -9.4, -2.1 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 368 µs | 315 µs | -14.4% | -15.5, -13.4 | **better** |
| RTT, 20 clients, p99 | 60 | 484 µs | 410 µs | -15.1% | -17.7, -12.5 | **better** |
| delivery to 20, p50 | 60 | 1.2 ms | 1.1 ms | -9.5% | -11.0, -8.1 | **better** |
| delivery to 20, p99 | 60 | 2.1 ms | 1.9 ms | -9.7% | -13.6, -6.1 | **better** |
| delivery to 20, whole fan-out | 60 | 0.031 s | 0.028 s | -9.4% | -10.8, -8.1 | **better** |
| 100 callers, 1 connection | 40 | 1.46 s | 1.30 s | -10.7% | -14.3, -7.2 | **better** |
| 100 clients | 40 | 2.51 s | 2.28 s | -9.1% | -11.6, -6.3 | **better** |
| dict calls, 1 client | 60 | 0.084 s | 0.082 s | -2.1% | -3.0, -1.2 | within ±5%* |
| dict calls, 20 clients | 60 | 0.367 s | 0.374 s | +1.9% | +0.7, +3.1 | within ±5%* |
| calls, broker CPU | 60 | 0.44 s | 0.39 s | -11.7% | -12.5, -11.0 | **better** |
| signals, broker CPU | 60 | 0.30 s | 0.24 s | -18.9% | -19.4, -18.3 | **better** |
| latency, broker CPU | 60 | 0.58 s | 0.51 s | -11.3% | -12.2, -10.5 | **better** |
| shared, broker CPU | 40 | 3.94 s | 3.51 s | -10.9% | -12.9, -8.9 | **better** |
| dicts, broker CPU | 60 | 0.41 s | 0.41 s | +1.1% | +0.1, +2.0 | within ±5%* |
| calls, broker user time | 60 | 0.22 s | 0.16 s | -24.2% | -25.9, -22.6 | **better** |
| signals, broker user time | 60 | 0.16 s | 0.10 s | -36.3% | -37.8, -34.7 | **better** |
| latency, broker user time | 60 | 0.28 s | 0.21 s | -23.9% | -25.6, -22.1 | **better** |
| shared, broker user time | 40 | 1.91 s | 1.50 s | -21.4% | -23.0, -19.7 | **better** |
| dicts, broker user time | 60 | 0.20 s | 0.20 s | -0.4% | -2.3, +1.4 | within ±5% |
| calls, broker system time | 60 | 0.22 s | 0.22 s | +0.3% | -1.4, +2.2 | within ±5% |
| signals, broker system time | 60 | 0.14 s | 0.14 s | +1.3% | -1.1, +3.9 | within ±5% |
| latency, broker system time | 60 | 0.30 s | 0.30 s | +0.3% | -1.5, +2.0 | within ±5% |
| shared, broker system time | 40 | 2.02 s | 2.00 s | -1.0% | -3.9, +1.9 | within ±5% |
| dicts, broker system time | 60 | 0.20 s | 0.21 s | +2.6% | +0.4, +4.8 | within ±5%* |
| calls, broker peak RSS | 60 | 6.9 MiB | 7.0 MiB | +1.5% | +0.7, +2.2 | within ±5%* |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.3 MiB | +1.5% | +0.7, +2.3 | within ±5%* |
| latency, broker peak RSS | 60 | 7.1 MiB | 7.2 MiB | +1.6% | +1.1, +2.1 | within ±5%* |
| shared, broker peak RSS | 40 | 13.6 MiB | 13.8 MiB | +1.5% | -0.1, +3.1 | within ±5% |
| dicts, broker peak RSS | 60 | 6.7 MiB | 6.8 MiB | +1.6% | +1.0, +2.2 | within ±5%* |

### after against unchecked

| Measure | n | unchecked | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.071 s | 0.070 s | -0.7% | -1.7, +0.3 | within ±5% |
| calls, 20 clients | 60 | 0.345 s | 0.347 s | +0.5% | -0.4, +1.4 | within ±5% |
| signals, burst to 1 | 60 | 0.140 s | 0.140 s | +0.1% | -0.9, +1.2 | within ±5% |
| signals, broadcast to 20 | 60 | 0.084 s | 0.084 s | +0.2% | -1.5, +2.0 | within ±5% |
| RTT, 1 client, p50 | 60 | 60 µs | 60 µs | -0.1% | -0.7, +0.6 | within ±5% |
| RTT, 1 client, p99 | 60 | 127 µs | 126 µs | -0.8% | -4.0, +2.3 | within ±5% |
| RTT, 20 clients, p50 | 60 | 311 µs | 315 µs | +1.1% | +0.1, +2.1 | within ±5%* |
| RTT, 20 clients, p99 | 60 | 405 µs | 410 µs | +1.4% | -1.6, +4.5 | within ±5% |
| delivery to 20, p50 | 60 | 1.1 ms | 1.1 ms | +0.8% | -0.7, +2.4 | within ±5% |
| delivery to 20, p99 | 60 | 1.9 ms | 1.9 ms | -1.1% | -4.9, +2.6 | within ±5% |
| delivery to 20, whole fan-out | 60 | 0.028 s | 0.028 s | +0.4% | -0.9, +1.8 | within ±5% |
| 100 callers, 1 connection | 40 | 1.30 s | 1.30 s | +0.5% | -3.8, +4.9 | within ±5% |
| 100 clients | 40 | 2.27 s | 2.28 s | +0.6% | -2.6, +4.1 | within ±5% |
| dict calls, 1 client | 60 | 0.081 s | 0.082 s | +1.2% | -0.1, +2.5 | within ±5% |
| dict calls, 20 clients | 60 | 0.331 s | 0.374 s | +13.1% | +11.8, +14.3 | **worse** |
| calls, broker CPU | 60 | 0.39 s | 0.39 s | +0.5% | -0.1, +1.2 | within ±5% |
| signals, broker CPU | 60 | 0.24 s | 0.24 s | +0.5% | -0.5, +1.5 | within ±5% |
| latency, broker CPU | 60 | 0.51 s | 0.51 s | +0.6% | -0.2, +1.4 | within ±5% |
| shared, broker CPU | 40 | 3.48 s | 3.51 s | +0.7% | -2.1, +3.6 | within ±5% |
| dicts, broker CPU | 60 | 0.37 s | 0.41 s | +12.0% | +10.9, +13.0 | **worse** |
| calls, broker user time | 60 | 0.16 s | 0.16 s | -0.3% | -2.7, +2.0 | within ±5% |
| signals, broker user time | 60 | 0.10 s | 0.10 s | +0.9% | -1.8, +3.7 | within ±5% |
| latency, broker user time | 60 | 0.21 s | 0.21 s | -0.1% | -2.3, +2.0 | within ±5% |
| shared, broker user time | 40 | 1.47 s | 1.50 s | +2.5% | -0.7, +5.8 | inconclusive |
| dicts, broker user time | 60 | 0.16 s | 0.20 s | +28.1% | +25.7, +30.6 | **worse** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | +1.2% | -0.5, +2.9 | within ±5% |
| signals, broker system time | 60 | 0.14 s | 0.14 s | +0.1% | -2.0, +2.2 | within ±5% |
| latency, broker system time | 60 | 0.30 s | 0.30 s | +1.1% | -0.5, +2.7 | within ±5% |
| shared, broker system time | 40 | 2.02 s | 2.00 s | -0.6% | -3.8, +2.7 | within ±5% |
| dicts, broker system time | 60 | 0.21 s | 0.21 s | -0.3% | -2.1, +1.4 | within ±5% |
| calls, broker peak RSS | 60 | 7.0 MiB | 7.0 MiB | +0.2% | -0.4, +0.8 | within ±5% |
| signals, broker peak RSS | 60 | 6.3 MiB | 6.3 MiB | +0.3% | -0.4, +1.0 | within ±5% |
| latency, broker peak RSS | 60 | 7.2 MiB | 7.2 MiB | -0.3% | -0.9, +0.3 | within ±5% |
| shared, broker peak RSS | 40 | 13.8 MiB | 13.8 MiB | +0.3% | -1.4, +2.1 | within ±5% |
| dicts, broker peak RSS | 60 | 6.8 MiB | 6.8 MiB | -0.0% | -0.6, +0.5 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.060 s | 0.070 s | +17.9% | +16.5, +19.2 | **worse** |
| calls, 20 clients | 60 | 0.321 s | 0.347 s | +8.2% | +6.7, +9.6 | **worse** |
| signals, burst to 1 | 60 | 0.177 s | 0.140 s | -20.7% | -21.4, -20.0 | **better** |
| signals, broadcast to 20 | 60 | 0.196 s | 0.084 s | -57.2% | -57.9, -56.6 | **better** |
| RTT, 1 client, p50 | 60 | 48 µs | 60 µs | +24.1% | +23.2, +24.9 | **worse** |
| RTT, 1 client, p99 | 60 | 105 µs | 126 µs | +20.5% | +15.6, +25.5 | **worse** |
| RTT, 20 clients, p50 | 60 | 299 µs | 315 µs | +5.1% | +3.4, +6.8 | inconclusive* |
| RTT, 20 clients, p99 | 60 | 389 µs | 410 µs | +5.6% | +2.4, +9.0 | inconclusive* |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -45.0% | -45.7, -44.3 | **better** |
| delivery to 20, p99 | 60 | 3.3 ms | 1.9 ms | -41.8% | -43.2, -40.3 | **better** |
| delivery to 20, whole fan-out | 60 | 0.066 s | 0.028 s | -57.4% | -57.9, -56.9 | **better** |
| 100 callers, 1 connection | 40 | 1.25 s | 1.30 s | +4.0% | +0.9, +7.0 | inconclusive* |
| 100 clients | 40 | 1.79 s | 2.28 s | +27.6% | +24.3, +31.1 | **worse** |
| dict calls, 1 client | 60 | 0.082 s | 0.082 s | +0.5% | -0.6, +1.6 | within ±5% |
| dict calls, 20 clients | 60 | 0.524 s | 0.374 s | -28.7% | -29.4, -28.0 | **better** |
| calls, broker CPU | 60 | 0.35 s | 0.39 s | +12.4% | +11.1, +13.8 | **worse** |
| signals, broker CPU | 60 | 0.39 s | 0.24 s | -36.8% | -37.3, -36.3 | **better** |
| latency, broker CPU | 60 | 0.48 s | 0.51 s | +6.1% | +4.8, +7.3 | inconclusive* |
| shared, broker CPU | 40 | 2.99 s | 3.51 s | +17.2% | +14.6, +19.9 | **worse** |
| dicts, broker CPU | 60 | 0.56 s | 0.41 s | -26.0% | -26.6, -25.5 | **better** |
| calls, broker user time | 60 | 0.12 s | 0.16 s | +41.1% | +38.4, +43.8 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.10 s | -18.6% | -20.9, -16.3 | **better** |
| latency, broker user time | 60 | 0.16 s | 0.21 s | +34.0% | +31.3, +36.8 | **worse** |
| shared, broker user time | 40 | 0.98 s | 1.50 s | +54.2% | +50.4, +58.3 | **worse** |
| dicts, broker user time | 60 | 0.35 s | 0.20 s | -41.8% | -42.7, -40.9 | **better** |
| calls, broker system time | 60 | 0.23 s | 0.22 s | -2.1% | -4.1, -0.0 | within ±5%* |
| signals, broker system time | 60 | 0.26 s | 0.14 s | -45.7% | -46.7, -44.6 | **better** |
| latency, broker system time | 60 | 0.33 s | 0.30 s | -7.4% | -9.3, -5.6 | **better** |
| shared, broker system time | 40 | 2.02 s | 2.00 s | -0.7% | -3.4, +2.1 | within ±5% |
| dicts, broker system time | 60 | 0.21 s | 0.21 s | +0.7% | -1.3, +2.7 | within ±5% |
| calls, broker peak RSS | 60 | 8.1 MiB | 7.0 MiB | -14.2% | -14.8, -13.5 | **better** |
| signals, broker peak RSS | 60 | 8.3 MiB | 6.3 MiB | -24.0% | -24.9, -23.2 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.2 MiB | -12.1% | -12.7, -11.5 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 13.8 MiB | +52.5% | +50.6, +54.4 | **worse** |
| dicts, broker peak RSS | 60 | 8.0 MiB | 6.8 MiB | -15.5% | -16.0, -15.1 | **better** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.060 s | 0.073 s | +22.6% | +21.2, +23.9 | **worse** |
| calls, 20 clients | 60 | 0.321 s | 0.397 s | +23.6% | +21.7, +25.5 | **worse** |
| signals, burst to 1 | 60 | 0.177 s | 0.186 s | +4.9% | +4.1, +5.7 | inconclusive* |
| signals, broadcast to 20 | 60 | 0.196 s | 0.092 s | -53.3% | -54.0, -52.5 | **better** |
| RTT, 1 client, p50 | 60 | 48 µs | 62 µs | +29.7% | +28.8, +30.6 | **worse** |
| RTT, 1 client, p99 | 60 | 105 µs | 134 µs | +27.9% | +23.0, +33.0 | **worse** |
| RTT, 20 clients, p50 | 60 | 299 µs | 368 µs | +22.8% | +20.5, +25.2 | **worse** |
| RTT, 20 clients, p99 | 60 | 389 µs | 484 µs | +24.5% | +20.6, +28.5 | **worse** |
| delivery to 20, p50 | 60 | 2.0 ms | 1.2 ms | -39.2% | -40.1, -38.3 | **better** |
| delivery to 20, p99 | 60 | 3.3 ms | 2.1 ms | -35.5% | -37.7, -33.0 | **better** |
| delivery to 20, whole fan-out | 60 | 0.066 s | 0.031 s | -53.0% | -53.6, -52.3 | **better** |
| 100 callers, 1 connection | 40 | 1.25 s | 1.46 s | +16.4% | +13.2, +19.7 | **worse** |
| 100 clients | 40 | 1.79 s | 2.51 s | +40.3% | +36.7, +44.0 | **worse** |
| dict calls, 1 client | 60 | 0.082 s | 0.084 s | +2.6% | +1.3, +4.0 | within ±5%* |
| dict calls, 20 clients | 60 | 0.524 s | 0.367 s | -30.0% | -30.8, -29.2 | **better** |
| calls, broker CPU | 60 | 0.35 s | 0.44 s | +27.4% | +25.7, +29.1 | **worse** |
| signals, broker CPU | 60 | 0.39 s | 0.30 s | -22.1% | -22.7, -21.5 | **better** |
| latency, broker CPU | 60 | 0.48 s | 0.58 s | +19.6% | +18.0, +21.3 | **worse** |
| shared, broker CPU | 40 | 2.99 s | 3.94 s | +31.6% | +28.9, +34.3 | **worse** |
| dicts, broker CPU | 60 | 0.56 s | 0.41 s | -26.8% | -27.6, -26.1 | **better** |
| calls, broker user time | 60 | 0.12 s | 0.22 s | +86.2% | +82.2, +90.1 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.16 s | +27.7% | +24.6, +30.9 | **worse** |
| latency, broker user time | 60 | 0.16 s | 0.28 s | +76.0% | +72.1, +79.8 | **worse** |
| shared, broker user time | 40 | 0.98 s | 1.91 s | +96.2% | +92.5, +100.0 | **worse** |
| dicts, broker user time | 60 | 0.35 s | 0.20 s | -41.5% | -42.5, -40.5 | **better** |
| calls, broker system time | 60 | 0.23 s | 0.22 s | -2.4% | -4.7, -0.0 | within ±5%* |
| signals, broker system time | 60 | 0.26 s | 0.14 s | -46.4% | -47.6, -45.2 | **better** |
| latency, broker system time | 60 | 0.33 s | 0.30 s | -7.7% | -9.4, -6.0 | **better** |
| shared, broker system time | 40 | 2.02 s | 2.02 s | +0.3% | -2.3, +2.9 | within ±5% |
| dicts, broker system time | 60 | 0.21 s | 0.20 s | -1.8% | -4.1, +0.5 | within ±5% |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.9 MiB | -15.4% | -16.0, -14.8 | **better** |
| signals, broker peak RSS | 60 | 8.3 MiB | 6.2 MiB | -25.1% | -25.9, -24.4 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.1 MiB | -13.5% | -14.0, -13.0 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 13.6 MiB | +50.3% | +48.6, +51.9 | **worse** |
| dicts, broker peak RSS | 60 | 8.0 MiB | 6.7 MiB | -16.9% | -17.4, -16.4 | **better** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.129 s | 0.070 s | -45.5% | -46.1, -44.8 | **better** |
| calls, 20 clients | 60 | 1.180 s | 0.347 s | -70.6% | -70.8, -70.3 | **better** |
| signals, burst to 1 | 60 | 0.818 s | 0.140 s | -82.9% | -83.0, -82.7 | **better** |
| signals, broadcast to 20 | 60 | 2.014 s | 0.084 s | -95.8% | -95.9, -95.8 | **better** |
| RTT, 1 client, p50 | 60 | 92 µs | 60 µs | -35.1% | -35.5, -34.7 | **better** |
| RTT, 1 client, p99 | 60 | 194 µs | 126 µs | -35.1% | -37.1, -33.2 | **better** |
| RTT, 20 clients, p50 | 60 | 1140 µs | 315 µs | -72.4% | -72.6, -72.2 | **better** |
| RTT, 20 clients, p99 | 60 | 1426 µs | 410 µs | -71.2% | -72.0, -70.3 | **better** |
| delivery to 20, p50 | 60 | 20.7 ms | 1.1 ms | -94.7% | -94.7, -94.6 | **better** |
| delivery to 20, p99 | 60 | 32.5 ms | 1.9 ms | -94.1% | -94.2, -94.0 | **better** |
| delivery to 20, whole fan-out | 60 | 0.668 s | 0.028 s | -95.8% | -95.8, -95.8 | **better** |
| 100 callers, 1 connection | 40 | 6.32 s | 1.30 s | -79.4% | -80.0, -78.8 | **better** |
| 100 clients | 40 | 6.38 s | 2.28 s | -64.2% | -65.0, -63.3 | **better** |
| dict calls, 1 client | 60 | 0.138 s | 0.082 s | -40.6% | -41.2, -40.1 | **better** |
| dict calls, 20 clients | 60 | 1.254 s | 0.374 s | -70.2% | -70.4, -69.9 | **better** |
| calls, broker CPU | 60 | 1.26 s | 0.39 s | -69.2% | -69.4, -69.0 | **better** |
| signals, broker CPU | 60 | 2.84 s | 0.24 s | -91.4% | -91.5, -91.3 | **better** |
| latency, broker CPU | 60 | 2.14 s | 0.51 s | -76.0% | -76.2, -75.9 | **better** |
| shared, broker CPU | 40 | 12.67 s | 3.51 s | -72.3% | -72.8, -71.7 | **better** |
| dicts, broker CPU | 60 | 1.34 s | 0.41 s | -69.1% | -69.3, -68.9 | **better** |
| calls, broker user time | 60 | 0.47 s | 0.16 s | -65.2% | -65.9, -64.5 | **better** |
| signals, broker user time | 60 | 0.89 s | 0.10 s | -88.4% | -88.6, -88.1 | **better** |
| latency, broker user time | 60 | 0.74 s | 0.21 s | -71.4% | -71.9, -70.9 | **better** |
| shared, broker user time | 40 | 4.58 s | 1.50 s | -67.2% | -67.9, -66.4 | **better** |
| dicts, broker user time | 60 | 0.65 s | 0.20 s | -68.5% | -69.0, -67.9 | **better** |
| calls, broker system time | 60 | 0.79 s | 0.22 s | -71.6% | -72.0, -71.2 | **better** |
| signals, broker system time | 60 | 1.95 s | 0.14 s | -92.8% | -92.9, -92.7 | **better** |
| latency, broker system time | 60 | 1.40 s | 0.30 s | -78.5% | -78.7, -78.2 | **better** |
| shared, broker system time | 40 | 8.08 s | 2.00 s | -75.2% | -75.8, -74.6 | **better** |
| dicts, broker system time | 60 | 0.69 s | 0.21 s | -69.7% | -70.2, -69.3 | **better** |
| calls, broker peak RSS | 60 | 6.4 MiB | 7.0 MiB | +8.4% | +7.6, +9.2 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.3 MiB | +14.4% | +13.5, +15.2 | **worse** |
| latency, broker peak RSS | 60 | 6.4 MiB | 7.2 MiB | +12.1% | +11.1, +13.1 | **worse** |
| shared, broker peak RSS | 40 | 9.7 MiB | 13.8 MiB | +42.3% | +40.7, +44.0 | **worse** |
| dicts, broker peak RSS | 60 | 6.0 MiB | 6.8 MiB | +13.6% | +13.0, +14.3 | **worse** |

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at bc40cf0 builds the brokers and runs all of this, in about 39 minutes on this laptop once the
builds are made, and writes its results to `$WORK/batched-sends-results-0413582`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`.
