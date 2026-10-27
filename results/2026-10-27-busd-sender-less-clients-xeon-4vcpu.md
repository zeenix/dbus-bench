# busd checking the messages of clients that leave the sender out, on a 4-vCPU Xeon

Measured on 2026-10-27 on the VM of [busd checking the messages of its
clients](2026-10-27-busd-message-checks-xeon-4vcpu.md): 4 vCPUs of an Intel Xeon @ 2.10GHz under
KVM, 15 GiB, Linux 6.18, Ubuntu 24.04.5. It ran `scripts/compare-batched-sends.sh` at 8f59742,
which made every build of busd with rustc 1.97.0. dbus-broker is 37, built from source with meson's
release build type and its default options otherwise, and ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py). dbus-daemon is
the 1.14.10 of Ubuntu 24.04. Compare the brokers with each other, within this file only.

The builds of busd:

* **before**: 227254e, busd's main branch, on zbus 50c54bf and zruntime b3bd01d, which builds each
  message that a client leaves the sender out of anew, with the field added;
* **after**: fd577a2 of zeenix/busd, the head of z-galaxy/busd#391, on the same zruntime and on zbus
  8cb16a2 of zeenix/zbus, the head of z-galaxy/zbus#2086. It checks the messages of its clients as
  a whole, and their bodies against their signatures, passes on only the replies that answer a call
  that waits for one, and sets the sender of a message that a client leaves it out of with
  `Message::with_sender`, which copies the bytes of the message with the field appended.

The clients are those of 8f59742, which build each message that is timed themselves and leave the
sender out of it, as libdbus, GLib and sd-bus clients do: the calls, the replies of the services and
the signals. Only `Hello`, `RequestName` and `AddMatch` go through zbus's API, which sets the sender
of the last two. A trace of after has it set the sender of 42,042 messages of the benchmark of
method calls, 46,023 of `fanout`, 52,063 of `latency` and 400,202 of `shared`: all of their calls,
replies and signals, and the `Hello` of each connection. The clients of [the run of
before](2026-10-27-busd-message-checks-xeon-4vcpu.md) set the sender of each message, as zbus does,
so its after had busd set it for the `Hello`s alone.

## Summary

* After against before, busd uses 21 to 27% less CPU time on every workload, with 32 to 43% less
  user time. It takes 26.8% less time on the calls of 20 clients, 35.2% less on the burst of signals
  to one subscriber, 24.9% less on the median round trip of 20 clients and 19.1% less at p99, and
  13.1% and 22.6% less on the shared phases. One client's calls take 6.0% less (inconclusive, but
  repeatable) and its median round trip 7.6% less. The broadcast to 20 subscribers, and the
  latencies' fan-out, whose signals busd receives once each, however many subscribers it passes
  them on to, take as long, or 3.8% less (inconclusive, but repeatable). Its peak memory is up to
  2.7%, 141 KiB, higher.
* That is what setting the sender takes, which after does for less. With clients that set the
  sender, in [the run of before](2026-10-27-busd-message-checks-xeon-4vcpu.md), after took as long
  as before on every workload, within the margin of ±5%.
* So after takes busd much closer to dbus-broker than before was, for such clients. With 20
  clients, busd's calls take 16.6% longer than dbus-broker's, against 59.2%, its median round trip
  20.1% longer, against 60.0%, and with 100 clients, busd takes 56.8% longer, against 102.6%. The
  burst of signals, which took 40.6% longer than with dbus-broker, takes 8.9% less (inconclusive,
  but repeatable), and busd is faster with one client, on the broadcast, on the latencies' fan-out
  and on the first shared phase. It uses 16.0% more CPU time on the calls, against 58.5%,
  and 23.5% more on the shared phases, against 57.4%.
