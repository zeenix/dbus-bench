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
| queue | 60 | 0.387 | 0.008 | 0.385 | 0.376 | 0.415 |
| baseline | 60 | 0.314 | 0.006 | 0.314 | 0.302 | 0.330 |
| batched | 60 | 0.299 | 0.006 | 0.297 | 0.290 | 0.325 |
| dbus-broker | 60 | 0.303 | 0.005 | 0.303 | 0.292 | 0.314 |
| dbus-daemon | 60 | 0.858 | 0.013 | 0.856 | 0.840 | 0.904 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.380 | 0.013 | 0.375 | 0.363 | 0.408 |
| baseline | 60 | 0.377 | 0.013 | 0.373 | 0.362 | 0.421 |
| batched | 60 | 0.358 | 0.009 | 0.356 | 0.345 | 0.397 |
| dbus-broker | 60 | 0.375 | 0.013 | 0.371 | 0.361 | 0.446 |
| dbus-daemon | 60 | 1.207 | 0.013 | 1.202 | 1.189 | 1.251 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.527 | 0.013 | 0.526 | 0.501 | 0.575 |
| baseline | 60 | 0.525 | 0.008 | 0.524 | 0.506 | 0.555 |
| batched | 60 | 0.372 | 0.008 | 0.371 | 0.356 | 0.394 |
| dbus-broker | 60 | 0.366 | 0.016 | 0.362 | 0.338 | 0.405 |
| dbus-daemon | 60 | 2.076 | 0.022 | 2.072 | 2.043 | 2.149 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 55199 | 1270 | 55164 | 52632 | 57908 |
| baseline | 60 | 6605 | 112 | 6610 | 6340 | 6812 |
| batched | 60 | 6623 | 121 | 6628 | 6380 | 6872 |
| dbus-broker | 60 | 41014 | 1478 | 41420 | 35776 | 43384 |
| dbus-daemon | 60 | 5658 | 131 | 5664 | 5404 | 5840 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.700 | 0.016 | 0.695 | 0.677 | 0.744 |
| baseline | 60 | 0.690 | 0.016 | 0.686 | 0.671 | 0.751 |
| batched | 60 | 0.661 | 0.013 | 0.659 | 0.643 | 0.727 |
| dbus-broker | 60 | 0.681 | 0.017 | 0.677 | 0.662 | 0.764 |
| dbus-daemon | 60 | 1.246 | 0.018 | 1.243 | 1.212 | 1.308 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.186 | 0.011 | 0.190 | 0.160 | 0.210 |
| baseline | 60 | 0.205 | 0.008 | 0.210 | 0.190 | 0.220 |
| batched | 60 | 0.104 | 0.006 | 0.100 | 0.090 | 0.130 |
| dbus-broker | 60 | 0.120 | 0.011 | 0.120 | 0.100 | 0.140 |
| dbus-daemon | 60 | 1.180 | 0.014 | 1.180 | 1.160 | 1.220 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.366 | 0.014 | 0.360 | 0.340 | 0.400 |
| baseline | 60 | 0.363 | 0.015 | 0.360 | 0.340 | 0.410 |
| batched | 60 | 0.343 | 0.010 | 0.340 | 0.330 | 0.370 |
| dbus-broker | 60 | 0.360 | 0.012 | 0.360 | 0.340 | 0.420 |
| dbus-daemon | 60 | 0.548 | 0.014 | 0.550 | 0.520 | 0.590 |
