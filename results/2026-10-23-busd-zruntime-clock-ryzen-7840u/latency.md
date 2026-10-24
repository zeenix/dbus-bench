rounds: 60 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
zruntime-before: 20771cf16b21bc7aa84b3f3ec471b94cf23d7973
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 61.0 | 60.6 | 114.7 | 115.2 | 385.5 | 320.0 |
| timeout | 60 | 61.6 | 60.6 | 109.1 | 107.5 | 377.0 | 252.3 |
| timeout-before | 60 | 63.4 | 61.7 | 117.8 | 118.7 | 365.6 | 289.7 |
| dbus-broker | 60 | 53.9 | 53.4 | 83.7 | 85.5 | 336.5 | 248.1 |
| dbus-daemon | 60 | 100.1 | 98.5 | 194.1 | 197.1 | 606.7 | 457.1 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 478.0 | 474.3 | 788.6 | 802.0 | 1405.1 | 1331.0 |
| timeout | 60 | 480.3 | 477.9 | 807.5 | 819.2 | 1502.9 | 1339.3 |
| timeout-before | 60 | 475.6 | 472.6 | 749.3 | 711.8 | 1442.6 | 1278.7 |
| dbus-broker | 60 | 512.8 | 513.5 | 682.0 | 659.6 | 1307.3 | 1120.8 |
| dbus-daemon | 60 | 1062.7 | 1058.5 | 1669.1 | 1665.2 | 2484.1 | 2434.6 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 57505.1 | 56042.5 | 95828.8 | 94699.8 | 97897.5 | 96164.4 |
| timeout | 60 | 22765.9 | 22493.7 | 29121.6 | 28553.2 | 31217.9 | 31008.6 |
| timeout-before | 60 | 22320.9 | 22131.0 | 28588.1 | 28033.7 | 30440.9 | 29413.4 |
| dbus-broker | 60 | 55612.1 | 54758.5 | 90286.9 | 89010.8 | 95313.7 | 93833.1 |
| dbus-daemon | 60 | 18355.6 | 18304.9 | 29351.7 | 29294.7 | 30982.3 | 31288.8 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.632 | 0.628 | 8150 | 8218 | 1.113 | 1.111 |
| timeout | 60 | 0.640 | 0.638 | 7072 | 7078 | 1.119 | 1.115 |
| timeout-before | 60 | 0.747 | 0.744 | 7016 | 7012 | 1.122 | 1.113 |
| dbus-broker | 60 | 0.528 | 0.528 | 11885 | 11912 | 1.043 | 1.037 |
| dbus-daemon | 60 | 2.077 | 2.069 | 6314 | 6302 | 2.295 | 2.286 |
