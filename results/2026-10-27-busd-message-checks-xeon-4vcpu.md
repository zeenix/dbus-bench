# busd checking the messages of its clients, on a 4-vCPU Xeon

Measured on 2026-10-27, on a VM with 4 vCPUs of an Intel Xeon @ 2.10GHz under KVM, 15 GiB, Linux
6.18, Ubuntu 24.04.5: not the VM of the earlier Xeon files, whose Xeon ran at 2.80GHz. It ran
`scripts/compare-batched-sends.sh` at f9aec77, which made every build of busd with rustc 1.97.0.
dbus-broker is 37, built from source with meson's release build type and its default options
otherwise, and ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py). dbus-daemon is
the 1.14.10 of Ubuntu 24.04. Compare the brokers with each other, within this file only.

The builds of busd:

* **before**: 227254e, busd's main branch, the merge of z-galaxy/busd#388, on zbus 50c54bf and
  zruntime b3bd01d, as its lock file has them;
* **after**: 50bf523 of zeenix/busd, the head of z-galaxy/busd#391, on the same zruntime and on zbus
  ef4be18 of zeenix/zbus, the head of z-galaxy/zbus#2086. That zbus checks a message that a
  connection receives as a whole, not only the fields of its header: its protocol version, the
  fields that its type requires, the padding after its header and the file descriptors that it
  declares. after has the connection of each client check the body of each message against its
  signature too, and passes a reply or an error on only if it answers a call that waits for one,
  of which it keeps a record for each call that expects a reply.

The two differ in zbus, and in the foldhash that after adds, alone, as the script checks in their
lock files. The clients are those of f9aec77, on the zbus and the zruntime of before, against every
broker.

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

* After against before, no measure changes conclusively beyond the margin of ±5%: the calls take
  as long (+1.4% with one client, -0.0% with 20), the signals 3.3% longer on the burst to one
  subscriber and 2.3% longer on the broadcast to 20 (both inconclusive), and the shared phases 2.8%
  less and 2.8% more (both inconclusive). busd uses as much CPU time, within ±5% but for the
  signals (+3.1%, inconclusive), where its user time is 8.0% higher, as it checks the bodies of
  40,000 and 6000 signals. Its peak memory is 2.6 to 3.2% higher, about 140 KiB, and 260 KiB on the
  shared phases, and its code 83 KiB larger.
