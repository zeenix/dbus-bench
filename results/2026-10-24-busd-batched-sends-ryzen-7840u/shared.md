rounds: 40 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: 4f346a36a23efe3a88b9539ff1130c55c660be70
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 1.879 | 0.071 | 1.864 | 1.791 | 2.181 |
| baseline | 40 | 2.077 | 0.050 | 2.068 | 2.008 | 2.233 |
| batched | 40 | 2.038 | 0.050 | 2.033 | 1.961 | 2.123 |
| dbus-broker | 40 | 1.906 | 0.048 | 1.894 | 1.852 | 2.110 |
| dbus-daemon | 40 | 6.394 | 0.053 | 6.389 | 6.311 | 6.564 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 2.256 | 0.083 | 2.248 | 2.130 | 2.556 |
| baseline | 40 | 2.250 | 0.062 | 2.241 | 2.112 | 2.469 |
| batched | 40 | 2.241 | 0.077 | 2.236 | 2.139 | 2.482 |
| dbus-broker | 40 | 2.174 | 0.073 | 2.151 | 2.093 | 2.420 |
| dbus-daemon | 40 | 5.751 | 0.094 | 5.720 | 5.607 | 5.997 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.423 | 0.127 | 3.399 | 3.274 | 3.827 |
| baseline | 40 | 3.450 | 0.085 | 3.449 | 3.307 | 3.741 |
| batched | 40 | 3.401 | 0.093 | 3.371 | 3.286 | 3.700 |
| dbus-broker | 40 | 2.716 | 0.084 | 2.694 | 2.631 | 3.141 |
| dbus-daemon | 40 | 12.149 | 0.113 | 12.126 | 11.963 | 12.415 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 11789 | 403 | 11788 | 10924 | 12592 |
| baseline | 40 | 11361 | 498 | 11322 | 10092 | 12276 |
| batched | 40 | 11238 | 393 | 11222 | 10296 | 12140 |
| dbus-broker | 40 | 9428 | 231 | 9458 | 8816 | 9844 |
| dbus-daemon | 40 | 8467 | 269 | 8468 | 7868 | 8980 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 4.040 | 0.103 | 4.036 | 3.906 | 4.394 |
| baseline | 40 | 4.167 | 0.085 | 4.148 | 4.058 | 4.548 |
| batched | 40 | 4.123 | 0.089 | 4.110 | 4.007 | 4.367 |
| dbus-broker | 40 | 4.069 | 0.106 | 4.037 | 3.958 | 4.465 |
| dbus-daemon | 40 | 8.203 | 0.093 | 8.197 | 8.041 | 8.422 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 1.967 | 0.103 | 1.945 | 1.820 | 2.280 |
| baseline | 40 | 1.884 | 0.072 | 1.885 | 1.760 | 2.120 |
| batched | 40 | 1.940 | 0.077 | 1.920 | 1.810 | 2.130 |
| dbus-broker | 40 | 1.526 | 0.036 | 1.520 | 1.470 | 1.640 |
| dbus-daemon | 40 | 5.719 | 0.094 | 5.695 | 5.580 | 5.960 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 2.197 | 0.076 | 2.190 | 2.090 | 2.470 |
| baseline | 40 | 2.196 | 0.060 | 2.190 | 2.070 | 2.420 |
| batched | 40 | 2.183 | 0.077 | 2.170 | 2.080 | 2.420 |
| dbus-broker | 40 | 2.156 | 0.072 | 2.135 | 2.080 | 2.400 |
| dbus-daemon | 40 | 4.380 | 0.073 | 4.370 | 4.270 | 4.550 |
