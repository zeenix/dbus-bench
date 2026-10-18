# busd on zruntime vs busd on Tokio

Measured on 2026-10-18, on a cloud VM: 4 vCPUs of an Intel Xeon @ 2.10GHz, 15 GiB of RAM, Linux
6.18. These numbers are not comparable with the ones in the [README](../README.md), which come
from a different machine. Compare the brokers with each other, within this file only.

## Summary

Ported from Tokio to zruntime, busd gets through the benchmark faster, and spends less CPU time and
memory doing it. Medians of 30 runs of each build:

| Metric | busd on Tokio | busd on zruntime | Change |
|---|---:|---:|---:|
| Single client, s | 0.214 | 0.194 | -9% |
| 20 clients, s | 2.749 | 2.062 | -25% |
| Broker CPU, s | 0.871 | 0.734 | -16% |
| Broker peak RSS, MiB | 5.76 | 4.70 | -19% |

* The gain does not come from running on one thread rather than on four. busd on a Tokio runtime
  of one thread, or of one worker, measures much the same as busd on its default pool of workers.
* With 20 clients, the benchmark's own client is what limits the timing. It keeps its one thread
  busy 95 to 97% of the time against every broker. So that timing shows how fast the client gets
  through its work, which the broker affects by how it paces the messages it delivers. The CPU time
  of the broker measures how efficient the broker is itself.
* dbus-daemon is still faster with 20 clients (1.84 s), though it spends the most CPU time of all
  the brokers. With a single client, busd on zruntime is the fastest of them.

## Setup

The client is the `dbus-bench` binary of this repository at 20f3031 (zbus 4.3.0 on a Tokio 1.38
runtime of one thread), built in release mode and unchanged. The brokers:

* busd-tokio: busd at 840d728, the main branch of z-galaxy/busd. It runs on zbus 6.0.0 with its
  `tokio` feature, and on Tokio 1.53.3's multi-thread runtime, which has 4 workers on this machine.
* busd-tokio-1w: the same binary, with `TOKIO_WORKER_THREADS=1`.
* busd-tokio-ct: busd at 840d728, with `#[tokio::main(flavor = "current_thread")]`.
* busd-zruntime: busd ported to zruntime, the `ccr-71f9417f-wbfql4` branch of zeenix/busd at
  f0444f9. It runs on zbus 6.0.0 with its `default-rt` feature, and on zruntime 0.2.0.
* dbus-daemon: dbus-daemon 1.14.10, as the distribution builds it, for reference.

Every busd binary was built with rustc 1.97.0 and busd's release profile (fat LTO, `opt-level =
"s"`, one codegen unit, `panic = "abort"`).

The runs were made with [`scripts/compare-brokers.py`](../scripts/compare-brokers.py), one warmup
round and 15 measured rounds per run, with the brokers in a random order in each round and a fresh
broker process for every measurement. The machine ran nothing else meanwhile. For example, run 1:

```sh
scripts/compare-brokers.py --bench target/release/dbus-bench --rounds 15 --warmup 1 --seed 1 \
    --out run1.json \
    --broker busd-tokio "busd-tokio --address {address}" \
    --broker busd-tokio-1w "TOKIO_WORKER_THREADS=1 busd-tokio --address {address}" \
    --broker busd-zruntime "busd-zruntime --address {address}" \
    --broker dbus-daemon "dbus-daemon --session --nofork --address={address}"
