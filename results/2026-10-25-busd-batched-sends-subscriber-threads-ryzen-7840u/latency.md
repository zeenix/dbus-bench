rounds: 60 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: ac6e6fa16f5b0b63cce856dc618ca2328c51e713
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
batched-before: 4f346a36a23efe3a88b9539ff1130c55c660be70
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 62.6 | 61.7 | 115.7 | 117.5 | 471.3 | 337.8 |
| baseline | 60 | 62.2 | 61.7 | 110.8 | 109.2 | 335.8 | 267.1 |
| batched | 60 | 62.5 | 61.7 | 114.0 | 112.8 | 452.3 | 316.4 |
| batched-before | 60 | 62.3 | 61.7 | 114.0 | 109.8 | 435.5 | 268.9 |
| dbus-broker | 60 | 54.4 | 53.4 | 84.8 | 85.5 | 384.4 | 256.5 |
| dbus-daemon | 60 | 101.8 | 100.9 | 200.9 | 205.4 | 671.7 | 511.1 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 485.1 | 485.6 | 877.7 | 882.8 | 1462.5 | 1484.1 |
| baseline | 60 | 484.3 | 485.6 | 881.7 | 910.1 | 1389.4 | 1339.9 |
| batched | 60 | 485.0 | 485.6 | 889.7 | 913.6 | 1414.3 | 1383.2 |
| batched-before | 60 | 484.2 | 485.6 | 891.3 | 915.4 | 1438.9 | 1402.2 |
| dbus-broker | 60 | 514.2 | 514.1 | 725.4 | 708.2 | 1356.8 | 1227.7 |
| dbus-daemon | 60 | 1086.8 | 1089.4 | 1704.5 | 1684.2 | 2517.3 | 2485.6 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 6297.3 | 6347.4 | 10039.3 | 10089.8 | 10544.4 | 10589.1 |
| baseline | 60 | 7541.8 | 7525.8 | 9891.7 | 9869.0 | 10273.1 | 10230.5 |
| batched | 60 | 2261.4 | 2260.1 | 3836.8 | 3751.3 | 4365.4 | 4258.9 |
| batched-before | 60 | 3041.8 | 3043.1 | 4303.9 | 4250.0 | 4748.5 | 4655.5 |
| dbus-broker | 60 | 2113.9 | 2114.6 | 3495.6 | 3510.9 | 3783.2 | 3725.2 |
| dbus-daemon | 60 | 20425.8 | 20469.3 | 32947.2 | 32954.6 | 34665.6 | 34621.0 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.631 | 0.634 | 7052 | 7090 | 0.970 | 0.974 |
| baseline | 60 | 0.668 | 0.671 | 7005 | 7014 | 1.005 | 1.003 |
| batched | 60 | 0.595 | 0.598 | 7001 | 7024 | 0.935 | 0.936 |
| batched-before | 60 | 0.600 | 0.603 | 7046 | 7068 | 0.938 | 0.943 |
| dbus-broker | 60 | 0.538 | 0.538 | 8247 | 8258 | 0.877 | 0.876 |
| dbus-daemon | 60 | 2.185 | 2.188 | 6307 | 6308 | 2.416 | 2.421 |
