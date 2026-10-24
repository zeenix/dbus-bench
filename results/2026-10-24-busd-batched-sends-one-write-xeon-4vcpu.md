# busd's batched sends with a write for each batch, on a 4-vCPU Xeon

Measured on 2026-10-24, on the VM of
[busd forwarding in batches](2026-10-24-busd-batched-sends-xeon-4vcpu.md), after that run: 4 vCPUs
of an Intel Xeon @ 2.80GHz under KVM, 15 GiB, Linux 6.18, Ubuntu 24.04.5. It ran
`scripts/compare-batched-sends.sh` at 18444f8, which made every build of busd with rustc 1.97.0.
dbus-broker is the 35 of Ubuntu 24.04, which ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py), and dbus-daemon
the 1.14.10 of Ubuntu 24.04. Compare the brokers with each other, within this file only.

busd forwards the messages of each peer in batches, which end with the message that brings them to
16 KiB or more. The zbus that the batches of the earlier file were written with ended each write
before the message that would take it past 16 KiB, so that a batch that went past 16 KiB took two
writes to a recipient that got all of it, the last message alone. zbus now ends a write with that
message instead, so that a batch goes in one write. The builds of busd, from z-galaxy/busd and from
the `ccr-fd1ce738-0xtuf0` branch of zeenix/busd:

* **queue**, 0c52e9c, and **baseline**, 0b89e3a, as in the earlier file: busd's main branch with a
  queue for each client, and busd's main branch since, which writes each message that it forwards
  to a client with a system call of its own, within a time limit of 100 ms.
* **batched-before**, 4f346a3: **batched** of the earlier file, on zbus 03c83b6, which ended each
  write before the message that would take it past 16 KiB.
* **batched**, ac6e6fa: the same, on zbus 596ec05, which ends each write with the message that
  brings it to 16 KiB or more. Both commits of zbus are on the `ccr-fd1ce738-0xtuf0` branch of
  zeenix/zbus, the second in place of the first.

All four run on zruntime 99e2ebd, the commit that baseline pins: queue through a patch of the
release that its lock file names.

## Summary

* batched is level with batched-before on every workload: within 5%, or inconclusive. The system
  time of the broker on the signals is 8.7% lower (from -17.1 to +0.7%, inconclusive), and its CPU
  time 2.2% lower (inconclusive), while the round trips of 20 connections take 7.6% longer at p99
  (from +1.4 to +14.2%, inconclusive), and the system time on the calls is 5.8% higher (from +0.8 to
  +11.3%, inconclusive). Its writes of the signals of the benchmark are 45% fewer: 9,386 for their
  120,000 deliveries, against 17,045, where baseline makes one for each.
* Against baseline, batched is where it was in the earlier file: faster on the signals, by 11.4% on
  the broadcast to 20 subscribers and 8.8% on the burst to one (inconclusive), with 24.1% less CPU
  time of the broker and 39.2% less system time, and level on the rest, with the calls on one
  connection 4.4% slower (from +1.6 to +7.4%, inconclusive). The whole fan-out of the latencies'
  signals to 20 subscribers takes 12.0% less time, while the delivery of each signal takes 6.2%
  longer at the median and 9.9% at p99 (inconclusive), as on
  [the Ryzen 7 7840U](2026-10-24-busd-batched-sends-ryzen-7840u.md).
* Against the queue, dbus-broker and dbus-daemon, batched is where it was in the earlier file:
  against the queue, level or better, apart from the connection that 100 proxies share, 7.3% slower;
  against dbus-broker, level on one connection, 35.2 to 39.1% faster with 20 connections and more,
  and faster on the signals, with 4.7% less CPU time on them (inconclusive), but 14.1 to 29.3% more
  on the rest; and against dbus-daemon, faster on every workload, with 29.9 to 47.0% less CPU time.
* No run of any broker failed.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), with 60 rounds
of each, and 40 of the shared connection, after 3 of warm-up, all six brokers in each round. The raw
results of each run are in the `.json` files of
[the directory](2026-10-24-busd-batched-sends-one-write-xeon-4vcpu), and the comparisons, with the
other metrics and the medians, in its
[stats](2026-10-24-busd-batched-sends-one-write-xeon-4vcpu/stats). A star marks a difference whose
95% interval excludes 0 but not the margin. The whole fan-out is how long the delivery of all the
signals to 20 subscribers takes.