* The one measure that moves further is the p99 of the round trips of 20 clients, 12.0% longer,
  1282 µs against 1145 µs, while their median and their p90 stay level. It holds less well than
  that: two more runs of the latencies had it 11.1% longer and 3.8% shorter, and the three of them
  6.0% longer (from +0.7 to +11.5%), for which none of the three commits of z-galaxy/busd#391
  accounts alone (see [below](#the-slowest-round-trips-of-20-clients)).
* So the gap to dbus-broker barely moves. With 20 clients, busd's calls take 9.9% longer than
  dbus-broker's, before and after, and its median round trip 9.8% longer, against 8.8%; with 100
  clients, busd takes 37.4% longer, against 33.6%, as after takes 2.8% longer than before there
  (inconclusive). Its p99 round trip with 20 clients, level with dbus-broker's before (+0.6%), is
  12.6% longer here, and likely nearer 7% longer, from the three runs. busd stays faster with one
  client (10.2% on the calls, against 11.4%), on the signals (20.1% on the burst, against 22.6%,
  and 42.0% on the broadcast, against 43.4%), on the latencies' fan-out and on the first shared
  phase.
* Every workload carries a byte array: the calls take an `ay`, and the signals a number or two and
  an `ay`, which the check of a body passes over in one step. The bodies whose check costs the
  most, such as a dict of variants, as properties are, are in none of them, and their clients set
  the sender of each message, which libdbus, GLib and sd-bus clients leave for the bus to set (see
  [below](#what-the-workloads-leave-out)).
* No run of any broker failed. A run of each client against after, with busd's debug log on, showed
  no client disconnected for its messages: the only disconnections were those of the clients
  closing their connections, one for each, as with before.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | -11.4% | -10.2% |
| calls, 20 clients | +9.9% | +9.9% |
| signals, burst to 1 | -22.6% | -20.1% |
| signals, broadcast to 20 | -43.4% | -42.0% |
| RTT, 1 client, p50 | -13.5% | -13.1% |
| RTT, 1 client, p99 | -12.9% | -10.1% |
| RTT, 20 clients, p50 | +8.8% | +9.8% |
| RTT, 20 clients, p99 | +0.6% | +12.6% |
| delivery to 20, p50 | -15.4% | -15.6% |
| delivery to 20, p99 | -41.8% | -32.3% |
| delivery to 20, whole fan-out | -43.4% | -41.8% |
| 100 proxies, 1 connection | -18.4% | -20.6% |
| 100 clients | +33.6% | +37.4% |
| calls, broker CPU | +8.1% | +8.4% |
| signals, broker CPU | -42.8% | -41.0% |
| latency, broker CPU | -1.5% | -0.3% |
| shared, broker CPU | +8.7% | +9.5% |

## The benchmarks

The workloads, and how the comparisons work, are those of [the latest zbus and
zruntime](2026-10-26-busd-dependency-updates-xeon-4vcpu.md#the-benchmarks): each service, client
and subscriber runs on a thread of its own, with a runtime of its own, as a process of its own
would. The shared phases are a connection that 100 proxies share to call one service, then 100
services, each with a client of its own. There are 60 rounds of each workload, and 40 of the shared
phases, after 3 of warm-up, all four brokers in each round. The raw results of each run are in
[runs.tar.xz](2026-10-27-busd-message-checks-xeon-4vcpu/runs.tar.xz), from which
[paired-stats.py](../scripts/paired-stats.py) makes the comparisons, with the other metrics and the
medians. The values are means over the rounds, and a star marks a difference whose 95% interval
excludes 0 but not the margin. The signals are those of the `fanout` client: a burst of 40,000 to
one subscriber, and a broadcast of 6000 to each of 20, each timed as a whole. The delivery to 20 is
the fan-out of the `latency` client, another broadcast, of 2000 signals of 1 KiB to each of 20
subscribers, which times each delivery, from just before the emitter builds the signal until the
subscriber takes it off its stream, and the whole fan-out how long all of them take.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.130 s | 0.132 s | +1.4% | -1.9, +4.7 | within ±5% |
| calls, 20 clients | 60 | 0.653 s | 0.653 s | -0.0% | -3.9, +3.9 | within ±5% |
| signals, burst to 1 | 60 | 0.206 s | 0.213 s | +3.3% | -0.3, +6.9 | inconclusive |
| signals, broadcast to 20 | 60 | 0.188 s | 0.192 s | +2.3% | -2.5, +7.5 | inconclusive |
| RTT, 1 client, p50 | 60 | 106 µs | 107 µs | +0.6% | -1.5, +2.5 | within ±5% |
| RTT, 1 client, p99 | 60 | 223 µs | 230 µs | +3.2% | -4.7, +11.8 | inconclusive |
| RTT, 20 clients, p50 | 60 | 574 µs | 579 µs | +0.9% | -4.8, +7.3 | inconclusive |
| RTT, 20 clients, p99 | 60 | 1145 µs | 1282 µs | +12.0% | +3.2, +21.6 | inconclusive* |
| delivery to 20, p50 | 60 | 3.1 ms | 3.1 ms | -0.2% | -6.1, +5.9 | inconclusive |
| delivery to 20, p99 | 60 | 10.8 ms | 12.6 ms | +16.3% | -4.0, +47.0 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.066 s | 0.068 s | +2.7% | -3.7, +10.3 | inconclusive |
| 100 proxies, 1 connection | 40 | 1.76 s | 1.71 s | -2.8% | -6.0, +0.4 | inconclusive |
| 100 clients | 40 | 3.48 s | 3.57 s | +2.8% | -0.3, +5.9 | inconclusive |
| calls, broker CPU | 60 | 0.67 s | 0.67 s | +0.3% | -3.1, +3.9 | within ±5% |
| signals, broker CPU | 60 | 0.33 s | 0.34 s | +3.1% | -1.2, +7.5 | inconclusive |
| latency, broker CPU | 60 | 0.89 s | 0.90 s | +1.3% | -2.5, +5.6 | within ±5% |
| shared, broker CPU | 40 | 4.83 s | 4.87 s | +0.8% | -1.5, +3.1 | within ±5% |
| calls, broker user time | 60 | 0.24 s | 0.23 s | -2.4% | -7.0, +2.5 | inconclusive |
| signals, broker user time | 60 | 0.15 s | 0.16 s | +8.0% | +3.3, +12.8 | inconclusive* |
| latency, broker user time | 60 | 0.31 s | 0.32 s | +3.6% | -1.8, +9.9 | inconclusive |
| shared, broker user time | 40 | 1.90 s | 1.96 s | +3.3% | +0.7, +5.9 | inconclusive* |
| calls, broker system time | 60 | 0.43 s | 0.44 s | +1.8% | -2.3, +6.3 | inconclusive |
| signals, broker system time | 60 | 0.18 s | 0.18 s | -1.0% | -7.5, +6.2 | inconclusive |
| latency, broker system time | 60 | 0.58 s | 0.58 s | +0.0% | -3.9, +4.4 | within ±5% |
| shared, broker system time | 40 | 2.93 s | 2.91 s | -0.8% | -3.6, +1.9 | within ±5% |
| calls, broker peak RSS | 60 | 5.1 MiB | 5.2 MiB | +2.6% | +2.1, +3.2 | within ±5%* |
| signals, broker peak RSS | 60 | 4.6 MiB | 4.8 MiB | +3.0% | +2.6, +3.4 | within ±5%* |
| latency, broker peak RSS | 60 | 5.1 MiB | 5.3 MiB | +2.6% | +2.1, +3.1 | within ±5%* |
| shared, broker peak RSS | 40 | 7.9 MiB | 8.1 MiB | +3.2% | +2.1, +4.2 | within ±5%* |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.147 s | 0.132 s | -10.2% | -12.4, -7.7 | **better** |
| calls, 20 clients | 60 | 0.594 s | 0.653 s | +9.9% | +5.5, +14.3 | **worse** |
| signals, burst to 1 | 60 | 0.266 s | 0.213 s | -20.1% | -23.4, -16.4 | **better** |
| signals, broadcast to 20 | 60 | 0.331 s | 0.192 s | -42.0% | -45.8, -38.1 | **better** |
| RTT, 1 client, p50 | 60 | 123 µs | 107 µs | -13.1% | -14.9, -11.3 | **better** |
| RTT, 1 client, p99 | 60 | 256 µs | 230 µs | -10.1% | -16.1, -3.1 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 527 µs | 579 µs | +9.8% | +3.8, +16.7 | inconclusive* |
| RTT, 20 clients, p99 | 60 | 1139 µs | 1282 µs | +12.6% | +3.4, +22.8 | inconclusive* |
| delivery to 20, p50 | 60 | 3.6 ms | 3.1 ms | -15.6% | -21.9, -8.9 | **better** |
| delivery to 20, p99 | 60 | 18.6 ms | 12.6 ms | -32.3% | -50.7, -4.5 | inconclusive* |
| delivery to 20, whole fan-out | 60 | 0.116 s | 0.068 s | -41.8% | -46.4, -36.6 | **better** |
| 100 proxies, 1 connection | 40 | 2.16 s | 1.71 s | -20.6% | -23.7, -17.4 | **better** |
| 100 clients | 40 | 2.60 s | 3.57 s | +37.4% | +33.6, +41.4 | **worse** |
| calls, broker CPU | 60 | 0.62 s | 0.67 s | +8.4% | +4.2, +12.7 | inconclusive* |
| signals, broker CPU | 60 | 0.58 s | 0.34 s | -41.0% | -44.0, -37.7 | **better** |
| latency, broker CPU | 60 | 0.90 s | 0.90 s | -0.3% | -3.9, +4.0 | within ±5% |
| shared, broker CPU | 40 | 4.44 s | 4.87 s | +9.5% | +6.4, +12.7 | **worse** |
| calls, broker user time | 60 | 0.17 s | 0.23 s | +40.7% | +33.7, +48.2 | **worse** |
| signals, broker user time | 60 | 0.17 s | 0.16 s | -2.9% | -8.0, +2.8 | inconclusive |
| latency, broker user time | 60 | 0.22 s | 0.32 s | +44.5% | +35.9, +53.8 | **worse** |
| shared, broker user time | 40 | 1.29 s | 1.96 s | +52.5% | +48.8, +56.5 | **worse** |
| calls, broker system time | 60 | 0.45 s | 0.44 s | -3.4% | -7.7, +0.9 | inconclusive |
| signals, broker system time | 60 | 0.41 s | 0.18 s | -56.5% | -59.5, -53.1 | **better** |
| latency, broker system time | 60 | 0.68 s | 0.58 s | -14.8% | -18.0, -11.1 | **better** |
| shared, broker system time | 40 | 3.16 s | 2.91 s | -8.0% | -11.3, -4.6 | inconclusive* |
| calls, broker peak RSS | 60 | 6.5 MiB | 5.2 MiB | -20.2% | -20.5, -19.9 | **better** |
| signals, broker peak RSS | 60 | 8.6 MiB | 4.8 MiB | -44.0% | -47.6, -40.2 | **better** |
| latency, broker peak RSS | 60 | 7.2 MiB | 5.3 MiB | -26.4% | -28.8, -24.0 | **better** |
| shared, broker peak RSS | 40 | 7.7 MiB | 8.1 MiB | +5.5% | +4.6, +6.5 | inconclusive* |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.147 s | 0.130 s | -11.4% | -13.6, -8.9 | **better** |
| calls, 20 clients | 60 | 0.594 s | 0.653 s | +9.9% | +5.9, +14.1 | **worse** |
| signals, burst to 1 | 60 | 0.266 s | 0.206 s | -22.6% | -26.3, -18.7 | **better** |
| signals, broadcast to 20 | 60 | 0.331 s | 0.188 s | -43.4% | -46.9, -39.5 | **better** |
| RTT, 1 client, p50 | 60 | 123 µs | 106 µs | -13.5% | -15.5, -11.6 | **better** |
| RTT, 1 client, p99 | 60 | 256 µs | 223 µs | -12.9% | -18.2, -7.2 | **better** |
| RTT, 20 clients, p50 | 60 | 527 µs | 574 µs | +8.8% | +3.2, +14.9 | inconclusive* |
| RTT, 20 clients, p99 | 60 | 1139 µs | 1145 µs | +0.6% | -5.9, +8.0 | inconclusive |
| delivery to 20, p50 | 60 | 3.6 ms | 3.1 ms | -15.4% | -21.7, -8.8 | **better** |
| delivery to 20, p99 | 60 | 18.6 ms | 10.8 ms | -41.8% | -53.9, -24.9 | **better** |
| delivery to 20, whole fan-out | 60 | 0.116 s | 0.066 s | -43.4% | -47.0, -39.2 | **better** |
| 100 proxies, 1 connection | 40 | 2.16 s | 1.76 s | -18.4% | -21.3, -15.3 | **better** |
| 100 clients | 40 | 2.60 s | 3.48 s | +33.6% | +29.8, +37.4 | **worse** |
| calls, broker CPU | 60 | 0.62 s | 0.67 s | +8.1% | +4.1, +12.3 | inconclusive* |
| signals, broker CPU | 60 | 0.58 s | 0.33 s | -42.8% | -45.7, -39.6 | **better** |
| latency, broker CPU | 60 | 0.90 s | 0.89 s | -1.5% | -4.7, +2.0 | within ±5% |
| shared, broker CPU | 40 | 4.44 s | 4.83 s | +8.7% | +5.8, +11.6 | **worse** |
| calls, broker user time | 60 | 0.17 s | 0.24 s | +44.1% | +37.1, +51.6 | **worse** |
| signals, broker user time | 60 | 0.17 s | 0.15 s | -10.1% | -14.7, -5.1 | **better** |
| latency, broker user time | 60 | 0.22 s | 0.31 s | +39.5% | +31.9, +47.9 | **worse** |
| shared, broker user time | 40 | 1.29 s | 1.90 s | +47.7% | +43.5, +52.3 | **worse** |
| calls, broker system time | 60 | 0.45 s | 0.43 s | -5.2% | -9.5, -0.7 | inconclusive* |
| signals, broker system time | 60 | 0.41 s | 0.18 s | -56.0% | -59.1, -52.7 | **better** |
| latency, broker system time | 60 | 0.68 s | 0.58 s | -14.8% | -17.7, -11.6 | **better** |
| shared, broker system time | 40 | 3.16 s | 2.93 s | -7.2% | -10.0, -4.3 | inconclusive* |
| calls, broker peak RSS | 60 | 6.5 MiB | 5.1 MiB | -22.3% | -22.6, -21.9 | **better** |
| signals, broker peak RSS | 60 | 8.6 MiB | 4.6 MiB | -45.7% | -49.2, -41.9 | **better** |
| latency, broker peak RSS | 60 | 7.2 MiB | 5.1 MiB | -28.2% | -30.7, -25.9 | **better** |
| shared, broker peak RSS | 40 | 7.7 MiB | 7.9 MiB | +2.3% | +1.6, +3.0 | within ±5%* |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.161 s | 0.132 s | -17.9% | -20.3, -15.2 | **better** |
| calls, 20 clients | 60 | 1.426 s | 0.653 s | -54.2% | -55.9, -52.5 | **better** |
| signals, burst to 1 | 60 | 0.813 s | 0.213 s | -73.8% | -74.8, -72.9 | **better** |
| signals, broadcast to 20 | 60 | 1.212 s | 0.192 s | -84.2% | -84.9, -83.4 | **better** |
| RTT, 1 client, p50 | 60 | 124 µs | 107 µs | -13.8% | -15.6, -11.9 | **better** |
| RTT, 1 client, p99 | 60 | 259 µs | 230 µs | -11.3% | -15.8, -6.3 | **better** |
| RTT, 20 clients, p50 | 60 | 1333 µs | 579 µs | -56.6% | -58.6, -54.5 | **better** |
| RTT, 20 clients, p99 | 60 | 2263 µs | 1282 µs | -43.3% | -47.3, -39.2 | **better** |
| delivery to 20, p50 | 60 | 11.0 ms | 3.1 ms | -72.1% | -74.1, -70.1 | **better** |
| delivery to 20, p99 | 60 | 23.4 ms | 12.6 ms | -46.2% | -56.4, -31.5 | **better** |
| delivery to 20, whole fan-out | 60 | 0.383 s | 0.068 s | -82.3% | -83.6, -80.8 | **better** |
| 100 proxies, 1 connection | 40 | 6.21 s | 1.71 s | -72.4% | -73.1, -71.7 | **better** |
| 100 clients | 40 | 7.00 s | 3.57 s | -48.9% | -50.5, -47.3 | **better** |
| calls, broker CPU | 60 | 1.47 s | 0.67 s | -54.3% | -55.9, -52.7 | **better** |
| signals, broker CPU | 60 | 2.01 s | 0.34 s | -82.9% | -83.5, -82.2 | **better** |
| latency, broker CPU | 60 | 2.09 s | 0.90 s | -56.9% | -58.3, -55.3 | **better** |
| shared, broker CPU | 40 | 12.91 s | 4.87 s | -62.3% | -63.2, -61.4 | **better** |
| calls, broker user time | 60 | 0.81 s | 0.23 s | -70.9% | -72.2, -69.6 | **better** |
| signals, broker user time | 60 | 0.83 s | 0.16 s | -80.4% | -81.2, -79.5 | **better** |
| latency, broker user time | 60 | 1.03 s | 0.32 s | -69.0% | -70.5, -67.5 | **better** |
| shared, broker user time | 40 | 7.32 s | 1.96 s | -73.2% | -73.9, -72.5 | **better** |
| calls, broker system time | 60 | 0.67 s | 0.44 s | -34.3% | -37.1, -31.4 | **better** |
| signals, broker system time | 60 | 1.17 s | 0.18 s | -84.7% | -85.5, -83.7 | **better** |
| latency, broker system time | 60 | 1.06 s | 0.58 s | -45.1% | -47.1, -42.8 | **better** |
| shared, broker system time | 40 | 5.59 s | 2.91 s | -48.1% | -49.4, -46.6 | **better** |
| calls, broker peak RSS | 60 | 5.3 MiB | 5.2 MiB | -1.8% | -2.3, -1.3 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.8 MiB | +2.1% | +0.0, +3.6 | within ±5%* |
| latency, broker peak RSS | 60 | 5.3 MiB | 5.3 MiB | -0.9% | -1.5, -0.3 | within ±5%* |
| shared, broker peak RSS | 40 | 8.6 MiB | 8.1 MiB | -4.8% | -5.6, -4.0 | inconclusive* |

## The slowest round trips of 20 clients

In the run of the tables above, the p99 of the round trips of 20 clients is 12.0% longer with after
(from +3.2 to +21.6%), while their median (+0.9%) and their p90 (+3.3%) stay level, and so does
busd's CPU time. Two more runs of the latencies alone, by
[compare-latency.py](../scripts/compare-latency.py) with the same builds and client, tested whether
it holds:

* before and after, 60 rounds after 3 of warm-up: after's p99 is 11.1% longer (from +2.1 to
  +20.5%), with the median 0.3% and the p90 2.9% longer;
* before, after and the two commits of z-galaxy/busd#391 between them, 60 rounds after 3 of warm-up:
  **checks**, 6cbc3af, busd's main branch on the zbus of after, which checks the messages that it
  receives as a whole but not their bodies, and **bodies**, ed8ec1d, which has the connection of
  each client check their bodies too, but tracks no replies. after's p99 is 3.8% shorter than
  before's here (from -12.0 to +4.9%), and the steps from before to checks, to bodies and to after
  change it by +1.9, -10.8 and +5.8%, none of them conclusively.

Over the 180 pairs of the three runs, after's p99 is 6.0% longer than before's (from +0.7 to +11.5%,
by a bootstrap of the pairs), its p90 1.0% longer (from -2.3 to +4.6%) and its median 0.4% shorter
(from -3.0 to +2.3%). So the slowest 1% of the round trips likely take a few percent longer, around
the margin, without any one of the three changes accounting for it, and the 12.6% that after takes
longer than dbus-broker on them in the run above likely overstates the gap, which is nearer 7%. Each
call costs busd about 700 instructions more with after, by the counts of z-galaxy/busd#391: 180 to
check its body of 16 KiB and about 485 for the record of its reply. That is well under a
microsecond, so the work itself is not what lengthens the slowest round trips by 70 µs or more;
the 20 clients, their services and the bus share 4 vCPUs, which makes the slowest round trips
sensitive to small shifts in how their threads are scheduled. On the Ryzen 7 7840U, with 16 threads,
after's p99 is 0.6% longer (from -5.4 to +6.8%, [the run of
2026-10-27](2026-10-27-busd-message-checks-ryzen-7840u.md)), which fits that. The raw results of the
two runs are in [latency-rerun](2026-10-27-busd-message-checks-xeon-4vcpu/latency-rerun/runs.tar.xz)
and [latency-by-commit](2026-10-27-busd-message-checks-xeon-4vcpu/latency-by-commit/runs.tar.xz).

## What the workloads leave out

The check of a body walks it against its signature, and how long that takes depends on the
signature far more than on the size of the body. The workloads here carry byte arrays alone, which
it passes over in one step: z-galaxy/busd#391 counts about 180 instructions more for each call of
16 KiB of bytes, and about 200 more for each signal of a number and a few bytes, as callgrind counts
the instructions that busd runs. For a call with a dict of 20 entries of numbers, strings, booleans
and arrays of strings in variants, it counts 9,500 more, 26% more in all. A dict of variants is what
properties come in, with `GetAll` and `PropertiesChanged`, so where much of a bus's traffic is of
those, the check costs busd more than here. None of the workloads measures that.

Nor do they measure messages without a sender. The clients here are zbus's, which sets the sender
of every message but `Hello`, whereas libdbus, GLib and sd-bus leave it out of every message, for
the bus to set. busd built each such message anew to set it, before fd577a2, and copies its bytes
with the field appended since: by fd577a2's counts, a burst of 40,000 signals of a number and 1 KiB
of bytes, from a client that leaves the sender out, takes busd about 20,400 instructions more for
each than one from a client that sets it, before fd577a2, and about 2,000 more with it. So for
clients that leave the sender out, as most do, busd costs more than the workloads here show before
fd577a2, and fd577a2 takes back more than they can show. [The run with clients that leave the
sender out](2026-10-27-busd-sender-less-clients-xeon-4vcpu.md) measures both.

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at f9aec77 builds the brokers and runs all of this, in about 36 minutes on this VM once the builds
are made, and writes its results to `$WORK/batched-sends-results-50bf523`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. It ran with dbus-broker 37
first on the `PATH`, and with fake-journald.py started before it. The two runs of the latencies
alone took the builds and the client from `$WORK/bin`, where the script leaves them, with busd at
6cbc3af and ed8ec1d built from exports of those commits as the script builds the others
(`cargo build --release --locked`) and copied there as `busd-checks` and `busd-bodies`:

```sh
scripts/compare-latency.py --bench $WORK/bin/latency --rounds 60 --warmup 3 --seed 41 \
    --out latency.json \
    --broker before "$WORK/bin/busd-before --address {address}" \
    --broker after "$WORK/bin/busd-after --address {address}"
scripts/compare-latency.py --bench $WORK/bin/latency --rounds 60 --warmup 3 --seed 42 \
    --out latency.json \
    --broker before "$WORK/bin/busd-before --address {address}" \
    --broker checks "$WORK/bin/busd-checks --address {address}" \
    --broker bodies "$WORK/bin/busd-bodies --address {address}" \
    --broker after "$WORK/bin/busd-after --address {address}"
```
