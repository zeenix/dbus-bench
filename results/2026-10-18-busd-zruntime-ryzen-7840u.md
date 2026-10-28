# busd against dbus-broker and dbus-daemon, on a Ryzen 7 7840U

Measured on 2026-10-18 on a laptop with an AMD Ryzen 7 7840U (8 cores, 16 threads), running
Fedora 44 with Linux 7.1.13, through
[`scripts/compare-busd-builds.sh`][busd-builds], in two runs of one warmup
round and 15 measured rounds each. The busd builds are those of the comparisons on a 4-vCPU VM,
[busd on zruntime vs busd on Tokio](2026-10-18-busd-zruntime-xeon-4vcpu.md) and
[why dbus-daemon leads busd with 20 clients](2026-10-18-busd-dbus-daemon-xeon-4vcpu.md), built
with rustc 1.99.0. dbus-broker 37 and dbus-daemon 1.16.2 are those that Fedora 44 ships. Only the
second run has dbus-broker.

## Summary

* busd on zruntime is level with dbus-broker, the broker that most systems run, where the bus is
  loaded: with 20 clients, both take 0.93 s, and they spend 0.42 s and 0.41 s of CPU time doing
  it. With a single client, dbus-broker is 7% faster: 0.082 s against 0.088 s.
* busd needs less memory: its peak resident memory is 6.3 MiB, against 7.9 MiB for dbus-broker's
  two processes, its launcher and the broker proper, together.
* It is the port to zruntime that puts busd level with dbus-broker. On Tokio, busd is about as
  fast with 20 clients, but spends more than twice dbus-broker's CPU time (0.91 s), and it is 13%
  slower than dbus-broker with a single client. Over both runs, busd spends 53% less CPU time on
  zruntime than on Tokio in the 20-client phase and needs 16% less memory, and it is 4% faster
  with a single client and 2% slower with 20.
* dbus-daemon is well behind: 1.19 s with 20 clients and 0.160 s with a single client, for 1.14 s
  of CPU time. It is the one broker that limits the 20-client timing: it keeps its one thread busy
  (97%), and the client waits for it, busy 83% of the time. With every other broker the client is
  busy all through that phase (98 to 99%), so its timing says more about the client than about
  the broker, and the CPU time of the broker is what tells those brokers apart.
* Spinning for 20 µs before going to sleep puts busd ahead of dbus-broker: 3.5% with a single
  client (0.079 s) and 2.4% with 20 (0.907 s), for 34% more CPU time than dbus-broker's (0.55 s).
  On the VM, the spin mostly made up for the cost of waking an idle virtual CPU instead, which
  real hardware does not have.

The differences called out above are those that a Mann–Whitney U test (20,000 permutations) finds
unlikely to be chance (p < 0.05). Two are not: busd on zruntime against dbus-broker with 20
clients (p = 0.46), and busd on Tokio against it (p = 0.13), which is why they count as level. The
CPU times of busd on zruntime and of dbus-broker differ by one clock tick (10 ms), which the test
does tell from chance (p = 0.003), but which is no difference that matters.

## Results

Timings are medians, with the fastest and slowest run in parentheses. "Broker CPU" is the
broker's CPU time in the 20-client phase, and "busy" that over the phase's duration, summed over
the broker's threads and processes. "Client busy" is the same for the client. "Sleeps" is how many
times the broker gave up the CPU to wait (voluntary context switches) over the whole run, and
"RSS" its peak resident memory, summed over its processes. All are medians.

### Run 2: with dbus-broker

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Busy | Client busy | Sleeps | RSS, MiB |
|---|---:|---:|---:|---:|---:|---:|---:|
| busd-tokio | 0.092 (0.089–0.098) | 0.917 (0.889–1.037) | 0.91 | 99% | 98% | 47,742 | 7.55 |
| busd-zruntime | 0.088 (0.083–0.093) | 0.926 (0.904–0.968) | 0.42 | 46% | 98% | 8,245 | 6.34 |
| busd-spin0 | 0.087 (0.083–0.091) | 0.918 (0.900–0.950) | 0.42 | 46% | 98% | 8,076 | 6.34 |
| busd-spin20 | 0.079 (0.075–0.084) | 0.907 (0.869–0.947) | 0.55 | 60% | 99% | 4,687 | 6.33 |
| dbus-daemon | 0.160 (0.146–0.179) | 1.185 (1.151–1.233) | 1.14 | 97% | 83% | 2,079 | 6.05 |
| dbus-broker | 0.082 (0.077–0.091) | 0.930 (0.911–1.051) | 0.41 | 44% | 99% | 59,451 | 7.86 |

* busd-tokio: busd at 840d728, on Tokio's multi-thread runtime.
* busd-zruntime: busd ported to zruntime, at 0d22862.
* busd-spin0 and busd-spin20: the port built against zruntime 0.2.0 with the experimental spin of
  [`zruntime-spin.diff`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/patches/zruntime-spin.diff), off
  and at 20 µs. busd-spin0 measures as busd-zruntime does, as it should.
* dbus-broker: started by `systemd-socket-activate` under its launcher, `dbus-broker-launch
  --scope user`, on a bus of its own. Its CPU time, sleeps and memory are those of the launcher and
  the broker together.

### Run 1: without dbus-broker

The first run, 40 minutes earlier, agrees with the second: its timings are within 3% of the
second's and its CPU times within 7%, and busd on zruntime compares with busd on Tokio in the same
way.

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Busy | Client busy | Sleeps | RSS, MiB |
|---|---:|---:|---:|---:|---:|---:|---:|
| busd-tokio | 0.091 (0.087–0.095) | 0.907 (0.882–0.953) | 0.95 | 104% | 100% | 47,956 | 7.56 |
| busd-zruntime | 0.088 (0.082–0.100) | 0.934 (0.910–0.961) | 0.45 | 49% | 99% | 8,041 | 6.38 |
| busd-spin0 | 0.088 (0.083–0.095) | 0.923 (0.892–0.980) | 0.45 | 48% | 98% | 8,055 | 6.38 |
| busd-spin20 | 0.079 (0.075–0.085) | 0.910 (0.883–0.984) | 0.57 | 63% | 99% | 4,564 | 6.31 |
| dbus-daemon | 0.159 (0.144–0.180) | 1.158 (1.145–1.213) | 1.15 | 99% | 85% | 2,074 | 6.14 |

The raw results are `run1.json` and `run2.json`, in
[`runs.tar.xz`](2026-10-18-busd-zruntime-ryzen-7840u/runs.tar.xz).

## The numbers in the README

The [README](../README.md)'s results for this machine, from 2024, have every broker take about
6.5 s with 20 connections and 0.43 s with one. The same client takes 0.9 to 1.2 s and 0.08 to 0.16
s here. The README says to run the client with `cargo run`, which builds it without optimisation,
while `compare-busd-builds.sh` builds it in release mode. An unoptimised client is a likely reason
why every broker took about as long then: the client would have been far slower than any of them.

[busd-builds]: https://github.com/zeenix/dbus-bench/blob/75e5dc0/scripts/compare-busd-builds.sh
