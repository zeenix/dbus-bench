rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: ac6e6fa16f5b0b63cce856dc618ca2328c51e713
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
batched-before: 4f346a36a23efe3a88b9539ff1130c55c660be70
dbus-broker: dbus-broker 35
dbus-daemon: D-Bus Message Bus Daemon 1.14.10

### single_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 177.9 | 177.6 | 324.6 | 318.4 | 2820.1 | 2201.3 |
| baseline | 60 | 177.4 | 176.4 | 324.6 | 318.6 | 3025.0 | 2312.8 |
| batched | 60 | 178.4 | 178.6 | 324.7 | 325.1 | 3334.7 | 2426.7 |
| batched-before | 60 | 177.8 | 176.9 | 328.1 | 323.6 | 2850.1 | 2619.3 |
| dbus-broker | 60 | 178.0 | 176.7 | 326.6 | 318.2 | 3507.0 | 2387.5 |
| dbus-daemon | 60 | 190.7 | 188.9 | 350.3 | 338.7 | 3034.3 | 2528.3 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 729.8 | 729.6 | 1590.2 | 1554.9 | 4447.2 | 3928.7 |
| baseline | 60 | 716.3 | 717.1 | 1548.8 | 1539.2 | 4277.7 | 3509.3 |
| batched | 60 | 737.4 | 735.9 | 1616.6 | 1578.5 | 4776.0 | 3645.1 |
| batched-before | 60 | 714.8 | 707.5 | 1502.5 | 1510.3 | 4620.1 | 3389.1 |
| dbus-broker | 60 | 1210.8 | 1214.7 | 2604.4 | 2611.4 | 5847.4 | 5107.4 |
| dbus-daemon | 60 | 842.6 | 835.7 | 2053.4 | 2065.6 | 5591.2 | 4444.5 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 68686.6 | 66697.5 | 118196.8 | 112528.8 | 123315.8 | 117450.3 |
| baseline | 60 | 26823.6 | 26643.3 | 39544.9 | 37934.3 | 41930.0 | 40699.3 |
| batched | 60 | 28476.5 | 27557.7 | 43456.2 | 38993.9 | 46216.3 | 42810.6 |
| batched-before | 60 | 28286.3 | 26666.0 | 40880.0 | 37986.2 | 45485.0 | 41838.4 |
| dbus-broker | 60 | 71263.0 | 70307.1 | 130176.9 | 124742.2 | 136855.7 | 132699.3 |
| dbus-daemon | 60 | 60496.6 | 57292.4 | 196716.1 | 190475.1 | 202130.9 | 197573.8 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 1.205 | 1.199 | 6309 | 6338 | 2.079 | 2.075 |
| baseline | 60 | 1.181 | 1.184 | 5079 | 5084 | 2.054 | 2.053 |
| batched | 60 | 1.149 | 1.140 | 5112 | 5128 | 2.042 | 2.047 |
| batched-before | 60 | 1.138 | 1.137 | 5114 | 5114 | 2.015 | 2.002 |
| dbus-broker | 60 | 1.007 | 1.008 | 11100 | 11096 | 2.598 | 2.595 |
| dbus-daemon | 60 | 1.639 | 1.635 | 6124 | 6142 | 2.376 | 2.376 |
