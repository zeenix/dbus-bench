# The benchmark on zbus 6

Measured on 2026-10-20, on a cloud VM: 4 vCPUs of an Intel Xeon @ 2.10GHz, Linux 6.18. These
numbers are not comparable with the ones in the [README](../README.md), which come from a different
machine. Compare the builds with each other, within this file only.

## Summary

Moving the benchmark from zbus 4.3 to zbus 6 makes its client much faster, and the client is what
limits the timings of the fastest brokers. Having the service borrow the byte array of each call
rather than copy it, and the client make the array once, makes it faster still. Medians of 15 runs
of each build, with 20 clients:

| Build | busd main | dbus-broker | dbus-daemon |
|---|---:|---:|---:|
| zbus-4.3 | 2.158 s | 2.852 s | 1.857 s |
| zbus-6 | 0.768 s | 1.178 s | 0.878 s |
| zbus-6-borrow | 0.674 s | 1.117 s | 0.882 s |

* The move to zbus 6 takes 53 to 64% off the timings with 20 clients and 24 to 31% off those with
  a single client (p < 0.001 throughout). In the 20-client phase, the client spends 58 to 65% less
  CPU time, and the brokers spend 16 to 28% less (p < 0.001), which these runs do not explain.
* On zbus 6, borrowing the array and making it once take another 12.2% off the 20-client timing
  with busd (p = 0.0001) and 5.2% with dbus-broker (p = 0.01): the client spends 9.6% and 4.4% less
  CPU time in that phase. Most of that comes from not copying the array. Making it once alone
  (zbus-6-once) gains 5.4% with busd (p = 0.02), and nothing with dbus-broker (p = 1.0).
* With busd and dbus-broker, the client is busy 96 to 98% of the 20-client phase with every build,
  so that timing tracks the client's CPU time. With dbus-daemon, it is busy 97% of the time on
  zbus 4.3 but only 82 to 84% on zbus 6: dbus-daemon is what limits that run now, and borrowing the
  array changes nothing there (p = 0.49).

## Setup

The client is the `dbus-bench` binary of this repository, built in release mode with rustc 1.97.0,
in four builds:

* zbus-4.3: 2f30506, the main branch before the move to zbus 6, on zbus 4.3.0 and a Tokio runtime
  of one thread.
* zbus-6: 21dfc98, the move to zbus 6.0.0, still on a Tokio runtime of one thread.
* zbus-6-once: zbus-6 with [make-once.diff](2026-10-20-zbus-6-xeon-4vcpu/make-once.diff), which has
  the client make the array once and send it with every call. For the proxy that the interface
  generates to take it by reference, the service takes it as a `&ByteBuf`, which zbus still copies
  the array into.
* zbus-6-borrow: e11f380, where the service takes the array as a `ByteArray`, which borrows it from
  the message, and the client makes it once. It was measured from a copy that named that newtype
  `Payload`, and was the same otherwise.

The brokers:

* busd-main: busd at a982812, the main branch of z-galaxy/busd, on zbus 6.0.0 and zruntime 0.2.0,
  built with busd's release profile.
* dbus-broker 35 and dbus-daemon 1.14.10, as Ubuntu 24.04 ships them. dbus-broker's launcher logs
  to the journal, which the VM did not run, so a socket that threw away what it got stood in for
  the journal's.

Each round ran [`scripts/compare-brokers.py`](../scripts/compare-brokers.py) once for each build,
the builds in an order shuffled anew every round, so that drift of the machine hit all of them
alike. Each of those runs measured every broker once, in an order of its own, with a fresh broker
process for every measurement. Round 0 is left out of the results. The machine ran nothing else
meanwhile.

```sh
for round in $(seq 0 15); do
    for build in $(printf '%s\n' zbus-4.3 zbus-6 zbus-6-once zbus-6-borrow |
        shuf --random-source=<(yes "$round")); do
        scripts/compare-brokers.py --bench "dbus-bench-$build" --rounds 1 --warmup 0 \
            --seed "$round" --out "r$round-$build.json" \
            --broker dbus-daemon "dbus-daemon --session --nofork --address={address}" \
            --broker dbus-broker "systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS={address} \
                -l {path} dbus-broker-launch --scope user" \
            --broker busd-main "busd --address {address}"
    done
done
```

The runs of all those files are in `runs.json`, which
[runs.tar.xz](2026-10-20-zbus-6-xeon-4vcpu/runs.tar.xz) holds, each with its build and round,
round 0's flagged as warmup runs.
[analyze.py](2026-10-20-zbus-6-xeon-4vcpu/analyze.py) makes the tables below from it, with the
p-values of a Mann–Whitney U test (20,000 permutations):

```sh
cd results/2026-10-20-zbus-6-xeon-4vcpu
tar -xJf runs.tar.xz
./analyze.py runs.json zbus-4.3 zbus-6
./analyze.py runs.json zbus-6 zbus-6-once zbus-6-borrow
```

## Results

Medians in seconds. `single_s` and `multi_s` are the timings that the client prints, for the single
client and the 20 clients. `client_cpu_s` and `broker_cpu_s` are the CPU times of the client and
the broker over the whole run, `multi_client_cpu_s` and `multi_broker_cpu_s` those of the
20-client phase alone (see [`scripts/compare-brokers.py`](../scripts/compare-brokers.py)).

