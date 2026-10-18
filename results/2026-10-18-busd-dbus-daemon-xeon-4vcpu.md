# Why dbus-daemon leads busd with 20 clients

A follow-up to [busd on zruntime vs busd on Tokio](2026-10-18-busd-zruntime-xeon-4vcpu.md), on the
same VM (4 vCPUs of an Intel Xeon @ 2.10GHz, Linux 6.18) and with the same client and binaries,
measured later the same day. In that comparison, busd on zruntime was the fastest broker with a
single client, but dbus-daemon was still faster with 20 clients. This looks into why, and at two
ways of closing the gap.

Measured on real hardware since, on a Ryzen 7 7840U, the picture changes: busd is well ahead of
dbus-daemon there and level with dbus-broker, and the spin mostly shortens the single-client
timing. See [busd against dbus-broker and dbus-daemon, on a Ryzen 7
7840U](2026-10-18-busd-zruntime-ryzen-7840u.md).

## Summary

* dbus-daemon is not faster at routing messages. In the 20-client phase it spends 0.98 s of CPU
  time, where busd on zruntime spends 0.69 s and busd on Tokio 0.85 s.
* It is faster because it sleeps less. The benchmark's client runs on one thread, which it keeps
  busy, so it is what limits the timing. Every message it sends to a broker that is asleep in
  `epoll_wait` costs it a wake-up of that broker: 6% of the client's CPU time with dbus-daemon, 10%
  with busd on zruntime and 17% with busd on Tokio. dbus-daemon does more work per message, which
  keeps it busier, and it is asleep less often when the next message comes: it goes to sleep 16k
  times in a run, against 30k times for busd on zruntime and 76k times for busd on Tokio.
* Spreading the connections over several threads, each with a runtime of its own, makes busd
  slower: 2.29 s with 3 threads or a thread per connection, against 2.08 s with one thread. Each
  thread goes to sleep on its own, so there are more sleeps to wake from, not fewer.
* Having zruntime spin for up to 20 µs before it goes to sleep removes most of the sleeps. The
  20-client phase then takes 1.67 to 1.70 s, ahead of dbus-daemon's 1.74 to 1.81 s, for 0.84 to
  0.86 s of CPU time, still less than dbus-daemon's. Spinning costs CPU time whenever the bus runs
  out of work, though, and wake-ups are dearer on a VM than on real hardware, so this needs
  measuring on real hardware before anyone acts on it.

## CPU time in the 20-client phase

Run 4: ten measured rounds of each configuration. The CPU times of the 20-client phase come from
`/proc/PID/stat` as the client prints the timing of each phase. "Busy" is the broker's CPU time in
the phase over the phase's duration, and "sleeps" is how many times the broker gave up the CPU to
wait (voluntary context switches) over the whole run. All numbers are medians.

| Broker | Single client, s | 20 clients, s | Broker CPU, s | Busy | Client CPU, s | Sleeps |
|---|---:|---:|---:|---:|---:|---:|
| busd-tokio | 0.222 | 2.866 | 0.85 | 29% | 2.84 | 76,474 |
| busd-zruntime | 0.197 | 2.078 | 0.69 | 33% | 2.04 | 30,066 |
| busd-zruntime-mt1 | 0.193 | 2.043 | 0.68 | 33% | 2.02 | 30,152 |
| busd-zruntime-mt3 | 0.211 | 2.289 | 0.86 | 38% | 2.27 | 39,994 |
| busd-zruntime-mt32 | 0.195 | 2.291 | 0.90 | 39% | 2.26 | 42,431 |
| busd-zruntime-spin20 | 0.207 | 1.699 | 0.86 | 51% | 1.68 | 6,820 |
| busd-zruntime-spin50 | 0.194 | 1.664 | 0.97 | 58% | 1.64 | 3,860 |
| dbus-daemon | 0.223 | 1.743 | 0.98 | 56% | 1.72 | 16,374 |

* busd-tokio and busd-zruntime are the binaries of the first comparison.
* busd-zruntime-mtN is busd-zruntime with an experimental change
  ([`busd-threads.diff`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/patches/busd-threads.diff)): with
  `BUSD_THREADS=N`, the bus starts N threads, each of which drives a zruntime runtime of its own,
  and hands each connection it accepts to one of them in turn. The connection then runs on that
  thread, while the accept loop and the bus's own D-Bus service stay on the main thread. With 32
  threads, each of the benchmark's 21 connections gets a thread of its own (threads 1 to 21; the
  ids start at 1).
