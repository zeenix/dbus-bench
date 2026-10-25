# busd forwarding in batches, with zbus's `Connection::send_all`, on a 4-vCPU Xeon

Measured on 2026-10-24, on a cloud VM: 4 vCPUs of an Intel Xeon @ 2.80GHz under KVM, 15 GiB, Linux
6.18, Ubuntu 24.04.5. It ran `scripts/compare-batched-sends.sh` at 541d4c1, which made every build
of busd with rustc 1.97.0. dbus-broker is the 35 of Ubuntu 24.04, which ran under
[fake-journald.py](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py), as the VM has
no systemd, and dbus-daemon the 1.14.10 of Ubuntu 24.04. The VMs of the earlier `xeon-4vcpu` files
had Xeons @ 2.10GHz: compare the brokers with each other, within this file only.

The builds of busd, from z-galaxy/busd and from the `ccr-fd1ce738-0xtuf0` branch of zeenix/busd:

* **queue**, 0c52e9c: busd's main branch with a queue for each client (z-galaxy/busd#376), and a
  task of the client's own that writes the queue to the client's socket, the baseline of
  [the time limit](2026-10-23-busd-zruntime-clock-ryzen-7840u.md), on zbus 6.0.0.
* **baseline**, 0b89e3a: busd's main branch, which writes each message that it forwards to a
  client's socket as it forwards it, with a system call of its own, within a time limit of 100 ms
  (z-galaxy/busd#382), on zbus 6.1.0.
* **batched**, 4f346a3: baseline, forwarding the messages of each peer in batches, of those that
  are there already, which end with their 16th message or with the one that brings them to 16 KiB
  or more, and writing those of a batch that go to a client in one go, with `Connection::send_all`
  of zbus 03c83b6, from the `ccr-fd1ce738-0xtuf0` branch of zeenix/zbus (z-galaxy/zbus#2078). That
  is zbus's main branch of the day, which has nothing on 6.1.0 but updates of dependencies, with
  three commits, which write up to 16 messages and 16 KiB with each system call, and a bigger
  message with one of its own.

All three run on zruntime 99e2ebd, the commit that baseline pins: queue through a patch of the
release that its lock file names.

## Summary

* batched is level with baseline on the method calls, the round trips, the delivery of signals to
  20 subscribers and both phases of the shared connection: within 5%, or inconclusive with
  intervals that reach no higher than +5.7%. So are the CPU time and the peak memory of the broker
  on those workloads, and callgrind counts 1.4% more instructions of busd on the method calls.
* On the signals, batched is faster: 11.4% on the broadcast to 20 subscribers (from 9.2 to 13.6%),
  and 7.1% on the burst to one (from 3.7 to 10.4%, inconclusive), with 23.8% less CPU time of the
  broker, and 36.7% less system time. It writes the signals to a subscriber mostly 14 at a time,
  with two system calls, where baseline makes one for each. In the latencies, the fan-out of 2000
  signals to 20 subscribers takes 15.6% less time all told, while each signal takes as long to
  arrive.
* Against the queue, batched is level or better, apart from the connection that 100 proxies share,
  which takes 8.4% longer (from +5.0 to +12.0%, inconclusive), as with baseline (+6.7%). A burst of
  signals to one subscriber is 25.9% faster, a broadcast to 20 12.7% faster, the delivery of
  signals to 20 subscribers takes 62% less time at the median and 67% less at p99, and the signal
  workload's peak memory is 91% smaller.
* Against dbus-broker, batched is level on one busy connection, and faster with 20 connections or
  more, by 35.0 to 41.0%, and on the signals, by 13.8% on the burst and 25.8% on the broadcast,
  where baseline is 7.1% (inconclusive) and 16.3% faster. Its delivery of signals to 20 subscribers
  takes 63% less time at the median and 70% less at p99. It uses 7.4% less CPU time on the
  signals, where baseline uses 21.5% more, 11.5 to 35.0% more on the rest, and 18 to 88% less peak
  memory.
* Against dbus-daemon, batched is faster on every workload: 8.0 to 34.2% on the calls and the
  signals, 12.2 and 19.2% on the shared connection, with round trips 3.7 to 24.2% shorter (on one
  connection, inconclusive), and a delivery of signals that takes 55% less time at the median and
  79% less at p99. It uses 29 to 47% less CPU time, and 1.4 to 37.0% less peak memory.
* No run of any broker failed. With batches of up to 64 KiB, an earlier version of batched had
  busd disconnect the shared connection once, in 40 rounds, as it started: see
  [how big a write and a batch are](#how-big-a-write-and-a-batch-are).

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), with 60 rounds
of each, and 40 of the shared connection, after 3 of warm-up, all five brokers in each round. The
raw results of each run are in [runs.tar.xz](2026-10-24-busd-batched-sends-xeon-4vcpu/runs.tar.xz),
from which [paired-stats.py](../scripts/paired-stats.py) makes the comparisons, with the other
metrics and the medians. A star marks a difference whose 95% interval excludes 0 but not the margin.
The whole fan-out is how long the delivery of all the signals to 20 subscribers takes.

### batched against baseline

| Measure | n | baseline | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.199 s | 0.201 s | +1.0% | -1.6, +3.7 | within ±5% |
| calls, 20 connections | 60 | 0.790 s | 0.779 s | -1.4% | -3.9, +1.3 | within ±5% |
| signals, burst to 1 | 60 | 0.453 s | 0.421 s | -7.1% | -10.4, -3.7 | inconclusive* |
| signals, broadcast to 20 | 60 | 0.549 s | 0.486 s | -11.4% | -13.6, -9.2 | **better** |
| RTT, 1 connection, p50 | 60 | 179 µs | 181 µs | +0.8% | -0.9, +2.5 | within ±5% |
| RTT, 1 connection, p99 | 60 | 332 µs | 335 µs | +0.7% | -3.1, +4.7 | within ±5% |
| RTT, 20 connections, p50 | 60 | 743 µs | 737 µs | -0.8% | -4.6, +3.1 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1593 µs | 1591 µs | -0.2% | -5.7, +5.6 | within ±5% |
| delivery to 20, p50 | 60 | 27.5 ms | 27.6 ms | +0.5% | -4.6, +5.7 | within ±5% |
| delivery to 20, p99 | 60 | 41.6 ms | 40.0 ms | -4.0% | -11.3, +3.7 | inconclusive |
| delivery to 20, whole fan-out | 60 | 0.313 s | 0.264 s | -15.6% | -19.2, -11.8 | **better** |
| 100 proxies, 1 connection | 40 | 3.89 s | 3.95 s | +1.5% | -1.4, +4.6 | within ±5% |
| 100 connections | 40 | 4.78 s | 4.67 s | -2.3% | -5.8, +1.1 | inconclusive |
| calls, broker CPU | 60 | 0.66 s | 0.67 s | +1.1% | -1.8, +4.0 | within ±5% |
| signals, broker CPU | 60 | 0.62 s | 0.47 s | -23.8% | -25.7, -21.8 | **better** |
| latency, broker CPU | 60 | 1.20 s | 1.16 s | -3.0% | -5.1, -0.9 | within ±5%* |
| shared, broker CPU | 40 | 6.01 s | 6.02 s | +0.1% | -3.0, +3.2 | within ±5% |
| calls, broker system time | 60 | 0.32 s | 0.33 s | +3.5% | -1.6, +9.2 | inconclusive |
| signals, broker system time | 60 | 0.23 s | 0.15 s | -36.7% | -40.3, -32.9 | **better** |
| latency, broker system time | 60 | 0.65 s | 0.61 s | -5.9% | -9.0, -2.7 | inconclusive* |
| shared, broker system time | 40 | 2.72 s | 2.74 s | +0.7% | -4.1, +5.7 | within ±5% |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.9 MiB | +1.1% | +0.4, +1.8 | within ±5%* |
| signals, broker peak RSS | 60 | 4.8 MiB | 4.9 MiB | +2.2% | +1.6, +2.8 | within ±5%* |
| latency, broker peak RSS | 60 | 5.0 MiB | 5.0 MiB | +1.5% | +0.9, +2.1 | within ±5%* |
| shared, broker peak RSS | 40 | 6.9 MiB | 6.9 MiB | -0.7% | -2.2, +0.7 | within ±5% |

The signals of the benchmark, of 1,172 bytes each, go up to 14 to a batch, the 14th taking it past
16 KiB, and batched writes a batch of 14 to the subscriber of the burst with two system calls, of 13
signals and then 1, as strace shows: zbus leaves the message that would take a write past 16 KiB to
the next one.

### batched against the queue

| Measure | n | queue | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.199 s | 0.201 s | +1.2% | -0.9, +3.5 | within ±5% |
| calls, 20 connections | 60 | 0.782 s | 0.779 s | -0.4% | -3.2, +2.7 | within ±5% |
| signals, burst to 1 | 60 | 0.568 s | 0.421 s | -25.9% | -27.8, -24.1 | **better** |
| signals, broadcast to 20 | 60 | 0.557 s | 0.486 s | -12.7% | -14.5, -10.8 | **better** |
| RTT, 1 connection, p50 | 60 | 183 µs | 181 µs | -1.5% | -3.3, +0.3 | within ±5% |
| RTT, 1 connection, p99 | 60 | 346 µs | 335 µs | -3.4% | -7.3, +0.9 | inconclusive |
| RTT, 20 connections, p50 | 60 | 746 µs | 737 µs | -1.3% | -4.4, +1.7 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1582 µs | 1591 µs | +0.5% | -5.0, +6.4 | inconclusive |
| delivery to 20, p50 | 60 | 72.6 ms | 27.6 ms | -61.9% | -63.7, -60.2 | **better** |
| delivery to 20, p99 | 60 | 122.5 ms | 40.0 ms | -67.4% | -69.6, -65.1 | **better** |
| delivery to 20, whole fan-out | 60 | 0.322 s | 0.264 s | -18.0% | -20.9, -14.9 | **better** |
| 100 proxies, 1 connection | 40 | 3.64 s | 3.95 s | +8.4% | +5.0, +12.0 | inconclusive* |
| 100 connections | 40 | 4.91 s | 4.67 s | -4.8% | -8.4, -1.3 | inconclusive* |
| calls, broker CPU | 60 | 0.67 s | 0.67 s | +0.5% | -2.4, +3.6 | within ±5% |
| signals, broker CPU | 60 | 0.67 s | 0.47 s | -29.4% | -30.8, -27.8 | **better** |
| latency, broker CPU | 60 | 1.22 s | 1.16 s | -5.3% | -7.1, -3.5 | inconclusive* |
| shared, broker CPU | 40 | 6.35 s | 6.02 s | -5.1% | -8.2, -2.1 | inconclusive* |
| calls, broker peak RSS | 60 | 4.8 MiB | 4.9 MiB | +0.2% | -0.5, +0.9 | within ±5% |
| signals, broker peak RSS | 60 | 53.2 MiB | 4.9 MiB | -90.9% | -91.0, -90.7 | **better** |
| latency, broker peak RSS | 60 | 6.2 MiB | 5.0 MiB | -18.3% | -19.0, -17.6 | **better** |
| shared, broker peak RSS | 40 | 7.3 MiB | 6.9 MiB | -5.9% | -7.3, -4.6 | inconclusive* |

baseline is about as far from the queue on the shared connection, +6.7% (from +4.3 to +9.4,
inconclusive), and less ahead of it on the burst of signals, -20.2%.

### batched against dbus-broker

| Measure | n | dbus-broker | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.204 s | 0.201 s | -1.3% | -4.0, +1.3 | within ±5% |
| calls, 20 connections | 60 | 1.288 s | 0.779 s | -39.5% | -41.1, -37.7 | **better** |
| signals, burst to 1 | 60 | 0.488 s | 0.421 s | -13.8% | -16.9, -10.7 | **better** |
| signals, broadcast to 20 | 60 | 0.656 s | 0.486 s | -25.8% | -27.7, -24.0 | **better** |
| RTT, 1 connection, p50 | 60 | 181 µs | 181 µs | -0.1% | -1.6, +1.5 | within ±5% |
| RTT, 1 connection, p99 | 60 | 339 µs | 335 µs | -1.1% | -4.1, +2.0 | within ±5% |
| RTT, 20 connections, p50 | 60 | 1217 µs | 737 µs | -39.5% | -41.6, -37.0 | **better** |
| RTT, 20 connections, p99 | 60 | 2697 µs | 1591 µs | -41.0% | -43.9, -37.9 | **better** |
| delivery to 20, p50 | 60 | 74.2 ms | 27.6 ms | -62.8% | -64.2, -61.2 | **better** |
| delivery to 20, p99 | 60 | 133.6 ms | 40.0 ms | -70.1% | -72.0, -68.1 | **better** |
| delivery to 20, whole fan-out | 60 | 0.359 s | 0.264 s | -26.3% | -28.7, -23.6 | **better** |
| 100 proxies, 1 connection | 40 | 3.88 s | 3.95 s | +1.8% | -1.1, +4.7 | within ±5% |
| 100 connections | 40 | 7.19 s | 4.67 s | -35.0% | -37.2, -32.8 | **better** |
| calls, broker CPU | 60 | 0.60 s | 0.67 s | +11.5% | +8.9, +14.2 | **worse** |
| signals, broker CPU | 60 | 0.51 s | 0.47 s | -7.4% | -9.5, -5.1 | **better** |
| latency, broker CPU | 60 | 1.03 s | 1.16 s | +12.7% | +10.6, +15.0 | **worse** |
| shared, broker CPU | 40 | 4.46 s | 6.02 s | +35.0% | +30.9, +39.3 | **worse** |
| calls, broker peak RSS | 60 | 7.2 MiB | 4.9 MiB | -32.6% | -33.0, -32.2 | **better** |
| signals, broker peak RSS | 60 | 40.4 MiB | 4.9 MiB | -88.0% | -88.1, -87.8 | **better** |
| latency, broker peak RSS | 60 | 11.0 MiB | 5.0 MiB | -54.0% | -54.2, -53.7 | **better** |
| shared, broker peak RSS | 40 | 8.4 MiB | 6.9 MiB | -18.3% | -19.3, -17.4 | **better** |

baseline is where batched is against dbus-broker, but on the signals: 7.1% faster on the burst
(inconclusive) and 16.3% on the broadcast, with 21.5% more CPU time.

### batched against dbus-daemon

| Measure | n | dbus-daemon | batched | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.219 s | 0.201 s | -8.0% | -9.9, -6.2 | **better** |
| calls, 20 connections | 60 | 0.903 s | 0.779 s | -13.7% | -16.0, -11.4 | **better** |
| signals, burst to 1 | 60 | 0.521 s | 0.421 s | -19.2% | -21.9, -16.2 | **better** |
| signals, broadcast to 20 | 60 | 0.738 s | 0.486 s | -34.2% | -35.8, -32.5 | **better** |
| RTT, 1 connection, p50 | 60 | 188 µs | 181 µs | -4.2% | -5.7, -2.7 | inconclusive* |
| RTT, 1 connection, p99 | 60 | 347 µs | 335 µs | -3.7% | -7.7, +0.9 | inconclusive |
| RTT, 20 connections, p50 | 60 | 851 µs | 737 µs | -13.4% | -16.4, -10.0 | **better** |
| RTT, 20 connections, p99 | 60 | 2099 µs | 1591 µs | -24.2% | -27.7, -20.6 | **better** |
| delivery to 20, p50 | 60 | 60.8 ms | 27.6 ms | -54.6% | -56.9, -52.2 | **better** |
| delivery to 20, p99 | 60 | 192.6 ms | 40.0 ms | -79.3% | -80.4, -78.0 | **better** |
| delivery to 20, whole fan-out | 60 | 0.394 s | 0.264 s | -32.8% | -35.1, -30.4 | **better** |
| 100 proxies, 1 connection | 40 | 4.50 s | 3.95 s | -12.2% | -14.4, -10.0 | **better** |
| 100 connections | 40 | 5.78 s | 4.67 s | -19.2% | -21.8, -16.5 | **better** |
| calls, broker CPU | 60 | 0.98 s | 0.67 s | -31.8% | -33.5, -30.0 | **better** |
| signals, broker CPU | 60 | 0.89 s | 0.47 s | -46.9% | -48.1, -45.7 | **better** |
| latency, broker CPU | 60 | 1.64 s | 1.16 s | -29.4% | -31.0, -27.7 | **better** |
| shared, broker CPU | 40 | 9.60 s | 6.02 s | -37.3% | -39.0, -35.5 | **better** |
| calls, broker peak RSS | 60 | 4.9 MiB | 4.9 MiB | -1.4% | -1.9, -0.9 | within ±5%* |
| signals, broker peak RSS | 60 | 7.7 MiB | 4.9 MiB | -37.0% | -39.0, -35.3 | **better** |
| latency, broker peak RSS | 60 | 6.0 MiB | 5.0 MiB | -16.2% | -16.7, -15.6 | **better** |
| shared, broker peak RSS | 40 | 7.1 MiB | 6.9 MiB | -2.9% | -4.1, -1.7 | within ±5%* |

### The connection that 100 proxies share

In this phase, one connection serves an object and makes 100,000 calls to it through the bus, 100 at
a time, each with 16 KiB of data. A call takes a batch past 16 KiB, so a batch of batched holds one
call at most, after replies, and batched forwards the calls one at a time, as baseline does. Taking
the multi-client phase's CPU time out of each run's whole, the phase's means are:

| Broker | Phase | Client CPU | Broker CPU | Client's waits | Broker's waits |
|---|---:|---:|---:|---:|---:|
| baseline | 3.89 s | 3.61 s | 2.41 s | 13246 | 18122 |
| batched | 3.95 s | 3.63 s | 2.47 s | 13366 | 17722 |
| queue | 3.64 s | 3.34 s | 2.52 s | 20694 | 16811 |
| dbus-broker | 3.88 s | 3.81 s | 1.72 s | 212 | 198124 |
| dbus-daemon | 4.50 s | 3.89 s | 4.13 s | 55872 | 4799 |

The client's and the broker's waits are their voluntary context switches, over both phases.

## How big a write and a batch are

A first version of zbus's `send_all` wrote up to 16 messages with each system call, however many
bytes they came to, and busd's batches went up to 64 KiB. The calls of the shared connection then
went to the client up to four at a time, and its phase took 38% longer than with baseline, 3.8 to
8.3 s where baseline took 3.6 to 4.1 s, with 44% more CPU time of the broker, and 35% more of the
client. Ten rounds, after one of warm-up, of a build of batched of the day that read both bounds
from the environment, in two runs, each against baseline:

| Bytes in a write | Bytes in a batch | Phase | Range | Broker CPU | Client CPU |
|---|---|---:|---|---:|---:|
| (baseline) | | 3.88 s | 3.56 to 4.05 s | 2.40 s | 3.58 s |
| any | up to 64 KiB | 5.37 s | 3.78 to 8.34 s | 3.46 s | 4.83 s |
| up to 32 KiB | up to 64 KiB | 3.88 s | 3.54 to 4.32 s | 2.36 s | 3.59 s |
| up to 16 KiB | up to 64 KiB | 3.81 s | 3.52 to 4.15 s | 2.32 s | 3.53 s |
| (baseline) | | 3.91 s | 3.42 to 4.76 s | 2.38 s | 3.64 s |
| any | up to 64 KiB | 5.85 s | 3.64 to 8.56 s | 3.76 s | 5.18 s |
| any | up to 16 KiB | 3.82 s | 3.24 to 4.10 s | 2.36 s | 3.53 s |

The CPU times are those of the phase, and the runs are in the `bounds` directory of
[runs.tar.xz](2026-10-24-busd-batched-sends-xeon-4vcpu/runs.tar.xz), with `$WORK/bin/busd-bounds`
for that build, which no branch has. Of what writes of any size add to the broker's CPU time, 1.07
of 1.23 s is system time, over both phases, and the client spends more time in the kernel as well:
in eight runs of the start and the phase with each bound of the writes, one after the other, on that
build with batches of up to 64 KiB, the slowest with writes of any size took 5.3 s, with 2.32 s of
system time of the client and 2.24 s of busd, where with writes of up to 16 KiB, the client had 1.13
to 1.45 s of it and busd 0.91 to 1.17 s. Writes of several messages of 16 KiB had both ends work
harder for the same bytes, in some runs and not in others, while writes with one such message did
not. zbus bounds each write at 16 KiB, which still takes a dozen or more small messages at a time.

A batch of busd ends with the message that brings it to 16 KiB or more, while a write of zbus
stops short of it, so a batch that ends on its bytes takes two writes to a recipient that gets all
of it, the last message alone, as the signals above show.

The full run of batched at 08b03e0, with writes of up to 16 KiB and batches of up to 64 KiB, had
busd disconnect the shared connection in one of its 40 rounds, 173 ms after it accepted it:
``Disconnecting `:busd.2`, as it didn't take 15 messages within 100ms``. The time limit of a send
covers the messages that the client gets in one go, and the wait for those that other senders have
on their way to it, so a batch of up to 64 KiB could have the client take up to 64 KiB more within
it than its last message alone. batched bounds its batches at 16 KiB now. 200 starts of the shared
client, for 0.6 s each, against busd with batches of up to 64 KiB, up to 16 KiB, and baseline, one
after the other, had none of them disconnected, so these runs can't tell how much the bound had to
do with that disconnect, which is rare either way.

## The instructions of a batch of one message

In the method calls, a connection calls itself 1000 times through the bus, and then 20 connections
do at once, each of them waiting for the reply to a call before it makes the next, so that the bus
mostly forwards batches of one message. Callgrind counts the instructions of busd for all of it,
which, unlike its CPU time, the noise of the VM leaves alone: 1765.5 million with baseline and
1790.0 million with batched, 1.4% more, as means of three runs of each, all within 0.2% of the mean.
batched with batches of up to 64 KiB, at 08b03e0, ran 1799.2 million, 1.9% more than baseline, in
two runs.

## Reproducing

```sh
scripts/compare-batched-sends.sh
```

builds the brokers and runs all of this, in about 58 minutes on this VM once the builds are made,
and writes its results to `$WORK/batched-sends-results-4f346a3`, whose raw runs
[pack-results.sh](../scripts/pack-results.sh) packs into a `runs.tar.xz`.