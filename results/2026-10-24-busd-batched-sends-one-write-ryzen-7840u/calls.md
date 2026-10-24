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
| queue | 60 | 0.072 | 0.002 | 0.072 | 0.067 | 0.077 |
| baseline | 60 | 0.070 | 0.003 | 0.070 | 0.066 | 0.077 |
| batched | 60 | 0.071 | 0.003 | 0.071 | 0.067 | 0.078 |
| batched-before | 60 | 0.071 | 0.003 | 0.071 | 0.066 | 0.079 |
| dbus-broker | 60 | 0.061 | 0.002 | 0.061 | 0.057 | 0.067 |
| dbus-daemon | 60 | 0.139 | 0.005 | 0.139 | 0.129 | 0.153 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.464 | 0.014 | 0.464 | 0.428 | 0.500 |
| baseline | 60 | 0.467 | 0.014 | 0.467 | 0.442 | 0.521 |
| batched | 60 | 0.465 | 0.016 | 0.464 | 0.429 | 0.503 |
| batched-before | 60 | 0.465 | 0.014 | 0.465 | 0.431 | 0.503 |
| dbus-broker | 60 | 0.444 | 0.013 | 0.440 | 0.422 | 0.474 |
| dbus-daemon | 60 | 1.182 | 0.020 | 1.181 | 1.144 | 1.232 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.426 | 0.011 | 0.427 | 0.400 | 0.451 |
| baseline | 60 | 0.428 | 0.012 | 0.428 | 0.404 | 0.459 |
| batched | 60 | 0.427 | 0.013 | 0.426 | 0.393 | 0.455 |
| batched-before | 60 | 0.428 | 0.012 | 0.428 | 0.400 | 0.455 |
| dbus-broker | 60 | 0.354 | 0.008 | 0.353 | 0.340 | 0.371 |
| dbus-daemon | 60 | 1.278 | 0.020 | 1.276 | 1.239 | 1.333 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 6709 | 124 | 6720 | 6372 | 6948 |
| baseline | 60 | 6696 | 125 | 6696 | 6424 | 6924 |
| batched | 60 | 6694 | 113 | 6682 | 6388 | 6972 |
| batched-before | 60 | 6677 | 136 | 6658 | 6444 | 6976 |
| dbus-broker | 60 | 8264 | 183 | 8262 | 7868 | 8648 |
| dbus-daemon | 60 | 6246 | 144 | 6220 | 6028 | 6560 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.492 | 0.012 | 0.491 | 0.465 | 0.523 |
| baseline | 60 | 0.495 | 0.013 | 0.494 | 0.475 | 0.547 |
| batched | 60 | 0.493 | 0.013 | 0.492 | 0.462 | 0.524 |
| batched-before | 60 | 0.492 | 0.011 | 0.492 | 0.464 | 0.521 |
| dbus-broker | 60 | 0.487 | 0.013 | 0.483 | 0.464 | 0.516 |
| dbus-daemon | 60 | 0.957 | 0.013 | 0.957 | 0.930 | 0.987 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.364 | 0.012 | 0.365 | 0.330 | 0.390 |
| baseline | 60 | 0.366 | 0.014 | 0.370 | 0.330 | 0.390 |
| batched | 60 | 0.365 | 0.015 | 0.360 | 0.330 | 0.400 |
| batched-before | 60 | 0.367 | 0.014 | 0.370 | 0.330 | 0.400 |
| dbus-broker | 60 | 0.296 | 0.008 | 0.300 | 0.280 | 0.310 |
| dbus-daemon | 60 | 1.155 | 0.021 | 1.150 | 1.120 | 1.210 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.443 | 0.014 | 0.440 | 0.410 | 0.490 |
| baseline | 60 | 0.447 | 0.014 | 0.450 | 0.430 | 0.490 |
| batched | 60 | 0.445 | 0.015 | 0.445 | 0.410 | 0.480 |
| batched-before | 60 | 0.444 | 0.012 | 0.440 | 0.420 | 0.470 |
| dbus-broker | 60 | 0.429 | 0.014 | 0.430 | 0.410 | 0.460 |
| dbus-daemon | 60 | 0.888 | 0.014 | 0.890 | 0.860 | 0.920 |