* busd-zruntime-spinN is busd-zruntime built against zruntime with an experimental change
  ([`zruntime-spin.diff`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/patches/zruntime-spin.diff)):
  with `ZRUNTIME_SPIN_US=N`, the runtime polls for up to N µs without blocking before a wait that
  would put the thread to sleep.

Run 5, eight measured rounds, checks that the second build is not faster for another reason: with
the spinning off (spin0), it measures the same as busd-zruntime.

| Broker | Single client, s | 20 clients, s | Broker CPU, s | Busy | Client CPU, s | Sleeps |
|---|---:|---:|---:|---:|---:|---:|
| busd-zruntime | 0.194 | 2.043 | 0.69 | 34% | 1.99 | 29,496 |
| busd-zruntime-spin0 | 0.199 | 2.116 | 0.70 | 33% | 2.08 | 30,028 |
| busd-zruntime-spin20 | 0.198 | 1.669 | 0.84 | 51% | 1.65 | 6,808 |
| dbus-daemon | 0.222 | 1.812 | 0.97 | 54% | 1.77 | 17,088 |

The single-client timings vary from round to round by more than any of these changes do, 0.16 to
0.25 s, so neither run shows an effect of spinning, or of threads, there.

## Where the time goes

`perf record -F 1999 -g` of the client and of the broker during one run with each broker. The
client and the busd builds were built with frame pointers and symbols for this, and dbus-daemon is
the distribution's. The summaries are in the [`perf`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/perf)
directory.

| | busd-tokio | busd-zruntime | dbus-daemon |
|---|---:|---:|---:|
| Client CPU spent waking the broker on a send | 17.3% | 10.5% | 6.4% |
| Broker CPU spent coming back from a sleep | 35% | 19% | 8% |
| Broker samples in its own code and libc | 915 | 784 | 1,394 |

* The client's wake-ups are its `sendmsg` calls that find the broker's end of the socket waited
  on: `unix_stream_sendmsg`, `sock_def_readable`, `__wake_up_sync_key`
  ([call chain](2026-10-18-busd-dbus-daemon-xeon-4vcpu/perf/client-wakeup-callchain.txt)).
* The broker's are the returns from `epoll_wait` that slept, in `finish_task_switch`
  ([call chain](2026-10-18-busd-dbus-daemon-xeon-4vcpu/perf/broker-switch-callchain.txt)).
* Outside the kernel, busd on zruntime needs little more than half the samples dbus-daemon needs,
  which matches the CPU times above: per message, busd does less work.

Both kinds of wake-up are dearer on a VM than on real hardware: waking a virtual CPU that is idle
takes the host's help. On the machine of the [README](../README.md), busd on Tokio was within 3%
of dbus-daemon with 20 connections, where it takes 50 to 65% longer here, so the gap is likely
smaller on real hardware.

## What dbus-daemon does

dbus-daemon runs one thread, around one `epoll` loop. On each pass, it reads at most about 4 KiB
from each connection that is ready, in reads of 2 KiB, then routes every message it has read in
full, and writes each one out right away, with one `sendmsg` per message. So a 16 KiB message
takes it several passes around the loop to read. Its loop does more work per message than busd
does, and goes round more often, and either way it is asleep less often when the next message
comes. Neither is something that busd would want to copy.

## What could close the gap

* More threads: no. The bus is not short of CPU (busd on zruntime is busy a third of the time),
  and every thread that sleeps on its own is one more thread to wake, while the threads also share
  the bus's state behind locks. The Tokio build, with 4 worker threads, sleeps 76k times.
* Spinning before going to sleep: yes in this benchmark, at a price. While the bus has work coming
  in, a short spin catches the next message without a sleep, as the tables show. But the bus also
  spins every time its work runs out, for nothing. A mostly idle session or system bus runs out of
  work after nearly every message, so it would spend up to the spin time, 20 µs, of CPU per message
  on spinning, and keep its CPU out of deep idle states for that long. That makes it something to
  turn on where it pays, or to do adaptively, such as spinning only while the bus is busy, judged
  by how short its last sleep was. Either way, it is a change to zruntime, not to busd.

## Files

* [`run4.json`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/run4.json),
  [`run5.json`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/run5.json): the runs above, from
  [`scripts/compare-brokers.py`](../scripts/compare-brokers.py).
* [`perf`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/perf): the profiles' summaries and the two call
  chains.
* [`patches`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/patches): the two experimental changes,
  against busd at f0444f9 and zruntime 0.2.0. Neither is meant to be merged as it is.
