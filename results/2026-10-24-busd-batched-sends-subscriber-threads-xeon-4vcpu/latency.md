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
| queue | 60 | 174.5 | 174.3 | 318.6 | 310.8 | 4399.0 | 2421.8 |
| baseline | 60 | 170.6 | 171.1 | 301.9 | 290.1 | 2224.5 | 1870.1 |
| batched | 60 | 171.8 | 173.2 | 299.5 | 298.9 | 2750.4 | 2416.4 |
| batched-before | 60 | 173.8 | 174.5 | 314.0 | 306.9 | 3611.4 | 2388.9 |
| dbus-broker | 60 | 171.0 | 170.1 | 307.8 | 303.7 | 3747.5 | 2472.8 |
| dbus-daemon | 60 | 180.0 | 180.2 | 308.5 | 304.4 | 2759.9 | 2305.5 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 694.1 | 673.9 | 1439.1 | 1424.3 | 4519.8 | 3263.7 |
| baseline | 60 | 686.5 | 669.7 | 1379.8 | 1327.0 | 3739.7 | 3010.6 |
| batched | 60 | 694.4 | 669.6 | 1465.1 | 1456.4 | 4334.6 | 3186.6 |
| batched-before | 60 | 701.7 | 699.3 | 1526.1 | 1488.0 | 5775.5 | 3803.6 |
| dbus-broker | 60 | 1206.2 | 1194.1 | 2508.6 | 2495.8 | 5226.9 | 4877.1 |
| dbus-daemon | 60 | 779.9 | 776.4 | 1924.7 | 1937.4 | 4774.2 | 3785.9 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 9066.1 | 8408.1 | 24369.0 | 21186.9 | 29904.4 | 27447.0 |
| baseline | 60 | 16526.9 | 17370.6 | 37178.6 | 36713.8 | 40444.8 | 39365.5 |
| batched | 60 | 4615.3 | 4635.0 | 12141.5 | 11833.2 | 17202.4 | 16914.1 |
| batched-before | 60 | 5019.0 | 5008.9 | 11502.0 | 11569.1 | 15746.4 | 15577.8 |
| dbus-broker | 60 | 6535.3 | 5437.6 | 37151.2 | 34998.7 | 44149.0 | 41624.3 |
| dbus-daemon | 60 | 10610.4 | 10904.4 | 27694.3 | 25868.1 | 31484.7 | 28919.1 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 1.122 | 1.115 | 5715 | 5646 | 1.833 | 1.824 |
| baseline | 60 | 1.280 | 1.266 | 5040 | 5072 | 1.978 | 1.968 |
| batched | 60 | 1.076 | 1.081 | 5101 | 5106 | 1.798 | 1.801 |
| batched-before | 60 | 1.098 | 1.099 | 5086 | 5106 | 1.825 | 1.819 |
| dbus-broker | 60 | 0.944 | 0.939 | 10079 | 9814 | 2.340 | 2.335 |
| dbus-daemon | 60 | 1.715 | 1.716 | 5045 | 5034 | 2.230 | 2.245 |
