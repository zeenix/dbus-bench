# busd on zbus that reads ahead of each message, on a Ryzen 7 7840U

Measured on 2026-10-28 on the laptop of [the run of
0413582](2026-10-27-busd-message-checks-0413582-ryzen-7840u.md): an AMD Ryzen 7 7840U (8 cores, 16
threads), running Fedora 44 with Linux 7.1.13 and glibc 2.43. It ran
`NOTRIM=1 scripts/compare-read-ahead.sh` at 5ac1c7a, which made both builds of busd with rustc
1.99.0. dbus-broker 37 and dbus-daemon 1.16.2 are Fedora's. Compare the brokers with each other,
within this file only.

The builds of busd differ in the commit of zbus that they build on alone, as the script checks in
their lock files:

* **before**: e57b173, busd's main branch as of z-galaxy/busd#395, on zbus 7960179, the merge of
  z-galaxy/zbus#2088, and zruntime b3bd01d;
* **after**: the same busd on zbus 82992ca of zeenix/zbus, the head of z-galaxy/zbus#2090 when it
  ran, which 98ad9ce replaced with the same tree. That zbus reads as much as the socket of a connection holds
  into a buffer of 4 KiB that the connection keeps, and takes each message that is whole in it out
  of it without reading again, where 7960179 reads the primary header of each message, and then
  the rest of it, into a `Vec` that it reallocates to the length of the message. A message longer
  than the buffer, as the calls of 16 KiB are, still takes two reads, into an allocation of its
  exact length;
* **before-notrim** and **after-notrim**: before and after with glibc's trim threshold raised to
  4 MiB, through `GLIBC_TUNABLES=glibc.malloc.trim_threshold=4194304`, so that glibc doesn't give
  the top of the heap back to the kernel, and take it again, as it does by default once more than
  128 KiB is free there. On a 4-vCPU Xeon VM, `strace` counted after doing that several times as
  often as before on the method calls, though the large allocations of both are the same: 1,461
  to 5,376 `brk` calls in a run of them, where before made 137 to 1,077.

The clients are those of 5ac1c7a, on zbus 50c54bf and zruntime b3bd01d: they leave the sender out
of every message that is timed, as libdbus, GLib and sd-bus clients do, and the `dicts` workload
makes the method calls with a body of 100 variants, `a{sa{sv}}`.

## Summary

* After against before, busd takes 15.6% less time on the burst of signals and 7.1% less on the
  broadcast, 7.4% less on the median round trip of 20 clients, 8.7% less on the latencies'
  fan-out, and 13.3% less with 100 callers on one connection, with 6.6 to 11.8% less CPU time on
  those workloads. On the method calls of 20 clients, and on their dict calls, it takes 5.2% less
  each, with 5.9% and 5.1% less CPU time, and 4.6% less with 100 clients: repeatable, if not
  clearly beyond the margin of ±5%. With one client, it takes 2.1% less on the calls and 3.7% less
  on the median round trip, and as long on the dict calls. Its peak memory is 1.1 to 1.8% higher,
  and 4.1% with the 200 connections of the shared phases: the buffer of each.
* glibc's trimming costs after time where it costs before none. With the trim threshold raised,
  after takes another 3.1% less on the calls of 20 clients and 8.7% less with 100 callers on one
  connection, where before takes as long on the calls (+0.4%) and 6.8% less with the 100 callers.
  So, both with it raised, after takes 8.5% less than before on the calls of 20 clients, with 8.0%
  less CPU time, and 15.1% less with 100 callers on one connection. Otherwise, raising it takes up
  to 6% off the system time of the shared phases, and up to 5% off the peak memory, of both, and
  leaves the rest within ±5%.
* Against dbus-broker, after takes 3.3% longer on the calls of 20 clients, where before takes 8.9%
  longer, 11.6% less time with 100 callers on one connection (before: 1.9% more), 20.6% longer with
  100 clients (before: 26.4%), and about as long on the median round trip of 20 clients (-1.9%,
  before: +5.9%). With one client, after takes 16.7% longer on the calls (before: 19.2%) and 19.9%
  longer on the median round trip (before: 24.6%). It is faster on the burst of signals, by 33.7%
  (before: 21.5%), on the broadcast and the latencies' fan-out, and on the dict calls of 20 clients,
  by 31.0% (before: 27.2%). Its CPU time is 6.8% more on the calls (before: 13.5%), 6.0% more on
  the shared phases (before: 14.9%), and level on the latencies (before: 7.6% more).
