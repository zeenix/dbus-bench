rounds: 60 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
zruntime-before: 20771cf16b21bc7aa84b3f3ec471b94cf23d7973
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.381 | 0.007 | 0.379 | 0.371 | 0.402 |
| timeout | 60 | 0.313 | 0.007 | 0.312 | 0.302 | 0.334 |
| timeout-before | 60 | 0.330 | 0.004 | 0.330 | 0.322 | 0.342 |
| dbus-broker | 60 | 0.303 | 0.004 | 0.302 | 0.295 | 0.312 |
| dbus-daemon | 60 | 0.860 | 0.012 | 0.858 | 0.837 | 0.896 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.383 | 0.015 | 0.377 | 0.364 | 0.427 |
| timeout | 60 | 0.379 | 0.012 | 0.374 | 0.364 | 0.428 |
| timeout-before | 60 | 0.371 | 0.009 | 0.369 | 0.362 | 0.419 |
| dbus-broker | 60 | 0.374 | 0.011 | 0.370 | 0.363 | 0.413 |
| dbus-daemon | 60 | 1.206 | 0.012 | 1.202 | 1.189 | 1.247 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.523 | 0.013 | 0.521 | 0.498 | 0.555 |
| timeout | 60 | 0.522 | 0.009 | 0.519 | 0.505 | 0.559 |
| timeout-before | 60 | 0.664 | 0.008 | 0.663 | 0.650 | 0.698 |
| dbus-broker | 60 | 0.361 | 0.012 | 0.357 | 0.338 | 0.398 |
| dbus-daemon | 60 | 2.077 | 0.021 | 2.072 | 2.037 | 2.138 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 54207 | 1232 | 54236 | 51808 | 58056 |
| timeout | 60 | 6562 | 109 | 6574 | 6324 | 6800 |
| timeout-before | 60 | 6542 | 111 | 6536 | 6120 | 6812 |
| dbus-broker | 60 | 41049 | 1127 | 41440 | 38272 | 43112 |
| dbus-daemon | 60 | 5578 | 118 | 5562 | 5392 | 5832 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.700 | 0.019 | 0.692 | 0.677 | 0.756 |
| timeout | 60 | 0.691 | 0.016 | 0.684 | 0.673 | 0.757 |
| timeout-before | 60 | 0.690 | 0.012 | 0.686 | 0.679 | 0.749 |
| dbus-broker | 60 | 0.680 | 0.014 | 0.677 | 0.663 | 0.727 |
| dbus-daemon | 60 | 1.243 | 0.020 | 1.240 | 1.216 | 1.305 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.186 | 0.012 | 0.190 | 0.160 | 0.210 |
| timeout | 60 | 0.202 | 0.009 | 0.200 | 0.180 | 0.220 |
| timeout-before | 60 | 0.281 | 0.009 | 0.280 | 0.260 | 0.310 |
| dbus-broker | 60 | 0.115 | 0.010 | 0.120 | 0.090 | 0.140 |
| dbus-daemon | 60 | 1.179 | 0.012 | 1.180 | 1.160 | 1.220 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.367 | 0.016 | 0.360 | 0.350 | 0.410 |
| timeout | 60 | 0.362 | 0.014 | 0.360 | 0.340 | 0.410 |
| timeout-before | 60 | 0.357 | 0.012 | 0.360 | 0.340 | 0.410 |
| dbus-broker | 60 | 0.359 | 0.012 | 0.360 | 0.340 | 0.390 |
| dbus-daemon | 60 | 0.546 | 0.017 | 0.540 | 0.530 | 0.600 |
