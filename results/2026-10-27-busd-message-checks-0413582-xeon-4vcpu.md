# busd at the latest head of busd#391, on a 4-vCPU Xeon

Measured on 2026-10-27 on the VM of [what checking bodies costs
busd](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md): 4 vCPUs of an Intel Xeon @ 2.10GHz under
KVM, 15 GiB, Linux 6.18, Ubuntu 24.04.5. It ran `scripts/compare-batched-sends.sh` at bc40cf0,
which made every build of busd with rustc 1.97.0. dbus-broker is 37, built from source with meson's
release build type and its default options otherwise, and ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py). dbus-daemon is
the 1.14.10 of Ubuntu 24.04. Compare the brokers with each other, within this file only.

The builds of busd are those of [that run](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md), but
for the head of z-galaxy/busd#391:

* **before**: 227254e, busd's main branch, on zbus 50c54bf and zruntime b3bd01d;
* **after**: 0413582 of zeenix/busd, the head of z-galaxy/busd#391, which differs from fd577a2,
  which that run measured, in the commit of zbus that it builds on alone: 7ad87f4 of zeenix/zbus,
  the head of z-galaxy/zbus#2086. The commits of that zbus differ from those of 8cb16a2 in a few
  ways: the parser of the header rejects a string that doesn't end with a 0 and a field that comes
  twice, as libdbus does, and leaves the maybe type of GVariant to the parser of signatures, and the
  check of bodies is reworked;
* **unchecked**: after, without the line that has zbus check the bodies of the messages of each
  client.

The clients are those of bc40cf0, which are those of that run: they leave the sender out of every
message that is timed, as libdbus, GLib and sd-bus clients do, and the `dicts` workload makes the
method calls with a body of 100 variants, `a{sa{sv}}`.

## Summary

* After against before, busd takes 27.6% less time on the calls of 20 clients, 34.6% less on the
  burst of signals, 30.6% less on the median round trip of 20 clients and 21.3% less at p99, 14.0%
  and 25.5% less on the shared phases, and 9.4% less on the dict calls of 20 clients, with 9 to 28%
  less CPU time on every workload, and 36 to 43% less user time on all but the dicts. With one
  client, it takes 6.3% less on the calls (inconclusive, but repeatable) and 8.2% less on the median
  round trip, and as long on the dict calls.
* Checking the bodies costs busd nothing measurable on the workloads of byte arrays: after against
  unchecked is within ±5%, or inconclusive, on every measure of them, from -4.1 to +3.4% on the
  times and from -2.1 to +2.2% on the CPU time. On the dicts, it costs 14.2% more CPU time and 40.5%
  more user time, 0.079 s for the 21,000 calls of a run (from 0.066 to 0.092 s), about 3.8 µs for
  each, and makes the calls of 20 clients take 12.6% longer, and those of one 5.6% longer
  (inconclusive, but repeatable).
* Against dbus-broker, after takes 16.8% longer on the calls of 20 clients, where before takes
  61.3% longer, 15.9% longer on their median round trip (before: 67.0%), and 54.4% longer with 100
  clients (before: 107.3%). It is faster with one client, by 9.7% on the calls, on the burst of
  signals, by 11.8%, where before is 34.9% slower, on the broadcast, on the latencies' fan-out, on
  the first shared phase, and on the dicts, by 28.4% with 20 clients and 16.1% with one.
* The new commits of zbus make no difference that these runs can tell. Every broker took as long
  or up to 16% less time in this run than in [the run of
  fd577a2](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md), three hours before on the same VM,
  before among them, which is the same build in both, and after about as much as the others: the
  VM was faster for this run. The paired comparisons of each run, which
  are what tell the builds apart, agree between the two within a few points: after against before
  is -27.6% on the calls of 20 clients here and -26.9% there, -34.6% and -35.3% on the burst, and
  after against dbus-broker +16.8% and +17.0% on those calls. The check of the dicts makes their
  calls of 20 clients 12.6% longer here and 17.3% there, where every broker took 11 to 16% less
  time on them in this run, so that the two runs can't tell those apart either.
