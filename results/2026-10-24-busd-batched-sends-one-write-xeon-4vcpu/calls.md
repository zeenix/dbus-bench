rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: ac6e6fa16f5b0b63cce856dc618ca2328c51e713
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
batched-before: 4f346a36a23efe3a88b9539ff1130c55c660be70
dbus-broker: dbus-broker 35
dbus-daemon: D-Bus Message Bus Daemon 1.14.10

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.205 | 0.015 | 0.204 | 0.177 | 0.256 |
| baseline | 60 | 0.200 | 0.015 | 0.199 | 0.172 | 0.238 |
| batched | 60 | 0.208 | 0.020 | 0.205 | 0.177 | 0.299 |
| batched-before | 60 | 0.208 | 0.015 | 0.207 | 0.181 | 0.239 |
| dbus-broker | 60 | 0.208 | 0.016 | 0.206 | 0.155 | 0.246 |
| dbus-daemon | 60 | 0.224 | 0.016 | 0.221 | 0.196 | 0.276 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.813 | 0.090 | 0.803 | 0.665 | 1.030 |
| baseline | 60 | 0.800 | 0.105 | 0.787 | 0.653 | 1.146 |
| batched | 60 | 0.808 | 0.077 | 0.800 | 0.664 | 0.992 |
| batched-before | 60 | 0.819 | 0.086 | 0.811 | 0.685 | 1.195 |
| dbus-broker | 60 | 1.248 | 0.100 | 1.245 | 1.012 | 1.602 |
| dbus-daemon | 60 | 0.963 | 0.114 | 0.939 | 0.800 | 1.284 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.712 | 0.093 | 0.705 | 0.574 | 1.023 |
| baseline | 60 | 0.683 | 0.069 | 0.679 | 0.565 | 0.924 |
| batched | 60 | 0.707 | 0.076 | 0.700 | 0.591 | 1.020 |
| batched-before | 60 | 0.701 | 0.062 | 0.697 | 0.600 | 0.843 |
| dbus-broker | 60 | 0.597 | 0.042 | 0.595 | 0.520 | 0.714 |
| dbus-daemon | 60 | 1.035 | 0.110 | 0.993 | 0.882 | 1.363 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 4924 | 87 | 4908 | 4752 | 5084 |
| baseline | 60 | 4880 | 89 | 4884 | 4700 | 5044 |
| batched | 60 | 4930 | 88 | 4926 | 4760 | 5156 |
| batched-before | 60 | 4962 | 108 | 4966 | 4688 | 5180 |
| dbus-broker | 60 | 7310 | 102 | 7314 | 7056 | 7548 |
| dbus-daemon | 60 | 5024 | 39 | 5024 | 4940 | 5112 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.865 | 0.073 | 0.862 | 0.742 | 1.060 |
| baseline | 60 | 0.861 | 0.104 | 0.842 | 0.726 | 1.219 |
| batched | 60 | 0.868 | 0.071 | 0.863 | 0.734 | 1.057 |
| batched-before | 60 | 0.880 | 0.085 | 0.871 | 0.761 | 1.257 |
| dbus-broker | 60 | 1.358 | 0.098 | 1.356 | 1.143 | 1.726 |
| dbus-daemon | 60 | 0.909 | 0.084 | 0.890 | 0.788 | 1.211 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.599 | 0.089 | 0.600 | 0.470 | 0.860 |
| baseline | 60 | 0.575 | 0.065 | 0.570 | 0.450 | 0.800 |
| batched | 60 | 0.592 | 0.070 | 0.585 | 0.480 | 0.870 |
| batched-before | 60 | 0.589 | 0.059 | 0.580 | 0.490 | 0.730 |
| dbus-broker | 60 | 0.495 | 0.038 | 0.490 | 0.430 | 0.590 |
| dbus-daemon | 60 | 0.904 | 0.105 | 0.870 | 0.760 | 1.220 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.758 | 0.070 | 0.750 | 0.640 | 0.930 |
| baseline | 60 | 0.753 | 0.100 | 0.730 | 0.630 | 1.100 |
| batched | 60 | 0.760 | 0.069 | 0.760 | 0.620 | 0.950 |
| batched-before | 60 | 0.769 | 0.083 | 0.760 | 0.650 | 1.140 |
| dbus-broker | 60 | 1.227 | 0.098 | 1.230 | 1.010 | 1.580 |
| dbus-daemon | 60 | 0.799 | 0.082 | 0.780 | 0.680 | 1.080 |
