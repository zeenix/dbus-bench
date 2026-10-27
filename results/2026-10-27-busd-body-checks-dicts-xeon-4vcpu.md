# What checking bodies costs busd, with dicts of variants, on a 4-vCPU Xeon

Measured on 2026-10-27 on the VM of [busd checking the messages of clients that leave the sender
out](2026-10-27-busd-sender-less-clients-xeon-4vcpu.md): 4 vCPUs of an Intel Xeon @ 2.10GHz under
KVM, 15 GiB, Linux 6.18, Ubuntu 24.04.5. It ran `scripts/compare-batched-sends.sh` at aba31e9, which
made every build of busd with rustc 1.97.0. dbus-broker is 37, built from source with meson's
release build type and its default options otherwise, and ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py). dbus-daemon is
the 1.14.10 of Ubuntu 24.04. Compare the brokers with each other, within this file only.

The builds of busd:

* **before**: 227254e, busd's main branch, on zbus 50c54bf and zruntime b3bd01d, which checks the
  fields of the header of each message that it receives but not its body, and builds each message
  that a client leaves the sender out of anew, with the field added;
* **after**: fd577a2 of zeenix/busd, the head of z-galaxy/busd#391, on the same zruntime and on zbus
  8cb16a2 of zeenix/zbus, the head of z-galaxy/zbus#2086. It checks the messages of its clients as
  a whole, and their bodies against their signatures, passes on only the replies that answer a call
  that waits for one, and sets the sender of a message that a client leaves it out of with
  `Message::with_sender`;
* **unchecked**: after, but for the line that has zbus check the bodies of the messages of each
  client, `.validate_bodies()` in `src/peer/mod.rs`, which the script drops from its export. So
  after against unchecked is what checking the bodies costs busd, and nothing else.

The clients are those of aba31e9, which leave the sender out of every message that is timed, as
those of [the run with such clients](2026-10-27-busd-sender-less-clients-xeon-4vcpu.md) do, and add
a workload: `dicts`, the method calls of the benchmark, but with a body of 10 interfaces of 10
properties each, 100 variants of numbers, strings, booleans and arrays of strings, `a{sa{sv}}`, of
4242 bytes, the shape of the properties of an object by interface, as `GetManagedObjects` and
`InterfacesAdded` carry them. Its services reply without reading the body. The other workloads carry
byte arrays alone, which a check passes over in one step.

## Summary

* Checking the bodies costs busd nothing measurable on the workloads of byte arrays: after against
  unchecked is within ±5%, or inconclusive, on every measure of them, from -3.0 to +1.6% on the
  times, but for the p99s of the round trips of 20 clients and of the fan-out, 6.1 and 6.3% shorter
  (inconclusive), and from -2.8 to 0.0% on the CPU time, as z-galaxy/busd#391's counts of 180 to
  200 instructions for each body of them have it.
* With the dicts, it costs busd 18.5% more CPU time and 43.1% more user time, 0.118 s for the 21,000
  calls of a run (from 0.093 to 0.144 s): about 5.6 µs of CPU time for each call. That is in line
  with the 7,917 instructions that z-galaxy/zbus#2086 counts to check an `a{sv}` of 20 such entries,
  about 40,000 for these 100. The calls of 20 clients take 17.3% longer for it (from +13.2 to
  +21.7%), and those of one client 3.5% longer (inconclusive, but repeatable).
* Even so, after takes less than before on the dicts, which doesn't check their bodies: 5.8% less
  with 20 clients (inconclusive, but repeatable), with 5.7% less CPU time, as setting the sender of
  each call and of each reply with `Message::with_sender` saves more than the check of the call
  costs. On the other workloads, after takes 14 to 35% less time than before on the calls, the
  round trips and the shared phases of many clients and on the burst of signals, with 23 to 29%
  less CPU time, as in [the run with clients that leave the sender
  out](2026-10-27-busd-sender-less-clients-xeon-4vcpu.md).
* And busd is faster than dbus-broker on the dicts, which dbus-broker checks too: after takes 26.7%
  less time with 20 clients and 16.0% less with one, with 27.0% less CPU time, and before 22.2% and
  15.6% less. dbus-broker takes 69% longer on the dicts of 20 clients than on their calls of 16 KiB
  of bytes (0.988 s against 0.584 s), where after takes 6% longer (0.724 s against 0.683 s).
