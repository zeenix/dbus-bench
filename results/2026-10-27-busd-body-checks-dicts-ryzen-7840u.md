# What checking bodies costs busd, with dicts of variants, on a Ryzen 7 7840U

Measured on 2026-10-27 on the laptop of [busd checking the messages of its
clients](2026-10-27-busd-message-checks-ryzen-7840u.md): an AMD Ryzen 7 7840U (8 cores, 16 threads),
running Fedora 44 with Linux 7.1.13. It ran `scripts/compare-batched-sends.sh` at a3c1280, which
made every build of busd with rustc 1.99.0. dbus-broker 37 and dbus-daemon 1.16.2 are Fedora's.
Compare the brokers with each other, within this file only.

The builds of busd and the clients are those of [the run on a 4-vCPU
Xeon](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md), which describes them: **before**, 227254e,
busd's main branch, on zbus 50c54bf; **after**, fd577a2 of zeenix/busd, the head of
z-galaxy/busd#391, on zbus 8cb16a2, the head of z-galaxy/zbus#2086, which checks the messages of its
clients as a whole, and their bodies against their signatures, passes on only the replies that
answer a call that waits for one, and sets the sender of a message that a client leaves it out of
with `Message::with_sender`; and **unchecked**, after without the check of bodies. The clients leave
the sender out of every message that is timed, as libdbus, GLib and sd-bus clients do, and the
`dicts` workload makes the method calls with a body of 100 variants, `a{sa{sv}}`, of 4242 bytes.

## Summary

* Checking the bodies costs busd nothing measurable on the workloads of byte arrays: after against
  unchecked is within ±5% on every measure of them but four, which are inconclusive and differ by
  2.9% at most: the p99s of the round trips of 20 clients and of the fan-out, the 100 clients, and
  the user time of the shared phases.
* With the dicts, it costs busd 13.0% more CPU time and 28.7% more user time, 0.050 s for the
  21,000 calls of a run (from 0.045 to 0.054 s): about 2.4 µs of CPU time for each call, against
  5.6 µs on the Xeon. The calls of 20 clients take 13.9% longer for it (from +12.5 to +15.3%), and
  those of one client as long, within ±5%.
* after takes as long as before on the dicts, within ±5% (+1.6% with 20 clients, with 1.3% more CPU
  time), as setting the sender of each call and of each reply with `Message::with_sender` saves
  about what the check of the call costs. On the other workloads, after takes 8 to 25% less time
  than before with many clients and on the signals, with 10 to 19% less CPU time: 10.4% less on the
  calls of 20 clients, 24.5% less on the burst of signals, 12.8% less on the median round trip of 20
  clients, and 12.0% and 9.0% less (inconclusive, but repeatable) on the shared phases. With one
  client, it takes 4 to 5% less (within ±5%, or inconclusive).
* busd is faster than dbus-broker on the dicts of 20 clients, which dbus-broker checks too: after
  takes 28.8% less time, with 25.7% less CPU time, and before 29.9% less. With one client, both are
  level with it, within ±5%.
* On the other workloads, after closes most of the gap that clients that leave the sender out open
  between before and dbus-broker. With 20 clients, its calls take 7.1% longer than dbus-broker's
  (before: 19.4%) and its median round trip 6.8% longer (before: 22.5%); with one client, 17.0%
  and 22.6% longer (before: 22.7% and 28.2%); and with 100 clients 29.1% longer (before: 41.8%).
  It is faster on the burst of signals by 21.6%, where before was 3.9% slower, on the broadcast by
  59.5% and on the fan-out of the latencies by 46.1% at the median.
* No run of any broker failed.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | +22.7% | +17.0% |
| calls, 20 clients | +19.4% | +7.1% |
| dict calls, 1 client | +0.5% | -1.1% |
| dict calls, 20 clients | -29.9% | -28.8% |
| signals, burst to 1 | +3.9% | -21.6% |
| signals, broadcast to 20 | -55.9% | -59.5% |
| RTT, 1 client, p50 | +28.2% | +22.6% |
| RTT, 20 clients, p50 | +22.5% | +6.8% |
| RTT, 20 clients, p99 | +21.2% | +7.9% |
| delivery to 20, whole fan-out | -58.0% | -58.3% |
| 100 callers, 1 connection | +26.4% | +11.3% |
| 100 clients | +41.8% | +29.1% |
| calls, broker CPU | +24.7% | +12.2% |
| dicts, broker CPU | -26.6% | -25.7% |
| signals, broker CPU | -23.4% | -37.9% |
| latency, broker CPU | +19.3% | +6.9% |
| shared, broker CPU | +36.4% | +20.6% |

