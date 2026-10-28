# zruntime's busy polling on a Ryzen 7 7840U

Measured on 2026-10-19 on the laptop of [busd against dbus-broker and dbus-daemon, on a Ryzen 7
7840U](2026-10-18-busd-zruntime-ryzen-7840u.md): an AMD Ryzen 7 7840U (8 cores, 16 threads),
running Fedora 44 with Linux 7.1.13, through
[`scripts/compare-busd-builds.sh`][busd-builds], with the energy counters of
the CPU package open to it. The builds are those of [zruntime's busy polling, measured on
busd](2026-10-18-zruntime-busy-poll-xeon-4vcpu.md), which describes the busy polling, built with
rustc 1.99.0, with busypoll-off and busypoll20 against z-galaxy/zruntime#52 at 27d5df4. Later
commits of that pull request change only its documentation. dbus-broker 37 and dbus-daemon 1.16.2
are those that Fedora 44 ships.

## Summary

On this laptop, busy polling with a limit of 20 µs gains much less than on the VM, and costs more:

* **Under load**, it makes the 20-client run 4.5% faster, 0.875 s against 0.916 s, which puts busd
  ahead of dbus-broker's 0.910 s, for 29% more CPU time in that phase: 0.53 s against 0.41 s, and
  dbus-broker's 0.39 s. A single client gains nothing, 0.088 s against 0.085 s, where the spin
  before every sleep makes it 10% faster, 0.077 s. The rule of the busy polling misses the short
  waits that the spin catches.
* **On one CPU**, it does not hold back with a single client as it did on the VM: the run is 41%
  slower, 0.127 s against 0.090 s, as slow as with the spin.
* **Under light traffic**, it costs where calls and their replies go to and fro. With calls
  forwarded to another client once a millisecond, busd spends 12% more CPU time per call, the
  calls take 6% longer, and the CPU package uses 13% more energy. With calls to the bus every
  50 µs, busd spends 17% more CPU time per call, and the calls take 3% longer. With calls to the bus
  once a millisecond, nothing differs that these runs can measure.

On the VM, the busy polling made the 20-client run 21% faster, because waking an idle virtual CPU
is dear there. On this laptop, a wake-up is cheap enough that there is little to gain, and the costs
show instead. That is what busy polling being off by default is for, and it argues against busd
turning it on by default too.

## Results

Timings are medians, with the fastest and slowest run in parentheses. "Broker CPU" is the broker's
CPU time in the 20-client phase, and "sleeps" how many times it gave up the CPU to wait (voluntary
context switches) over the whole run, both medians too. The differences called out come from a
Mann–Whitney U test (20,000 permutations).

### Under load

One warmup round and 15 measured rounds.

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Sleeps |
|---|---:|---:|---:|---:|
| busd-zruntime | 0.083 (0.081–0.101) | 0.922 (0.895–0.977) | 0.41 | 8,239 |
| busypoll-off | 0.085 (0.081–0.096) | 0.916 (0.892–0.960) | 0.41 | 7,919 |
| busypoll20 | 0.088 (0.084–0.096) | 0.875 (0.863–0.929) | 0.53 | 5,682 |
| busd-spin20 | 0.077 (0.074–0.083) | 0.896 (0.864–0.939) | 0.53 | 4,604 |
| dbus-broker | 0.078 (0.076–0.080) | 0.910 (0.900–0.947) | 0.39 | 59,166 |
| dbus-daemon | 0.146 (0.143–0.190) | 1.156 (1.140–1.194) | 1.12 | 2,055 |

* busypoll-off measures as busd-zruntime does (p > 0.46).
* busypoll20 is faster than busypoll-off with 20 clients and spends more CPU time (both
  p < 0.0001), and is no faster with a single client (p = 0.06).
* Against busd-spin20, busypoll20 is as fast with 20 clients (p = 0.07), for as much CPU time in
  that phase (p = 0.83), and slower with a single client (p < 0.0001).
* Against dbus-broker, busypoll20 is faster with 20 clients (p = 0.0003), slower with a single
  client, and spends more CPU time (both p < 0.0001).

### On one CPU

The client and every broker on CPU 0. One warmup round and 10 measured rounds.

| Broker | 1 client, s | 20 clients, s | Broker CPU, s | Sleeps |
|---|---:|---:|---:|---:|
| busypoll-off | 0.090 (0.090–0.092) | 1.602 (1.587–1.667) | 0.52 | 31,469 |
| busypoll20 | 0.127 (0.119–0.130) | 1.637 (1.554–1.665) | 0.62 | 9,844 |
| spin20 | 0.129 (0.127–0.132) | 1.617 (1.558–1.659) | 0.59 | 8,860 |

