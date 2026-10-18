# busd on zruntime vs busd on Tokio, on a Ryzen 7 7840U

Measured on 2026-10-18 on a laptop with an AMD Ryzen 7 7840U (8 cores, 16 threads), running
Fedora 44 with Linux 7.1.13, through
[`scripts/compare-busd-builds.sh`](../scripts/compare-busd-builds.sh): one warmup round and 15
measured rounds. The brokers are the builds of the comparisons on a
4-vCPU VM, [busd on zruntime vs busd on Tokio](2026-10-18-busd-zruntime-xeon-4vcpu.md) and
[why dbus-daemon leads busd with 20 clients](2026-10-18-busd-dbus-daemon-xeon-4vcpu.md), and the
dbus-daemon that Fedora 44 ships.

## Summary

* Here, busd is well ahead of dbus-daemon, on either runtime. Busd on zruntime takes 0.93 s with
  20 clients, where dbus-daemon takes 1.16 s (19% less), and 0.088 s with a single client, where
  dbus-daemon takes 0.159 s (45% less). It spends 61% less CPU time in the 20-client phase.
  With 20 clients, dbus-daemon is what limits the timing: it keeps its one thread busy (99%), and
  the client waits for it (busy 85% of the time).
* busd on zruntime and busd on Tokio take about as long. With 20 clients, Tokio is 3% faster
  (0.907 s against 0.934 s), and with a single client, zruntime is 3.6% faster (0.088 s against
  0.091 s), which these rounds cannot tell from chance. On zruntime, though, the bus spends less
  than half the CPU time that it does on Tokio in the 20-client phase (0.45 s against 0.95 s), and
  its peak resident memory is 6.4 MiB rather than 7.6 MiB.
* With every busd build, the client keeps its thread busy all through the 20-client phase (98 to
  100%), so that timing says more about the client than about the bus. The CPU time of the bus is
  what tells the builds apart.
* Spinning for 20 µs before going to sleep shortens the single-client timing by 10% (0.079 s
  against 0.088 s), but changes nothing that these rounds can tell with 20 clients, while the bus
  spends 27% more CPU time in that phase. On the VM it was the other way round: there, the spin
  made up for the cost of waking an idle virtual CPU, which real hardware does not have.

The differences called out above are those that a Mann–Whitney U test over the 15 rounds of each
broker (20,000 permutations) finds unlikely to be chance (p < 0.05): with 20 clients, Tokio against
zruntime (p = 0.02) and busd against dbus-daemon; with a single client, the spin and busd against
dbus-daemon; and every difference in CPU time. The rest are not: zruntime against Tokio with a
single client (p = 0.08), and the spin with 20 clients (p = 0.09).

## Results

Timings are medians, with the fastest and slowest run in parentheses. "Broker CPU" is the
broker's CPU time in the 20-client phase, and "busy" that over the phase's duration, summed over
the broker's threads. "Client busy" is the same for the client. "Sleeps" is how many times the
broker gave up the CPU to wait (voluntary context switches) over the whole run, and "RSS" its peak
resident memory. All are medians.

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Busy | Client busy | Sleeps | RSS, MiB |
|---|---:|---:|---:|---:|---:|---:|---:|
| busd-tokio | 0.091 (0.087–0.095) | 0.907 (0.882–0.953) | 0.95 | 104% | 100% | 47,956 | 7.56 |
| busd-zruntime | 0.088 (0.082–0.100) | 0.934 (0.910–0.961) | 0.45 | 49% | 99% | 8,041 | 6.38 |
| busd-spin0 | 0.088 (0.083–0.095) | 0.923 (0.892–0.980) | 0.45 | 48% | 98% | 8,055 | 6.38 |
| busd-spin20 | 0.079 (0.075–0.085) | 0.910 (0.883–0.984) | 0.57 | 63% | 99% | 4,564 | 6.31 |
| dbus-daemon | 0.159 (0.144–0.180) | 1.158 (1.145–1.213) | 1.15 | 99% | 85% | 2,074 | 6.14 |

* busd-tokio: busd at 840d728, on Tokio's multi-thread runtime.
* busd-zruntime: busd ported to zruntime, at f0444f9.
* busd-spin0 and busd-spin20: the port built against zruntime 0.2.0 with the experimental spin of
  [`zruntime-spin.diff`](2026-10-18-busd-dbus-daemon-xeon-4vcpu/patches/zruntime-spin.diff), off
  and at 20 µs. busd-spin0 measures as busd-zruntime does, as it should.

The raw results are in [`run1.json`](2026-10-18-busd-zruntime-ryzen-7840u/run1.json).

## The numbers in the README

The [README](../README.md)'s results for this machine, from 2024, have every broker take about
6.5 s with 20 connections and 0.43 s with one. The same client takes 0.9 to 1.2 s and 0.08 to 0.16
s here. The README says to run the client with `cargo run`, which builds it without optimisation,
while `compare-busd-builds.sh` builds it in release mode. An unoptimised client is a likely reason
why every broker took about as long then: the client would have been far slower than any of them.
