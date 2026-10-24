rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: 4f346a36a23efe3a88b9539ff1130c55c660be70
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
dbus-broker: dbus-broker 35
dbus-daemon: D-Bus Message Bus Daemon 1.14.10

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.199 | 0.011 | 0.199 | 0.177 | 0.233 |
| baseline | 60 | 0.199 | 0.014 | 0.197 | 0.173 | 0.233 |
| batched | 60 | 0.201 | 0.014 | 0.202 | 0.175 | 0.242 |
| dbus-broker | 60 | 0.204 | 0.015 | 0.200 | 0.176 | 0.256 |
| dbus-daemon | 60 | 0.219 | 0.014 | 0.217 | 0.195 | 0.261 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.782 | 0.057 | 0.780 | 0.686 | 0.959 |
| baseline | 60 | 0.790 | 0.056 | 0.790 | 0.659 | 0.922 |
| batched | 60 | 0.779 | 0.069 | 0.781 | 0.663 | 1.025 |
| dbus-broker | 60 | 1.288 | 0.091 | 1.294 | 1.134 | 1.596 |
| dbus-daemon | 60 | 0.903 | 0.078 | 0.905 | 0.737 | 1.079 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.667 | 0.042 | 0.668 | 0.591 | 0.756 |
| baseline | 60 | 0.663 | 0.045 | 0.661 | 0.560 | 0.789 |
| batched | 60 | 0.670 | 0.060 | 0.662 | 0.565 | 0.805 |
| dbus-broker | 60 | 0.601 | 0.035 | 0.600 | 0.524 | 0.688 |
| dbus-daemon | 60 | 0.982 | 0.073 | 0.980 | 0.856 | 1.157 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 4961 | 93 | 4954 | 4776 | 5168 |
| baseline | 60 | 4916 | 88 | 4914 | 4736 | 5128 |
| batched | 60 | 4971 | 99 | 4976 | 4752 | 5240 |
| dbus-broker | 60 | 7378 | 104 | 7382 | 7104 | 7600 |
| dbus-daemon | 60 | 5041 | 38 | 5038 | 4960 | 5160 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.850 | 0.056 | 0.840 | 0.754 | 1.018 |
| baseline | 60 | 0.856 | 0.053 | 0.857 | 0.730 | 0.992 |
| batched | 60 | 0.846 | 0.061 | 0.846 | 0.741 | 1.091 |
| dbus-broker | 60 | 1.398 | 0.094 | 1.398 | 1.230 | 1.730 |
| dbus-daemon | 60 | 0.869 | 0.056 | 0.873 | 0.752 | 0.998 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.559 | 0.041 | 0.555 | 0.480 | 0.640 |
| baseline | 60 | 0.555 | 0.045 | 0.550 | 0.460 | 0.670 |
| batched | 60 | 0.560 | 0.058 | 0.560 | 0.460 | 0.680 |
| dbus-broker | 60 | 0.501 | 0.034 | 0.500 | 0.440 | 0.580 |
| dbus-daemon | 60 | 0.855 | 0.071 | 0.855 | 0.730 | 1.040 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.743 | 0.054 | 0.735 | 0.650 | 0.920 |
| baseline | 60 | 0.750 | 0.054 | 0.760 | 0.630 | 0.890 |
| batched | 60 | 0.739 | 0.062 | 0.730 | 0.640 | 0.990 |
| dbus-broker | 60 | 1.265 | 0.091 | 1.270 | 1.100 | 1.580 |
| dbus-daemon | 60 | 0.762 | 0.053 | 0.770 | 0.650 | 0.900 |