* No run of any broker failed.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | +19.2% | +16.7% |
| calls, 20 clients | +8.9% | +3.3% |
| dict calls, 1 client | +2.0% | +1.8% |
| dict calls, 20 clients | -27.2% | -31.0% |
| signals, burst to 1 | -21.5% | -33.7% |
| signals, broadcast to 20 | -59.3% | -62.2% |
| RTT, 1 client, p50 | +24.6% | +19.9% |
| RTT, 20 clients, p50 | +5.9% | -1.9% |
| RTT, 20 clients, p99 | +0.4% | -3.6% |
| delivery to 20, whole fan-out | -56.1% | -59.9% |
| 100 callers, 1 connection | +1.9% | -11.6% |
| 100 clients | +26.4% | +20.6% |
| calls, broker CPU | +13.5% | +6.8% |
| dicts, broker CPU | -24.6% | -28.4% |
| signals, broker CPU | -37.8% | -45.1% |
| latency, broker CPU | +7.6% | +0.5% |
| shared, broker CPU | +14.9% | +6.0% |
| shared, broker peak RSS | +51.2% | +57.3% |

## The benchmarks

The workloads and the comparisons are those of [the run on the
Xeon](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md#the-benchmarks): 60 rounds of each workload,
and 40 of the shared phases, after 3 of warm-up, all six brokers in each round. The raw results are
in [runs.tar.xz](2026-10-28-busd-zbus-read-ahead-ryzen-7840u/runs.tar.xz). The values are means
over the rounds, and a star marks a difference whose 95% interval excludes 0 but not the margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.081 s | 0.079 s | -2.1% | -4.0, -0.2 | within ±5%* |
| calls, 20 clients | 60 | 0.364 s | 0.345 s | -5.2% | -7.3, -2.7 | inconclusive* |
| signals, burst to 1 | 60 | 0.135 s | 0.114 s | -15.6% | -16.7, -14.4 | **better** |
| signals, broadcast to 20 | 60 | 0.079 s | 0.073 s | -7.1% | -8.8, -5.4 | **better** |
| RTT, 1 client, p50 | 60 | 59 µs | 57 µs | -3.7% | -4.2, -3.2 | within ±5%* |
| RTT, 1 client, p99 | 60 | 124 µs | 121 µs | -2.2% | -8.1, +3.9 | inconclusive |
| RTT, 20 clients, p50 | 60 | 310 µs | 287 µs | -7.4% | -8.9, -5.9 | **better** |
| RTT, 20 clients, p99 | 60 | 438 µs | 421 µs | -3.9% | -6.7, -1.2 | inconclusive* |
| delivery to 20, p50 | 60 | 1.1 ms | 1.1 ms | -1.8% | -3.3, -0.2 | within ±5%* |
| delivery to 20, p99 | 60 | 2.0 ms | 1.9 ms | -3.4% | -5.9, -0.4 | inconclusive* |
| delivery to 20, whole fan-out | 60 | 0.029 s | 0.027 s | -8.7% | -9.9, -7.5 | **better** |
| 100 callers, 1 connection | 40 | 1.25 s | 1.08 s | -13.3% | -16.4, -9.9 | **better** |
| 100 clients | 40 | 2.12 s | 2.03 s | -4.6% | -7.5, -1.5 | inconclusive* |
| dict calls, 1 client | 60 | 0.082 s | 0.082 s | -0.2% | -2.6, +2.1 | within ±5% |
| dict calls, 20 clients | 60 | 0.386 s | 0.366 s | -5.2% | -6.7, -3.9 | inconclusive* |
| calls, broker CPU | 60 | 0.41 s | 0.39 s | -5.9% | -7.7, -3.8 | inconclusive* |
| signals, broker CPU | 60 | 0.24 s | 0.21 s | -11.8% | -12.7, -10.9 | **better** |
| latency, broker CPU | 60 | 0.51 s | 0.48 s | -6.6% | -7.6, -5.6 | **better** |
| shared, broker CPU | 40 | 3.29 s | 3.03 s | -7.7% | -9.7, -5.6 | **better** |
| dicts, broker CPU | 60 | 0.42 s | 0.40 s | -5.1% | -6.4, -4.0 | inconclusive* |
| calls, broker user time | 60 | 0.18 s | 0.16 s | -6.7% | -9.3, -3.9 | inconclusive* |
| signals, broker user time | 60 | 0.10 s | 0.09 s | -14.7% | -17.2, -12.1 | **better** |
| latency, broker user time | 60 | 0.21 s | 0.19 s | -9.0% | -11.3, -6.6 | **better** |
| shared, broker user time | 40 | 1.37 s | 1.27 s | -6.9% | -9.9, -3.6 | inconclusive* |
| dicts, broker user time | 60 | 0.21 s | 0.20 s | -3.4% | -6.2, -0.9 | inconclusive* |
| calls, broker system time | 60 | 0.23 s | 0.22 s | -5.2% | -7.5, -2.7 | inconclusive* |
| signals, broker system time | 60 | 0.14 s | 0.12 s | -9.7% | -11.5, -7.9 | **better** |
| latency, broker system time | 60 | 0.30 s | 0.28 s | -4.9% | -6.5, -3.2 | inconclusive* |
| shared, broker system time | 40 | 1.92 s | 1.76 s | -8.4% | -10.1, -6.4 | **better** |
| dicts, broker system time | 60 | 0.21 s | 0.20 s | -6.7% | -8.7, -4.7 | inconclusive* |
| calls, broker peak RSS | 60 | 6.9 MiB | 7.1 MiB | +1.5% | +0.8, +2.2 | within ±5%* |
| signals, broker peak RSS | 60 | 6.3 MiB | 6.3 MiB | +1.1% | +0.3, +1.8 | within ±5%* |
| latency, broker peak RSS | 60 | 7.2 MiB | 7.3 MiB | +1.7% | +1.1, +2.3 | within ±5%* |
| shared, broker peak RSS | 40 | 13.7 MiB | 14.3 MiB | +4.1% | +2.5, +5.8 | inconclusive* |
| dicts, broker peak RSS | 60 | 6.8 MiB | 6.9 MiB | +1.8% | +1.2, +2.5 | within ±5%* |

### after-notrim against after

| Measure | n | after | after-notrim | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.079 s | 0.078 s | -1.9% | -3.7, -0.1 | within ±5%* |
| calls, 20 clients | 60 | 0.345 s | 0.334 s | -3.1% | -5.4, -1.0 | within ±5%* |
| signals, burst to 1 | 60 | 0.114 s | 0.113 s | -1.0% | -2.1, +0.0 | within ±5% |
| signals, broadcast to 20 | 60 | 0.073 s | 0.072 s | -1.2% | -2.9, +0.5 | within ±5% |
| RTT, 1 client, p50 | 60 | 57 µs | 57 µs | -0.1% | -0.6, +0.5 | within ±5% |
| RTT, 1 client, p99 | 60 | 121 µs | 118 µs | -2.7% | -7.5, +2.4 | inconclusive |
| RTT, 20 clients, p50 | 60 | 287 µs | 283 µs | -1.6% | -3.6, +0.3 | within ±5% |
| RTT, 20 clients, p99 | 60 | 421 µs | 400 µs | -5.0% | -7.4, -2.5 | inconclusive* |
| delivery to 20, p50 | 60 | 1.1 ms | 1.1 ms | -0.4% | -2.0, +1.1 | within ±5% |
| delivery to 20, p99 | 60 | 1.9 ms | 1.9 ms | +0.1% | -4.6, +5.3 | within ±5% |
| delivery to 20, whole fan-out | 60 | 0.027 s | 0.027 s | -0.2% | -2.0, +1.5 | within ±5% |
| 100 callers, 1 connection | 40 | 1.08 s | 0.99 s | -8.7% | -11.8, -5.7 | **better** |
| 100 clients | 40 | 2.03 s | 2.03 s | -0.1% | -3.4, +3.4 | within ±5% |
| dict calls, 1 client | 60 | 0.082 s | 0.081 s | -0.5% | -2.6, +1.5 | within ±5% |
| dict calls, 20 clients | 60 | 0.366 s | 0.368 s | +0.4% | -0.8, +1.6 | within ±5% |
| calls, broker CPU | 60 | 0.39 s | 0.38 s | -1.9% | -3.9, -0.2 | within ±5%* |
| signals, broker CPU | 60 | 0.21 s | 0.21 s | -0.1% | -1.0, +0.8 | within ±5% |
| latency, broker CPU | 60 | 0.48 s | 0.48 s | -0.0% | -1.2, +1.1 | within ±5% |
| shared, broker CPU | 40 | 3.03 s | 2.95 s | -2.8% | -5.6, +0.3 | inconclusive |
| dicts, broker CPU | 60 | 0.40 s | 0.41 s | +1.0% | +0.1, +2.0 | within ±5%* |
| calls, broker user time | 60 | 0.16 s | 0.16 s | -2.4% | -5.7, +0.8 | inconclusive |
| signals, broker user time | 60 | 0.09 s | 0.08 s | -1.4% | -4.6, +1.9 | within ±5% |
| latency, broker user time | 60 | 0.19 s | 0.19 s | -1.1% | -3.3, +1.0 | within ±5% |
| shared, broker user time | 40 | 1.27 s | 1.27 s | -0.2% | -4.0, +3.7 | within ±5% |
| dicts, broker user time | 60 | 0.20 s | 0.20 s | -0.1% | -2.2, +2.0 | within ±5% |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -1.5% | -3.8, +0.7 | within ±5% |
| signals, broker system time | 60 | 0.12 s | 0.12 s | +0.8% | -1.4, +3.1 | within ±5% |
| latency, broker system time | 60 | 0.28 s | 0.29 s | +0.7% | -0.9, +2.3 | within ±5% |
| shared, broker system time | 40 | 1.76 s | 1.68 s | -4.6% | -7.4, -1.8 | inconclusive* |
| dicts, broker system time | 60 | 0.20 s | 0.20 s | +2.2% | +0.3, +4.1 | within ±5%* |
| calls, broker peak RSS | 60 | 7.1 MiB | 7.0 MiB | -0.6% | -1.3, +0.0 | within ±5% |
| signals, broker peak RSS | 60 | 6.3 MiB | 6.2 MiB | -1.8% | -2.6, -1.1 | within ±5%* |
| latency, broker peak RSS | 60 | 7.3 MiB | 7.2 MiB | -1.5% | -2.0, -1.1 | within ±5%* |
| shared, broker peak RSS | 40 | 14.3 MiB | 13.6 MiB | -4.8% | -6.3, -3.3 | inconclusive* |
| dicts, broker peak RSS | 60 | 6.9 MiB | 6.8 MiB | -1.5% | -2.1, -0.9 | within ±5%* |

### before-notrim against before

| Measure | n | before | before-notrim | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.081 s | 0.080 s | -1.5% | -2.8, -0.1 | within ±5%* |
| calls, 20 clients | 60 | 0.364 s | 0.365 s | +0.4% | -1.2, +2.2 | within ±5% |
| signals, burst to 1 | 60 | 0.135 s | 0.136 s | +0.2% | -1.1, +1.5 | within ±5% |
| signals, broadcast to 20 | 60 | 0.079 s | 0.078 s | -0.8% | -2.1, +0.4 | within ±5% |
| RTT, 1 client, p50 | 60 | 59 µs | 59 µs | -0.3% | -0.8, +0.1 | within ±5% |
| RTT, 1 client, p99 | 60 | 124 µs | 126 µs | +1.4% | -4.1, +7.2 | inconclusive |
| RTT, 20 clients, p50 | 60 | 310 µs | 305 µs | -1.5% | -3.0, -0.1 | within ±5%* |
| RTT, 20 clients, p99 | 60 | 438 µs | 448 µs | +2.4% | -0.2, +5.1 | within ±5% |
| delivery to 20, p50 | 60 | 1.1 ms | 1.1 ms | +0.0% | -1.8, +1.9 | within ±5% |
| delivery to 20, p99 | 60 | 2.0 ms | 2.1 ms | +6.0% | -0.7, +15.3 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.029 s | 0.029 s | +0.5% | -1.3, +2.5 | within ±5% |
| 100 callers, 1 connection | 40 | 1.25 s | 1.16 s | -6.8% | -9.3, -4.1 | inconclusive* |
| 100 clients | 40 | 2.12 s | 2.07 s | -2.6% | -5.4, +0.3 | within ±5% |
| dict calls, 1 client | 60 | 0.082 s | 0.082 s | +0.5% | -1.9, +2.9 | within ±5% |
| dict calls, 20 clients | 60 | 0.386 s | 0.380 s | -1.6% | -3.2, -0.1 | within ±5%* |
| calls, broker CPU | 60 | 0.41 s | 0.41 s | +0.3% | -1.0, +1.8 | within ±5% |
| signals, broker CPU | 60 | 0.24 s | 0.24 s | +0.1% | -0.8, +0.9 | within ±5% |
| latency, broker CPU | 60 | 0.51 s | 0.51 s | +0.3% | -0.8, +1.3 | within ±5% |
| shared, broker CPU | 40 | 3.29 s | 3.15 s | -4.0% | -6.3, -1.6 | inconclusive* |
| dicts, broker CPU | 60 | 0.42 s | 0.42 s | -0.1% | -1.5, +1.3 | within ±5% |
| calls, broker user time | 60 | 0.18 s | 0.18 s | +1.2% | -0.9, +3.5 | within ±5% |
| signals, broker user time | 60 | 0.10 s | 0.10 s | +0.1% | -3.2, +3.6 | within ±5% |
| latency, broker user time | 60 | 0.21 s | 0.21 s | -2.7% | -4.9, -0.5 | within ±5%* |
| shared, broker user time | 40 | 1.37 s | 1.35 s | -1.4% | -4.4, +1.7 | within ±5% |
| dicts, broker user time | 60 | 0.21 s | 0.21 s | -1.0% | -3.9, +1.7 | within ±5% |
| calls, broker system time | 60 | 0.23 s | 0.23 s | -0.3% | -2.3, +1.8 | within ±5% |
| signals, broker system time | 60 | 0.14 s | 0.14 s | +0.1% | -2.4, +2.6 | within ±5% |
| latency, broker system time | 60 | 0.30 s | 0.31 s | +2.5% | +0.9, +4.0 | within ±5%* |
| shared, broker system time | 40 | 1.92 s | 1.81 s | -5.9% | -8.0, -3.7 | inconclusive* |
| dicts, broker system time | 60 | 0.21 s | 0.22 s | +0.8% | -1.0, +2.7 | within ±5% |
| calls, broker peak RSS | 60 | 6.9 MiB | 6.9 MiB | -0.8% | -1.5, -0.1 | within ±5%* |
| signals, broker peak RSS | 60 | 6.3 MiB | 6.2 MiB | -1.4% | -2.0, -0.7 | within ±5%* |
| latency, broker peak RSS | 60 | 7.2 MiB | 7.1 MiB | -1.3% | -1.9, -0.8 | within ±5%* |
| shared, broker peak RSS | 40 | 13.7 MiB | 13.2 MiB | -3.8% | -5.3, -2.3 | inconclusive* |
| dicts, broker peak RSS | 60 | 6.8 MiB | 6.7 MiB | -1.4% | -1.9, -0.8 | within ±5%* |

### after-notrim against before-notrim

| Measure | n | before-notrim | after-notrim | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.080 s | 0.078 s | -2.5% | -4.0, -1.0 | within ±5%* |
| calls, 20 clients | 60 | 0.365 s | 0.334 s | -8.5% | -10.3, -6.8 | **better** |
| signals, burst to 1 | 60 | 0.136 s | 0.113 s | -16.6% | -17.4, -15.8 | **better** |
| signals, broadcast to 20 | 60 | 0.078 s | 0.072 s | -7.5% | -8.7, -6.2 | **better** |
| RTT, 1 client, p50 | 60 | 59 µs | 57 µs | -3.5% | -4.0, -3.0 | within ±5%* |
| RTT, 1 client, p99 | 60 | 126 µs | 118 µs | -6.1% | -10.3, -1.9 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 305 µs | 283 µs | -7.5% | -8.7, -6.2 | **better** |
| RTT, 20 clients, p99 | 60 | 448 µs | 400 µs | -10.8% | -13.4, -8.5 | **better** |
| delivery to 20, p50 | 60 | 1.1 ms | 1.1 ms | -2.2% | -3.9, -0.5 | within ±5%* |
| delivery to 20, p99 | 60 | 2.1 ms | 1.9 ms | -8.7% | -16.2, -2.4 | inconclusive* |
| delivery to 20, whole fan-out | 60 | 0.029 s | 0.027 s | -9.3% | -11.2, -7.6 | **better** |
| 100 callers, 1 connection | 40 | 1.16 s | 0.99 s | -15.1% | -16.3, -13.9 | **better** |
| 100 clients | 40 | 2.07 s | 2.03 s | -2.1% | -5.3, +1.3 | within ±5% |
| dict calls, 1 client | 60 | 0.082 s | 0.081 s | -1.3% | -3.2, +0.5 | within ±5% |
| dict calls, 20 clients | 60 | 0.380 s | 0.368 s | -3.2% | -4.5, -2.1 | within ±5%* |
| calls, broker CPU | 60 | 0.41 s | 0.38 s | -8.0% | -9.4, -6.7 | **better** |
| signals, broker CPU | 60 | 0.24 s | 0.21 s | -12.0% | -12.6, -11.3 | **better** |
| latency, broker CPU | 60 | 0.51 s | 0.48 s | -6.9% | -7.7, -6.2 | **better** |
| shared, broker CPU | 40 | 3.15 s | 2.95 s | -6.5% | -8.8, -4.2 | inconclusive* |
| dicts, broker CPU | 60 | 0.42 s | 0.41 s | -4.0% | -5.1, -3.0 | within ±5%* |
| calls, broker user time | 60 | 0.18 s | 0.16 s | -10.1% | -12.4, -7.9 | **better** |
| signals, broker user time | 60 | 0.10 s | 0.08 s | -16.0% | -18.5, -13.5 | **better** |
| latency, broker user time | 60 | 0.21 s | 0.19 s | -7.5% | -9.4, -5.7 | **better** |
| shared, broker user time | 40 | 1.35 s | 1.27 s | -5.8% | -8.9, -2.5 | inconclusive* |
| dicts, broker user time | 60 | 0.21 s | 0.20 s | -2.5% | -4.6, -0.4 | within ±5%* |
| calls, broker system time | 60 | 0.23 s | 0.22 s | -6.4% | -8.1, -4.8 | inconclusive* |
| signals, broker system time | 60 | 0.14 s | 0.12 s | -9.0% | -11.0, -6.9 | **better** |
| latency, broker system time | 60 | 0.31 s | 0.29 s | -6.5% | -7.8, -5.3 | **better** |
| shared, broker system time | 40 | 1.81 s | 1.68 s | -7.1% | -9.0, -5.2 | **better** |
| dicts, broker system time | 60 | 0.22 s | 0.20 s | -5.4% | -7.2, -3.6 | inconclusive* |
| calls, broker peak RSS | 60 | 6.9 MiB | 7.0 MiB | +1.7% | +1.2, +2.3 | within ±5%* |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.2 MiB | +0.6% | -0.0, +1.2 | within ±5% |
| latency, broker peak RSS | 60 | 7.1 MiB | 7.2 MiB | +1.5% | +1.1, +2.0 | within ±5%* |
| shared, broker peak RSS | 40 | 13.2 MiB | 13.6 MiB | +3.0% | +1.3, +4.7 | within ±5%* |
| dicts, broker peak RSS | 60 | 6.7 MiB | 6.8 MiB | +1.7% | +1.2, +2.3 | within ±5%* |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.068 s | 0.079 s | +16.7% | +14.7, +18.9 | **worse** |
| calls, 20 clients | 60 | 0.334 s | 0.345 s | +3.3% | +1.1, +5.5 | inconclusive* |
| signals, burst to 1 | 60 | 0.173 s | 0.114 s | -33.7% | -34.5, -33.0 | **better** |
| signals, broadcast to 20 | 60 | 0.193 s | 0.073 s | -62.2% | -62.9, -61.6 | **better** |
| RTT, 1 client, p50 | 60 | 47 µs | 57 µs | +19.9% | +19.1, +20.7 | **worse** |
| RTT, 1 client, p99 | 60 | 109 µs | 121 µs | +10.9% | +5.1, +16.8 | **worse** |
| RTT, 20 clients, p50 | 60 | 293 µs | 287 µs | -1.9% | -3.7, +0.0 | within ±5% |
| RTT, 20 clients, p99 | 60 | 436 µs | 421 µs | -3.6% | -6.3, -0.6 | inconclusive* |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -44.1% | -44.8, -43.3 | **better** |
| delivery to 20, p99 | 60 | 3.4 ms | 1.9 ms | -44.0% | -45.6, -42.4 | **better** |
| delivery to 20, whole fan-out | 60 | 0.066 s | 0.027 s | -59.9% | -60.4, -59.4 | **better** |
| 100 callers, 1 connection | 40 | 1.22 s | 1.08 s | -11.6% | -14.2, -8.6 | **better** |
| 100 clients | 40 | 1.68 s | 2.03 s | +20.6% | +17.8, +23.7 | **worse** |
| dict calls, 1 client | 60 | 0.080 s | 0.082 s | +1.8% | -0.1, +3.7 | within ±5% |
| dict calls, 20 clients | 60 | 0.531 s | 0.366 s | -31.0% | -32.0, -30.1 | **better** |
| calls, broker CPU | 60 | 0.36 s | 0.39 s | +6.8% | +4.8, +8.9 | inconclusive* |
| signals, broker CPU | 60 | 0.38 s | 0.21 s | -45.1% | -45.7, -44.6 | **better** |
| latency, broker CPU | 60 | 0.47 s | 0.48 s | +0.5% | -0.6, +1.7 | within ±5% |
| shared, broker CPU | 40 | 2.86 s | 3.03 s | +6.0% | +3.9, +8.3 | inconclusive* |
| dicts, broker CPU | 60 | 0.56 s | 0.40 s | -28.4% | -29.3, -27.7 | **better** |
| calls, broker user time | 60 | 0.12 s | 0.16 s | +36.2% | +32.3, +40.1 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.09 s | -31.5% | -33.7, -29.3 | **better** |
| latency, broker user time | 60 | 0.15 s | 0.19 s | +26.1% | +22.7, +29.5 | **worse** |
| shared, broker user time | 40 | 0.95 s | 1.27 s | +33.5% | +30.3, +37.2 | **worse** |
| dicts, broker user time | 60 | 0.36 s | 0.20 s | -43.7% | -44.9, -42.5 | **better** |
| calls, broker system time | 60 | 0.24 s | 0.22 s | -7.9% | -10.2, -5.6 | **better** |
| signals, broker system time | 60 | 0.25 s | 0.12 s | -51.9% | -52.9, -50.9 | **better** |
| latency, broker system time | 60 | 0.32 s | 0.28 s | -11.7% | -13.3, -9.9 | **better** |
| shared, broker system time | 40 | 1.91 s | 1.76 s | -7.8% | -9.8, -5.7 | **better** |
| dicts, broker system time | 60 | 0.20 s | 0.20 s | -1.7% | -4.0, +0.9 | within ±5% |
| calls, broker peak RSS | 60 | 8.1 MiB | 7.1 MiB | -13.2% | -13.9, -12.5 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.3 MiB | -23.1% | -24.1, -22.2 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.3 MiB | -10.6% | -11.1, -10.1 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 14.3 MiB | +57.3% | +55.4, +59.2 | **worse** |
| dicts, broker peak RSS | 60 | 8.0 MiB | 6.9 MiB | -13.7% | -14.3, -13.1 | **better** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.068 s | 0.081 s | +19.2% | +17.0, +21.6 | **worse** |
| calls, 20 clients | 60 | 0.334 s | 0.364 s | +8.9% | +6.8, +11.0 | **worse** |
| signals, burst to 1 | 60 | 0.173 s | 0.135 s | -21.5% | -22.5, -20.6 | **better** |
| signals, broadcast to 20 | 60 | 0.193 s | 0.079 s | -59.3% | -60.1, -58.6 | **better** |
| RTT, 1 client, p50 | 60 | 47 µs | 59 µs | +24.6% | +23.7, +25.4 | **worse** |
| RTT, 1 client, p99 | 60 | 109 µs | 124 µs | +13.4% | +7.3, +19.7 | **worse** |
| RTT, 20 clients, p50 | 60 | 293 µs | 310 µs | +5.9% | +4.1, +7.9 | inconclusive* |
| RTT, 20 clients, p99 | 60 | 436 µs | 438 µs | +0.4% | -2.4, +3.2 | within ±5% |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -43.1% | -44.0, -42.1 | **better** |
| delivery to 20, p99 | 60 | 3.4 ms | 2.0 ms | -42.0% | -43.6, -40.5 | **better** |
| delivery to 20, whole fan-out | 60 | 0.066 s | 0.029 s | -56.1% | -56.7, -55.4 | **better** |
| 100 callers, 1 connection | 40 | 1.22 s | 1.25 s | +1.9% | -0.3, +4.2 | within ±5% |
| 100 clients | 40 | 1.68 s | 2.12 s | +26.4% | +23.8, +29.3 | **worse** |
| dict calls, 1 client | 60 | 0.080 s | 0.082 s | +2.0% | +0.1, +4.3 | within ±5%* |
| dict calls, 20 clients | 60 | 0.531 s | 0.386 s | -27.2% | -28.3, -26.0 | **better** |
| calls, broker CPU | 60 | 0.36 s | 0.41 s | +13.5% | +11.4, +15.5 | **worse** |
| signals, broker CPU | 60 | 0.38 s | 0.24 s | -37.8% | -38.5, -37.1 | **better** |
| latency, broker CPU | 60 | 0.47 s | 0.51 s | +7.6% | +6.3, +9.0 | **worse** |
| shared, broker CPU | 40 | 2.86 s | 3.29 s | +14.9% | +13.2, +16.6 | **worse** |
| dicts, broker CPU | 60 | 0.56 s | 0.42 s | -24.6% | -25.6, -23.5 | **better** |
| calls, broker user time | 60 | 0.12 s | 0.18 s | +46.0% | +42.0, +50.0 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.10 s | -19.7% | -22.1, -17.2 | **better** |
| latency, broker user time | 60 | 0.15 s | 0.21 s | +38.6% | +35.2, +42.2 | **worse** |
| shared, broker user time | 40 | 0.95 s | 1.37 s | +43.4% | +40.3, +46.8 | **worse** |
| dicts, broker user time | 60 | 0.36 s | 0.21 s | -41.7% | -43.1, -40.0 | **better** |
| calls, broker system time | 60 | 0.24 s | 0.23 s | -2.8% | -5.2, -0.5 | within ±5%* |
| signals, broker system time | 60 | 0.25 s | 0.14 s | -46.7% | -48.1, -45.4 | **better** |
| latency, broker system time | 60 | 0.32 s | 0.30 s | -7.1% | -8.6, -5.6 | **better** |
| shared, broker system time | 40 | 1.91 s | 1.92 s | +0.6% | -1.1, +2.4 | within ±5% |
| dicts, broker system time | 60 | 0.20 s | 0.21 s | +5.4% | +3.0, +7.8 | inconclusive* |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.9 MiB | -14.5% | -15.1, -13.9 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.3 MiB | -23.9% | -24.9, -23.0 | **better** |
| latency, broker peak RSS | 60 | 8.2 MiB | 7.2 MiB | -12.1% | -12.7, -11.6 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 13.7 MiB | +51.2% | +49.4, +53.0 | **worse** |
| dicts, broker peak RSS | 60 | 8.0 MiB | 6.8 MiB | -15.3% | -15.8, -14.7 | **better** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.148 s | 0.079 s | -46.1% | -47.1, -45.2 | **better** |
| calls, 20 clients | 60 | 1.259 s | 0.345 s | -72.6% | -73.1, -72.0 | **better** |
| signals, burst to 1 | 60 | 0.801 s | 0.114 s | -85.7% | -85.8, -85.6 | **better** |
| signals, broadcast to 20 | 60 | 1.976 s | 0.073 s | -96.3% | -96.4, -96.2 | **better** |
| RTT, 1 client, p50 | 60 | 90 µs | 57 µs | -37.1% | -37.6, -36.7 | **better** |
| RTT, 1 client, p99 | 60 | 186 µs | 121 µs | -34.9% | -37.9, -32.0 | **better** |
| RTT, 20 clients, p50 | 60 | 1130 µs | 287 µs | -74.6% | -74.9, -74.2 | **better** |
| RTT, 20 clients, p99 | 60 | 1423 µs | 421 µs | -70.4% | -71.6, -69.3 | **better** |
| delivery to 20, p50 | 60 | 20.4 ms | 1.1 ms | -94.5% | -94.5, -94.4 | **better** |
| delivery to 20, p99 | 60 | 32.1 ms | 1.9 ms | -94.1% | -94.3, -93.9 | **better** |
| delivery to 20, whole fan-out | 60 | 0.658 s | 0.027 s | -96.0% | -96.0, -95.9 | **better** |
| 100 callers, 1 connection | 40 | 6.21 s | 1.08 s | -82.6% | -83.1, -82.0 | **better** |
| 100 clients | 40 | 6.07 s | 2.03 s | -66.6% | -67.4, -65.7 | **better** |
| dict calls, 1 client | 60 | 0.137 s | 0.082 s | -40.4% | -41.5, -39.3 | **better** |
| dict calls, 20 clients | 60 | 1.263 s | 0.366 s | -71.0% | -71.3, -70.7 | **better** |
| calls, broker CPU | 60 | 1.35 s | 0.39 s | -71.4% | -71.9, -70.9 | **better** |
| signals, broker CPU | 60 | 2.79 s | 0.21 s | -92.5% | -92.6, -92.5 | **better** |
| latency, broker CPU | 60 | 2.10 s | 0.48 s | -77.4% | -77.6, -77.2 | **better** |
| shared, broker CPU | 40 | 12.24 s | 3.03 s | -75.2% | -75.8, -74.7 | **better** |
| dicts, broker CPU | 60 | 1.34 s | 0.40 s | -70.1% | -70.4, -69.8 | **better** |
| calls, broker user time | 60 | 0.51 s | 0.16 s | -67.6% | -68.4, -66.7 | **better** |
| signals, broker user time | 60 | 0.86 s | 0.09 s | -90.1% | -90.3, -89.8 | **better** |
| latency, broker user time | 60 | 0.72 s | 0.19 s | -73.3% | -73.8, -72.8 | **better** |
| shared, broker user time | 40 | 4.38 s | 1.27 s | -70.9% | -71.6, -70.1 | **better** |
| dicts, broker user time | 60 | 0.65 s | 0.20 s | -69.2% | -69.7, -68.6 | **better** |
| calls, broker system time | 60 | 0.84 s | 0.22 s | -73.7% | -74.2, -73.2 | **better** |
| signals, broker system time | 60 | 1.92 s | 0.12 s | -93.6% | -93.8, -93.5 | **better** |
| latency, broker system time | 60 | 1.38 s | 0.28 s | -79.5% | -79.8, -79.3 | **better** |
| shared, broker system time | 40 | 7.87 s | 1.76 s | -77.7% | -78.1, -77.1 | **better** |
| dicts, broker system time | 60 | 0.69 s | 0.20 s | -70.9% | -71.3, -70.4 | **better** |
| calls, broker peak RSS | 60 | 6.5 MiB | 7.1 MiB | +9.3% | +8.3, +10.2 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.3 MiB | +15.6% | +14.6, +16.7 | **worse** |
| latency, broker peak RSS | 60 | 6.4 MiB | 7.3 MiB | +14.0% | +12.9, +15.1 | **worse** |
| shared, broker peak RSS | 40 | 9.8 MiB | 14.3 MiB | +46.2% | +44.5, +48.0 | **worse** |
| dicts, broker peak RSS | 60 | 6.0 MiB | 6.9 MiB | +15.5% | +14.7, +16.3 | **worse** |

## Reproducing

```sh
NOTRIM=1 scripts/compare-read-ahead.sh
```

at 5ac1c7a builds the brokers and runs all of this, in about 41 minutes on this laptop once the
builds are made, and writes its results to `$WORK/read-ahead-results-82992ca`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. Without `NOTRIM=1`, it
leaves before-notrim and after-notrim out.