```

The raw results are in [the directory of the same name](2026-10-18-busd-zruntime-xeon-4vcpu),
next to this file.

## Results

Timings are medians, with the fastest and slowest run in parentheses. CPU time and peak resident
memory are medians too, and cover the broker's whole life.

### Run 1: the four brokers

| Broker | n | Single client, s | 20 clients, s | Broker CPU, s | Broker peak RSS, MiB |
|---|---:|---:|---:|---:|---:|
| busd-tokio | 15 | 0.206 (0.193–0.236) | 2.755 (2.688–3.117) | 0.876 | 5.73 |
| busd-tokio-1w | 15 | 0.207 (0.194–0.237) | 2.746 (2.622–2.987) | 0.865 | 5.30 |
| busd-zruntime | 15 | 0.198 (0.181–0.251) | 2.146 (1.922–2.683) | 0.744 | 4.71 |
| dbus-daemon | 15 | 0.225 (0.204–0.298) | 1.844 (1.681–2.333) | 1.103 | 4.89 |

### Run 2: Tokio on one thread

| Broker | n | Single client, s | 20 clients, s | Broker CPU, s | Broker peak RSS, MiB |
|---|---:|---:|---:|---:|---:|
| busd-tokio | 15 | 0.219 (0.201–0.260) | 2.704 (2.629–2.968) | 0.864 | 5.78 |
| busd-tokio-ct | 15 | 0.207 (0.191–0.232) | 2.757 (2.544–2.813) | 0.843 | 5.16 |
| busd-zruntime | 15 | 0.194 (0.177–0.205) | 2.038 (1.929–2.159) | 0.721 | 4.67 |

The summary pools the busd-tokio and busd-zruntime runs of runs 1 and 2.

### Run 3: the client

Six measured rounds per broker, which also record the client's CPU time, and how many times each
process gave up the CPU to wait for something to do (voluntary context switches, "waits" below).
Times are in seconds, and "busy" is the client's CPU time over its wall time.

| Broker | 20 clients | Client wall | Client CPU | Busy | Client waits | Broker CPU | Broker waits |
|---|---:|---:|---:|---:|---:|---:|---:|
| busd-tokio | 2.692 | 2.910 | 2.820 | 97% | 4,040 | 0.856 | 78,406 |
| busd-tokio-ct | 2.703 | 2.910 | 2.812 | 97% | 4,182 | 0.814 | 78,680 |
| busd-zruntime | 2.036 | 2.227 | 2.151 | 97% | 4,052 | 0.704 | 34,543 |
| dbus-daemon | 1.717 | 1.941 | 1.845 | 95% | 4,172 | 1.020 | 18,452 |

The client is busy nearly all the time with every broker, but how much CPU time it needs depends on
the broker. That fits with how often the broker waits: busd on Tokio waits more than twice as often
as busd on zruntime, which suggests that it handles fewer messages per wake-up, and hands them on
to the client in smaller bursts. The client itself waits as often with every broker, though, so
this does not pin down why it needs more CPU time with some brokers than with others.

### System calls

`strace -c -f` attached to each broker for one run (`--strace-dir`):

| Broker | recvmsg (would block) | sendmsg | epoll waits | futex |
|---|---:|---:|---:|---:|
| busd-tokio | 126,381 (42,108) | 42,377 | 6,366 | 3,835 |
| busd-tokio-ct | 126,361 (42,088) | 42,229 | 5,026 | 71 |
| busd-zruntime | 126,363 (42,090) | 42,210 | 4,695 | 85 |
| dbus-daemon | 252,168 (42,063) | 42,168 | 13,429 | not listed |

Tracing slows a broker down several times over, which changes how messages queue up. So only the
number of calls made per message is worth reading here, not the timings, and not the number of
waits. busd makes the same calls per message on zruntime as on Tokio, so zruntime adds none. The
futex calls of busd-tokio are the wake-ups between its threads. Those of busd-zruntime are the idle
waits of the one thread it keeps for blocking work, which binds the socket at start-up and then
has nothing to do.

### Size of the binary

| | busd-tokio | busd-zruntime | Change |
|---|---:|---:|---:|
| Release binary, bytes | 1,983,168 | 1,866,512 | -116,656 (-5.9%) |
| Code (text section), bytes | 1,905,834 | 1,795,593 | -110,241 (-5.8%) |
| Crates compiled | 59 | 55 | -4 |

Both binaries are stripped, as busd's release profile has it. The port takes tokio, tokio-macros,
mio, event-listener and parking out of the crates that are compiled, and adds signal-hook. The
lock file shrinks from 190 packages to 129, mostly because the console-subscriber feature, which
the default build left out, is gone, and with it the crates that only it pulled in.

## Follow-up

[Why dbus-daemon leads busd with 20 clients](2026-10-18-busd-dbus-daemon-xeon-4vcpu.md) profiles
the client and the brokers, which explains why the client needs more CPU time with some brokers
than with others, and tries two ways of closing the gap with dbus-daemon: more threads, which make
busd slower, and spinning in zruntime before it goes to sleep, which puts busd ahead.
