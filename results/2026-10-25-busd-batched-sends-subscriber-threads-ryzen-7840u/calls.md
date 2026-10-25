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
| queue | 60 | 0.071 | 0.003 | 0.071 | 0.066 | 0.083 |
| baseline | 60 | 0.070 | 0.003 | 0.069 | 0.065 | 0.079 |
| batched | 60 | 0.071 | 0.003 | 0.071 | 0.066 | 0.081 |
| batched-before | 60 | 0.071 | 0.003 | 0.071 | 0.066 | 0.079 |
| dbus-broker | 60 | 0.061 | 0.003 | 0.060 | 0.058 | 0.074 |
| dbus-daemon | 60 | 0.135 | 0.006 | 0.134 | 0.127 | 0.154 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.447 | 0.018 | 0.442 | 0.423 | 0.508 |
| baseline | 60 | 0.449 | 0.018 | 0.446 | 0.421 | 0.519 |
| batched | 60 | 0.447 | 0.016 | 0.443 | 0.426 | 0.505 |
| batched-before | 60 | 0.448 | 0.017 | 0.443 | 0.423 | 0.503 |
| dbus-broker | 60 | 0.433 | 0.023 | 0.427 | 0.412 | 0.578 |
| dbus-daemon | 60 | 1.154 | 0.036 | 1.143 | 1.118 | 1.326 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.413 | 0.013 | 0.409 | 0.396 | 0.456 |
| baseline | 60 | 0.414 | 0.015 | 0.409 | 0.396 | 0.468 |
| batched | 60 | 0.415 | 0.014 | 0.412 | 0.398 | 0.467 |
| batched-before | 60 | 0.414 | 0.015 | 0.412 | 0.394 | 0.475 |
| dbus-broker | 60 | 0.344 | 0.012 | 0.341 | 0.330 | 0.392 |
| dbus-daemon | 60 | 1.249 | 0.037 | 1.239 | 1.214 | 1.423 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 6694 | 126 | 6702 | 6380 | 6968 |
| baseline | 60 | 6682 | 112 | 6658 | 6460 | 6964 |
| batched | 60 | 6708 | 124 | 6722 | 6352 | 6920 |
| batched-before | 60 | 6710 | 118 | 6706 | 6440 | 6920 |
| dbus-broker | 60 | 8214 | 178 | 8228 | 7876 | 8572 |
| dbus-daemon | 60 | 6230 | 126 | 6228 | 6028 | 6460 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.479 | 0.016 | 0.474 | 0.460 | 0.529 |
| baseline | 60 | 0.477 | 0.018 | 0.471 | 0.455 | 0.534 |
| batched | 60 | 0.478 | 0.018 | 0.474 | 0.457 | 0.550 |
| batched-before | 60 | 0.479 | 0.017 | 0.474 | 0.454 | 0.543 |
| dbus-broker | 60 | 0.476 | 0.024 | 0.469 | 0.454 | 0.623 |
| dbus-daemon | 60 | 0.943 | 0.024 | 0.935 | 0.912 | 1.038 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.349 | 0.016 | 0.350 | 0.320 | 0.390 |
| baseline | 60 | 0.351 | 0.017 | 0.350 | 0.320 | 0.410 |
| batched | 60 | 0.349 | 0.014 | 0.350 | 0.320 | 0.390 |
| batched-before | 60 | 0.350 | 0.015 | 0.350 | 0.320 | 0.400 |
| dbus-broker | 60 | 0.285 | 0.012 | 0.280 | 0.270 | 0.340 |
| dbus-daemon | 60 | 1.126 | 0.037 | 1.120 | 1.080 | 1.300 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.429 | 0.017 | 0.430 | 0.400 | 0.480 |
| baseline | 60 | 0.432 | 0.019 | 0.430 | 0.400 | 0.490 |
| batched | 60 | 0.429 | 0.016 | 0.430 | 0.410 | 0.490 |
| batched-before | 60 | 0.430 | 0.016 | 0.430 | 0.400 | 0.480 |
| dbus-broker | 60 | 0.418 | 0.025 | 0.410 | 0.390 | 0.570 |
| dbus-daemon | 60 | 0.874 | 0.023 | 0.870 | 0.840 | 0.970 |