## What leaving the sender out costs each broker

This run and [the run of before](2026-10-27-busd-message-checks-ryzen-7840u.md) on this laptop
differ in the clients, which set the sender there, but for after, which was 50bf523 there, and runs
the same code as fd577a2 for such clients. How much longer each broker takes with the clients that
leave the sender out, from the means of the two runs, which are not paired:

| Measure | before | after | dbus-broker | dbus-daemon |
|---|---:|---:|---:|---:|
| calls, 1 client | +18.2% | +11.6% | +11.1% | +8.4% |
| calls, 20 clients | +12.3% | -0.5% | -0.4% | -2.2% |
| signals, burst to 1 | +46.8% | +8.5% | +2.8% | -3.6% |
| signals, broadcast to 20 | +10.7% | -0.8% | +0.2% | +3.4% |
| RTT, 1 client, p50 | +10.4% | +5.1% | +4.1% | +2.4% |
| RTT, 20 clients, p50 | +21.6% | +4.3% | -0.1% | -1.0% |
| delivery to 20, whole fan-out | +10.3% | +1.7% | +1.3% | +3.7% |
| 100 callers, 1 connection | +19.1% | +4.0% | +1.0% | -2.3% |
| 100 clients | +17.3% | +8.6% | +2.6% | -0.5% |
| calls, broker CPU | +13.2% | +0.8% | -0.0% | -1.9% |
| signals, broker CPU | +31.2% | +4.2% | +1.7% | +1.3% |
| latency, broker CPU | +18.0% | +4.2% | +2.0% | +0.9% |
| shared, broker CPU | +20.1% | +7.5% | +2.3% | -1.4% |

dbus-broker and dbus-daemon take as long, within 4%, with these clients, but on the calls of one
client, which take 8 to 11% longer with every broker: there the clients themselves take longer.
Against them, messages without a sender cost before 11 to 47% more, and after 9% more at most.

## The benchmarks

