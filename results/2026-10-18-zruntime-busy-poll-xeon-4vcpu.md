# zruntime's busy polling, measured on busd

Measured on 2026-10-18, on the VM of [busd on zruntime vs busd on
Tokio](2026-10-18-busd-zruntime-xeon-4vcpu.md): 4 vCPUs of an Intel Xeon @ 2.10GHz, Linux 6.18.

[Why dbus-daemon leads busd with 20 clients](2026-10-18-busd-dbus-daemon-xeon-4vcpu.md) found
that busd gets through the 20-client benchmark faster when zruntime spins for 20 µs before every
sleep. It also found that such a spin costs CPU time for nothing whenever the bus runs out of work,
and suggested spinning only while the bus is busy. zruntime's busy polling
([z-galaxy/zruntime#52](https://github.com/z-galaxy/zruntime/pull/52)) does that, as an opt-in.
Before a wait that would put it to sleep, a runtime polls for up to a limit, but only if one of its
last eight such waits lasted no longer than the limit.

## Summary

* Under load, the busy polling does what the spin before every sleep does. With 20 clients, busd
  takes 1.72 s instead of 2.17 s, and goes to sleep 7,200 times instead of 29,600, for 0.86 s of
  CPU time instead of 0.71 s. The spin before every sleep takes 1.73 s, for 0.88 s.
* Under light load, it costs nothing that these runs can measure, where the spin before every
  sleep costs 30 to 50% more CPU time. With a client calling every millisecond, busd spends 79 µs
  of CPU time per call with the busy polling, 81 µs without it and 104 µs with the spin.

## Setup

The client of the load test is the `dbus-bench` binary of this repository at 20f3031, as in the
earlier comparisons. The brokers were built with rustc 1.97.0 and busd's release profile:

* busd-zruntime: busd ported to zruntime, at 0d22862, on zruntime 0.2.0.
* busypoll-off, busypoll20 and busypoll50: busd at 0d22862, built against the code of
  z-galaxy/zruntime#52 with
  [`busd-busy-poll.diff`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/patches/busd-busy-poll.diff).
  With `ZRUNTIME_BUSY_POLL_US=N`, busd sets a limit of N µs on its runtime as it starts, and
  without it, it does not poll.
* spin20: busd-zruntime-spin20 of the follow-up, built against zruntime 0.2.0 with the
  experimental change that spins for 20 µs before every sleep.
* dbus-daemon 1.14.10, as the distribution builds it, for reference.

The light-load test runs
[`measure-light-traffic.py`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/measure-light-traffic.py)
with [`light-client`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-client), a client on zbus
6.0.0. It makes a method call through the bus once every millisecond for 3 s: either to the bus
itself (`GetId`), or to a service on a second connection of its own, so that the bus forwards each
call and its reply. Then the script stops the broker and reads the CPU time that the broker spent
over its whole life. Each round runs the brokers in a random order, with a fresh broker process
for every run. For example:

```sh
(cd light-client && cargo build --release)
MODE=forward SECS=3 INTERVAL_US=1000 ./measure-light-traffic.py \
    light-client/target/release/light-client 15 light-forward.json \
    "off=busd-busypoll --address {address}" \
    "busypoll20=env ZRUNTIME_BUSY_POLL_US=20 busd-busypoll --address {address}" \
    "spin20=env ZRUNTIME_SPIN_US=20 busd-zruntime-spin --address {address}"
```

## Results

### Under load

[`scripts/compare-brokers.py`](../scripts/compare-brokers.py), one warmup round and 10 measured
rounds. Timings are medians, with the fastest and slowest run in parentheses. "Broker CPU" is the
broker's CPU time in the 20-client phase, and "sleeps" how many times it gave up the CPU to wait
(voluntary context switches) over the whole run. Both are medians too.

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Sleeps |
|---|---:|---:|---:|---:|
| busd-zruntime | 0.225 (0.184–0.243) | 2.207 (2.091–2.295) | 0.68 | 32,460 |
| busypoll-off | 0.209 (0.188–0.253) | 2.169 (2.076–2.299) | 0.71 | 29,622 |
| busypoll20 | 0.202 (0.195–0.216) | 1.723 (1.566–1.851) | 0.86 | 7,177 |
| busypoll50 | 0.199 (0.177–0.237) | 1.691 (1.542–2.004) | 0.98 | 4,281 |
| spin20 | 0.204 (0.196–0.228) | 1.725 (1.672–1.803) | 0.88 | 7,052 |
| dbus-daemon | 0.236 (0.212–0.267) | 1.880 (1.755–2.187) | 1.03 | 16,592 |

With the polling off, the busd build of zruntime#52 measures as busd on zruntime 0.2.0 does, and
with a limit of 20 µs, as spin20 does: a Mann–Whitney U test (20,000 permutations) finds no
difference between either pair in any of the timings or in the CPU time (p > 0.28).

### Under light load

15 rounds. "CPU per call" is the broker's CPU time over the calls the client made, 3,000 in every
run but one, a median with the lowest and highest run in parentheses.

| Broker | CPU per call, calls to the bus, µs | CPU per call, forwarded calls, µs |
|---|---:|---:|
| busypoll-off | 80.5 (71.9–89.6) | 84.5 (74.0–99.1) |
| busypoll20 | 78.8 (73.2–99.9) | 88.6 (72.9–97.3) |
| spin20 | 103.8 (94.3–113.2) | 127.5 (117.4–132.1) |

The same test finds the CPU time of busypoll20 no different from that of busypoll-off with either
kind of call (p = 0.63), and that of spin20 different with both (p < 0.0001). The brokers go to
sleep as often as each other: about 3,000 times a run with calls to the bus, once a call, and about
6,000 with forwarded calls. busypoll20 does not poll at all here: an `strace` of it makes one wait
with a timeout of zero in a run of 2,000 calls of either kind, where a spin would make many. Its
waits last longer than its limit, so it never starts, where spin20 spins before every sleep and
catches almost nothing.

### A pitfall

The first runs of this comparison set the limit through
`SharedRuntime::current()?.set_busy_poll(..)` as busd started, and dropped the handle. They
measured as busypoll-off did, whatever the limit, up to 5 ms. The runtime that
`SharedRuntime::current()` returns there is the thread's own, which lasts only while something
holds it, and nothing else did yet. So it was dropped with the handle, and busd's listeners and
connections went on a new one, which did not poll. The patch above keeps the handle for as long as
busd runs.

## Files

* [`run.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/run.json): the run under load.
* [`light-bus.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-bus.json),
  [`light-forward.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-forward.json): the runs
  under light load.
* [`light-client`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-client),
  [`measure-light-traffic.py`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/measure-light-traffic.py):
  the light-load test.
* [`busd-busy-poll.diff`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/patches/busd-busy-poll.diff):
  the change to busd that turns the busy polling on. It expects a checkout of zruntime with the
  busy polling next to busd's.
