rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
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
| queue | 60 | 0.603 | 0.065 | 0.582 | 0.509 | 0.792 |
| baseline | 60 | 0.480 | 0.058 | 0.473 | 0.390 | 0.659 |
| batched | 60 | 0.438 | 0.058 | 0.434 | 0.353 | 0.624 |
| batched-before | 60 | 0.446 | 0.049 | 0.439 | 0.364 | 0.587 |
| dbus-broker | 60 | 0.487 | 0.049 | 0.487 | 0.410 | 0.637 |
| dbus-daemon | 60 | 0.549 | 0.096 | 0.534 | 0.435 | 0.985 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.571 | 0.059 | 0.560 | 0.487 | 0.853 |
| baseline | 60 | 0.569 | 0.061 | 0.562 | 0.484 | 0.830 |
| batched | 60 | 0.504 | 0.055 | 0.488 | 0.427 | 0.738 |
| batched-before | 60 | 0.498 | 0.055 | 0.484 | 0.422 | 0.691 |
| dbus-broker | 60 | 0.667 | 0.058 | 0.661 | 0.566 | 0.883 |
| dbus-daemon | 60 | 0.756 | 0.066 | 0.754 | 0.637 | 0.913 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.716 | 0.066 | 0.707 | 0.594 | 0.887 |
| baseline | 60 | 0.658 | 0.061 | 0.654 | 0.537 | 0.815 |
| batched | 60 | 0.499 | 0.058 | 0.486 | 0.399 | 0.705 |
| batched-before | 60 | 0.511 | 0.055 | 0.499 | 0.417 | 0.724 |
| dbus-broker | 60 | 0.524 | 0.045 | 0.524 | 0.419 | 0.612 |
| dbus-daemon | 60 | 0.942 | 0.106 | 0.936 | 0.795 | 1.353 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 52435 | 4056 | 52264 | 40612 | 59652 |
| baseline | 60 | 4864 | 83 | 4872 | 4684 | 5080 |
| batched | 60 | 4910 | 90 | 4908 | 4740 | 5128 |
| batched-before | 60 | 4940 | 94 | 4932 | 4764 | 5140 |
| dbus-broker | 60 | 41750 | 650 | 41774 | 39108 | 42988 |
| dbus-daemon | 60 | 7787 | 631 | 7656 | 6876 | 10472 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 1.039 | 0.101 | 1.020 | 0.906 | 1.480 |
| baseline | 60 | 1.016 | 0.093 | 0.987 | 0.875 | 1.374 |
| batched | 60 | 0.919 | 0.094 | 0.898 | 0.810 | 1.370 |
| batched-before | 60 | 0.919 | 0.079 | 0.902 | 0.810 | 1.221 |
| dbus-broker | 60 | 1.145 | 0.076 | 1.134 | 1.003 | 1.376 |
| dbus-daemon | 60 | 1.228 | 0.104 | 1.218 | 1.062 | 1.552 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.254 | 0.030 | 0.250 | 0.200 | 0.320 |
| baseline | 60 | 0.248 | 0.028 | 0.240 | 0.200 | 0.330 |
| batched | 60 | 0.140 | 0.039 | 0.130 | 0.110 | 0.340 |
| batched-before | 60 | 0.147 | 0.033 | 0.140 | 0.110 | 0.330 |
| dbus-broker | 60 | 0.206 | 0.029 | 0.200 | 0.150 | 0.280 |
| dbus-daemon | 60 | 0.396 | 0.033 | 0.400 | 0.330 | 0.470 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.565 | 0.061 | 0.550 | 0.480 | 0.850 |
| baseline | 60 | 0.565 | 0.060 | 0.555 | 0.490 | 0.840 |
| batched | 60 | 0.495 | 0.052 | 0.480 | 0.430 | 0.730 |
| batched-before | 60 | 0.493 | 0.055 | 0.480 | 0.420 | 0.690 |
| dbus-broker | 60 | 0.661 | 0.058 | 0.655 | 0.570 | 0.880 |
| dbus-daemon | 60 | 0.746 | 0.066 | 0.750 | 0.630 | 0.910 |