### The move to zbus 6

| busd main | zbus-4.3 | zbus-6 |
|---|---:|---:|
| single_s | 0.197 | 0.145 (-26.5%, p = 0.0000) |
| multi_s | 2.158 | 0.768 (-64.4%, p = 0.0000) |
| client_cpu_s | 2.240 | 0.817 (-63.5%, p = 0.0000) |
| multi_client_cpu_s | 2.110 | 0.730 (-65.4%, p = 0.0000) |
| broker_cpu_s | 0.752 | 0.569 (-24.4%, p = 0.0000) |
| multi_broker_cpu_s | 0.680 | 0.500 (-26.5%, p = 0.0000) |

| dbus-broker | zbus-4.3 | zbus-6 |
|---|---:|---:|
| single_s | 0.211 | 0.146 (-30.8%, p = 0.0000) |
| multi_s | 2.852 | 1.178 (-58.7%, p = 0.0000) |
| client_cpu_s | 2.956 | 1.233 (-58.3%, p = 0.0000) |
| multi_client_cpu_s | 2.800 | 1.130 (-59.6%, p = 0.0000) |
| broker_cpu_s | 0.670 | 0.501 (-25.2%, p = 0.0000) |
| multi_broker_cpu_s | 0.600 | 0.430 (-28.3%, p = 0.0000) |

| dbus-daemon | zbus-4.3 | zbus-6 |
|---|---:|---:|
| single_s | 0.223 | 0.169 (-24.3%, p = 0.0000) |
| multi_s | 1.857 | 0.878 (-52.7%, p = 0.0000) |
| client_cpu_s | 1.948 | 0.823 (-57.7%, p = 0.0000) |
| multi_client_cpu_s | 1.810 | 0.730 (-59.7%, p = 0.0000) |
| broker_cpu_s | 1.066 | 0.922 (-13.5%, p = 0.0006) |
| multi_broker_cpu_s | 0.980 | 0.820 (-16.3%, p = 0.0007) |

The client is busy 97% of the 20-client phase with busd on zbus 4.3 and 96% on zbus 6, 98 and 97%
with dbus-broker, and 97 and 84% with dbus-daemon.

### Borrowing the array, and making it once

| busd main | zbus-6 | zbus-6-once | zbus-6-borrow |
|---|---:|---:|---:|
| single_s | 0.145 | 0.141 (-2.7%, p = 0.1124) | 0.145 (+0.1%, p = 0.7148) |
| multi_s | 0.768 | 0.727 (-5.4%, p = 0.0248) | 0.674 (-12.2%, p = 0.0001) |
| client_cpu_s | 0.817 | 0.768 (-5.9%, p = 0.0360) | 0.732 (-10.4%, p = 0.0000) |
| multi_client_cpu_s | 0.730 | 0.690 (-5.5%, p = 0.0145) | 0.660 (-9.6%, p = 0.0000) |
| broker_cpu_s | 0.569 | 0.549 (-3.5%, p = 0.2213) | 0.550 (-3.3%, p = 0.3927) |
| multi_broker_cpu_s | 0.500 | 0.480 (-4.0%, p = 0.3568) | 0.480 (-4.0%, p = 0.3724) |

| dbus-broker | zbus-6 | zbus-6-once | zbus-6-borrow |
|---|---:|---:|---:|
| single_s | 0.146 | 0.144 (-1.0%, p = 0.7440) | 0.140 (-4.3%, p = 0.5175) |
| multi_s | 1.178 | 1.176 (-0.1%, p = 1.0000) | 1.117 (-5.2%, p = 0.0124) |
| client_cpu_s | 1.233 | 1.239 (+0.5%, p = 0.9676) | 1.183 (-4.0%, p = 0.0054) |
| multi_client_cpu_s | 1.130 | 1.150 (+1.8%, p = 1.0000) | 1.080 (-4.4%, p = 0.0036) |
| broker_cpu_s | 0.501 | 0.500 (-0.3%, p = 1.0000) | 0.485 (-3.2%, p = 0.0729) |
| multi_broker_cpu_s | 0.430 | 0.430 (+0.0%, p = 0.9389) | 0.420 (-2.3%, p = 0.0147) |

| dbus-daemon | zbus-6 | zbus-6-once | zbus-6-borrow |
|---|---:|---:|---:|
| single_s | 0.169 | 0.161 (-4.7%, p = 0.4332) | 0.162 (-4.2%, p = 0.1711) |
| multi_s | 0.878 | 0.884 (+0.6%, p = 0.9690) | 0.882 (+0.4%, p = 0.4870) |
| client_cpu_s | 0.823 | 0.821 (-0.3%, p = 0.6551) | 0.796 (-3.3%, p = 0.0360) |
| multi_client_cpu_s | 0.730 | 0.750 (+2.7%, p = 0.8769) | 0.710 (-2.7%, p = 0.0774) |
| broker_cpu_s | 0.922 | 0.929 (+0.8%, p = 0.9673) | 0.940 (+2.0%, p = 0.9310) |
| multi_broker_cpu_s | 0.820 | 0.830 (+1.2%, p = 0.8461) | 0.840 (+2.4%, p = 0.9729) |

The client is busy 96% of the 20-client phase with busd in all three builds, 97% with
dbus-broker, and 84, 83 and 82% with dbus-daemon.