### batched against batched-before

| Measure | n | batched-before | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.208 s | 0.208 s | +0.2% | -2.7, +3.3 | within ±5% |
| calls, 20 connections | 60 | 0.819 s | 0.808 s | -1.3% | -4.6, +2.0 | within ±5% |
| signals, burst to 1 | 60 | 0.446 s | 0.438 s | -1.7% | -5.4, +2.3 | within ±5% |
| signals, broadcast to 20 | 60 | 0.498 s | 0.504 s | +1.3% | -2.2, +4.6 | within ±5% |
| RTT, 1 connection, p50 | 60 | 178 µs | 178 µs | +0.3% | -1.3, +2.0 | within ±5% |
| RTT, 1 connection, p99 | 60 | 328 µs | 325 µs | -1.0% | -5.0, +3.0 | within ±5% |
| RTT, 20 connections, p50 | 60 | 715 µs | 737 µs | +3.2% | -0.1, +6.6 | inconclusive |
| RTT, 20 connections, p99 | 60 | 1502 µs | 1617 µs | +7.6% | +1.4, +14.2 | inconclusive* |
| delivery to 20, p50 | 60 | 28.3 ms | 28.5 ms | +0.7% | -3.5, +4.7 | within ±5% |
| delivery to 20, p99 | 60 | 40.9 ms | 43.5 ms | +6.3% | -1.3, +14.6 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.270 s | 0.268 s | -0.8% | -4.5, +3.1 | within ±5% |
| 100 proxies, 1 connection | 40 | 3.61 s | 3.65 s | +1.1% | -1.5, +3.8 | within ±5% |
| 100 connections | 40 | 4.34 s | 4.27 s | -1.4% | -3.6, +0.7 | within ±5% |
| calls, broker CPU | 60 | 0.70 s | 0.71 s | +0.9% | -1.9, +3.8 | within ±5% |
| signals, broker CPU | 60 | 0.51 s | 0.50 s | -2.2% | -5.9, +1.6 | inconclusive |
| latency, broker CPU | 60 | 1.14 s | 1.15 s | +1.0% | -1.1, +3.1 | within ±5% |
| shared, broker CPU | 40 | 5.50 s | 5.49 s | -0.1% | -2.4, +2.0 | within ±5% |
| calls, broker system time | 60 | 0.32 s | 0.34 s | +5.8% | +0.8, +11.3 | inconclusive* |
| signals, broker system time | 60 | 0.16 s | 0.15 s | -8.7% | -17.1, +0.7 | inconclusive |
| latency, broker system time | 60 | 0.61 s | 0.62 s | +2.2% | -1.1, +5.4 | within ±5% |
| shared, broker system time | 40 | 2.52 s | 2.52 s | -0.3% | -4.3, +3.5 | within ±5% |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.8 MiB | -0.7% | -1.3, +0.1 | within ±5% |
| signals, broker peak RSS | 60 | 4.8 MiB | 4.8 MiB | -0.6% | -1.2, +0.0 | within ±5% |
| latency, broker peak RSS | 60 | 5.0 MiB | 5.0 MiB | -0.0% | -0.7, +0.6 | within ±5% |
| shared, broker peak RSS | 40 | 6.9 MiB | 7.0 MiB | +1.3% | -0.0, +2.7 | within ±5% |

The signals of the benchmark, of 1,172 bytes each, go up to 14 to a batch, the 14th taking it past
16 KiB, and batched writes a batch of 14 to a subscriber with one system call, of 16,408 bytes,
where batched-before wrote 13 and then 1. In a run of the signals client against each, under strace,
batched-before wrote the signals to their subscribers with 17,045 system calls, 8,200 of 13 signals
and as many of 1, and batched with 9,386, 7,500 of them of 14 signals, for 120,000 deliveries, where
baseline makes a write for each.

### batched against baseline

