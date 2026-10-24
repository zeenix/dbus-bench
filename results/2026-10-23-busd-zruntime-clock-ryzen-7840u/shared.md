rounds: 40 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
zruntime-before: 20771cf16b21bc7aa84b3f3ec471b94cf23d7973
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 1.865 | 0.050 | 1.850 | 1.811 | 2.029 |
| timeout | 40 | 2.075 | 0.053 | 2.063 | 1.994 | 2.221 |
| timeout-before | 40 | 2.169 | 0.073 | 2.167 | 2.042 | 2.371 |
| dbus-broker | 40 | 1.898 | 0.039 | 1.885 | 1.846 | 2.029 |
| dbus-daemon | 40 | 6.371 | 0.039 | 6.370 | 6.301 | 6.478 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 2.247 | 0.078 | 2.237 | 2.126 | 2.468 |
| timeout | 40 | 2.257 | 0.097 | 2.236 | 2.160 | 2.627 |
| timeout-before | 40 | 2.512 | 0.089 | 2.514 | 2.357 | 2.842 |
| dbus-broker | 40 | 2.167 | 0.074 | 2.148 | 2.076 | 2.470 |
| dbus-daemon | 40 | 5.738 | 0.128 | 5.712 | 5.612 | 6.283 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 3.398 | 0.116 | 3.365 | 3.247 | 3.748 |
| timeout | 40 | 3.473 | 0.101 | 3.458 | 3.323 | 3.831 |
| timeout-before | 40 | 4.284 | 0.129 | 4.270 | 4.099 | 4.738 |
| dbus-broker | 40 | 2.712 | 0.058 | 2.709 | 2.627 | 2.916 |
| dbus-daemon | 40 | 12.113 | 0.124 | 12.095 | 11.958 | 12.589 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 11766 | 520 | 11688 | 10892 | 12964 |
| timeout | 40 | 11222 | 587 | 11196 | 10112 | 12760 |
| timeout-before | 40 | 11275 | 467 | 11220 | 10220 | 12416 |
| dbus-broker | 40 | 9340 | 286 | 9370 | 8636 | 9852 |
| dbus-daemon | 40 | 8546 | 295 | 8506 | 8060 | 9184 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 4.017 | 0.082 | 3.998 | 3.895 | 4.262 |
| timeout | 40 | 4.175 | 0.116 | 4.140 | 4.039 | 4.668 |
| timeout-before | 40 | 4.388 | 0.108 | 4.375 | 4.220 | 4.744 |
| dbus-broker | 40 | 4.054 | 0.104 | 4.028 | 3.918 | 4.439 |
| dbus-daemon | 40 | 8.172 | 0.107 | 8.161 | 7.972 | 8.476 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 1.956 | 0.099 | 1.940 | 1.820 | 2.320 |
| timeout | 40 | 1.904 | 0.093 | 1.880 | 1.730 | 2.170 |
| timeout-before | 40 | 2.491 | 0.094 | 2.500 | 2.350 | 2.830 |
| dbus-broker | 40 | 1.527 | 0.039 | 1.515 | 1.470 | 1.670 |
| dbus-daemon | 40 | 5.707 | 0.128 | 5.680 | 5.580 | 6.250 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 2.187 | 0.073 | 2.170 | 2.090 | 2.420 |
| timeout | 40 | 2.202 | 0.096 | 2.170 | 2.110 | 2.570 |
| timeout-before | 40 | 2.377 | 0.068 | 2.370 | 2.300 | 2.630 |
| dbus-broker | 40 | 2.151 | 0.074 | 2.135 | 2.060 | 2.450 |
| dbus-daemon | 40 | 4.376 | 0.099 | 4.360 | 4.250 | 4.740 |