* No run of any broker failed.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | -3.7% | -9.7% |
| calls, 20 clients | +61.3% | +16.8% |
| dict calls, 1 client | -16.1% | -16.1% |
| dict calls, 20 clients | -20.9% | -28.4% |
| signals, burst to 1 | +34.9% | -11.8% |
| signals, broadcast to 20 | -35.1% | -37.9% |
| RTT, 1 client, p50 | -5.4% | -13.2% |
| RTT, 20 clients, p50 | +67.0% | +15.9% |
| RTT, 20 clients, p99 | +46.6% | +15.4% |
| delivery to 20, whole fan-out | -30.7% | -37.8% |
| 100 callers, 1 connection | -0.2% | -14.1% |
| 100 clients | +107.3% | +54.4% |
| calls, broker CPU | +59.9% | +16.0% |
| dicts, broker CPU | -21.9% | -29.1% |
| signals, broker CPU | -10.7% | -35.7% |
| latency, broker CPU | +40.5% | +6.0% |
| shared, broker CPU | +61.1% | +22.5% |

## The benchmarks

The workloads and the comparisons are those of [the run of
fd577a2](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md#the-benchmarks): 60 rounds of each
workload, and 40 of the shared phases, after 3 of warm-up, all five brokers in each round. The raw
results are in [runs.tar.xz](2026-10-27-busd-message-checks-0413582-xeon-4vcpu/runs.tar.xz). The
values are means over the rounds, and a star marks a difference whose 95% interval excludes 0 but
not the margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.125 s | 0.117 s | -6.3% | -8.8, -3.7 | inconclusive* |
| calls, 20 clients | 60 | 0.914 s | 0.662 s | -27.6% | -29.6, -25.4 | **better** |
| signals, burst to 1 | 60 | 0.296 s | 0.193 s | -34.6% | -36.7, -32.5 | **better** |
| signals, broadcast to 20 | 60 | 0.180 s | 0.172 s | -4.3% | -8.7, +0.2 | inconclusive |
| RTT, 1 client, p50 | 60 | 109 µs | 100 µs | -8.2% | -11.2, -5.3 | **better** |
| RTT, 1 client, p99 | 60 | 234 µs | 213 µs | -9.3% | -15.7, -1.8 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 869 µs | 603 µs | -30.6% | -34.1, -26.9 | **better** |
| RTT, 20 clients, p99 | 60 | 1569 µs | 1235 µs | -21.3% | -26.6, -15.7 | **better** |
| delivery to 20, p50 | 60 | 2.9 ms | 2.9 ms | -1.5% | -8.2, +5.5 | inconclusive |
| delivery to 20, p99 | 60 | 10.3 ms | 9.9 ms | -4.4% | -14.9, +7.9 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.070 s | 0.062 s | -10.2% | -15.1, -5.0 | inconclusive* |
| 100 callers, 1 connection | 40 | 2.00 s | 1.72 s | -14.0% | -16.4, -11.4 | **better** |
| 100 clients | 40 | 5.20 s | 3.87 s | -25.5% | -27.2, -23.9 | **better** |
| dict calls, 1 client | 60 | 0.130 s | 0.130 s | -0.0% | -3.0, +3.3 | within ±5% |
| dict calls, 20 clients | 60 | 0.669 s | 0.606 s | -9.4% | -11.6, -7.1 | **better** |
| calls, broker CPU | 60 | 0.94 s | 0.68 s | -27.5% | -29.4, -25.5 | **better** |
| signals, broker CPU | 60 | 0.43 s | 0.31 s | -28.0% | -30.1, -25.8 | **better** |
| latency, broker CPU | 60 | 1.22 s | 0.92 s | -24.6% | -27.3, -22.0 | **better** |
| shared, broker CPU | 40 | 6.92 s | 5.26 s | -24.0% | -25.4, -22.6 | **better** |
| dicts, broker CPU | 60 | 0.70 s | 0.63 s | -9.2% | -11.2, -6.9 | **better** |
| calls, broker user time | 60 | 0.40 s | 0.25 s | -37.4% | -39.6, -35.1 | **better** |
| signals, broker user time | 60 | 0.26 s | 0.15 s | -43.0% | -45.6, -40.4 | **better** |
| latency, broker user time | 60 | 0.53 s | 0.34 s | -36.6% | -39.2, -33.8 | **better** |
| shared, broker user time | 40 | 3.30 s | 2.13 s | -35.6% | -36.7, -34.4 | **better** |
| dicts, broker user time | 60 | 0.34 s | 0.29 s | -14.6% | -17.5, -11.6 | **better** |
| calls, broker system time | 60 | 0.55 s | 0.44 s | -20.3% | -23.4, -16.9 | **better** |
| signals, broker system time | 60 | 0.17 s | 0.16 s | -4.5% | -9.1, +0.3 | inconclusive |
| latency, broker system time | 60 | 0.70 s | 0.59 s | -15.5% | -18.9, -12.1 | **better** |
| shared, broker system time | 40 | 3.62 s | 3.14 s | -13.4% | -15.5, -11.3 | **better** |
| dicts, broker system time | 60 | 0.36 s | 0.34 s | -4.0% | -7.1, -0.6 | inconclusive* |
| calls, broker peak RSS | 60 | 5.1 MiB | 5.2 MiB | +2.6% | +2.1, +3.1 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.8 MiB | +0.6% | +0.1, +0.9 | within ±5%* |
| latency, broker peak RSS | 60 | 5.1 MiB | 5.3 MiB | +2.2% | +1.8, +2.7 | within ±5%* |
| shared, broker peak RSS | 40 | 8.0 MiB | 8.2 MiB | +2.0% | +1.0, +3.1 | within ±5%* |
| dicts, broker peak RSS | 60 | 4.9 MiB | 5.0 MiB | +1.8% | +1.3, +2.2 | within ±5%* |

### after against unchecked

| Measure | n | unchecked | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.115 s | 0.117 s | +2.0% | -1.1, +5.2 | within ±5% |
| calls, 20 clients | 60 | 0.644 s | 0.662 s | +2.8% | -0.7, +6.4 | inconclusive |
| signals, burst to 1 | 60 | 0.196 s | 0.193 s | -1.3% | -4.2, +1.7 | within ±5% |
| signals, broadcast to 20 | 60 | 0.166 s | 0.172 s | +3.4% | -0.6, +7.6 | inconclusive |
| RTT, 1 client, p50 | 60 | 102 µs | 100 µs | -2.2% | -5.3, +0.8 | within ±5% |
| RTT, 1 client, p99 | 60 | 222 µs | 213 µs | -4.1% | -10.4, +2.8 | inconclusive |
| RTT, 20 clients, p50 | 60 | 618 µs | 603 µs | -2.4% | -7.7, +3.2 | inconclusive |
| RTT, 20 clients, p99 | 60 | 1227 µs | 1235 µs | +0.6% | -5.0, +6.6 | inconclusive |
| delivery to 20, p50 | 60 | 2.9 ms | 2.9 ms | -0.8% | -7.0, +5.5 | inconclusive |
| delivery to 20, p99 | 60 | 10.1 ms | 9.9 ms | -2.3% | -12.6, +9.2 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.065 s | 0.062 s | -3.7% | -10.2, +3.0 | inconclusive |
| 100 callers, 1 connection | 40 | 1.74 s | 1.72 s | -1.5% | -5.0, +1.9 | within ±5% |
| 100 clients | 40 | 3.93 s | 3.87 s | -1.5% | -3.9, +1.1 | within ±5% |
| dict calls, 1 client | 60 | 0.123 s | 0.130 s | +5.6% | +2.8, +8.4 | inconclusive* |
| dict calls, 20 clients | 60 | 0.538 s | 0.606 s | +12.6% | +10.2, +15.3 | **worse** |
| calls, broker CPU | 60 | 0.67 s | 0.68 s | +2.2% | -1.0, +5.6 | inconclusive |
| signals, broker CPU | 60 | 0.31 s | 0.31 s | +0.5% | -2.4, +3.6 | within ±5% |
| latency, broker CPU | 60 | 0.94 s | 0.92 s | -2.1% | -5.7, +1.6 | inconclusive |
| shared, broker CPU | 40 | 5.35 s | 5.26 s | -1.6% | -3.8, +0.6 | within ±5% |
| dicts, broker CPU | 60 | 0.55 s | 0.63 s | +14.2% | +12.0, +16.7 | **worse** |
| calls, broker user time | 60 | 0.24 s | 0.25 s | +3.0% | -1.2, +7.6 | inconclusive |
| signals, broker user time | 60 | 0.15 s | 0.15 s | -1.3% | -6.6, +4.5 | inconclusive |
| latency, broker user time | 60 | 0.34 s | 0.34 s | -0.6% | -5.2, +4.1 | within ±5% |
| shared, broker user time | 40 | 2.16 s | 2.13 s | -1.6% | -4.1, +0.7 | within ±5% |
| dicts, broker user time | 60 | 0.20 s | 0.29 s | +40.5% | +35.3, +45.8 | **worse** |
| calls, broker system time | 60 | 0.43 s | 0.44 s | +1.8% | -2.5, +6.2 | inconclusive |
| signals, broker system time | 60 | 0.16 s | 0.16 s | +2.2% | -2.9, +7.6 | inconclusive |
| latency, broker system time | 60 | 0.60 s | 0.59 s | -2.9% | -6.9, +1.3 | inconclusive |
| shared, broker system time | 40 | 3.19 s | 3.14 s | -1.6% | -4.6, +1.5 | within ±5% |
| dicts, broker system time | 60 | 0.35 s | 0.34 s | -1.2% | -4.1, +1.9 | within ±5% |
| calls, broker peak RSS | 60 | 5.2 MiB | 5.2 MiB | -0.2% | -0.7, +0.3 | within ±5% |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.8 MiB | +0.1% | -0.2, +0.4 | within ±5% |
| latency, broker peak RSS | 60 | 5.3 MiB | 5.3 MiB | -0.2% | -0.7, +0.2 | within ±5% |
| shared, broker peak RSS | 40 | 8.2 MiB | 8.2 MiB | +0.3% | -0.7, +1.4 | within ±5% |
| dicts, broker peak RSS | 60 | 5.0 MiB | 5.0 MiB | +0.0% | -0.4, +0.5 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.130 s | 0.117 s | -9.7% | -12.5, -7.0 | **better** |
| calls, 20 clients | 60 | 0.567 s | 0.662 s | +16.8% | +11.9, +21.8 | **worse** |
| signals, burst to 1 | 60 | 0.219 s | 0.193 s | -11.8% | -15.3, -8.3 | **better** |
| signals, broadcast to 20 | 60 | 0.277 s | 0.172 s | -37.9% | -41.2, -34.4 | **better** |
| RTT, 1 client, p50 | 60 | 115 µs | 100 µs | -13.2% | -15.7, -10.9 | **better** |
| RTT, 1 client, p99 | 60 | 241 µs | 213 µs | -11.7% | -18.2, -4.5 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 521 µs | 603 µs | +15.9% | +9.6, +22.2 | **worse** |
| RTT, 20 clients, p99 | 60 | 1070 µs | 1235 µs | +15.4% | +7.7, +23.6 | **worse** |
| delivery to 20, p50 | 60 | 3.9 ms | 2.9 ms | -25.4% | -38.7, -9.7 | **better** |
| delivery to 20, p99 | 60 | 20.5 ms | 9.9 ms | -51.8% | -62.2, -36.3 | **better** |
| delivery to 20, whole fan-out | 60 | 0.100 s | 0.062 s | -37.8% | -41.4, -33.9 | **better** |
| 100 callers, 1 connection | 40 | 2.00 s | 1.72 s | -14.1% | -17.2, -11.1 | **better** |
| 100 clients | 40 | 2.51 s | 3.87 s | +54.4% | +50.4, +58.7 | **worse** |
| dict calls, 1 client | 60 | 0.155 s | 0.130 s | -16.1% | -18.6, -13.4 | **better** |
| dict calls, 20 clients | 60 | 0.846 s | 0.606 s | -28.4% | -30.2, -26.5 | **better** |
| calls, broker CPU | 60 | 0.59 s | 0.68 s | +16.0% | +11.4, +20.6 | **worse** |
| signals, broker CPU | 60 | 0.48 s | 0.31 s | -35.7% | -38.2, -33.3 | **better** |
| latency, broker CPU | 60 | 0.87 s | 0.92 s | +6.0% | +2.7, +9.2 | inconclusive* |
| shared, broker CPU | 40 | 4.30 s | 5.26 s | +22.5% | +19.3, +25.7 | **worse** |
| dicts, broker CPU | 60 | 0.89 s | 0.63 s | -29.1% | -30.8, -27.3 | **better** |
| calls, broker user time | 60 | 0.14 s | 0.25 s | +78.1% | +69.1, +87.5 | **worse** |
| signals, broker user time | 60 | 0.14 s | 0.15 s | +10.9% | +5.0, +16.9 | **worse** |
| latency, broker user time | 60 | 0.20 s | 0.34 s | +68.4% | +60.5, +76.7 | **worse** |
| shared, broker user time | 40 | 1.18 s | 2.13 s | +80.3% | +74.9, +86.1 | **worse** |
| dicts, broker user time | 60 | 0.49 s | 0.29 s | -41.6% | -43.7, -39.4 | **better** |
| calls, broker system time | 60 | 0.45 s | 0.44 s | -3.4% | -8.0, +1.5 | inconclusive |
| signals, broker system time | 60 | 0.35 s | 0.16 s | -53.9% | -56.3, -51.3 | **better** |
| latency, broker system time | 60 | 0.67 s | 0.59 s | -12.5% | -15.8, -9.4 | **better** |
| shared, broker system time | 40 | 3.12 s | 3.14 s | +0.6% | -2.5, +3.7 | within ±5% |
| dicts, broker system time | 60 | 0.40 s | 0.34 s | -13.7% | -16.6, -10.5 | **better** |
| calls, broker peak RSS | 60 | 6.4 MiB | 5.2 MiB | -19.3% | -19.6, -19.0 | **better** |
| signals, broker peak RSS | 60 | 8.9 MiB | 4.8 MiB | -46.6% | -49.6, -43.4 | **better** |
| latency, broker peak RSS | 60 | 7.3 MiB | 5.3 MiB | -27.6% | -30.5, -24.9 | **better** |
| shared, broker peak RSS | 40 | 7.6 MiB | 8.2 MiB | +8.0% | +7.2, +8.9 | **worse** |
| dicts, broker peak RSS | 60 | 6.4 MiB | 5.0 MiB | -21.1% | -21.4, -20.7 | **better** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.130 s | 0.125 s | -3.7% | -6.4, -0.9 | inconclusive* |
| calls, 20 clients | 60 | 0.567 s | 0.914 s | +61.3% | +55.7, +67.2 | **worse** |
| signals, burst to 1 | 60 | 0.219 s | 0.296 s | +34.9% | +28.5, +41.6 | **worse** |
| signals, broadcast to 20 | 60 | 0.277 s | 0.180 s | -35.1% | -38.8, -31.4 | **better** |
| RTT, 1 client, p50 | 60 | 115 µs | 109 µs | -5.4% | -8.8, -1.9 | inconclusive* |
| RTT, 1 client, p99 | 60 | 241 µs | 234 µs | -2.6% | -9.7, +6.0 | inconclusive |
| RTT, 20 clients, p50 | 60 | 521 µs | 869 µs | +67.0% | +58.4, +76.6 | **worse** |
| RTT, 20 clients, p99 | 60 | 1070 µs | 1569 µs | +46.6% | +35.6, +58.5 | **worse** |
| delivery to 20, p50 | 60 | 3.9 ms | 2.9 ms | -24.3% | -38.1, -8.7 | **better** |
| delivery to 20, p99 | 60 | 20.5 ms | 10.3 ms | -49.6% | -60.4, -34.0 | **better** |
| delivery to 20, whole fan-out | 60 | 0.100 s | 0.070 s | -30.7% | -34.9, -26.2 | **better** |
| 100 callers, 1 connection | 40 | 2.00 s | 2.00 s | -0.2% | -3.7, +3.4 | within ±5% |
| 100 clients | 40 | 2.51 s | 5.20 s | +107.3% | +101.7, +112.9 | **worse** |
| dict calls, 1 client | 60 | 0.155 s | 0.130 s | -16.1% | -18.1, -13.9 | **better** |
| dict calls, 20 clients | 60 | 0.846 s | 0.669 s | -20.9% | -22.8, -19.2 | **better** |
| calls, broker CPU | 60 | 0.59 s | 0.94 s | +59.9% | +54.7, +65.5 | **worse** |
| signals, broker CPU | 60 | 0.48 s | 0.43 s | -10.7% | -13.6, -7.7 | **better** |
| latency, broker CPU | 60 | 0.87 s | 1.22 s | +40.5% | +35.4, +46.0 | **worse** |
| shared, broker CPU | 40 | 4.30 s | 6.92 s | +61.1% | +57.1, +65.1 | **worse** |
| dicts, broker CPU | 60 | 0.89 s | 0.70 s | -21.9% | -23.6, -20.3 | **better** |
| calls, broker user time | 60 | 0.14 s | 0.40 s | +184.5% | +172.1, +198.1 | **worse** |
| signals, broker user time | 60 | 0.14 s | 0.26 s | +94.6% | +85.1, +104.9 | **worse** |
| latency, broker user time | 60 | 0.20 s | 0.53 s | +165.4% | +151.1, +180.2 | **worse** |
| shared, broker user time | 40 | 1.18 s | 3.30 s | +179.8% | +171.5, +188.6 | **worse** |
| dicts, broker user time | 60 | 0.49 s | 0.34 s | -31.5% | -34.0, -29.1 | **better** |
| calls, broker system time | 60 | 0.45 s | 0.55 s | +21.2% | +16.3, +26.4 | **worse** |
| signals, broker system time | 60 | 0.35 s | 0.17 s | -51.7% | -53.9, -49.3 | **better** |
| latency, broker system time | 60 | 0.67 s | 0.70 s | +3.5% | -0.5, +7.9 | inconclusive |
| shared, broker system time | 40 | 3.12 s | 3.62 s | +16.2% | +13.1, +19.2 | **worse** |
| dicts, broker system time | 60 | 0.40 s | 0.36 s | -10.1% | -13.2, -6.7 | **better** |
| calls, broker peak RSS | 60 | 6.4 MiB | 5.1 MiB | -21.3% | -21.7, -21.0 | **better** |
| signals, broker peak RSS | 60 | 8.9 MiB | 4.7 MiB | -46.9% | -49.9, -43.7 | **better** |
| latency, broker peak RSS | 60 | 7.3 MiB | 5.1 MiB | -29.2% | -32.0, -26.5 | **better** |
| shared, broker peak RSS | 40 | 7.6 MiB | 8.0 MiB | +5.9% | +5.1, +6.7 | **worse** |
| dicts, broker peak RSS | 60 | 6.4 MiB | 4.9 MiB | -22.4% | -22.7, -22.1 | **better** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.136 s | 0.117 s | -13.8% | -16.4, -11.2 | **better** |
| calls, 20 clients | 60 | 1.155 s | 0.662 s | -42.7% | -44.2, -41.0 | **better** |
| signals, burst to 1 | 60 | 0.532 s | 0.193 s | -63.6% | -64.7, -62.5 | **better** |
| signals, broadcast to 20 | 60 | 1.114 s | 0.172 s | -84.6% | -85.3, -83.8 | **better** |
| RTT, 1 client, p50 | 60 | 108 µs | 100 µs | -7.7% | -10.3, -5.1 | **better** |
| RTT, 1 client, p99 | 60 | 234 µs | 213 µs | -9.2% | -15.9, -1.3 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 1092 µs | 603 µs | -44.8% | -47.1, -42.3 | **better** |
| RTT, 20 clients, p99 | 60 | 1979 µs | 1235 µs | -37.6% | -41.4, -33.6 | **better** |
| delivery to 20, p50 | 60 | 10.9 ms | 2.9 ms | -73.5% | -75.1, -71.8 | **better** |
| delivery to 20, p99 | 60 | 22.1 ms | 9.9 ms | -55.2% | -59.4, -50.5 | **better** |
| delivery to 20, whole fan-out | 60 | 0.369 s | 0.062 s | -83.1% | -84.0, -82.0 | **better** |
| 100 callers, 1 connection | 40 | 5.27 s | 1.72 s | -67.4% | -68.2, -66.6 | **better** |
| 100 clients | 40 | 5.66 s | 3.87 s | -31.6% | -33.3, -30.0 | **better** |
| dict calls, 1 client | 60 | 0.158 s | 0.130 s | -17.8% | -19.9, -15.7 | **better** |
| dict calls, 20 clients | 60 | 1.278 s | 0.606 s | -52.6% | -53.5, -51.5 | **better** |
| calls, broker CPU | 60 | 1.20 s | 0.68 s | -42.9% | -44.3, -41.3 | **better** |
| signals, broker CPU | 60 | 1.63 s | 0.31 s | -80.9% | -81.5, -80.3 | **better** |
| latency, broker CPU | 60 | 1.80 s | 0.92 s | -48.8% | -50.4, -47.3 | **better** |
| shared, broker CPU | 40 | 10.72 s | 5.26 s | -50.9% | -51.8, -50.0 | **better** |
| dicts, broker CPU | 60 | 1.34 s | 0.63 s | -52.7% | -53.6, -51.8 | **better** |
| calls, broker user time | 60 | 0.59 s | 0.25 s | -57.8% | -59.2, -56.4 | **better** |
| signals, broker user time | 60 | 0.59 s | 0.15 s | -74.6% | -75.7, -73.5 | **better** |
| latency, broker user time | 60 | 0.79 s | 0.34 s | -57.5% | -59.0, -55.9 | **better** |
| shared, broker user time | 40 | 5.63 s | 2.13 s | -62.2% | -62.8, -61.6 | **better** |
| dicts, broker user time | 60 | 0.87 s | 0.29 s | -67.0% | -68.0, -66.1 | **better** |
| calls, broker system time | 60 | 0.61 s | 0.44 s | -28.4% | -30.9, -25.6 | **better** |
| signals, broker system time | 60 | 1.04 s | 0.16 s | -84.5% | -85.3, -83.7 | **better** |
| latency, broker system time | 60 | 1.01 s | 0.59 s | -42.1% | -44.4, -39.8 | **better** |
| shared, broker system time | 40 | 5.10 s | 3.14 s | -38.5% | -40.0, -37.0 | **better** |
| dicts, broker system time | 60 | 0.47 s | 0.34 s | -26.0% | -28.4, -23.4 | **better** |
| calls, broker peak RSS | 60 | 5.2 MiB | 5.2 MiB | -0.8% | -1.2, -0.3 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.8 MiB | +1.4% | -1.4, +3.9 | within ±5% |
| latency, broker peak RSS | 60 | 5.2 MiB | 5.3 MiB | +0.3% | -0.2, +0.8 | within ±5% |
| shared, broker peak RSS | 40 | 8.5 MiB | 8.2 MiB | -3.3% | -4.1, -2.4 | within ±5%* |
| dicts, broker peak RSS | 60 | 4.8 MiB | 5.0 MiB | +4.2% | +3.8, +4.6 | within ±5%* |

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at bc40cf0 builds the brokers and runs all of this, in about 47 minutes on this VM once the builds
are made, and writes its results to `$WORK/batched-sends-results-0413582`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. It ran with dbus-broker 37
first on the `PATH`, and with fake-journald.py started before it, in the same job.
