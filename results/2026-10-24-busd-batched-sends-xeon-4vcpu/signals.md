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
| queue | 60 | 0.568 | 0.045 | 0.560 | 0.489 | 0.701 |
| baseline | 60 | 0.453 | 0.048 | 0.446 | 0.372 | 0.574 |
| batched | 60 | 0.421 | 0.035 | 0.418 | 0.356 | 0.516 |
| dbus-broker | 60 | 0.488 | 0.054 | 0.481 | 0.409 | 0.680 |
| dbus-daemon | 60 | 0.521 | 0.054 | 0.510 | 0.440 | 0.688 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.557 | 0.033 | 0.552 | 0.490 | 0.627 |
| baseline | 60 | 0.549 | 0.044 | 0.541 | 0.477 | 0.663 |
| batched | 60 | 0.486 | 0.034 | 0.486 | 0.434 | 0.551 |
| dbus-broker | 60 | 0.656 | 0.046 | 0.650 | 0.579 | 0.825 |
| dbus-daemon | 60 | 0.738 | 0.044 | 0.733 | 0.654 | 0.879 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.670 | 0.040 | 0.665 | 0.603 | 0.795 |
| baseline | 60 | 0.621 | 0.049 | 0.613 | 0.529 | 0.762 |
| batched | 60 | 0.473 | 0.034 | 0.471 | 0.412 | 0.582 |
| dbus-broker | 60 | 0.511 | 0.038 | 0.506 | 0.421 | 0.584 |
| dbus-daemon | 60 | 0.892 | 0.061 | 0.887 | 0.805 | 1.076 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 54464 | 3355 | 54840 | 46052 | 59668 |
| baseline | 60 | 4868 | 90 | 4850 | 4672 | 5080 |
| batched | 60 | 4976 | 92 | 4980 | 4776 | 5164 |
| dbus-broker | 60 | 41362 | 1896 | 41910 | 31140 | 43156 |
| dbus-daemon | 60 | 7903 | 947 | 7684 | 7052 | 13068 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 1.001 | 0.055 | 0.995 | 0.890 | 1.121 |
| baseline | 60 | 0.970 | 0.067 | 0.957 | 0.853 | 1.107 |
| batched | 60 | 0.889 | 0.047 | 0.891 | 0.806 | 1.025 |
| dbus-broker | 60 | 1.137 | 0.073 | 1.130 | 1.020 | 1.461 |
| dbus-daemon | 60 | 1.191 | 0.058 | 1.182 | 1.062 | 1.319 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.238 | 0.021 | 0.240 | 0.200 | 0.310 |
| baseline | 60 | 0.232 | 0.021 | 0.230 | 0.190 | 0.270 |
| batched | 60 | 0.132 | 0.014 | 0.130 | 0.110 | 0.160 |
| dbus-broker | 60 | 0.195 | 0.025 | 0.190 | 0.150 | 0.260 |
| dbus-daemon | 60 | 0.379 | 0.030 | 0.375 | 0.320 | 0.500 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.551 | 0.032 | 0.540 | 0.490 | 0.620 |
| baseline | 60 | 0.545 | 0.042 | 0.540 | 0.470 | 0.650 |
| batched | 60 | 0.481 | 0.031 | 0.480 | 0.430 | 0.550 |
| dbus-broker | 60 | 0.651 | 0.045 | 0.640 | 0.580 | 0.820 |
| dbus-daemon | 60 | 0.732 | 0.043 | 0.725 | 0.640 | 0.850 |
