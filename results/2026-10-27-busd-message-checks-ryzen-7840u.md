# busd checking the messages of its clients, on a Ryzen 7 7840U

Measured on 2026-10-27 on the laptop of [the latest zbus and
zruntime](2026-10-27-busd-dependency-updates-ryzen-7840u.md): an AMD Ryzen 7 7840U (8 cores, 16
threads), running Fedora 44 with Linux 7.1.13. It ran `scripts/compare-batched-sends.sh` at ca174ec,
which made every build of busd with rustc 1.99.0. dbus-broker 37 and dbus-daemon 1.16.2 are
Fedora's. Compare the brokers with each other, within this file only.

The builds of busd and the clients are those of [the run on a 4-vCPU
Xeon](2026-10-27-busd-message-checks-xeon-4vcpu.md), which describes them: **before**, 227254e,
busd's main branch, on zbus 50c54bf; and **after**, 50bf523 of zeenix/busd, then the head of
z-galaxy/busd#391, on zbus ef4be18, then the head of z-galaxy/zbus#2086, which checks the messages
that busd receives as a whole, and their bodies against their signatures, and passes on only the
replies that answer a call that waits for one.

z-galaxy/busd#391 has moved on since, to fd577a2, on zbus 8cb16a2. Its earlier commits are those of
50bf523, but for a fuzz target of zbus, and the new one has busd set the sender of a message that a
client leaves it out of with zbus's new `Message::with_sender`, which copies the bytes of the
message with the field appended, rather than building the message anew. zbus sets the sender of
every message of its clients but their `Hello`, so the clients of this repository have busd set it
for one message of each connection alone: a trace of fd577a2 shows it adding the field to 42
messages for the benchmark of method calls, 23 for `fanout`, 63 for `latency` and 202 for `shared`,
each the `Hello` of one of their connections. So these numbers stand for the head of the pull
request too, on these workloads.

## Summary

* Against before, after is within ±5% on every measure but three inconclusive ones, the two p99s
  below and busd's user time on the signals: its calls take 0.9% longer with one client and 1.1%
  longer with 20, its signals 2.1% longer on the burst to one subscriber and 2.3% longer on the
  broadcast to 20, its median round trip of 20 clients 1.7% longer, and its shared phases 0.9%
  longer and 1.7% shorter. busd uses 1.1 to 2.1% more CPU time on the calls, the signals and the
  latencies, and 1.2% less on the shared phases, with 7.9% more user time on the signals
  (inconclusive, but repeatable), as on the Xeon (8.0%), as it checks the body of each of their
  46,000 signals. Its peak memory is 0.3 to 1.7% higher, up to 118 KiB.
* The p99 of the round trips of 20 clients is 0.6% longer (from -5.4 to +6.8%), where the run of
  the Xeon had it 12.0% longer and three runs there 6.0% longer: that the 20 clients, their
  services and the bus share 4 vCPUs there is the likelier cause of the difference than the checks.
  The other p99 is that of the delays of the signals of the fan-out, 6.8% shorter.
* So the gap to dbus-broker grows by less than 2 points wherever it grows. With 20 clients, busd's
  calls take 7.1% longer than dbus-broker's, against 5.9%, and its median round trip 2.4% longer,
  against 0.7%; with one client, its calls take 16.4% longer, against 15.4%, and its median round
  trip 21.4%, against 20.8%; with 100 clients, busd takes 22.0% longer, against 24.1%. busd stays
  faster on every signal workload: 25.7% on the burst (before: 27.2%), 59.1% on the broadcast
  (60.1%), and 58.3% on the whole fan-out (58.0%).
