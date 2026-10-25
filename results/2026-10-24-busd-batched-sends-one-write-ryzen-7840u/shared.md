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
| queue | 40 | 1.825 | 0.054 | 1.809 | 1.752 | 1.949 |
| baseline | 40 | 2.013 | 0.046 | 2.006 | 1.946 | 2.156 |
| batched | 40 | 1.968 | 0.057 | 1.950 | 1.899 | 2.144 |
| batched-before | 40 | 1.975 | 0.053 | 1.967 | 1.881 | 2.114 |
| dbus-broker | 40 | 1.852 | 0.035 | 1.847 | 1.806 | 1.960 |
| dbus-daemon | 40 | 6.324 | 0.068 | 6.312 | 6.244 | 6.596 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 2.186 | 0.062 | 2.182 | 2.067 | 2.355 |
| baseline | 40 | 2.186 | 0.080 | 2.167 | 2.064 | 2.484 |
| batched | 40 | 2.198 | 0.068 | 2.182 | 2.077 | 2.383 |
| batched-before | 40 | 2.164 | 0.077 | 2.153 | 2.055 | 2.468 |
| dbus-broker | 40 | 2.098 | 0.039 | 2.089 | 2.030 | 2.179 |
| dbus-daemon | 40 | 5.715 | 0.120 | 5.698 | 5.527 | 6.141 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.302 | 0.104 | 3.291 | 3.148 | 3.553 |
| baseline | 40 | 3.339 | 0.123 | 3.311 | 3.231 | 3.841 |
| batched | 40 | 3.280 | 0.129 | 3.255 | 3.144 | 3.652 |
| batched-before | 40 | 3.261 | 0.098 | 3.230 | 3.116 | 3.608 |
| dbus-broker | 40 | 2.615 | 0.060 | 2.597 | 2.560 | 2.840 |
| dbus-daemon | 40 | 12.044 | 0.172 | 12.004 | 11.776 | 12.580 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 11755 | 445 | 11706 | 10420 | 12792 |
| baseline | 40 | 11525 | 438 | 11490 | 10576 | 12632 |
| batched | 40 | 11322 | 529 | 11236 | 10400 | 12384 |
| batched-before | 40 | 11447 | 479 | 11498 | 10584 | 12596 |
| dbus-broker | 40 | 9279 | 307 | 9294 | 8372 | 9888 |
| dbus-daemon | 40 | 8439 | 304 | 8384 | 7920 | 8968 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.931 | 0.078 | 3.922 | 3.811 | 4.163 |
| baseline | 40 | 4.056 | 0.093 | 4.035 | 3.878 | 4.350 |
| batched | 40 | 4.029 | 0.085 | 4.013 | 3.910 | 4.320 |
| batched-before | 40 | 4.004 | 0.102 | 3.974 | 3.899 | 4.359 |
| dbus-broker | 40 | 3.944 | 0.054 | 3.930 | 3.869 | 4.119 |
| dbus-daemon | 40 | 8.093 | 0.141 | 8.056 | 7.929 | 8.509 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 1.896 | 0.084 | 1.870 | 1.780 | 2.170 |
| baseline | 40 | 1.831 | 0.094 | 1.805 | 1.700 | 2.220 |
| batched | 40 | 1.880 | 0.100 | 1.850 | 1.760 | 2.160 |
| batched-before | 40 | 1.845 | 0.086 | 1.810 | 1.750 | 2.150 |
| dbus-broker | 40 | 1.474 | 0.037 | 1.465 | 1.410 | 1.570 |
| dbus-daemon | 40 | 5.686 | 0.120 | 5.665 | 5.500 | 6.120 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 2.132 | 0.057 | 2.125 | 2.030 | 2.290 |
| baseline | 40 | 2.137 | 0.077 | 2.120 | 2.020 | 2.430 |
| batched | 40 | 2.144 | 0.061 | 2.130 | 2.030 | 2.300 |
| batched-before | 40 | 2.116 | 0.072 | 2.110 | 2.010 | 2.390 |
| dbus-broker | 40 | 2.083 | 0.039 | 2.075 | 2.010 | 2.160 |
| dbus-daemon | 40 | 4.361 | 0.088 | 4.340 | 4.250 | 4.710 |
