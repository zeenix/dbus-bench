rounds: 60 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: 4f346a36a23efe3a88b9539ff1130c55c660be70
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 61.8 | 60.6 | 115.2 | 114.0 | 426.5 | 293.3 |
| baseline | 60 | 61.1 | 60.6 | 114.1 | 112.8 | 343.2 | 303.4 |
| batched | 60 | 61.5 | 60.6 | 116.9 | 118.1 | 417.6 | 333.6 |
| dbus-broker | 60 | 53.9 | 53.4 | 84.7 | 86.7 | 357.2 | 263.6 |
| dbus-daemon | 60 | 99.7 | 98.5 | 203.8 | 203.0 | 651.1 | 542.6 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 479.0 | 474.9 | 807.0 | 810.9 | 1527.9 | 1368.4 |
| baseline | 60 | 479.6 | 474.9 | 799.7 | 812.7 | 1354.0 | 1283.5 |
| batched | 60 | 480.4 | 476.1 | 822.5 | 839.4 | 1478.9 | 1352.9 |
| dbus-broker | 60 | 510.8 | 510.5 | 675.0 | 643.5 | 1271.8 | 1107.8 |
| dbus-daemon | 60 | 1064.8 | 1059.7 | 1675.7 | 1668.8 | 2588.9 | 2432.2 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 57753.5 | 56060.9 | 96316.5 | 94497.3 | 98078.3 | 97119.5 |
| baseline | 60 | 22766.3 | 22482.4 | 29082.7 | 28316.3 | 31506.0 | 32061.7 |
| batched | 60 | 26947.4 | 26690.3 | 34372.5 | 34097.4 | 37995.4 | 37515.6 |
| dbus-broker | 60 | 55321.0 | 54410.0 | 89894.3 | 88668.8 | 94768.5 | 93580.1 |
| dbus-daemon | 60 | 18329.7 | 18309.0 | 29376.7 | 29351.1 | 31118.3 | 31415.8 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.637 | 0.633 | 8087 | 8156 | 1.121 | 1.117 |
| baseline | 60 | 0.637 | 0.636 | 7065 | 7062 | 1.117 | 1.112 |
| batched | 60 | 0.592 | 0.590 | 7091 | 7092 | 1.114 | 1.108 |
| dbus-broker | 60 | 0.527 | 0.524 | 11864 | 11838 | 1.042 | 1.034 |
| dbus-daemon | 60 | 2.079 | 2.074 | 6349 | 6358 | 2.298 | 2.293 |
