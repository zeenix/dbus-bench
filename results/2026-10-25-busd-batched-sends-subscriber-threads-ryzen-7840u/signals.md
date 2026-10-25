rounds: 60 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
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
| queue | 60 | 0.377 | 0.022 | 0.382 | 0.268 | 0.404 |
| baseline | 60 | 0.263 | 0.005 | 0.263 | 0.255 | 0.277 |
| batched | 60 | 0.216 | 0.003 | 0.216 | 0.209 | 0.226 |
| batched-before | 60 | 0.224 | 0.004 | 0.223 | 0.217 | 0.237 |
| dbus-broker | 60 | 0.188 | 0.004 | 0.188 | 0.183 | 0.206 |
| dbus-daemon | 60 | 0.849 | 0.009 | 0.847 | 0.830 | 0.871 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.242 | 0.006 | 0.241 | 0.233 | 0.261 |
| baseline | 60 | 0.395 | 0.007 | 0.396 | 0.378 | 0.427 |
| batched | 60 | 0.138 | 0.003 | 0.138 | 0.133 | 0.153 |
| batched-before | 60 | 0.156 | 0.004 | 0.155 | 0.150 | 0.173 |
| dbus-broker | 60 | 0.220 | 0.005 | 0.219 | 0.211 | 0.234 |
| dbus-daemon | 60 | 2.010 | 0.022 | 2.006 | 1.980 | 2.116 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.556 | 0.009 | 0.556 | 0.530 | 0.585 |
| baseline | 60 | 0.684 | 0.008 | 0.683 | 0.667 | 0.712 |
| batched | 60 | 0.377 | 0.005 | 0.377 | 0.369 | 0.399 |
| batched-before | 60 | 0.404 | 0.006 | 0.404 | 0.395 | 0.423 |
| dbus-broker | 60 | 0.415 | 0.008 | 0.413 | 0.404 | 0.454 |
| dbus-daemon | 60 | 2.871 | 0.026 | 2.866 | 2.830 | 2.999 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 54769 | 8845 | 56748 | 10868 | 61652 |
| baseline | 60 | 6299 | 164 | 6288 | 5976 | 6584 |
| batched | 60 | 6373 | 167 | 6394 | 5920 | 6736 |
| batched-before | 60 | 6402 | 142 | 6412 | 5992 | 6704 |
| dbus-broker | 60 | 15078 | 1582 | 14972 | 11052 | 19308 |
| dbus-daemon | 60 | 5633 | 122 | 5638 | 5424 | 5864 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 1.052 | 0.019 | 1.051 | 1.013 | 1.113 |
| baseline | 60 | 2.618 | 0.031 | 2.618 | 2.519 | 2.743 |
| batched | 60 | 1.201 | 0.019 | 1.199 | 1.166 | 1.279 |
| batched-before | 60 | 1.176 | 0.023 | 1.171 | 1.137 | 1.256 |
| dbus-broker | 60 | 1.480 | 0.025 | 1.477 | 1.429 | 1.580 |
| dbus-daemon | 60 | 3.670 | 0.032 | 3.661 | 3.622 | 3.798 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.213 | 0.008 | 0.210 | 0.200 | 0.240 |
| baseline | 60 | 0.365 | 0.009 | 0.360 | 0.340 | 0.390 |
| batched | 60 | 0.107 | 0.007 | 0.110 | 0.090 | 0.120 |
| batched-before | 60 | 0.122 | 0.007 | 0.120 | 0.110 | 0.140 |
| dbus-broker | 60 | 0.190 | 0.008 | 0.190 | 0.170 | 0.210 |
| dbus-daemon | 60 | 1.981 | 0.022 | 1.980 | 1.950 | 2.080 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.664 | 0.020 | 0.660 | 0.620 | 0.710 |
| baseline | 60 | 2.182 | 0.030 | 2.180 | 2.090 | 2.310 |
| batched | 60 | 0.774 | 0.019 | 0.770 | 0.740 | 0.840 |
| batched-before | 60 | 0.760 | 0.021 | 0.760 | 0.730 | 0.830 |
| dbus-broker | 60 | 1.065 | 0.024 | 1.065 | 1.020 | 1.140 |
| dbus-daemon | 60 | 2.821 | 0.026 | 2.820 | 2.780 | 2.920 |
