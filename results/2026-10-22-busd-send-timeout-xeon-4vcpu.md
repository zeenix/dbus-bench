# busd with a time limit on its sends, rather than a queue for each client

Measured on 2026-10-22, on a cloud VM: 4 vCPUs of an Intel Xeon @ 2.10GHz under KVM, 15 GiB,
Linux 6.18, Ubuntu 24.04.5. Every build of busd was made with rustc 1.97.0, on zbus 6.0.0 and
zruntime 0.2.0, and dbus-broker is the 35 of Ubuntu 24.04. These numbers are not comparable with
those of the other files here: compare the builds with each other, within this file only.

The builds of busd, from z-galaxy/busd and from the `ccr-314882eb-9cvuxt` branch of zeenix/busd:

* **baseline**, 0c52e9c: main, with a queue of up to 127 MiB for each client (z-galaxy/busd#376),
  and #377 and #378.
* **revert**, 41407f0: main with the queue of #376 reverted: a send to a client waits for as long
  as it takes.
* **timeout**, 8d57e20: the revert, then a time limit of 1 s on each send, past which the bus
  disconnects the client.
* **timeout-rq256**, e93cec5 with [read-ahead.diff]: the time limit, with zbus reading 256 messages
  ahead from each client, rather than 64.

8d57e20 is an earlier version of e93cec5, the commit on the branch, that differs from it only in
comments, and 63d08b0, which the results of the read-ahead name, has the tree of e93cec5, with a
shorter commit message. timeout-rq256 is an experiment, for [the read-ahead](#more-read-ahead)
below, and not a proposal.

[read-ahead.diff]: 2026-10-22-busd-send-timeout-xeon-4vcpu/read-ahead.diff

[A later run](2026-10-22-busd-concurrent-sends-xeon-4vcpu.md) measures the branch with a time limit
of 100 ms and the sends of a message to all of its recipients at once.

## Summary

The time limit keeps a client that stops reading from freezing the bus, which is what the queue of
z-galaxy/busd#376 was for, with no queue or task of its own for each client, and with less memory.
It falls short of the queue, and of dbus-broker, on a connection that many calls share at once,
which serves the object that they call:

* **On zbus 4.3, with 100 proxies, busd disconnects the client**, in 3 runs out of 3 (and in 2 out
  of 3 with 96 proxies), where the queue and dbus-broker complete the phase in about 11 s.
* **On zbus 6, with 100 proxies, the phase is 12.8% slower than with the queue** (from +9.1 to
  +16.6%, 40 pairs, and +12.7% in a second comparison of 30). The revert alone is 10.7% slower,
  and the time limit adds nothing to that which the runs can tell.

Both come from forwarding with no queue: while busd waits for a recipient of a client's messages, it
reads no further ahead from that client than the 64 messages that zbus queues for it. Reading 256
ahead, an experiment, moves the point where the zbus 4.3 client gets disconnected from about 100
proxies to between 200 and 300, and takes back about half of the slowdown on zbus 6, which leaves it
5.8% behind the queue (from +2.0 to +9.7%).

Elsewhere, the time limit is level with the queue or better:

* Calls: within 5%, or inconclusive with intervals that reach no higher than +2.0% for the
  timings, +5.7% for the median latencies and +8.1% for the p99 ones, which vary a lot from run to
  run.
* Signals: a burst to one subscriber is 19.5% faster, with 91% less memory, as there is no queue
  to hold it. A broadcast to 20 subscribers takes as long as with the queue, within 5%, and each
  of its signals reaches the subscribers 61% sooner at the median.

Clients that stop reading hold up the others for longer than with the queue, by design: while K
frozen subscribers of the bus's signals stall, every message of the bus waits up to K times 1 s,
before the bus disconnects them: 1012, 2007 and 3007 ms with 1, 2 and 3 of them. The queue and
dbus-broker kept them, and answered every call within 49 ms.

## The benchmarks

Each comparison runs every build once per round, in an order shuffled for each round, on a fresh
broker each time, after 3 rounds of warm-up that the tables leave out, and compares the builds round
by round, in pairs, with [scripts/paired-stats.py](../scripts/paired-stats.py): the difference of
the means, in percent, with a bootstrap 95% confidence interval over the pairs, against a margin of
5%. "Within ±5%" means that the 90% interval lies within the margin, "better" or "worse" that the
95% interval lies beyond it, and "inconclusive" anything else. The workloads:

* **calls**: the benchmark itself, on zbus 6 (`src/main.rs`): a connection that serves an object
  calls it 1000 times through the bus, with 16 KiB each time, then 20 such connections at once.
* **signals**: [fanout](../src/bin/fanout.rs): a burst of 40000 signals of 1 KiB to one
  subscriber, then 4000 broadcast to 20 subscribers, each of which checks that it gets them all,
  in order.
* **latency**: [latency](../src/bin/latency.rs): the distributions of the round trips of 5000 calls
  one after the other, of 64 bytes each, of 1000 calls of 16 KiB on each of 20 connections at once,
  and of how long each of 2000 signals takes to reach each of 20 subscribers. The percentiles are
  those of each run, averaged over the runs.
* **shared**: [shared](../src/bin/shared.rs): the phase of the `some-changes` branch where 100
  proxies share one connection, which serves the object that they all call, 1000 times each, on
  zbus 6, then 100 connections that each call themselves 1000 times.

The broker's CPU time is that of its process from start to end, from `wait4()`, and its peak memory
its `VmHWM`. [run-benchmarks.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/run-benchmarks.sh) runs
them all, the raw results of each run are in
[runs.tar.xz](2026-10-22-busd-send-timeout-xeon-4vcpu/runs.tar.xz), from which
[paired-stats.py](../scripts/paired-stats.py) makes the comparisons, with the other metrics and the
medians.

### The time limit against the queue

The rows that name a number of connections or subscribers time whole phases, of the benchmark, of
fanout or of shared, and the RTT and delivery rows are latencies, from the latency client. A star
marks a difference whose 95% interval excludes 0 but not the margin.

| Measure | n | baseline | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.164 s | 0.161 s | -1.9% | -5.7, +2.0 | inconclusive |
| calls, 20 connections | 60 | 0.721 s | 0.721 s | +0.0% | -4.0, +4.1 | within ±5% |
| calls, broker CPU | 60 | 0.599 s | 0.588 s | -1.9% | -5.7, +2.0 | inconclusive |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.8 MiB | -0.5% | -1.1, +0.1 | within ±5% |
| signals, burst to 1 | 60 | 0.519 s | 0.417 s | -19.5% | -22.0, -16.7 | **better** |
| signals, broadcast to 20 | 60 | 0.501 s | 0.495 s | -1.0% | -4.3, +2.5 | within ±5% |
| signals, broker CPU | 60 | 0.613 s | 0.564 s | -7.9% | -10.2, -5.5 | **better** |
| signals, broker peak RSS | 60 | 50.2 MiB | 4.7 MiB | -90.6% | -90.8, -90.3 | **better** |
| RTT, 1 connection, p50 | 60 | 131 µs | 131 µs | -0.4% | -2.2, +1.6 | within ±5% |
| RTT, 1 connection, p99 | 60 | 335 µs | 309 µs | -7.9% | -25.1, +8.1 | inconclusive |
| RTT, 20 connections, p50 | 60 | 660 µs | 659 µs | -0.1% | -6.1, +5.7 | inconclusive |
| RTT, 20 connections, p99 | 60 | 2032 µs | 1915 µs | -5.8% | -15.9, +5.2 | inconclusive |
| delivery to 20, p50 | 60 | 59.7 ms | 23.2 ms | -61.1% | -62.8, -59.4 | **better** |
| delivery to 20, p99 | 60 | 101.7 ms | 35.9 ms | -64.7% | -67.6, -61.3 | **better** |
| latency, broker CPU | 60 | 0.987 s | 0.980 s | -0.8% | -3.2, +1.6 | within ±5% |
| latency, broker peak RSS | 60 | 6.2 MiB | 4.9 MiB | -20.2% | -21.0, -19.5 | **better** |
| 100 proxies, 1 connection | 40 | 3.16 s | 3.56 s | +12.8% | +9.1, +16.6 | **worse** |
| 100 connections | 40 | 4.36 s | 4.22 s | -3.2% | -6.6, +0.1 | inconclusive |
| shared, broker CPU | 40 | 5.76 s | 5.48 s | -4.8% | -7.3, -2.3 | inconclusive* |
| shared, broker peak RSS | 40 | 7.3 MiB | 6.9 MiB | -6.2% | -7.4, -5.1 | **better** |

Only the phase where 100 proxies share one connection is worse, by 12.8%. The revert alone makes it
10.7% worse ([below](#the-revert-alone-against-the-queue)), and the time limit adds nothing to that
which the runs can tell (+1.9%, from -0.7 to +4.6%,
[below](#the-time-limit-against-the-revert-alone)), so it comes from forwarding without a queue:
busd reads the calls and the replies of that connection only as fast as it writes them back to it.
The signals are faster without the queue, and busd takes less memory: the queue of the baseline held
up to 50 MiB of the burst to one subscriber. The p99 latencies vary too much from run to run for
their intervals to say anything against the margin.

### The time limit against the revert alone

What the time limit itself costs, over sends that wait for as long as it takes:

| Measure | n | revert | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.158 s | 0.161 s | +1.5% | -1.7, +4.9 | within ±5% |
| calls, 20 connections | 60 | 0.731 s | 0.721 s | -1.3% | -4.4, +1.9 | within ±5% |
| calls, broker CPU | 60 | 0.580 s | 0.588 s | +1.3% | -2.4, +5.1 | within ±5% |
| calls, broker peak RSS | 60 | 4.7 MiB | 4.8 MiB | +0.9% | +0.2, +1.6 | within ±5%* |
| signals, burst to 1 | 60 | 0.426 s | 0.417 s | -2.0% | -6.2, +2.4 | inconclusive |
| signals, broadcast to 20 | 60 | 0.510 s | 0.495 s | -2.9% | -7.1, +1.3 | inconclusive |
| signals, broker CPU | 60 | 0.556 s | 0.564 s | +1.5% | -1.2, +4.2 | within ±5% |
| signals, broker peak RSS | 60 | 4.7 MiB | 4.7 MiB | +0.4% | -0.2, +1.0 | within ±5% |
| RTT, 1 connection, p50 | 60 | 130 µs | 131 µs | +0.5% | -1.0, +2.0 | within ±5% |
| RTT, 1 connection, p99 | 60 | 315 µs | 309 µs | -2.1% | -9.9, +6.5 | inconclusive |
| RTT, 20 connections, p50 | 60 | 641 µs | 659 µs | +2.8% | -1.2, +8.2 | inconclusive |
| RTT, 20 connections, p99 | 60 | 1702 µs | 1915 µs | +12.5% | +1.1, +24.8 | inconclusive* |
| delivery to 20, p50 | 60 | 22.5 ms | 23.2 ms | +3.2% | -0.9, +7.4 | inconclusive |
| delivery to 20, p99 | 60 | 32.9 ms | 35.9 ms | +9.1% | +0.2, +18.9 | inconclusive* |
| latency, broker CPU | 60 | 0.951 s | 0.980 s | +3.0% | +0.7, +5.1 | within ±5%* |
| latency, broker peak RSS | 60 | 4.9 MiB | 4.9 MiB | +0.6% | -0.1, +1.3 | within ±5% |
| 100 proxies, 1 connection | 40 | 3.50 s | 3.56 s | +1.9% | -0.7, +4.6 | within ±5% |
| 100 connections | 40 | 4.28 s | 4.22 s | -1.6% | -5.0, +1.7 | within ±5% |
| shared, broker CPU | 40 | 5.40 s | 5.48 s | +1.5% | -0.9, +3.8 | within ±5% |
| shared, broker peak RSS | 40 | 6.9 MiB | 6.9 MiB | +0.6% | -1.0, +2.1 | within ±5% |

The time limit costs 3.0% more CPU time of the broker in the latency runs (from +0.7 to +5.1%),
and it adds to the p99 latencies of the calls of 20 connections (+12.5%, from +1.1 to +24.8%) and
of the deliveries of the signals (+9.1%, from +0.2 to +18.9%). Against the queue, all three come
out level or better.

### The revert alone against the queue

| Measure | n | baseline | revert | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.164 s | 0.158 s | -3.3% | -6.8, +0.3 | inconclusive |
| calls, 20 connections | 60 | 0.721 s | 0.731 s | +1.3% | -2.1, +4.6 | within ±5% |
| calls, broker CPU | 60 | 0.599 s | 0.580 s | -3.1% | -6.5, +0.3 | inconclusive |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.7 MiB | -1.4% | -2.0, -0.8 | within ±5%* |
| signals, burst to 1 | 60 | 0.519 s | 0.426 s | -17.9% | -21.0, -14.6 | **better** |
| signals, broadcast to 20 | 60 | 0.501 s | 0.510 s | +1.9% | -2.2, +6.2 | inconclusive |
| signals, broker CPU | 60 | 0.613 s | 0.556 s | -9.3% | -11.7, -6.8 | **better** |
| signals, broker peak RSS | 60 | 50.2 MiB | 4.7 MiB | -90.6% | -90.9, -90.4 | **better** |
| RTT, 1 connection, p50 | 60 | 131 µs | 130 µs | -0.8% | -2.3, +0.8 | within ±5% |
| RTT, 1 connection, p99 | 60 | 335 µs | 315 µs | -6.0% | -23.0, +8.8 | inconclusive |
| RTT, 20 connections, p50 | 60 | 660 µs | 641 µs | -2.9% | -8.0, +1.3 | inconclusive |
| RTT, 20 connections, p99 | 60 | 2032 µs | 1702 µs | -16.3% | -25.9, -5.6 | **better** |
| delivery to 20, p50 | 60 | 59.7 ms | 22.5 ms | -62.3% | -63.9, -60.7 | **better** |
| delivery to 20, p99 | 60 | 101.7 ms | 32.9 ms | -67.6% | -69.5, -65.6 | **better** |
| latency, broker CPU | 60 | 0.987 s | 0.951 s | -3.6% | -6.5, -0.8 | inconclusive* |
| latency, broker peak RSS | 60 | 6.2 MiB | 4.9 MiB | -20.7% | -21.4, -20.0 | **better** |
| 100 proxies, 1 connection | 40 | 3.16 s | 3.50 s | +10.7% | +7.1, +14.5 | **worse** |
| 100 connections | 40 | 4.36 s | 4.28 s | -1.7% | -5.1, +1.9 | within ±5% |
| shared, broker CPU | 40 | 5.76 s | 5.40 s | -6.2% | -9.3, -3.0 | inconclusive* |
| shared, broker peak RSS | 40 | 7.3 MiB | 6.9 MiB | -6.7% | -8.0, -5.4 | **better** |

## Clients that stop reading

[run-stalls.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/run-stalls.sh) runs these, with the
scripts of [stalls](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls), and their logs are in the
directory next to this file.

### Frozen subscribers of the bus's signals

[frozen-timed.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/frozen-timed.sh) is the test of
[the earlier look into stalls](2026-10-20-busd-stalled-reader-xeon-4vcpu.md), timed: it freezes
`gdbus monitor --dest org.freedesktop.DBus`, which subscribes to the signals of the bus, with
SIGSTOP, then has new clients call the bus one after the other, each of which has the bus signal
NameOwnerChanged as it comes and as it goes, and records how long each call takes. With K of them
frozen ([log](2026-10-22-busd-send-timeout-xeon-4vcpu/frozen.log)):

| Broker | K | Calls | Slowest call | Calls over 100 ms | The frozen clients, once let go |
|---|---:|---:|---:|---:|---|
| baseline | 1 | 1500 | 49 ms | 0 | connected |
| timeout | 1 | 1500 | 1012 ms | 1 | disconnected |
| dbus-broker | 1 | 1500 | 22 ms | 0 | connected |
| baseline | 3 | 600 | 43 ms | 0 | connected |
| timeout | 2 | 600 | 2007 ms | 1 | disconnected, 1 s apart |
| timeout | 3 | 600 | 3007 ms | 1 | disconnected, 1 s apart |
| dbus-broker | 3 | 600 | 14 ms | 0 | connected |

The bus no longer freezes, as it did before the queue: once the socket of a frozen client is full,
the next message of the bus for it waits for the time limit, and every other message of the bus
waits behind that one, until the bus disconnects the client and goes on. The bus sends a message to
its recipients one after the other, so with K frozen clients subscribed to the same signal, that
takes K times the time limit. The queue of the baseline, and dbus-broker, keep the messages for the
frozen clients instead, and keep the clients.

### The zbus 4.3 client and its shared connection

The client of the `some-changes` branch, on zbus 4.3, has three phases: a connection that calls
itself through the bus, then 100 such connections at once, then 100 proxies that share one
connection, which serves the object that they all call, 1000 times each, with 16 KiB
([shared-phase.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/shared-phase.sh),
[log](2026-10-22-busd-send-timeout-xeon-4vcpu/shared-zbus43.log)):

| Broker | 1 connection | 100 connections | 100 proxies on 1 connection |
|---|---:|---:|---|
| baseline | 0.22 s | 8.82 s | 11.32 s |
| timeout | 0.20 s | 9.17 s | disconnected by busd |
| revert | 0.21 s | 9.01 s | hung, until killed after 60 s |
| dbus-broker | 0.22 s | 13.67 s | 10.96 s |

The last phase alone, by the number of proxies that share the connection:

| Broker | Proxies | Completed | Times |
|---|---:|---:|---|
| baseline | 100 | 3 of 3 | 10.6, 11.0 and 11.1 s |
| dbus-broker | 100 | 3 of 3 | 10.8, 11.5 and 11.8 s |
| timeout | 100 | 0 of 3 | disconnected after 2.1, 15.5 and 20.5 s |
| timeout | 96 | 1 of 3 | 45.5 s; disconnected after 2.1 and 32.6 s |
| timeout | 92 | 3 of 3 | 7.9, 10.5 and 12.1 s |
| timeout | 88 | 3 of 3 | 8.3, 8.3 and 8.9 s |
| baseline | 200 | 1 of 1 | 25.2 s |
| dbus-broker | 200 | 1 of 1 | 24.7 s |

zbus 4.3 stops reading its socket while it cannot write to it, as the section on the shared
connection of [the earlier look](2026-10-20-busd-stalled-reader-xeon-4vcpu.md) found. busd forwards
the calls and the replies of the shared connection back into it, and while it waits for the
connection to take one, it reads nothing more from it, past the 64 messages that zbus reads ahead
from it. Once the calls under way outgrow that, each side waits for the other. Without a time limit,
that is for good, with data that neither side reads in both directions, as in the log; with one,
until busd disconnects the client, 1 s later. The queue of the baseline, like dbus-broker, goes on
reading from a client while that client does not read, so the client never waits on the bus for
long.

## More read-ahead

What hurts the shared connection, on zbus 4.3 and on zbus 6, is that busd reads only 64 messages
ahead from a client while it waits for one of that client's recipients. zbus sets that number, with
`connection::Builder::max_queued`, and [read-ahead.diff] has busd's connections to its clients read
up to `$BUSD_MAX_QUEUED` messages ahead instead. That is a limit on how many messages busd holds for
a client, not on how many bytes: 256 messages may be 4 MiB of the calls above, or 32 GiB of the
largest messages that D-Bus allows.

The shared phase of the zbus 4.3 client
([log](2026-10-22-busd-send-timeout-xeon-4vcpu/read-ahead-zbus43.log)):

| Read-ahead | Proxies | Completed | Times |
|---:|---:|---:|---|
| 64 | 100 | 0 of 3 | disconnected after 2.1, 2.1 and 3.2 s |
| 128 | 100 | 3 of 3 | 11.0, 11.6 and 11.9 s |
| 256 | 100 | 3 of 3 | 11.3, 11.5 and 12.6 s |
| 1024 | 100 | 3 of 3 | 11.2, 11.3 and 11.3 s |
| 256 | 200 | 2 of 2 | 24.8 and 25.4 s |
| 1024 | 200 | 2 of 2 | 23.9 and 24.7 s |
| 256 | 300 | 0 of 2 | disconnected after 2.1 and 2.2 s |
| 1024 | 300 | 2 of 2 | 43.3 and 43.9 s |

64 is zbus's default, which the time limit has.

The shared phase on zbus 6 (100 proxies), in a comparison of its own, of 30 rounds:

| Measure | n | baseline | timeout-rq256 | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| 100 proxies, 1 connection | 30 | 3.12 s | 3.29 s | +5.8% | +2.0, +9.7 | inconclusive* |
| 100 connections | 30 | 4.22 s | 4.18 s | -0.9% | -4.6, +3.0 | within ±5% |
| shared, broker CPU | 30 | 5.63 s | 5.50 s | -2.4% | -5.2, +0.5 | within ±5% |
| shared, broker peak RSS | 30 | 7.3 MiB | 7.8 MiB | +6.1% | +4.1, +8.0 | inconclusive* |

| Measure | n | timeout | timeout-rq256 | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| 100 proxies, 1 connection | 30 | 3.51 s | 3.29 s | -6.1% | -8.3, -3.8 | inconclusive* |
| 100 connections | 30 | 4.16 s | 4.18 s | +0.5% | -2.9, +3.9 | within ±5% |
| shared, broker CPU | 30 | 5.33 s | 5.50 s | +3.2% | +0.7, +5.7 | inconclusive* |
| shared, broker peak RSS | 30 | 6.9 MiB | 7.8 MiB | +13.0% | +11.1, +15.0 | **worse** |

The comparison repeats the slowdown of the time limit alone, against the queue:

| Measure | n | baseline | timeout | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| 100 proxies, 1 connection | 30 | 3.12 s | 3.51 s | +12.7% | +9.2, +16.4 | **worse** |
| 100 connections | 30 | 4.22 s | 4.16 s | -1.4% | -4.6, +1.7 | within ±5% |
| shared, broker CPU | 30 | 5.63 s | 5.33 s | -5.4% | -8.0, -2.8 | inconclusive* |
| shared, broker peak RSS | 30 | 7.3 MiB | 6.9 MiB | -6.2% | -7.8, -4.5 | inconclusive* |

More read-ahead moves the point where a shared connection on zbus 4.3 gets disconnected, rather than
doing away with it: with 256 messages, it is somewhere between 200 and 300 proxies, rather than
between 92 and 100. On zbus 6, it takes back about half of what the time limit loses against the
queue, and leaves the phase 5.8% slower than with the queue, for 13% more memory than the time limit
alone. The queue of the baseline has a limit too, but of 127 MiB, which is about 8000 of these
calls.

## Reproducing

Run [scripts/compare-send-timeout.sh][send-timeout], which dbus-bench has up to 75e5dc0. It
fetches the commits it lacks, makes the four builds of busd and the clients, runs
[run-benchmarks.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/run-benchmarks.sh) and
[run-stalls.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/run-stalls.sh), and packs what they write
into `send-timeout-results-COMMIT.tar.gz` in `$WORK` (by default, `/tmp/send-timeout-bench`), COMMIT
being the short hash of the timeout commit, which `$TIMEOUT_REV` can change. The header of the
script says where it expects the checkout of busd, and which variables shorten a run.

It needs rustup and cargo. dbus-broker is optional, with the `systemd-socket-activate` that it runs
under: the runs against it are left out where either is missing. The test with [frozen
subscribers](#frozen-subscribers-of-the-buss-signals) needs gdbus and dbus-send, and is left out
without them. Only a machine without systemd, as the VM was, needs the stand-in for journald that
dbus-broker logs to, which binds `/run/systemd/journal/socket`. Start it first, from the root of
dbus-bench:

```sh
python3 results/2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py /tmp/journal.log &
JOURNAL=/tmp/journal.log scripts/compare-send-timeout.sh
```

On the VM, the benchmarks took about 28 minutes, the comparison with more read-ahead about 12 and
the runs with clients that stop reading about 14: a run takes about 55 minutes, plus about 6 for the
builds of the first one.

The binaries of the VM were named differently: the timeout build was `busd-timeout-8d57e20`, with
the same code as e93cec5, and the read-ahead build was `busd-timeout-mq`.

[send-timeout]: https://github.com/zeenix/dbus-bench/blob/75e5dc0/scripts/compare-send-timeout.sh