| Measure | n | baseline | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.200 s | 0.208 s | +4.4% | +1.6, +7.4 | inconclusive* |
| calls, 20 connections | 60 | 0.800 s | 0.808 s | +1.0% | -2.6, +4.8 | within ±5% |
| signals, burst to 1 | 60 | 0.480 s | 0.438 s | -8.8% | -12.4, -4.9 | inconclusive* |
| signals, broadcast to 20 | 60 | 0.569 s | 0.504 s | -11.4% | -14.3, -8.3 | **better** |
| RTT, 1 connection, p50 | 60 | 177 µs | 178 µs | +0.6% | -1.0, +2.2 | within ±5% |
| RTT, 1 connection, p99 | 60 | 325 µs | 325 µs | +0.0% | -3.6, +3.9 | within ±5% |
| RTT, 20 connections, p50 | 60 | 716 µs | 737 µs | +3.0% | +0.2, +5.8 | inconclusive* |
| RTT, 20 connections, p99 | 60 | 1549 µs | 1617 µs | +4.4% | -2.7, +12.0 | inconclusive |
| delivery to 20, p50 | 60 | 26.8 ms | 28.5 ms | +6.2% | +1.0, +11.4 | inconclusive* |
| delivery to 20, p99 | 60 | 39.5 ms | 43.5 ms | +9.9% | +1.6, +18.6 | inconclusive* |
| delivery to 20, whole fan-out | 60 | 0.305 s | 0.268 s | -12.0% | -15.9, -7.9 | **better** |
| 100 proxies, 1 connection | 40 | 3.71 s | 3.65 s | -1.6% | -4.3, +1.2 | within ±5% |
| 100 connections | 40 | 4.39 s | 4.27 s | -2.6% | -5.4, +0.2 | within ±5% |
| calls, broker CPU | 60 | 0.68 s | 0.71 s | +3.4% | +0.5, +6.5 | inconclusive* |
| signals, broker CPU | 60 | 0.66 s | 0.50 s | -24.1% | -26.5, -21.6 | **better** |
| latency, broker CPU | 60 | 1.18 s | 1.15 s | -2.7% | -4.6, -0.8 | within ±5%* |
| shared, broker CPU | 40 | 5.56 s | 5.49 s | -1.3% | -4.0, +1.6 | within ±5% |
| calls, broker system time | 60 | 0.32 s | 0.34 s | +6.8% | +1.4, +12.7 | inconclusive* |
| signals, broker system time | 60 | 0.24 s | 0.15 s | -39.2% | -43.7, -33.2 | **better** |
| latency, broker system time | 60 | 0.64 s | 0.62 s | -2.6% | -5.3, +0.2 | within ±5% |
| shared, broker system time | 40 | 2.53 s | 2.52 s | -0.5% | -4.2, +3.4 | within ±5% |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.8 MiB | +1.0% | +0.4, +1.6 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.8 MiB | +0.9% | +0.3, +1.6 | within ±5%* |
| latency, broker peak RSS | 60 | 5.0 MiB | 5.0 MiB | +0.7% | +0.1, +1.3 | within ±5%* |
| shared, broker peak RSS | 40 | 6.9 MiB | 7.0 MiB | +2.2% | +0.8, +3.6 | within ±5%* |

The signals of the latencies take longer each to reach the 20 subscribers, while all of them reach
them sooner: with fewer system calls for each, the bus has more of them on their way at once, which
the delay of each counts, as [the Ryzen 7 7840U](2026-10-24-busd-batched-sends-ryzen-7840u.md) shows
in more detail.

### batched against the queue