* The workloads carry byte arrays alone, the cheapest bodies to check, and their clients set the
  sender of each message, as libdbus, GLib and sd-bus clients don't: see [what the workloads leave
  out](2026-10-27-busd-message-checks-xeon-4vcpu.md#what-the-workloads-leave-out).
* No run of any broker failed.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | +15.4% | +16.4% |
| calls, 20 clients | +5.9% | +7.1% |
| signals, burst to 1 | -27.2% | -25.7% |
| signals, broadcast to 20 | -60.1% | -59.1% |
| RTT, 1 client, p50 | +20.8% | +21.4% |
| RTT, 1 client, p99 | +16.4% | +16.8% |
| RTT, 20 clients, p50 | +0.7% | +2.4% |
| RTT, 20 clients, p99 | +2.6% | +3.2% |
| delivery to 20, p50 | -46.0% | -45.7% |
| delivery to 20, p99 | -40.2% | -44.2% |
| delivery to 20, whole fan-out | -58.0% | -58.3% |
| 100 proxies, 1 connection | +7.2% | +8.1% |
| 100 clients | +24.1% | +22.0% |
| calls, broker CPU | +10.1% | +11.4% |
| signals, broker CPU | -40.7% | -39.4% |
| latency, broker CPU | +3.1% | +4.7% |
| shared, broker CPU | +16.1% | +14.8% |

## The benchmarks

The workloads and the comparisons are those of [the run on the
Xeon](2026-10-27-busd-message-checks-xeon-4vcpu.md#the-benchmarks): 60 rounds of each workload, and
40 of the shared phases, after 3 of warm-up, all four brokers in each round. The raw results are in
[runs.tar.xz](2026-10-27-busd-message-checks-ryzen-7840u/runs.tar.xz). The values are means over
the rounds, and a star marks a difference whose 95% interval excludes 0 but not the margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.069 s | 0.070 s | +0.9% | -0.3, +2.3 | within ±5% |
| calls, 20 clients | 60 | 0.338 s | 0.341 s | +1.1% | +0.1, +2.1 | within ±5%* |
| signals, burst to 1 | 60 | 0.130 s | 0.133 s | +2.1% | +0.7, +3.4 | within ±5%* |
| signals, broadcast to 20 | 60 | 0.078 s | 0.080 s | +2.3% | +0.9, +3.8 | within ±5%* |
| RTT, 1 client, p50 | 60 | 59 µs | 59 µs | +0.5% | -0.0, +1.0 | within ±5% |
| RTT, 1 client, p99 | 60 | 126 µs | 126 µs | +0.3% | -3.8, +4.6 | within ±5% |
| RTT, 20 clients, p50 | 60 | 309 µs | 314 µs | +1.7% | +0.6, +2.9 | within ±5%* |
| RTT, 20 clients, p99 | 60 | 464 µs | 466 µs | +0.6% | -5.4, +6.8 | inconclusive |
| delivery to 20, p50 | 60 | 1.1 ms | 1.1 ms | +0.6% | -1.7, +2.8 | within ±5% |
| delivery to 20, p99 | 60 | 2.1 ms | 2.0 ms | -6.8% | -12.1, -1.3 | inconclusive* |
| delivery to 20, whole fan-out | 60 | 0.029 s | 0.028 s | -0.9% | -2.8, +1.1 | within ±5% |
| 100 proxies, 1 connection | 40 | 1.39 s | 1.41 s | +0.9% | -2.6, +3.9 | within ±5% |
| 100 clients | 40 | 2.34 s | 2.30 s | -1.7% | -4.9, +1.6 | within ±5% |
| calls, broker CPU | 60 | 0.38 s | 0.38 s | +1.1% | +0.3, +2.0 | within ±5%* |
| signals, broker CPU | 60 | 0.23 s | 0.23 s | +2.1% | +1.2, +3.0 | within ±5%* |
| latency, broker CPU | 60 | 0.51 s | 0.52 s | +1.5% | +0.6, +2.4 | within ±5%* |
| shared, broker CPU | 40 | 3.62 s | 3.58 s | -1.2% | -3.8, +1.3 | within ±5% |
| calls, broker user time | 60 | 0.15 s | 0.16 s | +2.6% | +0.1, +5.3 | within ±5%* |
| signals, broker user time | 60 | 0.09 s | 0.10 s | +7.9% | +4.8, +11.1 | inconclusive* |
| latency, broker user time | 60 | 0.21 s | 0.21 s | +2.2% | -0.2, +4.7 | within ±5% |
| shared, broker user time | 40 | 1.43 s | 1.42 s | -0.1% | -3.1, +2.9 | within ±5% |
| calls, broker system time | 60 | 0.22 s | 0.22 s | +0.1% | -1.5, +1.6 | within ±5% |
| signals, broker system time | 60 | 0.14 s | 0.14 s | -1.7% | -3.7, +0.3 | within ±5% |
| latency, broker system time | 60 | 0.31 s | 0.31 s | +1.0% | -0.7, +2.7 | within ±5% |
| shared, broker system time | 40 | 2.20 s | 2.16 s | -1.8% | -4.4, +0.7 | within ±5% |
| calls, broker peak RSS | 60 | 6.8 MiB | 7.0 MiB | +1.7% | +1.0, +2.4 | within ±5%* |
| signals, broker peak RSS | 60 | 6.2 MiB | 6.2 MiB | +1.2% | +0.4, +1.9 | within ±5%* |
| latency, broker peak RSS | 60 | 7.1 MiB | 7.2 MiB | +1.0% | +0.4, +1.7 | within ±5%* |
| shared, broker peak RSS | 40 | 13.7 MiB | 13.8 MiB | +0.3% | -1.3, +2.0 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.060 s | 0.070 s | +16.4% | +15.1, +17.8 | **worse** |
| calls, 20 clients | 60 | 0.319 s | 0.341 s | +7.1% | +5.9, +8.4 | **worse** |
| signals, burst to 1 | 60 | 0.179 s | 0.133 s | -25.7% | -26.4, -25.0 | **better** |
| signals, broadcast to 20 | 60 | 0.195 s | 0.080 s | -59.1% | -59.7, -58.5 | **better** |
| RTT, 1 client, p50 | 60 | 49 µs | 59 µs | +21.4% | +20.7, +22.1 | **worse** |
| RTT, 1 client, p99 | 60 | 108 µs | 126 µs | +16.8% | +13.3, +20.3 | **worse** |
| RTT, 20 clients, p50 | 60 | 306 µs | 314 µs | +2.4% | +1.0, +3.8 | within ±5%* |
| RTT, 20 clients, p99 | 60 | 452 µs | 466 µs | +3.2% | -3.4, +10.2 | inconclusive |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -45.7% | -46.8, -44.5 | **better** |
| delivery to 20, p99 | 60 | 3.5 ms | 2.0 ms | -44.2% | -46.7, -41.5 | **better** |
| delivery to 20, whole fan-out | 60 | 0.068 s | 0.028 s | -58.3% | -59.2, -57.4 | **better** |
| 100 proxies, 1 connection | 40 | 1.30 s | 1.41 s | +8.1% | +4.3, +11.9 | inconclusive* |
| 100 clients | 40 | 1.89 s | 2.30 s | +22.0% | +18.4, +25.6 | **worse** |
| calls, broker CPU | 60 | 0.34 s | 0.38 s | +11.4% | +10.2, +12.5 | **worse** |
| signals, broker CPU | 60 | 0.39 s | 0.23 s | -39.4% | -40.0, -38.9 | **better** |
| latency, broker CPU | 60 | 0.50 s | 0.52 s | +4.7% | +3.6, +5.8 | inconclusive* |
| shared, broker CPU | 40 | 3.12 s | 3.58 s | +14.8% | +12.1, +17.5 | **worse** |
| calls, broker user time | 60 | 0.12 s | 0.16 s | +34.4% | +30.9, +38.2 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.10 s | -23.0% | -25.1, -20.9 | **better** |
| latency, broker user time | 60 | 0.17 s | 0.21 s | +26.5% | +23.4, +29.8 | **worse** |
| shared, broker user time | 40 | 1.03 s | 1.42 s | +37.7% | +34.8, +40.7 | **worse** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -0.7% | -2.7, +1.2 | within ±5% |
| signals, broker system time | 60 | 0.26 s | 0.14 s | -47.4% | -48.5, -46.3 | **better** |
| latency, broker system time | 60 | 0.33 s | 0.31 s | -6.4% | -7.9, -4.9 | inconclusive* |
| shared, broker system time | 40 | 2.09 s | 2.16 s | +3.4% | +0.4, +6.4 | inconclusive* |
| calls, broker peak RSS | 60 | 8.1 MiB | 7.0 MiB | -14.2% | -14.8, -13.7 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.2 MiB | -24.0% | -24.9, -23.1 | **better** |
| latency, broker peak RSS | 60 | 8.1 MiB | 7.2 MiB | -12.1% | -12.7, -11.4 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 13.8 MiB | +51.5% | +49.4, +53.5 | **worse** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.060 s | 0.069 s | +15.4% | +14.1, +16.7 | **worse** |
| calls, 20 clients | 60 | 0.319 s | 0.338 s | +5.9% | +4.7, +7.1 | inconclusive* |
| signals, burst to 1 | 60 | 0.179 s | 0.130 s | -27.2% | -28.2, -26.3 | **better** |
| signals, broadcast to 20 | 60 | 0.195 s | 0.078 s | -60.1% | -60.6, -59.5 | **better** |
| RTT, 1 client, p50 | 60 | 49 µs | 59 µs | +20.8% | +20.2, +21.5 | **worse** |
| RTT, 1 client, p99 | 60 | 108 µs | 126 µs | +16.4% | +11.8, +21.3 | **worse** |
| RTT, 20 clients, p50 | 60 | 306 µs | 309 µs | +0.7% | -0.7, +2.1 | within ±5% |
| RTT, 20 clients, p99 | 60 | 452 µs | 464 µs | +2.6% | -3.6, +9.5 | inconclusive |
| delivery to 20, p50 | 60 | 2.0 ms | 1.1 ms | -46.0% | -47.2, -44.7 | **better** |
| delivery to 20, p99 | 60 | 3.5 ms | 2.1 ms | -40.2% | -43.6, -36.5 | **better** |
| delivery to 20, whole fan-out | 60 | 0.068 s | 0.029 s | -58.0% | -58.9, -57.1 | **better** |
| 100 proxies, 1 connection | 40 | 1.30 s | 1.39 s | +7.2% | +3.1, +11.4 | inconclusive* |
| 100 clients | 40 | 1.89 s | 2.34 s | +24.1% | +19.6, +29.0 | **worse** |
| calls, broker CPU | 60 | 0.34 s | 0.38 s | +10.1% | +9.1, +11.1 | **worse** |
| signals, broker CPU | 60 | 0.39 s | 0.23 s | -40.7% | -41.2, -40.1 | **better** |
| latency, broker CPU | 60 | 0.50 s | 0.51 s | +3.1% | +2.0, +4.4 | within ±5%* |
| shared, broker CPU | 40 | 3.12 s | 3.62 s | +16.1% | +12.6, +19.8 | **worse** |
| calls, broker user time | 60 | 0.12 s | 0.15 s | +31.0% | +27.6, +34.4 | **worse** |
| signals, broker user time | 60 | 0.13 s | 0.09 s | -28.7% | -30.7, -26.6 | **better** |
| latency, broker user time | 60 | 0.17 s | 0.21 s | +23.8% | +21.1, +26.6 | **worse** |
| shared, broker user time | 40 | 1.03 s | 1.43 s | +37.8% | +32.9, +42.8 | **worse** |
| calls, broker system time | 60 | 0.22 s | 0.22 s | -0.8% | -2.7, +1.1 | within ±5% |
| signals, broker system time | 60 | 0.26 s | 0.14 s | -46.5% | -47.4, -45.5 | **better** |
| latency, broker system time | 60 | 0.33 s | 0.31 s | -7.3% | -8.9, -5.7 | **better** |
| shared, broker system time | 40 | 2.09 s | 2.20 s | +5.4% | +2.2, +8.7 | inconclusive* |
| calls, broker peak RSS | 60 | 8.1 MiB | 6.8 MiB | -15.6% | -16.2, -15.1 | **better** |
| signals, broker peak RSS | 60 | 8.2 MiB | 6.2 MiB | -24.9% | -25.7, -24.1 | **better** |
| latency, broker peak RSS | 60 | 8.1 MiB | 7.1 MiB | -13.0% | -13.5, -12.5 | **better** |
| shared, broker peak RSS | 40 | 9.1 MiB | 13.7 MiB | +51.0% | +49.1, +52.8 | **worse** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.133 s | 0.070 s | -47.6% | -48.2, -46.9 | **better** |
| calls, 20 clients | 60 | 1.252 s | 0.341 s | -72.7% | -73.0, -72.5 | **better** |
| signals, burst to 1 | 60 | 0.881 s | 0.133 s | -84.9% | -85.1, -84.8 | **better** |
| signals, broadcast to 20 | 60 | 2.014 s | 0.080 s | -96.0% | -96.1, -96.0 | **better** |
| RTT, 1 client, p50 | 60 | 95 µs | 59 µs | -37.6% | -38.0, -37.2 | **better** |
| RTT, 1 client, p99 | 60 | 202 µs | 126 µs | -37.4% | -39.3, -35.6 | **better** |
| RTT, 20 clients, p50 | 60 | 1219 µs | 314 µs | -74.3% | -74.5, -74.0 | **better** |
| RTT, 20 clients, p99 | 60 | 1706 µs | 466 µs | -72.7% | -74.3, -70.8 | **better** |
| delivery to 20, p50 | 60 | 20.5 ms | 1.1 ms | -94.6% | -94.7, -94.5 | **better** |
| delivery to 20, p99 | 60 | 33.3 ms | 2.0 ms | -94.1% | -94.3, -93.9 | **better** |
| delivery to 20, whole fan-out | 60 | 0.682 s | 0.028 s | -95.8% | -95.9, -95.8 | **better** |
| 100 proxies, 1 connection | 40 | 6.83 s | 1.41 s | -79.4% | -79.9, -78.8 | **better** |
| 100 clients | 40 | 7.12 s | 2.30 s | -67.7% | -68.6, -66.8 | **better** |
| calls, broker CPU | 60 | 1.34 s | 0.38 s | -71.5% | -71.7, -71.2 | **better** |
| signals, broker CPU | 60 | 2.91 s | 0.23 s | -91.9% | -92.0, -91.9 | **better** |
| latency, broker CPU | 60 | 2.26 s | 0.52 s | -77.0% | -77.1, -76.8 | **better** |
| shared, broker CPU | 40 | 13.92 s | 3.58 s | -74.3% | -74.7, -73.8 | **better** |
| calls, broker user time | 60 | 0.54 s | 0.16 s | -70.9% | -71.5, -70.3 | **better** |
| signals, broker user time | 60 | 0.94 s | 0.10 s | -89.7% | -89.9, -89.5 | **better** |
| latency, broker user time | 60 | 0.83 s | 0.21 s | -74.5% | -75.0, -74.0 | **better** |
| shared, broker user time | 40 | 5.40 s | 1.42 s | -73.6% | -74.2, -73.1 | **better** |
| calls, broker system time | 60 | 0.79 s | 0.22 s | -71.9% | -72.3, -71.5 | **better** |
| signals, broker system time | 60 | 1.96 s | 0.14 s | -93.0% | -93.1, -92.9 | **better** |
| latency, broker system time | 60 | 1.43 s | 0.31 s | -78.4% | -78.7, -78.1 | **better** |
| shared, broker system time | 40 | 8.51 s | 2.16 s | -74.7% | -75.2, -74.1 | **better** |
| calls, broker peak RSS | 60 | 6.3 MiB | 7.0 MiB | +10.5% | +9.8, +11.2 | **worse** |
| signals, broker peak RSS | 60 | 5.5 MiB | 6.2 MiB | +13.7% | +12.9, +14.5 | **worse** |
| latency, broker peak RSS | 60 | 6.3 MiB | 7.2 MiB | +13.6% | +12.7, +14.4 | **worse** |
| shared, broker peak RSS | 40 | 9.6 MiB | 13.8 MiB | +42.9% | +41.1, +44.6 | **worse** |

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at ca174ec builds the brokers and runs all of this, in about 31 minutes on this laptop once the
builds are made, and writes its results to `$WORK/batched-sends-results-50bf523`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. The script measures
fd577a2 by default from 425d828 on, and `AFTER_REV=50bf523` has it measure the commit of this run
again.
