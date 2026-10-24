# busd with a time limit of 100 ms, sending a message to all of its recipients at once

Measured on 2026-10-22, on the same kind of VM as
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md), after that run: 4 vCPUs of an
Intel Xeon @ 2.10GHz under KVM, 15 GiB, Linux 6.18, Ubuntu 24.04.5, with every build of busd made
with rustc 1.97.0, on zbus 6.0.0 and zruntime 0.2.0. Compare the builds with each other, within this
file only.

The builds of busd, from z-galaxy/busd and from the `ccr-314882eb-9cvuxt` branch of zeenix/busd:

* **baseline**, 0c52e9c: main, with a queue of up to 127 MiB for each client (z-galaxy/busd#376).
* **timeout**, 8d57e20: the queue reverted, then a time limit of 1 s on each send, past which the
  bus disconnects the client, with the sends of a message to its recipients one after the other. It
  has the code of e93cec5.
* **concurrent100**, 7f3ba5a: timeout, with the sends of a message to all of its recipients at once
  (c5e53ea), and a time limit of 100 ms (7f3ba5a).

## Summary

* Sending a message to all of its recipients at once, and the shorter limit, cost nothing that these
  runs can tell: concurrent100 is within 5% of timeout on every phase, on CPU time and on peak
  memory, and its latencies are within 5% or inconclusive, with intervals that reach no higher than
  +7.3%.
* Against the queue, concurrent100 is where timeout was: level with it or better, apart from the
  phase where 100 proxies share one connection, which is 12.2% slower (from +9.4 to +15.1%): 3.6 µs
  per call (from 2.8 to 4.4).
* Frozen subscribers of the bus's signals hold up the bus for about 100 ms now, however many of them
  there are: the slowest call to the bus took 124, 100, 105 and 106 ms with 1, 2, 3 and 5 of them,
  which the bus disconnected together. timeout took 3008 ms with 3 of them and 5007 ms with 5, which
  it disconnected 1 s apart.
* The zbus 4.3 client still gets disconnected with 100 proxies on one connection, in 3 runs out of
  3, but after 0.3 to 2.3 s, and it still completes with 92 proxies or fewer.

## The benchmarks

The workloads, and how the comparisons work, are those of
[the time limit of 1 s](2026-10-22-busd-send-timeout-xeon-4vcpu.md#the-benchmarks), with 60 rounds
of each, and 40 of the shared connection, after 3 of warm-up.
[run.sh](2026-10-22-busd-concurrent-sends-xeon-4vcpu/run.sh) runs them, the raw results of each run
are in the `.json` files of [the directory](2026-10-22-busd-concurrent-sends-xeon-4vcpu), and the
comparisons, with the other metrics and the medians, in its
[stats](2026-10-22-busd-concurrent-sends-xeon-4vcpu/stats). A star marks a difference whose 95%
interval excludes 0 but not the margin.

### concurrent100 against the queue

| Measure | n | baseline | concurrent100 | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.151 s | 0.149 s | -1.7% | -4.3, +0.8 | within ±5% |
| calls, 20 connections | 60 | 0.664 s | 0.670 s | +0.9% | -1.9, +3.9 | within ±5% |
| calls, broker CPU | 60 | 0.559 s | 0.556 s | -0.4% | -2.7, +1.9 | within ±5% |
| calls, broker peak RSS | 60 | 4.7 MiB | 4.7 MiB | -0.5% | -1.0, +0.1 | within ±5% |
| signals, burst to 1 | 60 | 0.501 s | 0.385 s | -23.1% | -26.4, -19.9 | **better** |
| signals, broadcast to 20 | 60 | 0.473 s | 0.470 s | -0.7% | -3.4, +2.0 | within ±5% |
| signals, broker CPU | 60 | 0.599 s | 0.532 s | -11.1% | -14.4, -8.1 | **better** |
| signals, broker peak RSS | 60 | 51.5 MiB | 4.6 MiB | -91.0% | -91.1, -90.8 | **better** |
| RTT, 1 connection, p50 | 60 | 128 µs | 126 µs | -1.5% | -2.9, -0.2 | within ±5%* |
| RTT, 1 connection, p99 | 60 | 261 µs | 271 µs | +3.8% | -3.1, +10.6 | inconclusive |
| RTT, 20 connections, p50 | 60 | 608 µs | 602 µs | -1.0% | -3.4, +1.4 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1418 µs | 1405 µs | -0.9% | -7.4, +6.0 | inconclusive |
| delivery to 20, p50 | 60 | 56.5 ms | 21.1 ms | -62.7% | -64.2, -61.1 | **better** |
| delivery to 20, p99 | 60 | 94.1 ms | 30.2 ms | -67.9% | -69.8, -65.5 | **better** |
| latency, broker CPU | 60 | 0.933 s | 0.911 s | -2.4% | -3.7, -1.0 | within ±5%* |
| latency, broker peak RSS | 60 | 6.1 MiB | 4.9 MiB | -20.3% | -20.9, -19.6 | **better** |
| 100 proxies, 1 connection | 40 | 2.93 s | 3.29 s | +12.2% | +9.4, +15.1 | **worse** |
| 100 connections | 40 | 3.89 s | 3.75 s | -3.4% | -6.1, -0.7 | inconclusive* |
| shared, broker CPU | 40 | 5.24 s | 4.88 s | -6.9% | -8.8, -5.0 | **better** |
| shared, broker peak RSS | 40 | 7.3 MiB | 6.9 MiB | -5.7% | -7.0, -4.5 | inconclusive* |

### concurrent100 against timeout

| Measure | n | timeout | concurrent100 | Diff | 95% CI | Verdict |
|---|---:|---:|---:|---:|---|---|
| calls, 1 connection | 60 | 0.148 s | 0.149 s | +0.2% | -2.1, +2.5 | within ±5% |
| calls, 20 connections | 60 | 0.683 s | 0.670 s | -1.9% | -4.5, +0.8 | within ±5% |
| calls, broker CPU | 60 | 0.559 s | 0.556 s | -0.4% | -2.5, +1.7 | within ±5% |
| calls, broker peak RSS | 60 | 4.7 MiB | 4.7 MiB | -0.2% | -0.8, +0.5 | within ±5% |
| signals, burst to 1 | 60 | 0.393 s | 0.385 s | -1.9% | -5.1, +1.5 | within ±5% |
| signals, broadcast to 20 | 60 | 0.466 s | 0.470 s | +0.8% | -2.1, +3.9 | within ±5% |
| signals, broker CPU | 60 | 0.535 s | 0.532 s | -0.6% | -2.8, +1.6 | within ±5% |
| signals, broker peak RSS | 60 | 4.6 MiB | 4.6 MiB | +0.6% | -0.1, +1.2 | within ±5% |
| RTT, 1 connection, p50 | 60 | 127 µs | 126 µs | -0.8% | -2.2, +0.6 | within ±5% |
| RTT, 1 connection, p99 | 60 | 273 µs | 271 µs | -0.7% | -8.4, +7.3 | inconclusive |
| RTT, 20 connections, p50 | 60 | 609 µs | 602 µs | -1.0% | -3.7, +1.7 | within ±5% |
| RTT, 20 connections, p99 | 60 | 1446 µs | 1405 µs | -2.8% | -11.3, +6.1 | inconclusive |
| delivery to 20, p50 | 60 | 21.8 ms | 21.1 ms | -3.4% | -7.1, +0.6 | inconclusive |
| delivery to 20, p99 | 60 | 31.7 ms | 30.2 ms | -4.6% | -13.2, +4.7 | inconclusive |
| latency, broker CPU | 60 | 0.919 s | 0.911 s | -0.9% | -2.4, +0.5 | within ±5% |
| latency, broker peak RSS | 60 | 4.8 MiB | 4.9 MiB | +0.5% | -0.2, +1.3 | within ±5% |
| 100 proxies, 1 connection | 40 | 3.30 s | 3.29 s | -0.2% | -2.6, +2.1 | within ±5% |
| 100 connections | 40 | 3.77 s | 3.75 s | -0.4% | -3.0, +2.2 | within ±5% |
| shared, broker CPU | 40 | 4.92 s | 4.88 s | -0.8% | -3.0, +1.3 | within ±5% |
| shared, broker peak RSS | 40 | 6.8 MiB | 6.9 MiB | +0.8% | -0.6, +2.2 | within ±5% |

## Clients that stop reading

### Frozen subscribers of the bus's signals

The test of
[frozen-timed.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/frozen-timed.sh), with K
subscribers of the bus's signals frozen
([log](2026-10-22-busd-concurrent-sends-xeon-4vcpu/frozen.log)):

| Build | K | Calls | Slowest call | Calls over 100 ms | The frozen clients |
|---|---:|---:|---:|---:|---|
| concurrent100 | 1 | 1500 | 124 ms | 1 | disconnected |
| concurrent100 | 2 | 600 | 100 ms | 0 | disconnected together |
| concurrent100 | 3 | 600 | 105 ms | 1 | disconnected together |
| concurrent100 | 5 | 600 | 106 ms | 1 | disconnected together |
| timeout | 3 | 600 | 3008 ms | 1 | disconnected 1 s apart |
| timeout | 5 | 600 | 5007 ms | 1 | disconnected 1 s apart |

The frozen clients take the same signals of the bus, and their sockets filled up on the same one
here, which the bus then waited on them all to take, at once. Clients whose sockets fill up on
different messages still hold up the bus once each.

### The zbus 4.3 client and its shared connection

With
[shared-phase.sh](2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/shared-phase.sh)
([log](2026-10-22-busd-concurrent-sends-xeon-4vcpu/shared-zbus43.log)), the whole client took 0.20 s
with 1 connection and 8.36 s with 100, and then got disconnected in the phase where 100 proxies
share one connection. That phase alone, by the number of proxies:

| Proxies | Completed | Times |
|---:|---:|---|
| 100 | 0 of 3 | disconnected after 0.3, 1.2 and 2.3 s |
| 96 | 1 of 3 | 12.0 s; disconnected after 0.3 and 0.3 s |
| 92 | 3 of 3 | 7.6, 7.8 and 8.4 s |
| 88 | 3 of 3 | 7.8, 7.8 and 8.0 s |
| 80 | 3 of 3 | 7.5, 7.7 and 8.4 s |
| 64 | 3 of 3 | 6.2, 6.3 and 6.5 s |

Against timeout, in the other file, that is the same point where the client gets disconnected,
between 92 and 100 proxies, and it gets disconnected sooner, as the bus waits on it for 100 ms
rather than 1 s.

## Reproducing

[run.sh](2026-10-22-busd-concurrent-sends-xeon-4vcpu/run.sh) runs all of these from the root of
dbus-bench, with the binaries named as it says. On the VM, they were named after their commits:
`busd-baseline-0c52e9c`, `busd-timeout-8d57e20` and `busd-concurrent100-7f3ba5a`, and the clients
`dbus-bench-zbus6`, `shared-zbus6` and `dbus-bench-zbus43-n`. To compare concurrent100 with the
queue and the revert elsewhere, run
`TIMEOUT_REV=7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c scripts/compare-send-timeout.sh`, which
builds it as its timeout.
