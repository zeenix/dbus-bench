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
| queue | 60 | 0.500 | 0.060 | 0.510 | 0.329 | 0.682 |
| baseline | 60 | 0.379 | 0.035 | 0.370 | 0.320 | 0.475 |
| batched | 60 | 0.328 | 0.039 | 0.319 | 0.278 | 0.560 |
| batched-before | 60 | 0.336 | 0.037 | 0.328 | 0.289 | 0.447 |
| dbus-broker | 60 | 0.263 | 0.032 | 0.255 | 0.219 | 0.365 |
| dbus-daemon | 60 | 0.689 | 0.081 | 0.676 | 0.569 | 1.166 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.331 | 0.030 | 0.324 | 0.272 | 0.410 |
| baseline | 60 | 0.959 | 0.187 | 0.967 | 0.437 | 1.450 |
| batched | 60 | 0.283 | 0.032 | 0.281 | 0.232 | 0.375 |
| batched-before | 60 | 0.292 | 0.035 | 0.289 | 0.232 | 0.448 |
| dbus-broker | 60 | 0.320 | 0.042 | 0.318 | 0.257 | 0.455 |
| dbus-daemon | 60 | 1.222 | 0.200 | 1.259 | 0.726 | 1.616 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.714 | 0.048 | 0.706 | 0.642 | 0.914 |
| baseline | 60 | 1.300 | 0.193 | 1.309 | 0.755 | 1.770 |
| batched | 60 | 0.522 | 0.048 | 0.515 | 0.455 | 0.780 |
| batched-before | 60 | 0.543 | 0.051 | 0.535 | 0.459 | 0.690 |
| dbus-broker | 60 | 0.512 | 0.048 | 0.505 | 0.428 | 0.670 |
| dbus-daemon | 60 | 1.890 | 0.201 | 1.919 | 1.457 | 2.231 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 47035 | 14309 | 50660 | 5104 | 60192 |
| baseline | 60 | 4734 | 48 | 4732 | 4628 | 4828 |
| batched | 60 | 4787 | 56 | 4786 | 4668 | 4992 |
| batched-before | 60 | 4798 | 46 | 4810 | 4688 | 4932 |
| dbus-broker | 60 | 21250 | 6857 | 19696 | 11640 | 43036 |
| dbus-daemon | 60 | 4806 | 231 | 4740 | 4524 | 5488 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 1.277 | 0.086 | 1.282 | 1.170 | 1.681 |
| baseline | 60 | 2.384 | 0.241 | 2.402 | 1.690 | 2.882 |
| batched | 60 | 1.233 | 0.106 | 1.222 | 1.071 | 1.601 |
| batched-before | 60 | 1.239 | 0.109 | 1.214 | 1.017 | 1.656 |
| dbus-broker | 60 | 1.363 | 0.117 | 1.349 | 1.155 | 1.787 |
| dbus-daemon | 60 | 2.838 | 0.238 | 2.904 | 2.286 | 3.306 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.308 | 0.029 | 0.300 | 0.260 | 0.390 |
| baseline | 60 | 0.917 | 0.197 | 0.925 | 0.340 | 1.430 |
| batched | 60 | 0.191 | 0.029 | 0.180 | 0.150 | 0.260 |
| batched-before | 60 | 0.206 | 0.033 | 0.200 | 0.150 | 0.320 |
| dbus-broker | 60 | 0.264 | 0.041 | 0.260 | 0.200 | 0.390 |
| dbus-daemon | 60 | 1.198 | 0.203 | 1.235 | 0.700 | 1.600 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.821 | 0.061 | 0.805 | 0.720 | 1.020 |
| baseline | 60 | 1.910 | 0.245 | 1.905 | 1.220 | 2.370 |
| batched | 60 | 0.783 | 0.077 | 0.770 | 0.670 | 1.000 |
| batched-before | 60 | 0.798 | 0.082 | 0.780 | 0.650 | 1.160 |
| dbus-broker | 60 | 0.912 | 0.093 | 0.900 | 0.740 | 1.180 |
| dbus-daemon | 60 | 2.214 | 0.231 | 2.270 | 1.620 | 2.640 |
