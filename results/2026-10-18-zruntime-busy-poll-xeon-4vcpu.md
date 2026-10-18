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
  sleep costs 29 to 51% more CPU time. With a client calling every millisecond, busd spends 79 µs
  of CPU time per call with the busy polling, 81 µs without it and 104 µs with the spin.
* It is not free, though, which is why it is off unless a program asks for it. It buys its speed
  with CPU time, 21% more per message here. It makes busd slower where busd shares a CPU with its
  client: 7% with 20 clients, for 35% more CPU time. And a stream of calls whose replies come back
  within the limit, with longer gaps between the calls, has it spin before every wait, the long
  ones included: with a limit longer than this VM takes to get a reply back, that costs more than
  the limit in CPU time for every call, for calls that are 16 to 24% faster.

## How the busy polling works

A runtime's thread waits on its poller (epoll here) whenever it has no task to run: until a source
it watches is ready, a timer is due, or another thread hands it work. Such a wait puts the thread
to sleep, and whatever ends it has to wake the thread up again. A program turns the busy polling on
with `Runtime::set_busy_poll(limit)`, which changes each wait as follows.

1. A wait that cannot sleep, because a task is ready or the future passed to `block_on` has been
   woken, is left as it is. It neither polls nor counts in what follows.
2. Any other wait first looks at the runtime's history of its last eight waits that could sleep,
   one bit each, set where the wait lasted no longer than the limit. If no bit is set, the wait
   sleeps, as it would without busy polling.
3. If a bit is set, the wait polls: it asks the poller what is ready, with a timeout of zero, again
   and again, without sleeping. It stops as soon as a source is ready, or another thread has
   something for it, which is what would have woken it from a sleep, or once the limit has
   passed. A timer that falls due before then cuts the polling short too.
4. Only if the polling found nothing does the wait go to sleep, for what is left of its time.
5. Either way, the wait is timed from its start to its end, and goes into the history: a bit set
   if it took no longer than the limit, because polling for the limit would have caught what ended
   it, or did.

What the history does, for a limit of 20 µs, written newest bit last:

| What happens | History | Polls next? |
|---|---|---|
| The limit is set: the history starts empty. | `00000000` | no |
| A wait ends within 20 µs, as something came at once. | `00000001` | yes |
| Busy: each wait polls, and catches the next message in time. | `11111111` | yes |
| Idle: a wait polls for 20 µs, finds nothing, and sleeps 5 ms. | `11111110` | yes |
| Seven more such waits, each polling for nothing first. | `00000000` | no |
| A message every millisecond: each wait sleeps about 1 ms. | `00000000` | no |
| Quick replies: a reply within 20 µs, the next call 1 ms later. | `01010101` | yes, always |

So a runtime that has gone idle stops polling after eight waits, and a burst of work costs no more
than eight times the limit of polling for nothing at its end. But a pattern of short waits and long
ones in turn, such as a stream of requests whose replies come back quickly, keeps it polling before
every wait: before the replies, where it pays, and before the long waits for the next request,
where it is CPU time for nothing.