| Measure | n | queue | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.205 s | 0.208 s | +1.8% | -1.2, +4.9 | within ±5% |
| calls, 20 connections | 60 | 0.813 s | 0.808 s | -0.5% | -3.6, +2.8 | within ±5% |
| signals, burst to 1 | 60 | 0.603 s | 0.438 s | -27.4% | -29.9, -24.7 | **better** |
| signals, broadcast to 20 | 60 | 0.571 s | 0.504 s | -11.8% | -14.5, -8.8 | **better** |
| RTT, 1 connection, p50 | 60 | 178 µs | 178 µs | +0.3% | -1.5, +2.1 | within ±5% |
| RTT, 1 connection, p99 | 60 | 325 µs | 325 µs | +0.1% | -3.5, +3.7 | within ±5% |
| RTT, 20 connections, p50 | 60 | 730 µs | 737 µs | +1.0% | -2.2, +4.2 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1590 µs | 1617 µs | +1.7% | -3.7, +7.3 | inconclusive |
| delivery to 20, p50 | 60 | 68.7 ms | 28.5 ms | -58.5% | -60.4, -56.7 | **better** |
| delivery to 20, p99 | 60 | 118.2 ms | 43.5 ms | -63.2% | -65.4, -61.0 | **better** |
| delivery to 20, whole fan-out | 60 | 0.314 s | 0.268 s | -14.5% | -18.0, -11.0 | **better** |
| 100 proxies, 1 connection | 40 | 3.40 s | 3.65 s | +7.3% | +5.1, +9.8 | **worse** |
| 100 connections | 40 | 4.38 s | 4.27 s | -2.4% | -5.0, +0.2 | within ±5% |
| calls, broker CPU | 60 | 0.71 s | 0.71 s | -0.7% | -4.4, +3.3 | within ±5% |
| signals, broker CPU | 60 | 0.72 s | 0.50 s | -30.2% | -32.4, -27.9 | **better** |
| latency, broker CPU | 60 | 1.21 s | 1.15 s | -4.7% | -6.7, -2.7 | inconclusive* |
| shared, broker CPU | 40 | 5.75 s | 5.49 s | -4.5% | -6.6, -2.4 | inconclusive* |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.8 MiB | +0.1% | -0.5, +0.8 | within ±5% |
| signals, broker peak RSS | 60 | 51.2 MiB | 4.8 MiB | -90.6% | -90.8, -90.4 | **better** |
| latency, broker peak RSS | 60 | 6.2 MiB | 5.0 MiB | -19.0% | -19.5, -18.4 | **better** |
| shared, broker peak RSS | 40 | 7.3 MiB | 7.0 MiB | -3.6% | -4.8, -2.2 | within ±5%* |

### batched against dbus-broker

| Measure | n | dbus-broker | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.208 s | 0.208 s | +0.3% | -2.3, +3.0 | within ±5% |
| calls, 20 connections | 60 | 1.248 s | 0.808 s | -35.2% | -37.2, -33.1 | **better** |
| signals, burst to 1 | 60 | 0.487 s | 0.438 s | -10.0% | -13.3, -6.6 | **better** |
| signals, broadcast to 20 | 60 | 0.667 s | 0.504 s | -24.4% | -26.9, -21.8 | **better** |
| RTT, 1 connection, p50 | 60 | 178 µs | 178 µs | +0.2% | -1.3, +1.8 | within ±5% |
| RTT, 1 connection, p99 | 60 | 327 µs | 325 µs | -0.6% | -4.3, +3.3 | within ±5% |
| RTT, 20 connections, p50 | 60 | 1211 µs | 737 µs | -39.1% | -40.8, -37.2 | **better** |
| RTT, 20 connections, p99 | 60 | 2604 µs | 1617 µs | -37.9% | -41.5, -34.1 | **better** |
| delivery to 20, p50 | 60 | 71.3 ms | 28.5 ms | -60.0% | -61.6, -58.5 | **better** |
| delivery to 20, p99 | 60 | 130.2 ms | 43.5 ms | -66.6% | -68.8, -64.4 | **better** |
| delivery to 20, whole fan-out | 60 | 0.344 s | 0.268 s | -22.1% | -24.9, -19.1 | **better** |
| 100 proxies, 1 connection | 40 | 3.72 s | 3.65 s | -2.1% | -4.9, +1.1 | within ±5% |
| 100 connections | 40 | 7.00 s | 4.27 s | -38.9% | -40.4, -37.5 | **better** |
| calls, broker CPU | 60 | 0.60 s | 0.71 s | +18.4% | +15.0, +22.1 | **worse** |
| signals, broker CPU | 60 | 0.52 s | 0.50 s | -4.7% | -7.7, -1.6 | inconclusive* |
| latency, broker CPU | 60 | 1.01 s | 1.15 s | +14.1% | +12.0, +16.2 | **worse** |
| shared, broker CPU | 40 | 4.25 s | 5.49 s | +29.3% | +26.0, +32.6 | **worse** |
| calls, broker peak RSS | 60 | 7.1 MiB | 4.8 MiB | -32.6% | -33.0, -32.2 | **better** |
| signals, broker peak RSS | 60 | 40.8 MiB | 4.8 MiB | -88.2% | -88.3, -88.2 | **better** |
| latency, broker peak RSS | 60 | 10.8 MiB | 5.0 MiB | -53.9% | -54.2, -53.7 | **better** |
| shared, broker peak RSS | 40 | 8.3 MiB | 7.0 MiB | -15.8% | -16.7, -15.0 | **better** |

