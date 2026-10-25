rounds: 40 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
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
| queue | 40 | 3.398 | 0.232 | 3.375 | 3.088 | 3.946 |
| baseline | 40 | 3.706 | 0.236 | 3.707 | 3.105 | 4.150 |
| batched | 40 | 3.646 | 0.319 | 3.596 | 3.095 | 4.701 |
| batched-before | 40 | 3.607 | 0.264 | 3.630 | 3.202 | 4.278 |
| dbus-broker | 40 | 3.723 | 0.182 | 3.730 | 3.392 | 4.278 |
| dbus-daemon | 40 | 4.131 | 0.327 | 4.040 | 3.610 | 5.120 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 4.379 | 0.459 | 4.296 | 3.793 | 5.870 |
| baseline | 40 | 4.390 | 0.365 | 4.349 | 3.742 | 5.370 |
| batched | 40 | 4.275 | 0.410 | 4.199 | 3.566 | 5.468 |
| batched-before | 40 | 4.335 | 0.405 | 4.240 | 3.744 | 5.292 |
| dbus-broker | 40 | 6.998 | 0.364 | 6.909 | 6.262 | 7.884 |
| dbus-daemon | 40 | 5.424 | 0.471 | 5.408 | 4.697 | 7.187 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 5.745 | 0.572 | 5.679 | 4.982 | 7.750 |
| baseline | 40 | 5.558 | 0.418 | 5.521 | 4.737 | 6.453 |
| batched | 40 | 5.488 | 0.519 | 5.367 | 4.610 | 6.651 |
| batched-before | 40 | 5.496 | 0.475 | 5.495 | 4.835 | 6.556 |
| dbus-broker | 40 | 4.246 | 0.186 | 4.240 | 3.907 | 4.677 |
| dbus-daemon | 40 | 9.025 | 0.563 | 8.977 | 8.220 | 10.737 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 7460 | 214 | 7458 | 6884 | 7960 |
| baseline | 40 | 7043 | 233 | 7020 | 6576 | 7668 |
| batched | 40 | 7195 | 213 | 7168 | 6824 | 7648 |
| batched-before | 40 | 7099 | 213 | 7078 | 6748 | 7504 |
| dbus-broker | 40 | 8549 | 177 | 8566 | 8132 | 8840 |
| dbus-daemon | 40 | 7172 | 136 | 7164 | 6916 | 7652 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 7.071 | 0.464 | 6.996 | 6.507 | 8.624 |
| baseline | 40 | 7.461 | 0.428 | 7.367 | 6.417 | 8.577 |
| batched | 40 | 7.282 | 0.560 | 7.129 | 6.476 | 9.100 |
| batched-before | 40 | 7.315 | 0.517 | 7.244 | 6.486 | 8.524 |
| dbus-broker | 40 | 10.593 | 0.433 | 10.569 | 9.832 | 11.844 |
| dbus-daemon | 40 | 7.713 | 0.494 | 7.665 | 7.022 | 9.401 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.371 | 0.445 | 3.305 | 2.770 | 4.960 |
| baseline | 40 | 3.263 | 0.334 | 3.235 | 2.710 | 4.010 |
| batched | 40 | 3.234 | 0.354 | 3.165 | 2.680 | 4.100 |
| batched-before | 40 | 3.258 | 0.352 | 3.235 | 2.740 | 4.200 |
| dbus-broker | 40 | 2.603 | 0.130 | 2.595 | 2.330 | 2.910 |
| dbus-daemon | 40 | 5.175 | 0.385 | 5.140 | 4.520 | 6.410 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.927 | 0.325 | 3.900 | 3.450 | 4.950 |
| baseline | 40 | 4.018 | 0.301 | 3.970 | 3.490 | 4.860 |
| batched | 40 | 3.906 | 0.323 | 3.855 | 3.330 | 4.950 |
| batched-before | 40 | 3.965 | 0.324 | 3.905 | 3.450 | 4.710 |
| dbus-broker | 40 | 6.920 | 0.356 | 6.835 | 6.210 | 7.790 |
| dbus-daemon | 40 | 4.124 | 0.337 | 4.085 | 3.650 | 5.200 |