The limit belongs to the runtime. A runtime from `SharedRuntime::current()`, the thread's own
inside the free `block_on`, lasts only while something holds it. A program has to keep the handle
that it sets the limit through for as long as the limit is to hold (see [a pitfall](#a-pitfall)).

## Why it is off by default

Whether busy polling pays depends on the program, its traffic and the machine, and these runs show
it costing more than it gives in some cases:

* **It spends CPU time to save time.** Under load, busd spends 21% more CPU time in the 20-client
  phase (0.86 s against 0.71 s) for the same work, to get through it 21% faster. On a machine
  that has no CPU to spare, that time is taken from other work.
* **It is slower on a shared CPU.** With busd and its client on one CPU, a broker that polls holds
  the CPU that the client needs to send what it polls for. There, busy polling makes the 20-client
  run 7% slower (2.36 s against 2.21 s) for 35% more CPU time (0.73 s against 0.54 s). It does
  hold back with a single client, where the spin before every sleep makes the run 54% slower.
* **Quick replies keep it polling for nothing.** A client that calls a service through the bus
  once a millisecond, whose replies come back within the limit, makes busd wait in turn for a
  reply, briefly, and for the next call, a millisecond. Each short wait keeps a bit set, so busd
  polls before each long wait too. With limits of 100, 200 and 500 µs, longer than the replies
  take to come back on this VM, busd needs 2.8, 4.0 and 7.6 times the CPU time per call, for calls
  that are 16 to 24% faster. With 20 µs, the replies take longer than the limit, and busy polling
  never starts, but they need not on faster hardware.
* **It keeps a CPU awake.** While a thread polls, its CPU stays out of the deep idle states that
  save power, which matters most on a laptop. This VM has no energy counters to measure that.

Where it does not start, it costs little: no difference that these runs can measure at a call
every millisecond, every 100 µs and every 50 µs, and 4% more CPU time at every 30 µs, with no
measurable change in latency. The spin before every sleep costs 29 to 56% more CPU time at each of
those rates, and makes the calls 15 to 16% faster at 30 and 50 µs, but not at 100 µs.

## Setup

The client of the load tests is the `dbus-bench` binary of this repository at 20f3031, as in the
earlier comparisons. The brokers were built with rustc 1.97.0 and busd's release profile:

* busd-zruntime: busd ported to zruntime, at 0d22862, on zruntime 0.2.0.
* busypoll-off and busypollN: busd at 0d22862, built against the code of z-galaxy/zruntime#52
  with
  [`busd-busy-poll.diff`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/patches/busd-busy-poll.diff).
  With `ZRUNTIME_BUSY_POLL_US=N`, busd sets a limit of N µs on its runtime as it starts, and
  without it, it does not poll.
* spin20: busd-zruntime-spin20 of the follow-up, built against zruntime 0.2.0 with the
  experimental change that spins for 20 µs before every sleep.
* dbus-daemon 1.14.10, as the distribution builds it, for reference.

The light-load tests run
[`measure-light-traffic.py`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/measure-light-traffic.py)
with [`light-client`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-client), a client on zbus
6.0.0. It makes a method call through the bus once every `INTERVAL_US` µs for 3 s, either to the
bus itself (`GetId`), or to a service on a second connection of its own, so that the bus forwards
each call and its reply, and times each call. A call that would start late skips its turn, so a
client whose calls take longer than the interval makes fewer of them. Then the script stops the
broker and reads the CPU time that the broker spent over its whole life. Each round runs the
brokers in a random order, with a fresh broker process for every run. For example:

```sh
(cd light-client && cargo build --release)
MODE=forward SECS=3 INTERVAL_US=1000 ./measure-light-traffic.py \
    light-client/target/release/light-client 10 light-forward-limits.json \
    "off=busd-busypoll --address {address}" \
    "busypoll100=env ZRUNTIME_BUSY_POLL_US=100 busd-busypoll --address {address}"
```

## Results

Timings are medians, with the fastest and slowest run in parentheses. "Broker CPU" is the broker's
CPU time in the 20-client phase, and "sleeps" how many times it gave up the CPU to wait (voluntary
context switches) over the whole run. Both are medians too. The differences called out come from a
Mann–Whitney U test (20,000 permutations).

### Under load

[`scripts/compare-brokers.py`](../scripts/compare-brokers.py), one warmup round and 10 measured
rounds.

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Sleeps |
|---|---:|---:|---:|---:|
| busd-zruntime | 0.225 (0.184–0.243) | 2.207 (2.091–2.295) | 0.68 | 32,460 |
| busypoll-off | 0.209 (0.188–0.253) | 2.169 (2.076–2.299) | 0.71 | 29,622 |
| busypoll20 | 0.202 (0.195–0.216) | 1.723 (1.566–1.851) | 0.86 | 7,177 |
| busypoll50 | 0.199 (0.177–0.237) | 1.691 (1.542–2.004) | 0.98 | 4,281 |
| spin20 | 0.204 (0.196–0.228) | 1.725 (1.672–1.803) | 0.88 | 7,052 |
| dbus-daemon | 0.236 (0.212–0.267) | 1.880 (1.755–2.187) | 1.03 | 16,592 |

With the polling off, the busd build of zruntime#52 measures as busd on zruntime 0.2.0 does, and
with a limit of 20 µs, as spin20 does: the test finds no difference between either pair in any of
the timings or in the CPU time (p > 0.28).

### On one CPU

The same, with `taskset -c 0` around `compare-brokers.py`, so that the client and the broker share
one CPU. One warmup round and 10 measured rounds.

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Sleeps |
|---|---:|---:|---:|---:|
| busypoll-off | 0.103 (0.093–0.137) | 2.208 (2.064–2.439) | 0.54 | 39,186 |
| busypoll20 | 0.098 (0.092–0.112) | 2.356 (2.228–2.482) | 0.73 | 24,540 |
| spin20 | 0.159 (0.146–0.192) | 2.456 (2.291–2.597) | 0.85 | 16,426 |

busypoll20 is slower than busypoll-off with 20 clients (p = 0.007) and spends more CPU time
(p < 0.0001), and is as fast with a single client (p = 0.22). spin20 is slower in both (p < 0.001).
On one CPU, a single client gets through its calls twice as fast as on four, with no CPU to wake.

### Under light load

A call every millisecond, 15 rounds. These two runs were made with an earlier version of
`light-client`, which only counted its calls. "CPU per call" is the broker's CPU time over the
calls the client made, 3,000 in every run but one.

| Broker | CPU per call, calls to the bus, µs | CPU per call, forwarded calls, µs |
|---|---:|---:|
| busypoll-off | 80.5 (71.9–89.6) | 84.5 (74.0–99.1) |
| busypoll20 | 78.8 (73.2–99.9) | 88.6 (72.9–97.3) |
| spin20 | 103.8 (94.3–113.2) | 127.5 (117.4–132.1) |

The test finds the CPU time of busypoll20 no different from that of busypoll-off with either kind
of call (p = 0.63), and that of spin20 different with both (p < 0.0001). The brokers go to sleep
as often as each other: about 3,000 times a run with calls to the bus, once a call, and about 6,000
with forwarded calls. busypoll20 does not poll at all here: an `strace` of it makes one wait with
a timeout of zero in a run of 2,000 calls of either kind, where a spin would make many. Its waits
last longer than its limit, so it never starts, where spin20 spins before every sleep and catches
almost nothing.

### Quick replies, long gaps

Forwarded calls, one every millisecond, with limits up to 500 µs. 10 rounds. "Latency" is the
median time a call took, and "p99" its 99th percentile, both medians over the runs.

| Broker | Calls | CPU per call, µs | Latency, µs | p99, µs | Sleeps |
|---|---:|---:|---:|---:|---:|
| busypoll-off | 2,994 | 80.7 (71.1–87.6) | 225 | 554 | 6,002 |
| busypoll20 | 2,991 | 80.2 (70.6–86.4) | 219 | 522 | 5,994 |
| busypoll100 | 2,986 | 226.4 (210.4–242.2) | 189 | 520 | 3,174 |
| busypoll200 | 2,994 | 325.4 (314.6–337.2) | 189 | 450 | 3,005 |
| busypoll500 | 2,994 | 611.5 (601.8–632.8) | 171 | 413 | 2,974 |

A forwarded call has busd wait twice: for the reply, which the service sends after a wake-up of
its own, and then for the next call. With a limit of 20 µs, the waits for the replies are long, and
busypoll20 measures as busypoll-off does (p > 0.68). From 100 µs on, they are short: busd polls
before each of them and catches the reply with no sleep, which saves a sleep a call and makes the
calls faster (p < 0.005). But the bit each of them sets has it poll before each wait for the next
call too, which finds nothing. So busd's CPU time per call grows by more than the limit: by the
limit, spent before each wait for the next call, and by the time it polls for each reply instead
of sleeping (p < 0.0001).

### Calls at short intervals

Calls to the bus, every 30, 50 and 100 µs, 10 rounds each. The calls take longer than 30 and 50 µs
on this VM, so the client makes fewer than the interval asks for.

| Broker | Interval, µs | Calls | CPU per call, µs | Latency, µs | p99, µs | Sleeps |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 30 | 42,445 | 37.4 (35.4–39.8) | 64 | 128 | 42,422 |
| busypoll20 | 30 | 43,340 | 38.8 (36.6–42.0) | 63 | 127 | 40,134 |
| spin20 | 30 | 49,472 | 54.3 (53.7–55.0) | 54 | 118 | 16,695 |
| busypoll-off | 50 | 41,596 | 38.0 (36.6–41.3) | 66 | 131 | 41,581 |
| busypoll20 | 50 | 42,061 | 39.3 (36.8–44.7) | 65 | 129 | 39,326 |
| spin20 | 50 | 48,848 | 54.3 (52.8–58.7) | 56 | 114 | 16,820 |
| busypoll-off | 100 | 29,471 | 37.4 (35.8–41.0) | 66 | 129 | 29,468 |
| busypoll20 | 100 | 29,524 | 39.1 (36.5–39.7) | 66 | 136 | 29,513 |
| spin20 | 100 | 29,498 | 58.5 (57.4–61.0) | 65 | 126 | 28,346 |

busypoll20 rarely saves a sleep at these rates: busd sleeps about as often as without it. Its CPU
time per call is 4% higher at 30 µs (p = 0.01), and no different at 50 and 100 µs (p > 0.3), and
its latencies are no different at any of them (p > 0.05). spin20 spends 43 to 56% more CPU time
per call at every interval (p < 0.0001), for calls that are 15 to 16% faster at 30 and 50 µs
(p < 0.001), and no faster at 100 µs (p = 0.93).

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
* [`one-cpu.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/one-cpu.json): the run on one CPU.
* [`light-bus.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-bus.json),
  [`light-forward.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-forward.json): the runs
  under light load.
* [`light-forward-limits.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-forward-limits.json):
  the quick replies with long gaps.
* [`light-bus-30.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-bus-30.json),
  [`light-bus-50.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-bus-50.json),
  [`light-bus-100.json`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-bus-100.json): the calls at
  short intervals.
* [`light-client`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/light-client),
  [`measure-light-traffic.py`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/measure-light-traffic.py):
  the light-load tests.
* [`busd-busy-poll.diff`](2026-10-18-zruntime-busy-poll-xeon-4vcpu/patches/busd-busy-poll.diff):
  the change to busd that turns the busy polling on. It expects a checkout of zruntime with the
  busy polling next to busd's.
