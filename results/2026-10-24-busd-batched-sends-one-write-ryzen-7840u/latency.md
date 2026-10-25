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
| queue | 60 | 61.9 | 61.7 | 121.5 | 123.5 | 610.7 | 514.1 |
| baseline | 60 | 61.9 | 61.7 | 121.6 | 121.1 | 615.0 | 467.2 |
| batched | 60 | 62.4 | 61.7 | 124.9 | 127.0 | 553.9 | 503.4 |
| batched-before | 60 | 62.0 | 61.7 | 122.2 | 120.5 | 486.4 | 365.1 |
| dbus-broker | 60 | 54.1 | 53.4 | 91.0 | 90.2 | 535.7 | 412.0 |
| dbus-daemon | 60 | 101.6 | 100.9 | 218.6 | 218.5 | 801.7 | 740.9 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 484.9 | 485.6 | 889.5 | 890.5 | 1727.1 | 1666.4 |
| baseline | 60 | 486.2 | 488.0 | 917.7 | 922.5 | 1761.2 | 1617.7 |
| batched | 60 | 486.1 | 488.6 | 895.7 | 916.6 | 1642.1 | 1491.9 |
| batched-before | 60 | 484.9 | 485.6 | 908.8 | 914.8 | 1638.1 | 1464.0 |
| dbus-broker | 60 | 519.0 | 517.7 | 775.0 | 747.4 | 1647.5 | 1534.6 |
| dbus-daemon | 60 | 1094.6 | 1093.5 | 1788.1 | 1715.7 | 2937.7 | 3062.1 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 59221.1 | 58629.1 | 98946.2 | 98669.6 | 101338.9 | 100378.7 |
| baseline | 60 | 23513.5 | 23236.4 | 30700.6 | 29918.0 | 33346.1 | 33399.2 |
| batched | 60 | 27871.2 | 27595.0 | 36553.1 | 36987.3 | 38965.9 | 38605.0 |
| batched-before | 60 | 27258.6 | 27254.9 | 35316.7 | 35211.1 | 39226.9 | 38939.2 |
| dbus-broker | 60 | 56317.8 | 55824.1 | 92329.9 | 91694.1 | 97336.3 | 96571.0 |
| dbus-daemon | 60 | 18765.6 | 18732.3 | 29981.6 | 29817.7 | 31464.7 | 31159.9 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.662 | 0.663 | 8155 | 8204 | 1.145 | 1.148 |
| baseline | 60 | 0.665 | 0.664 | 7071 | 7060 | 1.147 | 1.148 |
| batched | 60 | 0.605 | 0.603 | 7094 | 7084 | 1.127 | 1.130 |
| batched-before | 60 | 0.609 | 0.609 | 7087 | 7086 | 1.132 | 1.134 |
| dbus-broker | 60 | 0.553 | 0.553 | 11756 | 11758 | 1.063 | 1.060 |
| dbus-daemon | 60 | 2.143 | 2.141 | 6329 | 6328 | 2.367 | 2.366 |
