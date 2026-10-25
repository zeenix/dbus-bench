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
| queue | 40 | 3.232 | 0.253 | 3.197 | 2.857 | 3.856 |
| baseline | 40 | 3.415 | 0.182 | 3.419 | 3.069 | 3.838 |
| batched | 40 | 3.392 | 0.182 | 3.347 | 3.160 | 3.895 |
| batched-before | 40 | 3.427 | 0.175 | 3.427 | 3.000 | 3.781 |
| dbus-broker | 40 | 3.613 | 0.156 | 3.618 | 3.172 | 3.961 |
| dbus-daemon | 40 | 3.867 | 0.235 | 3.839 | 3.406 | 4.524 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.929 | 0.296 | 3.943 | 3.316 | 4.572 |
| baseline | 40 | 3.855 | 0.349 | 3.832 | 3.259 | 4.847 |
| batched | 40 | 3.816 | 0.313 | 3.769 | 3.344 | 4.679 |
| batched-before | 40 | 3.872 | 0.266 | 3.893 | 3.280 | 4.379 |
| dbus-broker | 40 | 6.335 | 0.356 | 6.309 | 5.566 | 7.579 |
| dbus-daemon | 40 | 5.199 | 0.228 | 5.162 | 4.769 | 5.732 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 5.289 | 0.340 | 5.276 | 4.633 | 6.174 |
| baseline | 40 | 5.006 | 0.316 | 5.019 | 4.384 | 5.750 |
| batched | 40 | 4.982 | 0.315 | 4.898 | 4.417 | 5.580 |
| batched-before | 40 | 5.046 | 0.290 | 5.077 | 4.359 | 5.585 |
| dbus-broker | 40 | 3.978 | 0.217 | 3.950 | 3.575 | 4.500 |
| dbus-daemon | 40 | 8.615 | 0.337 | 8.554 | 7.959 | 9.559 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 7558 | 202 | 7528 | 7116 | 7984 |
| baseline | 40 | 7086 | 222 | 7112 | 6660 | 7608 |
| batched | 40 | 7090 | 279 | 7052 | 6660 | 7944 |
| batched-before | 40 | 7145 | 275 | 7160 | 6520 | 7828 |
| dbus-broker | 40 | 8651 | 154 | 8658 | 8308 | 9132 |
| dbus-daemon | 40 | 7283 | 179 | 7240 | 7064 | 7808 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 6.576 | 0.368 | 6.526 | 5.970 | 7.670 |
| baseline | 40 | 6.736 | 0.308 | 6.703 | 6.125 | 7.343 |
| batched | 40 | 6.677 | 0.297 | 6.620 | 6.185 | 7.521 |
| batched-before | 40 | 6.742 | 0.286 | 6.732 | 5.934 | 7.391 |
| dbus-broker | 40 | 9.836 | 0.377 | 9.773 | 9.100 | 10.966 |
| dbus-daemon | 40 | 7.248 | 0.342 | 7.188 | 6.550 | 8.071 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.026 | 0.245 | 3.050 | 2.450 | 3.520 |
| baseline | 40 | 2.873 | 0.292 | 2.860 | 2.330 | 3.660 |
| batched | 40 | 2.876 | 0.245 | 2.815 | 2.500 | 3.460 |
| batched-before | 40 | 2.907 | 0.230 | 2.925 | 2.490 | 3.340 |
| dbus-broker | 40 | 2.393 | 0.168 | 2.365 | 2.020 | 2.850 |
| dbus-daemon | 40 | 4.982 | 0.190 | 4.955 | 4.640 | 5.410 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.569 | 0.237 | 3.545 | 3.060 | 4.150 |
| baseline | 40 | 3.541 | 0.248 | 3.505 | 3.130 | 4.110 |
| batched | 40 | 3.529 | 0.244 | 3.500 | 3.170 | 4.160 |
| batched-before | 40 | 3.567 | 0.193 | 3.600 | 3.130 | 3.910 |
| dbus-broker | 40 | 6.270 | 0.350 | 6.230 | 5.550 | 7.520 |
| dbus-daemon | 40 | 3.850 | 0.232 | 3.810 | 3.410 | 4.570 |