* On the other workloads, the gaps to dbus-broker are those of the run with such clients: with 20
  clients, after's calls take 17.0% longer than dbus-broker's (before: 60.1%), and with 100 clients
  57.6% longer (before: 109.1%), and after is faster on the burst of signals by 11.1% (before:
  37.3% slower), on the broadcasts and with one client.
* One run failed, in a round of warm-up, which the tables leave out: that of unchecked in the
  second round of the shared phases. busd disconnected the service that the 100 callers of the
  first phase call, `:busd.2`, as it didn't take a message within the 100 ms that busd waits for a
  client to, and the calls that waited on it got `NoReply` from busd. Up to 100 calls of 16 KiB
  wait for that service at once, more than the stream of its connection holds (64) and its socket
  buffers, so the service has to keep up with them all along, which its thread, held up at times by
  the other threads on the VM's 4 vCPUs, failed to do once in the 215 runs of the shared phases.
  The 40 measured rounds of each broker are all there.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | -4.1% | -10.4% |
| calls, 20 clients | +60.1% | +17.0% |
| dict calls, 1 client | -15.6% | -16.0% |
| dict calls, 20 clients | -22.2% | -26.7% |
| signals, burst to 1 | +37.3% | -11.1% |
| signals, broadcast to 20 | -36.3% | -41.7% |
| RTT, 1 client, p50 | -5.3% | -11.2% |
| RTT, 20 clients, p50 | +63.0% | +18.1% |
| RTT, 20 clients, p99 | +38.2% | +7.7% |
| delivery to 20, whole fan-out | -37.9% | -42.3% |
| 100 callers, 1 connection | +1.6% | -12.7% |
| 100 clients | +109.1% | +57.6% |
| calls, broker CPU | +58.3% | +16.0% |
| dicts, broker CPU | -22.5% | -27.0% |
| signals, broker CPU | -10.1% | -36.5% |
| latency, broker CPU | +36.5% | +5.5% |
| shared, broker CPU | +62.9% | +24.8% |

## The benchmarks

