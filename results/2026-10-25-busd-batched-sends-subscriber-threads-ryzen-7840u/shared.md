rounds: 40 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: ac6e6fa16f5b0b63cce856dc618ca2328c51e713
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
batched-before: 4f346a36a23efe3a88b9539ff1130c55c660be70
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 1.876 | 0.072 | 1.896 | 1.756 | 1.978 |
| baseline | 40 | 2.065 | 0.082 | 2.075 | 1.932 | 2.240 |
| batched | 40 | 2.026 | 0.077 | 2.033 | 1.898 | 2.190 |
| batched-before | 40 | 2.009 | 0.068 | 2.002 | 1.892 | 2.197 |
| dbus-broker | 40 | 1.884 | 0.047 | 1.898 | 1.814 | 1.977 |
| dbus-daemon | 40 | 6.375 | 0.074 | 6.383 | 6.244 | 6.580 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 2.222 | 0.092 | 2.228 | 2.056 | 2.415 |
| baseline | 40 | 2.226 | 0.075 | 2.228 | 2.074 | 2.364 |
| batched | 40 | 2.236 | 0.078 | 2.246 | 2.087 | 2.416 |
| batched-before | 40 | 2.231 | 0.098 | 2.222 | 2.059 | 2.530 |
| dbus-broker | 40 | 2.135 | 0.054 | 2.138 | 2.041 | 2.320 |
| dbus-daemon | 40 | 5.779 | 0.122 | 5.835 | 5.580 | 5.950 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.410 | 0.167 | 3.442 | 3.139 | 3.812 |
| baseline | 40 | 3.420 | 0.154 | 3.451 | 3.186 | 3.718 |
| batched | 40 | 3.403 | 0.159 | 3.410 | 3.147 | 3.724 |
| batched-before | 40 | 3.352 | 0.145 | 3.360 | 3.121 | 3.641 |
| dbus-broker | 40 | 2.693 | 0.095 | 2.724 | 2.542 | 2.874 |
| dbus-daemon | 40 | 12.157 | 0.182 | 12.219 | 11.843 | 12.503 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 11813 | 427 | 11722 | 11152 | 13016 |
| baseline | 40 | 11452 | 462 | 11520 | 10632 | 12212 |
| batched | 40 | 11316 | 407 | 11302 | 10576 | 12216 |
| batched-before | 40 | 11409 | 510 | 11334 | 10504 | 12632 |
| dbus-broker | 40 | 9333 | 288 | 9360 | 8676 | 9820 |
| dbus-daemon | 40 | 8475 | 320 | 8474 | 7912 | 9104 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.988 | 0.117 | 4.037 | 3.792 | 4.154 |
| baseline | 40 | 4.122 | 0.109 | 4.137 | 3.928 | 4.312 |
| batched | 40 | 4.097 | 0.124 | 4.121 | 3.872 | 4.374 |
| batched-before | 40 | 4.082 | 0.127 | 4.105 | 3.833 | 4.398 |
| dbus-broker | 40 | 4.006 | 0.086 | 4.021 | 3.856 | 4.216 |
| dbus-daemon | 40 | 8.201 | 0.178 | 8.284 | 7.880 | 8.505 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 1.956 | 0.122 | 1.960 | 1.780 | 2.330 |
| baseline | 40 | 1.873 | 0.094 | 1.880 | 1.730 | 2.130 |
| batched | 40 | 1.943 | 0.118 | 1.925 | 1.730 | 2.190 |
| batched-before | 40 | 1.912 | 0.108 | 1.905 | 1.760 | 2.170 |
| dbus-broker | 40 | 1.511 | 0.051 | 1.510 | 1.430 | 1.630 |
| dbus-daemon | 40 | 5.748 | 0.122 | 5.805 | 5.550 | 5.920 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 2.156 | 0.073 | 2.160 | 2.030 | 2.310 |
| baseline | 40 | 2.166 | 0.066 | 2.165 | 2.030 | 2.290 |
| batched | 40 | 2.178 | 0.069 | 2.190 | 2.050 | 2.350 |
| batched-before | 40 | 2.169 | 0.086 | 2.165 | 2.020 | 2.440 |
| dbus-broker | 40 | 2.118 | 0.054 | 2.120 | 2.010 | 2.300 |
| dbus-daemon | 40 | 4.386 | 0.088 | 4.430 | 4.230 | 4.550 |