### batched against dbus-daemon

| Measure | n | dbus-daemon | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.224 s | 0.208 s | -6.9% | -9.6, -4.0 | inconclusive* |
| calls, 20 connections | 60 | 0.963 s | 0.808 s | -16.0% | -18.8, -13.2 | **better** |
| signals, burst to 1 | 60 | 0.549 s | 0.438 s | -20.2% | -23.8, -16.3 | **better** |
| signals, broadcast to 20 | 60 | 0.756 s | 0.504 s | -33.3% | -35.3, -31.1 | **better** |
| RTT, 1 connection, p50 | 60 | 191 µs | 178 µs | -6.5% | -8.0, -4.9 | inconclusive* |
| RTT, 1 connection, p99 | 60 | 350 µs | 325 µs | -7.3% | -11.4, -3.3 | inconclusive* |
| RTT, 20 connections, p50 | 60 | 843 µs | 737 µs | -12.5% | -15.6, -9.3 | **better** |
| RTT, 20 connections, p99 | 60 | 2053 µs | 1617 µs | -21.3% | -25.8, -16.6 | **better** |
| delivery to 20, p50 | 60 | 60.5 ms | 28.5 ms | -52.9% | -55.5, -50.1 | **better** |
| delivery to 20, p99 | 60 | 196.7 ms | 43.5 ms | -77.9% | -79.3, -76.4 | **better** |
| delivery to 20, whole fan-out | 60 | 0.401 s | 0.268 s | -33.1% | -35.9, -30.0 | **better** |
| 100 proxies, 1 connection | 40 | 4.13 s | 3.65 s | -11.7% | -13.7, -9.7 | **better** |
| 100 connections | 40 | 5.42 s | 4.27 s | -21.2% | -23.0, -19.3 | **better** |
| calls, broker CPU | 60 | 1.03 s | 0.71 s | -31.7% | -33.8, -29.4 | **better** |
| signals, broker CPU | 60 | 0.94 s | 0.50 s | -47.0% | -48.9, -44.9 | **better** |
| latency, broker CPU | 60 | 1.64 s | 1.15 s | -29.9% | -31.5, -28.3 | **better** |
| shared, broker CPU | 40 | 9.02 s | 5.49 s | -39.2% | -40.4, -37.9 | **better** |
| calls, broker peak RSS | 60 | 4.9 MiB | 4.8 MiB | -1.9% | -2.4, -1.4 | within ±5%* |
| signals, broker peak RSS | 60 | 7.6 MiB | 4.8 MiB | -36.9% | -38.3, -35.7 | **better** |
| latency, broker peak RSS | 60 | 6.0 MiB | 5.0 MiB | -16.5% | -17.0, -16.0 | **better** |
| shared, broker peak RSS | 40 | 7.0 MiB | 7.0 MiB | +0.3% | -0.9, +1.5 | within ±5% |

### The connection that 100 proxies share

A call of this phase, of 16 KiB, takes a batch past 16 KiB, and batched writes it to the client
along with the replies before it in its batch, where batched-before wrote the replies with one
system call and the call with another. Taking the multi-client phase's CPU time out of each run's
whole, the phase's means are:

| Broker | Phase | Client CPU | Broker CPU | Client's waits | Broker's waits |
|---|---:|---:|---:|---:|---:|
| baseline | 3.71 s | 3.44 s | 2.30 s | 10858 | 18781 |
| batched-before | 3.61 s | 3.35 s | 2.24 s | 10649 | 18602 |
| batched | 3.65 s | 3.38 s | 2.25 s | 10657 | 18508 |
| queue | 3.40 s | 3.14 s | 2.37 s | 16670 | 16948 |
| dbus-broker | 3.72 s | 3.67 s | 1.64 s | 206 | 203966 |
| dbus-daemon | 4.13 s | 3.59 s | 3.85 s | 56182 | 3659 |

The client's and the broker's waits are their voluntary context switches, over both phases.

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at 18444f8 builds the brokers and runs all of this, in about 67 minutes on this VM once the
builds are made, and writes these files to `$WORK/batched-sends-results-ac6e6fa`, with the
comparisons in pairs next to the others rather than in `stats`.