The workloads and the comparisons are those of [the run with clients that leave the sender
out](2026-10-27-busd-sender-less-clients-xeon-4vcpu.md#the-benchmarks), with the `dicts` workload
added, whose two phases are those of the method calls: 1000 calls of one client, then 1000 calls of
each of 20 clients at once, each to a service of its own. There are 60 rounds of each workload, and
40 of the shared phases, after 3 of warm-up, all five brokers in each round. The raw results are in
[runs.tar.xz](2026-10-27-busd-body-checks-dicts-xeon-4vcpu/runs.tar.xz). The values are means over
the rounds, and a star marks a difference whose 95% interval excludes 0 but not the margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.131 s | 0.123 s | -6.5% | -9.3, -3.7 | inconclusive* |
| calls, 20 clients | 60 | 0.935 s | 0.683 s | -26.9% | -29.7, -23.9 | **better** |
| signals, burst to 1 | 60 | 0.320 s | 0.207 s | -35.3% | -37.9, -32.5 | **better** |
| signals, broadcast to 20 | 60 | 0.192 s | 0.176 s | -8.5% | -12.4, -4.3 | inconclusive* |
| RTT, 1 client, p50 | 60 | 111 µs | 104 µs | -6.2% | -8.1, -4.3 | inconclusive* |
| RTT, 1 client, p99 | 60 | 230 µs | 216 µs | -6.3% | -11.5, -0.9 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 902 µs | 654 µs | -27.6% | -31.6, -23.3 | **better** |
| RTT, 20 clients, p99 | 60 | 1492 µs | 1162 µs | -22.1% | -25.7, -18.3 | **better** |
| delivery to 20, p50 | 60 | 2.8 ms | 2.9 ms | +3.3% | -2.3, +9.1 | inconclusive |
| delivery to 20, p99 | 60 | 13.0 ms | 10.3 ms | -20.9% | -53.2, +24.0 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.068 s | 0.064 s | -7.1% | -17.2, +1.9 | inconclusive |
| 100 callers, 1 connection | 40 | 2.02 s | 1.73 s | -14.0% | -16.3, -11.8 | **better** |
| 100 clients | 40 | 5.23 s | 3.94 s | -24.6% | -26.6, -22.7 | **better** |
| dict calls, 1 client | 60 | 0.153 s | 0.152 s | -0.5% | -3.1, +2.1 | within ±5% |
| dict calls, 20 clients | 60 | 0.769 s | 0.724 s | -5.8% | -10.1, -1.5 | inconclusive* |
| calls, broker CPU | 60 | 0.97 s | 0.71 s | -26.7% | -29.5, -23.7 | **better** |
| signals, broker CPU | 60 | 0.47 s | 0.33 s | -29.3% | -31.6, -26.9 | **better** |
| latency, broker CPU | 60 | 1.25 s | 0.97 s | -22.7% | -25.4, -20.0 | **better** |
| shared, broker CPU | 40 | 6.96 s | 5.33 s | -23.4% | -24.8, -21.9 | **better** |
| dicts, broker CPU | 60 | 0.80 s | 0.76 s | -5.7% | -9.9, -1.6 | inconclusive* |
| calls, broker user time | 60 | 0.41 s | 0.25 s | -38.0% | -40.9, -34.9 | **better** |
| signals, broker user time | 60 | 0.29 s | 0.16 s | -44.7% | -47.4, -41.8 | **better** |
| latency, broker user time | 60 | 0.53 s | 0.34 s | -35.5% | -38.0, -33.0 | **better** |
| shared, broker user time | 40 | 3.30 s | 2.21 s | -33.2% | -34.7, -31.6 | **better** |
| dicts, broker user time | 60 | 0.40 s | 0.37 s | -7.7% | -11.7, -3.4 | inconclusive* |
| calls, broker system time | 60 | 0.56 s | 0.46 s | -18.5% | -22.3, -14.4 | **better** |
| signals, broker system time | 60 | 0.18 s | 0.17 s | -4.0% | -8.8, +1.1 | inconclusive |
| latency, broker system time | 60 | 0.72 s | 0.62 s | -13.2% | -17.0, -9.1 | **better** |
| shared, broker system time | 40 | 3.66 s | 3.13 s | -14.5% | -16.5, -12.6 | **better** |
| dicts, broker system time | 60 | 0.40 s | 0.39 s | -3.8% | -9.0, +1.4 | inconclusive |
| calls, broker peak RSS | 60 | 5.1 MiB | 5.2 MiB | +2.5% | +1.9, +3.0 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.7 MiB | +0.2% | -0.2, +0.7 | within ±5% |
| latency, broker peak RSS | 60 | 5.1 MiB | 5.3 MiB | +2.1% | +1.6, +2.7 | within ±5%* |
| shared, broker peak RSS | 40 | 8.0 MiB | 8.2 MiB | +1.8% | +1.0, +2.7 | within ±5%* |
| dicts, broker peak RSS | 60 | 4.9 MiB | 5.0 MiB | +2.2% | +1.7, +2.7 | within ±5%* |

### after against unchecked

| Measure | n | unchecked | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.122 s | 0.123 s | +0.4% | -2.3, +3.2 | within ±5% |
| calls, 20 clients | 60 | 0.704 s | 0.683 s | -3.0% | -7.0, +1.2 | inconclusive |
| signals, burst to 1 | 60 | 0.212 s | 0.207 s | -2.4% | -6.0, +1.2 | inconclusive |
| signals, broadcast to 20 | 60 | 0.179 s | 0.176 s | -1.5% | -4.8, +1.9 | within ±5% |
| RTT, 1 client, p50 | 60 | 102 µs | 104 µs | +1.6% | -0.4, +3.6 | within ±5% |
| RTT, 1 client, p99 | 60 | 213 µs | 216 µs | +1.2% | -3.8, +6.7 | inconclusive |
| RTT, 20 clients, p50 | 60 | 651 µs | 654 µs | +0.4% | -6.0, +7.6 | inconclusive |
| RTT, 20 clients, p99 | 60 | 1237 µs | 1162 µs | -6.1% | -11.1, -0.6 | inconclusive* |
| delivery to 20, p50 | 60 | 3.0 ms | 2.9 ms | -0.9% | -6.3, +4.9 | inconclusive |
| delivery to 20, p99 | 60 | 10.9 ms | 10.3 ms | -6.3% | -18.4, +7.9 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.064 s | 0.064 s | -0.8% | -6.5, +5.3 | inconclusive |
| 100 callers, 1 connection | 40 | 1.75 s | 1.73 s | -0.9% | -3.1, +1.3 | within ±5% |
| 100 clients | 40 | 3.98 s | 3.94 s | -1.1% | -4.2, +2.3 | within ±5% |
| dict calls, 1 client | 60 | 0.147 s | 0.152 s | +3.5% | +0.9, +6.2 | inconclusive* |
| dict calls, 20 clients | 60 | 0.617 s | 0.724 s | +17.3% | +13.2, +21.7 | **worse** |
| calls, broker CPU | 60 | 0.73 s | 0.71 s | -2.8% | -6.8, +1.3 | inconclusive |
| signals, broker CPU | 60 | 0.34 s | 0.33 s | -2.3% | -5.0, +0.4 | within ±5% |
| latency, broker CPU | 60 | 0.97 s | 0.97 s | -0.0% | -3.9, +4.1 | within ±5% |
| shared, broker CPU | 40 | 5.39 s | 5.33 s | -1.0% | -3.3, +1.3 | within ±5% |
| dicts, broker CPU | 60 | 0.64 s | 0.76 s | +18.5% | +14.3, +22.8 | **worse** |
| calls, broker user time | 60 | 0.26 s | 0.25 s | -2.2% | -6.8, +2.5 | inconclusive |
| signals, broker user time | 60 | 0.16 s | 0.16 s | -1.7% | -6.8, +3.5 | inconclusive |
| latency, broker user time | 60 | 0.34 s | 0.34 s | +0.6% | -2.8, +4.2 | within ±5% |
| shared, broker user time | 40 | 2.20 s | 2.21 s | +0.4% | -1.8, +2.7 | within ±5% |
| dicts, broker user time | 60 | 0.26 s | 0.37 s | +43.1% | +36.9, +49.4 | **worse** |
| calls, broker system time | 60 | 0.47 s | 0.46 s | -3.1% | -8.0, +2.0 | inconclusive |
| signals, broker system time | 60 | 0.17 s | 0.17 s | -2.8% | -7.2, +1.7 | inconclusive |
| latency, broker system time | 60 | 0.62 s | 0.62 s | -0.4% | -5.4, +5.1 | within ±5% |
| shared, broker system time | 40 | 3.19 s | 3.13 s | -2.1% | -5.1, +1.2 | within ±5% |
| dicts, broker system time | 60 | 0.38 s | 0.39 s | +1.9% | -2.9, +6.7 | inconclusive |
| calls, broker peak RSS | 60 | 5.2 MiB | 5.2 MiB | -0.4% | -0.9, +0.2 | within ±5% |
| signals, broker peak RSS | 60 | 4.8 MiB | 4.7 MiB | -0.3% | -0.6, +0.0 | within ±5% |
| latency, broker peak RSS | 60 | 5.3 MiB | 5.3 MiB | -0.1% | -0.6, +0.3 | within ±5% |
| shared, broker peak RSS | 40 | 8.1 MiB | 8.2 MiB | +0.6% | -0.5, +1.7 | within ±5% |
| dicts, broker peak RSS | 60 | 5.0 MiB | 5.0 MiB | -0.3% | -0.8, +0.1 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.137 s | 0.123 s | -10.4% | -12.8, -7.8 | **better** |
| calls, 20 clients | 60 | 0.584 s | 0.683 s | +17.0% | +12.0, +22.3 | **worse** |
| signals, burst to 1 | 60 | 0.233 s | 0.207 s | -11.1% | -15.3, -6.7 | **better** |
| signals, broadcast to 20 | 60 | 0.302 s | 0.176 s | -41.7% | -45.0, -38.1 | **better** |
| RTT, 1 client, p50 | 60 | 117 µs | 104 µs | -11.2% | -13.0, -9.3 | **better** |
| RTT, 1 client, p99 | 60 | 238 µs | 216 µs | -9.2% | -14.0, -4.0 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 554 µs | 654 µs | +18.1% | +10.7, +26.2 | **worse** |
| RTT, 20 clients, p99 | 60 | 1079 µs | 1162 µs | +7.7% | -0.0, +15.1 | inconclusive |
| delivery to 20, p50 | 60 | 5.0 ms | 2.9 ms | -40.7% | -58.0, -15.5 | **better** |
| delivery to 20, p99 | 60 | 19.7 ms | 10.3 ms | -48.0% | -59.5, -30.7 | **better** |
| delivery to 20, whole fan-out | 60 | 0.110 s | 0.064 s | -42.3% | -46.4, -37.8 | **better** |
| 100 callers, 1 connection | 40 | 1.98 s | 1.73 s | -12.7% | -15.5, -9.8 | **better** |
| 100 clients | 40 | 2.50 s | 3.94 s | +57.6% | +52.1, +63.2 | **worse** |
| dict calls, 1 client | 60 | 0.181 s | 0.152 s | -16.0% | -18.2, -13.8 | **better** |
| dict calls, 20 clients | 60 | 0.988 s | 0.724 s | -26.7% | -29.6, -23.8 | **better** |
| calls, broker CPU | 60 | 0.61 s | 0.71 s | +16.0% | +11.2, +21.1 | **worse** |
| signals, broker CPU | 60 | 0.52 s | 0.33 s | -36.5% | -39.5, -33.2 | **better** |
| latency, broker CPU | 60 | 0.92 s | 0.97 s | +5.5% | +1.7, +9.4 | inconclusive* |
| shared, broker CPU | 40 | 4.27 s | 5.33 s | +24.8% | +21.7, +27.9 | **worse** |
| dicts, broker CPU | 60 | 1.04 s | 0.76 s | -27.0% | -29.7, -24.2 | **better** |
| calls, broker user time | 60 | 0.14 s | 0.25 s | +75.1% | +66.2, +84.8 | **worse** |
| signals, broker user time | 60 | 0.15 s | 0.16 s | +8.1% | +1.7, +15.4 | inconclusive* |
| latency, broker user time | 60 | 0.21 s | 0.34 s | +63.1% | +57.4, +68.8 | **worse** |
| shared, broker user time | 40 | 1.17 s | 2.21 s | +88.9% | +83.7, +94.0 | **worse** |
| dicts, broker user time | 60 | 0.59 s | 0.37 s | -38.0% | -40.7, -35.1 | **better** |
| calls, broker system time | 60 | 0.47 s | 0.46 s | -2.3% | -7.4, +3.1 | inconclusive |
| signals, broker system time | 60 | 0.37 s | 0.17 s | -54.4% | -57.0, -51.5 | **better** |
| latency, broker system time | 60 | 0.70 s | 0.62 s | -11.7% | -15.8, -7.4 | **better** |
| shared, broker system time | 40 | 3.10 s | 3.13 s | +0.7% | -2.2, +3.6 | within ±5% |
| dicts, broker system time | 60 | 0.44 s | 0.39 s | -12.3% | -15.9, -8.5 | **better** |
| calls, broker peak RSS | 60 | 6.5 MiB | 5.2 MiB | -19.6% | -19.9, -19.2 | **better** |
| signals, broker peak RSS | 60 | 9.4 MiB | 4.7 MiB | -49.7% | -53.2, -45.9 | **better** |
| latency, broker peak RSS | 60 | 7.3 MiB | 5.3 MiB | -28.1% | -31.8, -24.7 | **better** |
| shared, broker peak RSS | 40 | 7.6 MiB | 8.2 MiB | +7.4% | +6.5, +8.2 | **worse** |
| dicts, broker peak RSS | 60 | 6.4 MiB | 5.0 MiB | -20.9% | -21.1, -20.6 | **better** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.137 s | 0.131 s | -4.1% | -6.8, -1.3 | inconclusive* |
| calls, 20 clients | 60 | 0.584 s | 0.935 s | +60.1% | +54.1, +66.4 | **worse** |
| signals, burst to 1 | 60 | 0.233 s | 0.320 s | +37.3% | +30.8, +44.0 | **worse** |
| signals, broadcast to 20 | 60 | 0.302 s | 0.192 s | -36.3% | -40.1, -32.2 | **better** |
| RTT, 1 client, p50 | 60 | 117 µs | 111 µs | -5.3% | -7.3, -3.3 | inconclusive* |
| RTT, 1 client, p99 | 60 | 238 µs | 230 µs | -3.1% | -7.5, +1.2 | inconclusive |
| RTT, 20 clients, p50 | 60 | 554 µs | 902 µs | +63.0% | +54.2, +72.0 | **worse** |
| RTT, 20 clients, p99 | 60 | 1079 µs | 1492 µs | +38.2% | +28.2, +47.9 | **worse** |
| delivery to 20, p50 | 60 | 5.0 ms | 2.8 ms | -42.7% | -58.9, -18.8 | **better** |
| delivery to 20, p99 | 60 | 19.7 ms | 13.0 ms | -34.2% | -61.6, +18.4 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.110 s | 0.068 s | -37.9% | -44.5, -28.4 | **better** |
| 100 callers, 1 connection | 40 | 1.98 s | 2.02 s | +1.6% | -1.4, +4.6 | within ±5% |
| 100 clients | 40 | 2.50 s | 5.23 s | +109.1% | +103.2, +114.9 | **worse** |
| dict calls, 1 client | 60 | 0.181 s | 0.153 s | -15.6% | -17.9, -13.2 | **better** |
| dict calls, 20 clients | 60 | 0.988 s | 0.769 s | -22.2% | -25.5, -18.8 | **better** |
| calls, broker CPU | 60 | 0.61 s | 0.97 s | +58.3% | +52.6, +64.1 | **worse** |
| signals, broker CPU | 60 | 0.52 s | 0.47 s | -10.1% | -14.4, -5.8 | **better** |
| latency, broker CPU | 60 | 0.92 s | 1.25 s | +36.5% | +32.0, +41.1 | **worse** |
| shared, broker CPU | 40 | 4.27 s | 6.96 s | +62.9% | +59.2, +66.6 | **worse** |
| dicts, broker CPU | 60 | 1.04 s | 0.80 s | -22.5% | -25.7, -19.2 | **better** |
| calls, broker user time | 60 | 0.14 s | 0.41 s | +182.5% | +167.9, +197.6 | **worse** |
| signals, broker user time | 60 | 0.15 s | 0.29 s | +95.5% | +83.7, +107.9 | **worse** |
| latency, broker user time | 60 | 0.21 s | 0.53 s | +153.1% | +143.1, +163.7 | **worse** |
| shared, broker user time | 40 | 1.17 s | 3.30 s | +182.6% | +174.6, +190.5 | **worse** |
| dicts, broker user time | 60 | 0.59 s | 0.40 s | -32.8% | -35.5, -29.8 | **better** |
| calls, broker system time | 60 | 0.47 s | 0.56 s | +20.0% | +15.2, +24.8 | **worse** |
| signals, broker system time | 60 | 0.37 s | 0.18 s | -52.5% | -55.3, -49.5 | **better** |
| latency, broker system time | 60 | 0.70 s | 0.72 s | +1.7% | -2.5, +6.0 | inconclusive |
| shared, broker system time | 40 | 3.10 s | 3.66 s | +17.8% | +14.8, +20.9 | **worse** |
| dicts, broker system time | 60 | 0.44 s | 0.40 s | -8.8% | -13.6, -3.8 | inconclusive* |
| calls, broker peak RSS | 60 | 6.5 MiB | 5.1 MiB | -21.5% | -21.9, -21.1 | **better** |
| signals, broker peak RSS | 60 | 9.4 MiB | 4.7 MiB | -49.8% | -53.3, -46.0 | **better** |
| latency, broker peak RSS | 60 | 7.3 MiB | 5.1 MiB | -29.6% | -33.2, -26.2 | **better** |
| shared, broker peak RSS | 40 | 7.6 MiB | 8.0 MiB | +5.5% | +4.5, +6.4 | inconclusive* |
| dicts, broker peak RSS | 60 | 6.4 MiB | 4.9 MiB | -22.5% | -22.8, -22.2 | **better** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.141 s | 0.123 s | -12.9% | -16.0, -9.8 | **better** |
| calls, 20 clients | 60 | 1.192 s | 0.683 s | -42.7% | -44.8, -40.4 | **better** |
| signals, burst to 1 | 60 | 0.560 s | 0.207 s | -63.0% | -64.4, -61.5 | **better** |
| signals, broadcast to 20 | 60 | 1.148 s | 0.176 s | -84.7% | -85.4, -83.9 | **better** |
| RTT, 1 client, p50 | 60 | 111 µs | 104 µs | -6.7% | -8.6, -4.6 | inconclusive* |
| RTT, 1 client, p99 | 60 | 226 µs | 216 µs | -4.5% | -8.8, +0.2 | inconclusive |
| RTT, 20 clients, p50 | 60 | 1137 µs | 654 µs | -42.5% | -45.6, -39.2 | **better** |
| RTT, 20 clients, p99 | 60 | 1806 µs | 1162 µs | -35.7% | -38.7, -32.4 | **better** |
| delivery to 20, p50 | 60 | 11.0 ms | 2.9 ms | -73.3% | -75.0, -71.5 | **better** |
| delivery to 20, p99 | 60 | 22.6 ms | 10.3 ms | -54.7% | -59.2, -49.2 | **better** |
| delivery to 20, whole fan-out | 60 | 0.375 s | 0.064 s | -83.1% | -84.1, -81.9 | **better** |
| 100 callers, 1 connection | 40 | 5.33 s | 1.73 s | -67.5% | -68.2, -66.7 | **better** |
| 100 clients | 40 | 5.70 s | 3.94 s | -30.9% | -32.6, -29.1 | **better** |
| dict calls, 1 client | 60 | 0.181 s | 0.152 s | -16.1% | -18.3, -13.9 | **better** |
| dict calls, 20 clients | 60 | 1.430 s | 0.724 s | -49.3% | -50.9, -47.7 | **better** |
| calls, broker CPU | 60 | 1.24 s | 0.71 s | -42.7% | -44.8, -40.5 | **better** |
| signals, broker CPU | 60 | 1.69 s | 0.33 s | -80.5% | -81.2, -79.7 | **better** |
| latency, broker CPU | 60 | 1.84 s | 0.97 s | -47.6% | -49.3, -45.9 | **better** |
| shared, broker CPU | 40 | 10.79 s | 5.33 s | -50.6% | -51.4, -49.7 | **better** |
| dicts, broker CPU | 60 | 1.50 s | 0.76 s | -49.5% | -51.0, -47.9 | **better** |
| calls, broker user time | 60 | 0.61 s | 0.25 s | -58.6% | -60.2, -56.9 | **better** |
| signals, broker user time | 60 | 0.62 s | 0.16 s | -74.1% | -75.1, -72.9 | **better** |
| latency, broker user time | 60 | 0.82 s | 0.34 s | -57.9% | -59.2, -56.6 | **better** |
| shared, broker user time | 40 | 5.65 s | 2.21 s | -61.0% | -61.7, -60.2 | **better** |
| dicts, broker user time | 60 | 1.03 s | 0.37 s | -64.3% | -65.5, -63.0 | **better** |
| calls, broker system time | 60 | 0.63 s | 0.46 s | -27.4% | -30.6, -24.0 | **better** |
| signals, broker system time | 60 | 1.07 s | 0.17 s | -84.2% | -85.0, -83.4 | **better** |
| latency, broker system time | 60 | 1.03 s | 0.62 s | -39.4% | -42.1, -36.6 | **better** |
| shared, broker system time | 40 | 5.14 s | 3.13 s | -39.2% | -40.6, -37.6 | **better** |
| dicts, broker system time | 60 | 0.47 s | 0.39 s | -16.8% | -20.3, -13.0 | **better** |
| calls, broker peak RSS | 60 | 5.2 MiB | 5.2 MiB | -0.8% | -1.3, -0.3 | within ±5%* |
| signals, broker peak RSS | 60 | 4.6 MiB | 4.7 MiB | +2.5% | +0.2, +4.5 | within ±5%* |
| latency, broker peak RSS | 60 | 5.3 MiB | 5.3 MiB | -0.1% | -0.6, +0.5 | within ±5% |
| shared, broker peak RSS | 40 | 8.4 MiB | 8.2 MiB | -2.9% | -3.6, -2.1 | within ±5%* |
| dicts, broker peak RSS | 60 | 4.8 MiB | 5.0 MiB | +4.1% | +3.7, +4.5 | within ±5%* |

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at aba31e9 builds the brokers and runs all of this, in about 48 minutes on this VM once the builds
are made, and writes its results to `$WORK/batched-sends-results-fd577a2`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. It ran with dbus-broker 37
first on the `PATH`, and with fake-journald.py started before it, in the same job, as a copy of it
that ran on its own had gone by the time of a run before this one.
