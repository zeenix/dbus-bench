rounds: 60 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
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
| queue | 60 | 0.072 | 0.002 | 0.071 | 0.066 | 0.079 |
| baseline | 60 | 0.071 | 0.003 | 0.070 | 0.065 | 0.079 |
| batched | 60 | 0.072 | 0.003 | 0.072 | 0.068 | 0.081 |
| dbus-broker | 60 | 0.061 | 0.002 | 0.060 | 0.058 | 0.069 |
| dbus-daemon | 60 | 0.138 | 0.006 | 0.138 | 0.129 | 0.153 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.453 | 0.013 | 0.452 | 0.422 | 0.480 |
| baseline | 60 | 0.451 | 0.012 | 0.449 | 0.425 | 0.483 |
| batched | 60 | 0.453 | 0.012 | 0.452 | 0.433 | 0.478 |
| dbus-broker | 60 | 0.435 | 0.013 | 0.431 | 0.415 | 0.477 |
| dbus-daemon | 60 | 1.155 | 0.020 | 1.154 | 1.118 | 1.241 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.417 | 0.011 | 0.416 | 0.393 | 0.441 |
| baseline | 60 | 0.414 | 0.011 | 0.413 | 0.394 | 0.441 |
| batched | 60 | 0.421 | 0.010 | 0.420 | 0.405 | 0.449 |
| dbus-broker | 60 | 0.345 | 0.009 | 0.344 | 0.331 | 0.376 |
| dbus-daemon | 60 | 1.252 | 0.022 | 1.249 | 1.212 | 1.345 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 6723 | 150 | 6736 | 6272 | 6988 |
| baseline | 60 | 6695 | 111 | 6698 | 6364 | 6968 |
| batched | 60 | 6694 | 131 | 6710 | 6392 | 6928 |
| dbus-broker | 60 | 8244 | 166 | 8264 | 7820 | 8588 |
| dbus-daemon | 60 | 6254 | 111 | 6252 | 6064 | 6496 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.483 | 0.013 | 0.481 | 0.457 | 0.514 |
| baseline | 60 | 0.480 | 0.012 | 0.478 | 0.461 | 0.512 |
| batched | 60 | 0.483 | 0.012 | 0.480 | 0.463 | 0.512 |
| dbus-broker | 60 | 0.478 | 0.013 | 0.474 | 0.458 | 0.520 |
| dbus-daemon | 60 | 0.946 | 0.016 | 0.943 | 0.920 | 1.015 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.353 | 0.012 | 0.350 | 0.320 | 0.380 |
| baseline | 60 | 0.348 | 0.012 | 0.350 | 0.320 | 0.370 |
| batched | 60 | 0.356 | 0.012 | 0.350 | 0.330 | 0.380 |
| dbus-broker | 60 | 0.284 | 0.010 | 0.280 | 0.270 | 0.320 |
| dbus-daemon | 60 | 1.126 | 0.021 | 1.120 | 1.090 | 1.220 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.432 | 0.012 | 0.430 | 0.410 | 0.460 |
| baseline | 60 | 0.431 | 0.012 | 0.430 | 0.400 | 0.460 |
| batched | 60 | 0.435 | 0.013 | 0.430 | 0.410 | 0.470 |
| dbus-broker | 60 | 0.418 | 0.015 | 0.420 | 0.400 | 0.460 |
| dbus-daemon | 60 | 0.876 | 0.015 | 0.870 | 0.850 | 0.930 |
