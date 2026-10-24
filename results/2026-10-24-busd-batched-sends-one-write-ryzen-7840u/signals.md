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
| queue | 60 | 0.396 | 0.009 | 0.395 | 0.377 | 0.426 |
| baseline | 60 | 0.324 | 0.009 | 0.323 | 0.308 | 0.346 |
| batched | 60 | 0.301 | 0.006 | 0.300 | 0.291 | 0.329 |
| batched-before | 60 | 0.304 | 0.006 | 0.303 | 0.294 | 0.326 |
| dbus-broker | 60 | 0.309 | 0.005 | 0.309 | 0.302 | 0.326 |
| dbus-daemon | 60 | 0.882 | 0.016 | 0.877 | 0.852 | 0.950 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.396 | 0.009 | 0.395 | 0.379 | 0.425 |
| baseline | 60 | 0.391 | 0.012 | 0.387 | 0.375 | 0.432 |
| batched | 60 | 0.365 | 0.010 | 0.363 | 0.344 | 0.409 |
| batched-before | 60 | 0.373 | 0.008 | 0.370 | 0.362 | 0.402 |
| dbus-broker | 60 | 0.387 | 0.009 | 0.385 | 0.369 | 0.414 |
| dbus-daemon | 60 | 1.246 | 0.012 | 1.245 | 1.222 | 1.291 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.546 | 0.011 | 0.545 | 0.527 | 0.577 |
| baseline | 60 | 0.532 | 0.009 | 0.531 | 0.517 | 0.555 |
| batched | 60 | 0.363 | 0.008 | 0.362 | 0.345 | 0.384 |
| batched-before | 60 | 0.379 | 0.007 | 0.377 | 0.367 | 0.399 |
| dbus-broker | 60 | 0.390 | 0.009 | 0.392 | 0.367 | 0.407 |
| dbus-daemon | 60 | 2.137 | 0.022 | 2.133 | 2.105 | 2.233 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 55214 | 1283 | 55330 | 51864 | 58088 |
| baseline | 60 | 6578 | 105 | 6588 | 6260 | 6744 |
| batched | 60 | 6598 | 129 | 6614 | 6332 | 6888 |
| batched-before | 60 | 6598 | 116 | 6596 | 6340 | 6860 |
| dbus-broker | 60 | 40029 | 1946 | 40422 | 35812 | 43232 |
| dbus-daemon | 60 | 5602 | 133 | 5570 | 5420 | 5852 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.722 | 0.012 | 0.723 | 0.693 | 0.749 |
| baseline | 60 | 0.711 | 0.015 | 0.708 | 0.691 | 0.758 |
| batched | 60 | 0.669 | 0.013 | 0.667 | 0.639 | 0.723 |
| batched-before | 60 | 0.679 | 0.011 | 0.675 | 0.657 | 0.709 |
| dbus-broker | 60 | 0.700 | 0.012 | 0.699 | 0.677 | 0.738 |
| dbus-daemon | 60 | 1.289 | 0.018 | 1.291 | 1.244 | 1.340 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.198 | 0.009 | 0.200 | 0.180 | 0.220 |
| baseline | 60 | 0.210 | 0.008 | 0.210 | 0.200 | 0.230 |
| batched | 60 | 0.091 | 0.006 | 0.090 | 0.080 | 0.100 |
| batched-before | 60 | 0.107 | 0.007 | 0.110 | 0.090 | 0.120 |
| dbus-broker | 60 | 0.134 | 0.008 | 0.130 | 0.120 | 0.150 |
| dbus-daemon | 60 | 1.220 | 0.014 | 1.220 | 1.180 | 1.260 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.383 | 0.011 | 0.380 | 0.370 | 0.420 |
| baseline | 60 | 0.378 | 0.012 | 0.380 | 0.360 | 0.410 |
| batched | 60 | 0.353 | 0.011 | 0.350 | 0.330 | 0.390 |
| batched-before | 60 | 0.360 | 0.010 | 0.360 | 0.340 | 0.390 |
| dbus-broker | 60 | 0.374 | 0.011 | 0.370 | 0.350 | 0.400 |
| dbus-daemon | 60 | 0.588 | 0.016 | 0.590 | 0.550 | 0.630 |