busypoll20 is slower than busypoll-off with a single client (p < 0.0001), as fast with 20 clients
(p = 0.06), and spends more CPU time (p < 0.0001). On the VM it was as fast as busypoll-off with a
single client, and slower with 20. These runs do not say why the rule holds back on one machine and
not on the other.

### Under light traffic

10 rounds of each test, every run 3 s long. "CPU per call" is the broker's CPU time over the calls
the client made, with the lowest and highest run in parentheses. "Latency" is the median time a
call took, and "p99" its 99th percentile, both medians over the runs. "Energy" is what the CPU
package used while the client ran, a median over the runs: it counts everything that ran on the
package, the client and the rest of the laptop included. Other activity on the laptop made some
runs take up to twice the usual energy, which the medians and the test, as they go by rank, leave
out.

| Broker | Calls | CPU per call, µs | Latency, µs | p99, µs | Sleeps | Energy, J |
|---|---:|---:|---:|---:|---:|---:|
| **To the bus, every 1 ms** | | | | | | |
| off | 3,000 | 57.5 (45.8–82.6) | 77 | 283 | 3,013 | 27.2 |
| busypoll20 | 3,000 | 62.1 (49.4–85.3) | 78 | 262 | 3,013 | 27.1 |
| spin20 | 3,000 | 82.9 (66.9–97.1) | 81 | 251 | 3,013 | 28.7 |
| **Forwarded, every 1 ms** | | | | | | |
| off | 3,000 | 56.7 (54.3–60.9) | 115 | 294 | 6,020 | 27.2 |
| busypoll20 | 3,000 | 63.7 (61.8–77.1) | 122 | 308 | 6,018 | 30.7 |
| busypoll50 | 3,000 | 150.6 (132.0–157.5) | 127 | 342 | 3,240 | 30.1 |
| spin20 | 3,000 | 103.4 (94.6–114.4) | 116 | 301 | 5,501 | 28.5 |
| **To the bus, every 50 µs** | | | | | | |
| off | 57,766 | 17.9 (17.7–18.7) | 38 | 81 | 57,772 | 64.7 |
| busypoll20 | 57,142 | 21.0 (19.9–22.0) | 39 | 85 | 57,124 | 65.1 |
| spin20 | 58,850 | 37.8 (37.4–38.4) | 37 | 67 | 52,769 | 65.4 |

* **To the bus, every 1 ms**: busypoll20 differs from off in nothing (p > 0.3). spin20 spends 44%
  more CPU time per call (p = 0.0002), and 5% more energy (p = 0.05).
* **Forwarded, every 1 ms**: busypoll20 spends 12% more CPU time per call (p < 0.0001), its calls
  take 6% longer (p = 0.0005), and the package uses 13% more energy (p = 0.005). It used more
  energy than off in all 10 rounds, if by 0.02 J in one. busypoll50 catches about half of the waits
  that would sleep otherwise: it spends 166% more CPU time per call and 11% more energy (both
  p < 0.001). spin20 spends 82% more CPU time per call (p < 0.0001), for calls that take as long
  (p > 0.99), and 5% more energy (p = 0.09).
* **To the bus, every 50 µs**: busypoll20 spends 17% more CPU time per call, and its calls take 3%
  longer (both p < 0.0001). spin20 spends 111% more CPU time per call, for calls that are 3% faster
  and a p99 that is 17% lower (both p < 0.001). The energy differs for neither (p > 0.05).

With the forwarded calls, busypoll20 goes to sleep as often as off does, so its polling almost
never catches anything. Yet its calls take longer than off's, and the package uses more energy, by
as much as with spin20, which spends nearly twice its CPU time: busypoll20 and spin20 differ in
neither (p > 0.29). These runs do not say why. Running the broker, the client and its service on
CPUs of their own would tell whether it comes from where the scheduler puts them, which a broker
that sleeps at times and polls at others could change.

## Files

The directory [of the same name](2026-10-19-zruntime-busy-poll-ryzen-7840u) holds the runs, as
`compare-busd-builds.sh` packed them, each as JSON and as the table the script printed:
`results` (under load), `one-cpu`, and `light-bus-1000`, `light-forward-1000` and `light-bus-50`
(under light traffic).

[busd-builds]: https://github.com/zeenix/dbus-bench/blob/75e5dc0/scripts/compare-busd-builds.sh