The workloads and the comparisons are those of [the run on the
Xeon](2026-10-27-busd-body-checks-dicts-xeon-4vcpu.md#the-benchmarks): 60 rounds of each workload,
and 40 of the shared phases, after 3 of warm-up, all five brokers in each round. The raw results are
in [runs.tar.xz](2026-10-27-busd-body-checks-dicts-ryzen-7840u/runs.tar.xz). The values are means
over the rounds, and a star marks a difference whose 95% interval excludes 0 but not the margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.082 s | 0.078 s | -4.7% | -6.1, -3.2 | inconclusive* |
| calls, 20 clients | 60 | 0.379 s | 0.340 s | -10.4% | -11.3, -9.4 | **better** |
| signals, burst to 1 | 60 | 0.191 s | 0.144 s | -24.5% | -25.3, -23.8 | **better** |
| signals, broadcast to 20 | 60 | 0.086 s | 0.079 s | -8.3% | -9.7, -6.9 | **better** |
| RTT, 1 client, p50 | 60 | 65 µs | 62 µs | -4.3% | -4.7, -4.0 | within ±5%* |
| RTT, 1 client, p99 | 60 | 201 µs | 187 µs | -7.0% | -12.3, -1.5 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 375 µs | 327 µs | -12.8% | -13.6, -12.0 | **better** |
| RTT, 20 clients, p99 | 60 | 575 µs | 512 µs | -11.0% | -17.8, -3.6 | inconclusive* |
| delivery to 20, p50 | 60 | 1.2 ms | 1.1 ms | -9.8% | -11.9, -7.9 | **better** |
| delivery to 20, p99 | 60 | 2.2 ms | 2.1 ms | -4.7% | -10.7, +2.1 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.032 s | 0.029 s | -8.6% | -10.5, -6.6 | **better** |
| 100 callers, 1 connection | 40 | 1.66 s | 1.46 s | -12.0% | -14.5, -9.4 | **better** |
| 100 clients | 40 | 2.75 s | 2.50 s | -9.0% | -14.7, -3.3 | inconclusive* |
| dict calls, 1 client | 60 | 0.095 s | 0.093 s | -1.5% | -3.7, +0.6 | within ±5% |
| dict calls, 20 clients | 60 | 0.379 s | 0.385 s | +1.6% | -0.2, +3.1 | within ±5% |
| calls, broker CPU | 60 | 0.43 s | 0.38 s | -10.0% | -10.8, -9.3 | **better** |
| signals, broker CPU | 60 | 0.30 s | 0.24 s | -19.0% | -19.6, -18.4 | **better** |
| latency, broker CPU | 60 | 0.61 s | 0.54 s | -10.4% | -11.3, -9.5 | **better** |
| shared, broker CPU | 40 | 4.35 s | 3.85 s | -11.5% | -15.4, -7.8 | **better** |
| dicts, broker CPU | 60 | 0.43 s | 0.43 s | +1.3% | -0.5, +2.8 | within ±5% |
| calls, broker user time | 60 | 0.21 s | 0.16 s | -23.7% | -25.4, -21.8 | **better** |
| signals, broker user time | 60 | 0.17 s | 0.11 s | -36.7% | -38.0, -35.4 | **better** |
| latency, broker user time | 60 | 0.29 s | 0.22 s | -23.6% | -25.3, -22.0 | **better** |
| shared, broker user time | 40 | 2.13 s | 1.65 s | -22.7% | -26.9, -18.7 | **better** |
| dicts, broker user time | 60 | 0.22 s | 0.22 s | -1.1% | -3.6, +1.4 | within ±5% |
| calls, broker system time | 60 | 0.22 s | 0.22 s | +3.1% | +1.3, +5.1 | within ±5%* |
| signals, broker system time | 60 | 0.13 s | 0.14 s | +3.3% | +1.1, +5.6 | inconclusive* |
| latency, broker system time | 60 | 0.31 s | 0.32 s | +1.8% | +0.1, +3.6 | within ±5%* |
| shared, broker system time | 40 | 2.22 s | 2.21 s | -0.8% | -4.8, +3.0 | within ±5% |
| dicts, broker system time | 60 | 0.21 s | 0.22 s | +3.8% | +1.6, +5.9 | inconclusive* |
| calls, broker peak RSS | 60 | 6.8 MiB | 7.0 MiB | +2.0% | +1.3, +2.6 | within ±5%* |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.3 MiB | +1.9% | +1.2, +2.6 | within ±5%* |
| latency, broker peak RSS | 60 | 7.1 MiB | 7.2 MiB | +1.4% | +0.8, +2.0 | within ±5%* |
| shared, broker peak RSS | 40 | 13.5 MiB | 13.7 MiB | +1.1% | -0.4, +2.6 | within ±5% |
| dicts, broker peak RSS | 60 | 6.7 MiB | 6.8 MiB | +1.6% | +0.9, +2.4 | within ±5%* |

### after against unchecked

| Measure | n | unchecked | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.079 s | 0.078 s | -1.3% | -2.8, +0.3 | within ±5% |
| calls, 20 clients | 60 | 0.338 s | 0.340 s | +0.5% | -0.6, +1.5 | within ±5% |
| signals, burst to 1 | 60 | 0.143 s | 0.144 s | +0.9% | -0.3, +2.1 | within ±5% |
| signals, broadcast to 20 | 60 | 0.079 s | 0.079 s | +0.3% | -1.1, +1.6 | within ±5% |
| RTT, 1 client, p50 | 60 | 62 µs | 62 µs | -0.3% | -0.6, +0.1 | within ±5% |
| RTT, 1 client, p99 | 60 | 187 µs | 187 µs | +0.1% | -5.0, +5.3 | within ±5% |
| RTT, 20 clients, p50 | 60 | 325 µs | 327 µs | +0.7% | -0.3, +1.8 | within ±5% |
| RTT, 20 clients, p99 | 60 | 498 µs | 512 µs | +2.9% | -6.9, +13.5 | inconclusive |
| delivery to 20, p50 | 60 | 1.1 ms | 1.1 ms | -0.9% | -3.1, +1.4 | within ±5% |
| delivery to 20, p99 | 60 | 2.1 ms | 2.1 ms | -1.8% | -8.3, +5.3 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.029 s | 0.029 s | -0.7% | -2.9, +1.5 | within ±5% |
| 100 callers, 1 connection | 40 | 1.50 s | 1.46 s | -2.6% | -5.2, -0.0 | within ±5%* |
| 100 clients | 40 | 2.44 s | 2.50 s | +2.5% | -2.0, +7.9 | inconclusive |
| dict calls, 1 client | 60 | 0.092 s | 0.093 s | +1.2% | -0.6, +3.2 | within ±5% |
| dict calls, 20 clients | 60 | 0.338 s | 0.385 s | +13.9% | +12.5, +15.3 | **worse** |
| calls, broker CPU | 60 | 0.38 s | 0.38 s | +0.1% | -0.6, +0.8 | within ±5% |
| signals, broker CPU | 60 | 0.24 s | 0.24 s | +0.6% | -0.3, +1.5 | within ±5% |
| latency, broker CPU | 60 | 0.54 s | 0.54 s | +0.5% | -0.6, +1.5 | within ±5% |
| shared, broker CPU | 40 | 3.83 s | 3.85 s | +0.5% | -2.7, +4.1 | within ±5% |
| dicts, broker CPU | 60 | 0.38 s | 0.43 s | +13.0% | +11.9, +14.1 | **worse** |
| calls, broker user time | 60 | 0.16 s | 0.16 s | -1.9% | -4.2, +0.7 | within ±5% |
| signals, broker user time | 60 | 0.10 s | 0.11 s | +1.4% | -1.1, +4.1 | within ±5% |
| latency, broker user time | 60 | 0.22 s | 0.22 s | -0.4% | -2.6, +1.8 | within ±5% |
| shared, broker user time | 40 | 1.61 s | 1.65 s | +2.1% | -1.8, +6.4 | inconclusive |
| dicts, broker user time | 60 | 0.17 s | 0.22 s | +28.7% | +25.5, +32.0 | **worse** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | +1.6% | -0.0, +3.1 | within ±5% |
| signals, broker system time | 60 | 0.14 s | 0.14 s | -0.0% | -2.1, +2.0 | within ±5% |
| latency, broker system time | 60 | 0.32 s | 0.32 s | +1.1% | -0.7, +3.0 | within ±5% |
| shared, broker system time | 40 | 2.22 s | 2.21 s | -0.7% | -3.7, +2.6 | within ±5% |
| dicts, broker system time | 60 | 0.21 s | 0.22 s | +0.6% | -1.1, +2.5 | within ±5% |
| calls, broker peak RSS | 60 | 6.9 MiB | 7.0 MiB | +0.7% | +0.0, +1.4 | within ±5%* |
| signals, broker peak RSS | 60 | 6.3 MiB | 6.3 MiB | -0.3% | -1.0, +0.4 | within ±5% |
| latency, broker peak RSS | 60 | 7.2 MiB | 7.2 MiB | +0.1% | -0.5, +0.6 | within ±5% |
| shared, broker peak RSS | 40 | 13.6 MiB | 13.7 MiB | +0.3% | -1.3, +1.8 | within ±5% |
| dicts, broker peak RSS | 60 | 6.8 MiB | 6.8 MiB | +0.3% | -0.4, +1.1 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.067 s | 0.078 s | +17.0% | +15.3, +18.7 | **worse** |
| calls, 20 clients | 60 | 0.317 s | 0.340 s | +7.1% | +5.3, +8.8 | **worse** |
| signals, burst to 1 | 60 | 0.184 s | 0.144 s | -21.6% | -22.4, -20.7 | **better** |
| signals, broadcast to 20 | 60 | 0.195 s | 0.079 s | -59.5% | -59.9, -59.1 | **better** |
| RTT, 1 client, p50 | 60 | 51 µs | 62 µs | +22.6% | +21.7, +23.6 | **worse** |
| RTT, 1 client, p99 | 60 | 169 µs | 187 µs | +10.5% | +5.3, +15.5 | **worse** |
| RTT, 20 clients, p50 | 60 | 306 µs | 327 µs | +6.8% | +5.2, +8.3 | **worse** |
| RTT, 20 clients, p99 | 60 | 475 µs | 512 µs | +7.9% | -0.9, +17.3 | inconclusive |
| delivery to 20, p50 | 60 | 2.1 ms | 1.1 ms | -46.1% | -46.9, -45.3 | **better** |
| delivery to 20, p99 | 60 | 3.6 ms | 2.1 ms | -41.5% | -44.5, -38.3 | **better** |
| delivery to 20, whole fan-out | 60 | 0.069 s | 0.029 s | -58.2% | -58.8, -57.5 | **better** |
| 100 callers, 1 connection | 40 | 1.31 s | 1.46 s | +11.3% | +9.4, +13.3 | **worse** |
| 100 clients | 40 | 1.94 s | 2.50 s | +29.1% | +23.4, +35.8 | **worse** |
| dict calls, 1 client | 60 | 0.094 s | 0.093 s | -1.1% | -2.9, +0.8 | within ±5% |
| dict calls, 20 clients | 60 | 0.541 s | 0.385 s | -28.8% | -29.9, -27.9 | **better** |
| calls, broker CPU | 60 | 0.34 s | 0.38 s | +12.2% | +10.7, +13.8 | **worse** |
| signals, broker CPU | 60 | 0.39 s | 0.24 s | -37.9% | -38.4, -37.4 | **better** |
| latency, broker CPU | 60 | 0.51 s | 0.54 s | +6.9% | +5.6, +8.2 | **worse** |
| shared, broker CPU | 40 | 3.19 s | 3.85 s | +20.6% | +17.2, +24.6 | **worse** |
| dicts, broker CPU | 60 | 0.58 s | 0.43 s | -25.7% | -26.7, -24.8 | **better** |
| calls, broker user time | 60 | 0.12 s | 0.16 s | +37.7% | +33.8, +41.6 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.11 s | -18.8% | -20.6, -16.8 | **better** |
| latency, broker user time | 60 | 0.17 s | 0.22 s | +33.5% | +30.1, +36.9 | **worse** |
| shared, broker user time | 40 | 1.03 s | 1.65 s | +59.4% | +52.8, +66.8 | **worse** |
| dicts, broker user time | 60 | 0.37 s | 0.22 s | -41.3% | -42.7, -40.0 | **better** |
| calls, broker system time | 60 | 0.23 s | 0.22 s | -0.8% | -3.0, +1.5 | within ±5% |
| signals, broker system time | 60 | 0.26 s | 0.14 s | -47.5% | -48.3, -46.6 | **better** |
| latency, broker system time | 60 | 0.34 s | 0.32 s | -6.1% | -7.7, -4.4 | inconclusive* |
| shared, broker system time | 40 | 2.16 s | 2.21 s | +2.1% | -0.5, +5.2 | within ±5% |
| dicts, broker system time | 60 | 0.21 s | 0.22 s | +1.5% | -0.6, +3.6 | within ±5% |
| calls, broker peak RSS | 60 | 8.1 MiB | 7.0 MiB | -14.3% | -15.0, -13.7 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.3 MiB | -22.9% | -23.6, -22.1 | **better** |
| latency, broker peak RSS | 60 | 8.1 MiB | 7.2 MiB | -11.9% | -12.4, -11.3 | **better** |
| shared, broker peak RSS | 40 | 9.0 MiB | 13.7 MiB | +51.0% | +49.3, +52.7 | **worse** |
| dicts, broker peak RSS | 60 | 8.0 MiB | 6.8 MiB | -14.8% | -15.4, -14.2 | **better** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.067 s | 0.082 s | +22.7% | +20.6, +24.8 | **worse** |
| calls, 20 clients | 60 | 0.317 s | 0.379 s | +19.4% | +17.6, +21.3 | **worse** |
| signals, burst to 1 | 60 | 0.184 s | 0.191 s | +3.9% | +2.8, +5.0 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.195 s | 0.086 s | -55.9% | -56.5, -55.2 | **better** |
| RTT, 1 client, p50 | 60 | 51 µs | 65 µs | +28.2% | +27.2, +29.2 | **worse** |
| RTT, 1 client, p99 | 60 | 169 µs | 201 µs | +18.8% | +13.8, +24.0 | **worse** |
| RTT, 20 clients, p50 | 60 | 306 µs | 375 µs | +22.5% | +20.7, +24.2 | **worse** |
| RTT, 20 clients, p99 | 60 | 475 µs | 575 µs | +21.2% | +11.7, +31.5 | **worse** |
| delivery to 20, p50 | 60 | 2.1 ms | 1.2 ms | -40.2% | -41.5, -38.8 | **better** |
| delivery to 20, p99 | 60 | 3.6 ms | 2.2 ms | -38.7% | -41.6, -35.4 | **better** |
| delivery to 20, whole fan-out | 60 | 0.069 s | 0.032 s | -54.2% | -55.1, -53.3 | **better** |
| 100 callers, 1 connection | 40 | 1.31 s | 1.66 s | +26.4% | +23.7, +29.3 | **worse** |
| 100 clients | 40 | 1.94 s | 2.75 s | +41.8% | +35.0, +50.1 | **worse** |
| dict calls, 1 client | 60 | 0.094 s | 0.095 s | +0.5% | -1.6, +2.6 | within ±5% |
| dict calls, 20 clients | 60 | 0.541 s | 0.379 s | -29.9% | -31.1, -28.6 | **better** |
| calls, broker CPU | 60 | 0.34 s | 0.43 s | +24.7% | +23.0, +26.4 | **worse** |
| signals, broker CPU | 60 | 0.39 s | 0.30 s | -23.4% | -24.1, -22.8 | **better** |
| latency, broker CPU | 60 | 0.51 s | 0.61 s | +19.3% | +17.8, +20.8 | **worse** |
| shared, broker CPU | 40 | 3.19 s | 4.35 s | +36.4% | +31.8, +41.9 | **worse** |
| dicts, broker CPU | 60 | 0.58 s | 0.43 s | -26.6% | -27.8, -25.2 | **better** |
| calls, broker user time | 60 | 0.12 s | 0.21 s | +80.4% | +76.0, +85.1 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.17 s | +28.3% | +25.6, +31.1 | **worse** |
| latency, broker user time | 60 | 0.17 s | 0.29 s | +74.8% | +71.2, +78.5 | **worse** |
| shared, broker user time | 40 | 1.03 s | 2.13 s | +106.2% | +99.1, +115.1 | **worse** |
| dicts, broker user time | 60 | 0.37 s | 0.22 s | -40.7% | -42.0, -39.2 | **better** |
| calls, broker system time | 60 | 0.23 s | 0.22 s | -3.7% | -5.9, -1.7 | inconclusive* |
| signals, broker system time | 60 | 0.26 s | 0.13 s | -49.2% | -50.1, -48.2 | **better** |
| latency, broker system time | 60 | 0.34 s | 0.31 s | -7.8% | -9.4, -6.1 | **better** |
| shared, broker system time | 40 | 2.16 s | 2.22 s | +3.0% | -0.6, +7.0 | inconclusive |
| dicts, broker system time | 60 | 0.21 s | 0.21 s | -2.2% | -4.7, +0.5 | within ±5% |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.8 MiB | -16.0% | -16.5, -15.5 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.2 MiB | -24.3% | -25.1, -23.5 | **better** |
| latency, broker peak RSS | 60 | 8.1 MiB | 7.1 MiB | -13.1% | -13.6, -12.6 | **better** |
| shared, broker peak RSS | 40 | 9.0 MiB | 13.5 MiB | +49.4% | +47.5, +51.4 | **worse** |
| dicts, broker peak RSS | 60 | 8.0 MiB | 6.7 MiB | -16.2% | -16.7, -15.6 | **better** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.144 s | 0.078 s | -46.0% | -47.0, -45.1 | **better** |
| calls, 20 clients | 60 | 1.224 s | 0.340 s | -72.2% | -72.4, -72.0 | **better** |
| signals, burst to 1 | 60 | 0.849 s | 0.144 s | -83.0% | -83.2, -82.9 | **better** |
| signals, broadcast to 20 | 60 | 2.083 s | 0.079 s | -96.2% | -96.2, -96.2 | **better** |
| RTT, 1 client, p50 | 60 | 97 µs | 62 µs | -36.0% | -36.4, -35.5 | **better** |
| RTT, 1 client, p99 | 60 | 281 µs | 187 µs | -33.3% | -36.5, -30.2 | **better** |
| RTT, 20 clients, p50 | 60 | 1207 µs | 327 µs | -72.9% | -73.1, -72.6 | **better** |
| RTT, 20 clients, p99 | 60 | 1666 µs | 512 µs | -69.3% | -71.5, -67.0 | **better** |
| delivery to 20, p50 | 60 | 21.9 ms | 1.1 ms | -94.9% | -94.9, -94.8 | **better** |
| delivery to 20, p99 | 60 | 34.9 ms | 2.1 ms | -94.0% | -94.3, -93.6 | **better** |
| delivery to 20, whole fan-out | 60 | 0.707 s | 0.029 s | -95.9% | -96.0, -95.8 | **better** |
| 100 callers, 1 connection | 40 | 6.67 s | 1.46 s | -78.1% | -78.5, -77.7 | **better** |
| 100 clients | 40 | 7.09 s | 2.50 s | -64.7% | -66.3, -63.0 | **better** |
| dict calls, 1 client | 60 | 0.158 s | 0.093 s | -41.1% | -42.2, -40.0 | **better** |
| dict calls, 20 clients | 60 | 1.327 s | 0.385 s | -71.0% | -71.2, -70.7 | **better** |
| calls, broker CPU | 60 | 1.31 s | 0.38 s | -70.7% | -70.9, -70.5 | **better** |
| signals, broker CPU | 60 | 2.94 s | 0.24 s | -91.7% | -91.7, -91.7 | **better** |
| latency, broker CPU | 60 | 2.28 s | 0.54 s | -76.2% | -76.5, -76.0 | **better** |
| shared, broker CPU | 40 | 13.73 s | 3.85 s | -71.9% | -72.7, -71.1 | **better** |
| dicts, broker CPU | 60 | 1.42 s | 0.43 s | -69.5% | -69.8, -69.3 | **better** |
| calls, broker user time | 60 | 0.49 s | 0.16 s | -67.3% | -68.0, -66.6 | **better** |
| signals, broker user time | 60 | 0.91 s | 0.11 s | -88.4% | -88.6, -88.2 | **better** |
| latency, broker user time | 60 | 0.79 s | 0.22 s | -72.0% | -72.5, -71.4 | **better** |
| shared, broker user time | 40 | 5.01 s | 1.65 s | -67.2% | -68.4, -65.8 | **better** |
| dicts, broker user time | 60 | 0.70 s | 0.22 s | -69.2% | -69.8, -68.6 | **better** |
| calls, broker system time | 60 | 0.82 s | 0.22 s | -72.7% | -73.1, -72.3 | **better** |
| signals, broker system time | 60 | 2.03 s | 0.14 s | -93.2% | -93.3, -93.1 | **better** |
| latency, broker system time | 60 | 1.49 s | 0.32 s | -78.5% | -78.8, -78.2 | **better** |
| shared, broker system time | 40 | 8.72 s | 2.21 s | -74.7% | -75.3, -74.0 | **better** |
| dicts, broker system time | 60 | 0.71 s | 0.22 s | -69.9% | -70.3, -69.4 | **better** |
| calls, broker peak RSS | 60 | 6.5 MiB | 7.0 MiB | +7.8% | +6.8, +8.9 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.3 MiB | +14.5% | +13.7, +15.3 | **worse** |
| latency, broker peak RSS | 60 | 6.4 MiB | 7.2 MiB | +11.6% | +10.6, +12.6 | **worse** |
| shared, broker peak RSS | 40 | 9.7 MiB | 13.7 MiB | +40.8% | +39.4, +42.2 | **worse** |
| dicts, broker peak RSS | 60 | 5.9 MiB | 6.8 MiB | +14.7% | +13.8, +15.6 | **worse** |

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at a3c1280 builds the brokers and runs all of this, in about 41 minutes on this laptop once the
builds are made, and writes its results to `$WORK/batched-sends-results-fd577a2`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`.