* But busd is still further behind dbus-broker with these clients than with the clients that set
  the sender: in the run of before, after's calls of 20 clients took 9.9% longer than dbus-broker's,
  its median round trip 9.8% longer, and its 100 clients 37.4% longer (see
  [below](#what-leaving-the-sender-out-costs-each-broker)).
* No run of any broker failed.

The gap to dbus-broker, from the tables below, as how much longer busd takes than dbus-broker, or
how much more it uses (a negative one is how much less):

| Measure | before | after |
|---|---:|---:|
| calls, 1 client | -3.6% | -9.4% |
| calls, 20 clients | +59.2% | +16.6% |
| signals, burst to 1 | +40.6% | -8.9% |
| signals, broadcast to 20 | -36.9% | -39.3% |
| RTT, 1 client, p50 | -4.7% | -11.9% |
| RTT, 1 client, p99 | -2.9% | -8.8% |
| RTT, 20 clients, p50 | +60.0% | +20.1% |
| RTT, 20 clients, p99 | +46.0% | +18.2% |
| delivery to 20, p50 | -19.9% | -20.9% |
| delivery to 20, p99 | -34.0% | -37.4% |
| delivery to 20, whole fan-out | -42.1% | -43.4% |
| 100 callers, 1 connection | -0.9% | -13.9% |
| 100 clients | +102.6% | +56.8% |
| calls, broker CPU | +58.5% | +16.0% |
| signals, broker CPU | -9.6% | -34.4% |
| latency, broker CPU | +35.1% | +6.6% |
| shared, broker CPU | +57.4% | +23.5% |

## What leaving the sender out costs each broker

This run and [the run of before](2026-10-27-busd-message-checks-xeon-4vcpu.md) differ in the clients
alone, but for after, which was 50bf523 there, which runs the same code as fd577a2 for clients that
set the sender. How much longer each broker takes with the clients that leave the sender out, from
the means of the two runs, which ran one after the other on the same VM but are not paired, so that
a difference of a few percent is within what two runs differ by:

| Measure | before | after | dbus-broker | dbus-daemon |
|---|---:|---:|---:|---:|
| calls, 1 client | -1.4% | -8.6% | -9.3% | -13.3% |
| calls, 20 clients | +40.4% | +2.8% | -3.1% | -18.0% |
| signals, burst to 1 | +53.8% | -3.5% | -15.3% | -31.4% |
| signals, broadcast to 20 | -0.9% | -6.8% | -11.0% | -3.5% |
| RTT, 1 client, p50 | +8.8% | +0.1% | -1.3% | -6.9% |
| RTT, 20 clients, p50 | +67.1% | +24.4% | +13.7% | -7.0% |
| delivery to 20, whole fan-out | +5.8% | +0.7% | +3.5% | +9.0% |
| 100 callers, 1 connection | +19.2% | +6.5% | -1.8% | -11.4% |
| 100 clients | +55.3% | +16.9% | +2.4% | -13.9% |
| calls, broker CPU | +41.4% | +3.1% | -3.6% | -17.7% |
| signals, broker CPU | +35.9% | -4.4% | -13.9% | -15.1% |
| latency, broker CPU | +48.3% | +15.5% | +8.1% | -4.8% |
| shared, broker CPU | +49.0% | +16.0% | +2.9% | -12.5% |

The clients changed in more than the sender: they no longer go through zbus's proxies and object
server, which gives every broker other timings. dbus-broker writes its sender field into every
message that it receives, whether the client set one or not, in buffers of its own that it sends
along with the message (`message_stitch_sender`), so the sender is no work for it either way. It
takes as long or less with these clients on all but the round trips of 20 clients, and dbus-daemon
takes 3 to 31% less on all but the latencies' fan-out. Against those, messages without a sender
cost before 19 to 55% more time on the calls of 20 clients, the burst of signals and the shared
phases, and after 17% more at most. The round trips of 20 clients take longer with every broker but
dbus-daemon, dbus-broker's 13.7% longer, so part of their 67.1% with before and 24.4% with after is
the clients'.

## The benchmarks

The workloads and the comparisons are those of [the run of
before](2026-10-27-busd-message-checks-xeon-4vcpu.md#the-benchmarks), with the clients of 8f59742:
60 rounds of each workload, and 40 of the shared phases, after 3 of warm-up, all four brokers in
each round. The callers of the first shared phase are 100 tasks that share a client connection, as
the 100 proxies of before were. The raw results are in
[runs.tar.xz](2026-10-27-busd-sender-less-clients-xeon-4vcpu/runs.tar.xz). The values are means
over the rounds, and a star marks a difference whose 95% interval excludes 0 but not the margin.

### after against before

| Measure | n | before | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.128 s | 0.121 s | -6.0% | -8.9, -2.9 | inconclusive* |
| calls, 20 clients | 60 | 0.917 s | 0.671 s | -26.8% | -29.2, -24.2 | **better** |
| signals, burst to 1 | 60 | 0.317 s | 0.205 s | -35.2% | -37.4, -32.9 | **better** |
| signals, broadcast to 20 | 60 | 0.186 s | 0.179 s | -3.8% | -7.1, -0.3 | inconclusive* |
| RTT, 1 client, p50 | 60 | 116 µs | 107 µs | -7.6% | -9.4, -5.6 | **better** |
| RTT, 1 client, p99 | 60 | 233 µs | 219 µs | -6.1% | -13.1, +1.3 | inconclusive |
| RTT, 20 clients, p50 | 60 | 959 µs | 720 µs | -24.9% | -28.5, -21.2 | **better** |
| RTT, 20 clients, p99 | 60 | 1567 µs | 1269 µs | -19.1% | -25.7, -11.8 | **better** |
| delivery to 20, p50 | 60 | 3.2 ms | 3.2 ms | -1.2% | -7.6, +5.4 | inconclusive |
| delivery to 20, p99 | 60 | 11.1 ms | 10.6 ms | -5.0% | -17.2, +8.6 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.070 s | 0.068 s | -2.3% | -7.2, +2.6 | inconclusive |
| 100 callers, 1 connection | 40 | 2.10 s | 1.82 s | -13.1% | -15.8, -10.2 | **better** |
| 100 clients | 40 | 5.40 s | 4.18 s | -22.6% | -24.7, -20.4 | **better** |
| calls, broker CPU | 60 | 0.95 s | 0.69 s | -26.9% | -29.2, -24.4 | **better** |
| signals, broker CPU | 60 | 0.45 s | 0.33 s | -27.4% | -29.7, -25.1 | **better** |
| latency, broker CPU | 60 | 1.32 s | 1.04 s | -21.1% | -23.5, -18.7 | **better** |
| shared, broker CPU | 40 | 7.20 s | 5.64 s | -21.6% | -23.5, -19.6 | **better** |
| calls, broker user time | 60 | 0.40 s | 0.25 s | -36.0% | -38.4, -33.4 | **better** |
| signals, broker user time | 60 | 0.28 s | 0.16 s | -43.1% | -45.8, -40.3 | **better** |
| latency, broker user time | 60 | 0.57 s | 0.37 s | -34.8% | -37.2, -32.3 | **better** |
| shared, broker user time | 40 | 3.44 s | 2.32 s | -32.5% | -34.2, -30.7 | **better** |
| calls, broker system time | 60 | 0.55 s | 0.44 s | -20.3% | -23.5, -16.8 | **better** |
| signals, broker system time | 60 | 0.17 s | 0.17 s | -1.2% | -6.5, +4.7 | inconclusive |
| latency, broker system time | 60 | 0.75 s | 0.67 s | -10.7% | -14.1, -7.1 | **better** |
| shared, broker system time | 40 | 3.76 s | 3.32 s | -11.6% | -14.0, -9.1 | **better** |
| calls, broker peak RSS | 60 | 5.1 MiB | 5.2 MiB | +2.4% | +1.9, +2.9 | within ±5%* |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.7 MiB | +0.3% | -0.0, +0.7 | within ±5% |
| latency, broker peak RSS | 60 | 5.1 MiB | 5.3 MiB | +2.7% | +2.2, +3.2 | within ±5%* |
| shared, broker peak RSS | 40 | 8.1 MiB | 8.2 MiB | +1.2% | -0.0, +2.4 | within ±5% |

### after against dbus-broker

| Measure | n | dbus-broker | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.133 s | 0.121 s | -9.4% | -12.4, -6.4 | **better** |
| calls, 20 clients | 60 | 0.576 s | 0.671 s | +16.6% | +11.9, +21.4 | **worse** |
| signals, burst to 1 | 60 | 0.225 s | 0.205 s | -8.9% | -13.2, -4.2 | inconclusive* |
| signals, broadcast to 20 | 60 | 0.294 s | 0.179 s | -39.3% | -42.5, -35.7 | **better** |
| RTT, 1 client, p50 | 60 | 121 µs | 107 µs | -11.9% | -13.7, -10.1 | **better** |
| RTT, 1 client, p99 | 60 | 240 µs | 219 µs | -8.8% | -13.8, -3.5 | inconclusive* |
| RTT, 20 clients, p50 | 60 | 599 µs | 720 µs | +20.1% | +11.9, +28.5 | **worse** |
| RTT, 20 clients, p99 | 60 | 1074 µs | 1269 µs | +18.2% | +10.8, +26.0 | **worse** |
| delivery to 20, p50 | 60 | 4.0 ms | 3.2 ms | -20.9% | -30.3, -11.5 | **better** |
| delivery to 20, p99 | 60 | 16.9 ms | 10.6 ms | -37.4% | -51.1, -18.7 | **better** |
| delivery to 20, whole fan-out | 60 | 0.120 s | 0.068 s | -43.4% | -46.8, -39.6 | **better** |
| 100 callers, 1 connection | 40 | 2.12 s | 1.82 s | -13.9% | -17.1, -10.5 | **better** |
| 100 clients | 40 | 2.67 s | 4.18 s | +56.8% | +52.6, +61.0 | **worse** |
| calls, broker CPU | 60 | 0.60 s | 0.69 s | +16.0% | +11.5, +20.6 | **worse** |
| signals, broker CPU | 60 | 0.50 s | 0.33 s | -34.4% | -37.2, -31.4 | **better** |
| latency, broker CPU | 60 | 0.98 s | 1.04 s | +6.6% | +2.4, +10.8 | inconclusive* |
| shared, broker CPU | 40 | 4.57 s | 5.64 s | +23.5% | +20.0, +27.1 | **worse** |
| calls, broker user time | 60 | 0.14 s | 0.25 s | +75.9% | +66.7, +85.3 | **worse** |
| signals, broker user time | 60 | 0.14 s | 0.16 s | +15.3% | +7.8, +23.4 | **worse** |
| latency, broker user time | 60 | 0.22 s | 0.37 s | +65.3% | +57.5, +73.8 | **worse** |
| shared, broker user time | 40 | 1.25 s | 2.32 s | +86.1% | +81.1, +91.1 | **worse** |
| calls, broker system time | 60 | 0.45 s | 0.44 s | -3.2% | -7.5, +1.3 | inconclusive |
| signals, broker system time | 60 | 0.36 s | 0.17 s | -53.7% | -56.7, -50.5 | **better** |
| latency, broker system time | 60 | 0.75 s | 0.67 s | -11.0% | -15.2, -6.6 | **better** |
| shared, broker system time | 40 | 3.32 s | 3.32 s | -0.0% | -3.2, +3.3 | within ±5% |
| calls, broker peak RSS | 60 | 6.4 MiB | 5.2 MiB | -19.2% | -19.5, -18.8 | **better** |
| signals, broker peak RSS | 60 | 8.3 MiB | 4.7 MiB | -42.5% | -45.1, -39.9 | **better** |
| latency, broker peak RSS | 60 | 7.0 MiB | 5.3 MiB | -24.8% | -27.5, -22.4 | **better** |
| shared, broker peak RSS | 40 | 7.6 MiB | 8.2 MiB | +7.4% | +6.5, +8.5 | **worse** |

### before against dbus-broker

| Measure | n | dbus-broker | before | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.133 s | 0.128 s | -3.6% | -6.5, -0.9 | inconclusive* |
| calls, 20 clients | 60 | 0.576 s | 0.917 s | +59.2% | +54.4, +64.1 | **worse** |
| signals, burst to 1 | 60 | 0.225 s | 0.317 s | +40.6% | +34.0, +47.3 | **worse** |
| signals, broadcast to 20 | 60 | 0.294 s | 0.186 s | -36.9% | -40.0, -33.5 | **better** |
| RTT, 1 client, p50 | 60 | 121 µs | 116 µs | -4.7% | -6.4, -3.0 | inconclusive* |
| RTT, 1 client, p99 | 60 | 240 µs | 233 µs | -2.9% | -9.4, +4.8 | inconclusive |
| RTT, 20 clients, p50 | 60 | 599 µs | 959 µs | +60.0% | +51.7, +69.0 | **worse** |
| RTT, 20 clients, p99 | 60 | 1074 µs | 1567 µs | +46.0% | +35.2, +58.5 | **worse** |
| delivery to 20, p50 | 60 | 4.0 ms | 3.2 ms | -19.9% | -29.5, -10.8 | **better** |
| delivery to 20, p99 | 60 | 16.9 ms | 11.1 ms | -34.0% | -49.8, -13.4 | **better** |
| delivery to 20, whole fan-out | 60 | 0.120 s | 0.070 s | -42.1% | -45.6, -38.2 | **better** |
| 100 callers, 1 connection | 40 | 2.12 s | 2.10 s | -0.9% | -3.8, +2.3 | within ±5% |
| 100 clients | 40 | 2.67 s | 5.40 s | +102.6% | +96.9, +108.2 | **worse** |
| calls, broker CPU | 60 | 0.60 s | 0.95 s | +58.5% | +53.7, +63.5 | **worse** |
| signals, broker CPU | 60 | 0.50 s | 0.45 s | -9.6% | -13.6, -5.5 | **better** |
| latency, broker CPU | 60 | 0.98 s | 1.32 s | +35.1% | +31.1, +39.4 | **worse** |
| shared, broker CPU | 40 | 4.57 s | 7.20 s | +57.4% | +53.6, +61.3 | **worse** |
| calls, broker user time | 60 | 0.14 s | 0.40 s | +174.7% | +161.0, +189.3 | **worse** |
| signals, broker user time | 60 | 0.14 s | 0.28 s | +102.5% | +90.9, +114.7 | **worse** |
| latency, broker user time | 60 | 0.22 s | 0.57 s | +153.7% | +140.7, +166.7 | **worse** |
| shared, broker user time | 40 | 1.25 s | 3.44 s | +175.7% | +168.9, +182.7 | **worse** |
| calls, broker system time | 60 | 0.45 s | 0.55 s | +21.5% | +16.8, +26.2 | **worse** |
| signals, broker system time | 60 | 0.36 s | 0.17 s | -53.2% | -55.8, -50.5 | **better** |
| latency, broker system time | 60 | 0.75 s | 0.75 s | -0.4% | -3.8, +3.2 | within ±5% |
| shared, broker system time | 40 | 3.32 s | 3.76 s | +13.1% | +9.7, +16.5 | **worse** |
| calls, broker peak RSS | 60 | 6.4 MiB | 5.1 MiB | -21.1% | -21.5, -20.6 | **better** |
| signals, broker peak RSS | 60 | 8.3 MiB | 4.7 MiB | -42.7% | -45.3, -40.1 | **better** |
| latency, broker peak RSS | 60 | 7.0 MiB | 5.1 MiB | -26.8% | -29.5, -24.3 | **better** |
| shared, broker peak RSS | 40 | 7.6 MiB | 8.1 MiB | +6.2% | +5.3, +7.2 | **worse** |

### after against dbus-daemon

| Measure | n | dbus-daemon | after | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 client | 60 | 0.139 s | 0.121 s | -13.4% | -16.3, -10.3 | **better** |
| calls, 20 clients | 60 | 1.169 s | 0.671 s | -42.6% | -44.3, -40.8 | **better** |
| signals, burst to 1 | 60 | 0.558 s | 0.205 s | -63.2% | -64.6, -61.8 | **better** |
| signals, broadcast to 20 | 60 | 1.170 s | 0.179 s | -84.7% | -85.4, -83.9 | **better** |
| RTT, 1 client, p50 | 60 | 115 µs | 107 µs | -7.3% | -9.1, -5.5 | **better** |
| RTT, 1 client, p99 | 60 | 228 µs | 219 µs | -3.9% | -10.3, +2.9 | inconclusive |
| RTT, 20 clients, p50 | 60 | 1240 µs | 720 µs | -41.9% | -45.2, -38.6 | **better** |
| RTT, 20 clients, p99 | 60 | 1998 µs | 1269 µs | -36.5% | -40.4, -32.3 | **better** |
| delivery to 20, p50 | 60 | 12.3 ms | 3.2 ms | -74.0% | -75.9, -71.9 | **better** |
| delivery to 20, p99 | 60 | 24.1 ms | 10.6 ms | -56.2% | -59.9, -52.1 | **better** |
| delivery to 20, whole fan-out | 60 | 0.417 s | 0.068 s | -83.7% | -84.7, -82.6 | **better** |
| 100 callers, 1 connection | 40 | 5.50 s | 1.82 s | -66.8% | -67.7, -66.0 | **better** |
| 100 clients | 40 | 6.03 s | 4.18 s | -30.7% | -32.4, -28.8 | **better** |
| calls, broker CPU | 60 | 1.21 s | 0.69 s | -42.8% | -44.4, -41.1 | **better** |
| signals, broker CPU | 60 | 1.70 s | 0.33 s | -80.7% | -81.4, -79.9 | **better** |
| latency, broker CPU | 60 | 1.99 s | 1.04 s | -47.7% | -49.6, -45.7 | **better** |
| shared, broker CPU | 40 | 11.29 s | 5.64 s | -50.0% | -51.1, -49.0 | **better** |
| calls, broker user time | 60 | 0.60 s | 0.25 s | -57.4% | -58.9, -55.9 | **better** |
| signals, broker user time | 60 | 0.62 s | 0.16 s | -73.9% | -75.2, -72.6 | **better** |
| latency, broker user time | 60 | 0.88 s | 0.37 s | -57.5% | -59.0, -56.0 | **better** |
| shared, broker user time | 40 | 5.93 s | 2.32 s | -60.9% | -61.7, -60.1 | **better** |
| calls, broker system time | 60 | 0.61 s | 0.44 s | -28.6% | -31.2, -25.7 | **better** |
| signals, broker system time | 60 | 1.08 s | 0.17 s | -84.6% | -85.6, -83.5 | **better** |
| latency, broker system time | 60 | 1.11 s | 0.67 s | -39.9% | -42.6, -37.2 | **better** |
| shared, broker system time | 40 | 5.36 s | 3.32 s | -38.0% | -39.4, -36.6 | **better** |
| calls, broker peak RSS | 60 | 5.2 MiB | 5.2 MiB | -0.7% | -1.3, -0.2 | within ±5%* |
| signals, broker peak RSS | 60 | 4.6 MiB | 4.7 MiB | +3.8% | +2.7, +4.9 | within ±5%* |
| latency, broker peak RSS | 60 | 5.2 MiB | 5.3 MiB | +0.8% | +0.2, +1.3 | within ±5%* |
| shared, broker peak RSS | 40 | 8.5 MiB | 8.2 MiB | -3.4% | -4.4, -2.5 | within ±5%* |

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

at 8f59742 builds the brokers and runs all of this, in about 37 minutes on this VM once the builds
are made, and writes its results to `$WORK/batched-sends-results-fd577a2`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`. It ran with dbus-broker 37
first on the `PATH`, and with fake-journald.py started before it.
