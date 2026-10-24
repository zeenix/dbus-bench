rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
dbus-bench: 9dfa2601632a08026f83a90e98315de7aced60dd (+ uncommitted clients)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20
revert: 41407f0

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.164 | 0.020 | 0.156 | 0.137 | 0.221 |
| timeout | 60 | 0.161 | 0.016 | 0.159 | 0.134 | 0.228 |
| revert | 60 | 0.158 | 0.016 | 0.154 | 0.136 | 0.209 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.721 | 0.078 | 0.704 | 0.612 | 1.075 |
| timeout | 60 | 0.721 | 0.081 | 0.707 | 0.596 | 0.933 |
| revert | 60 | 0.731 | 0.086 | 0.707 | 0.601 | 1.002 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.599 | 0.071 | 0.576 | 0.528 | 0.941 |
| timeout | 60 | 0.588 | 0.063 | 0.570 | 0.512 | 0.823 |
| revert | 60 | 0.580 | 0.069 | 0.569 | 0.503 | 0.897 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 4904 | 81 | 4904 | 4716 | 5104 |
| timeout | 60 | 4880 | 94 | 4876 | 4696 | 5100 |
| revert | 60 | 4836 | 86 | 4836 | 4668 | 5220 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.753 | 0.055 | 0.747 | 0.665 | 0.941 |
| timeout | 60 | 0.755 | 0.069 | 0.741 | 0.652 | 1.021 |
| revert | 60 | 0.765 | 0.076 | 0.745 | 0.651 | 1.001 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.513 | 0.066 | 0.490 | 0.450 | 0.840 |
| timeout | 60 | 0.504 | 0.058 | 0.490 | 0.430 | 0.700 |
| revert | 60 | 0.498 | 0.067 | 0.490 | 0.420 | 0.800 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.667 | 0.054 | 0.660 | 0.580 | 0.850 |
| timeout | 60 | 0.669 | 0.066 | 0.655 | 0.570 | 0.920 |
| revert | 60 | 0.679 | 0.074 | 0.660 | 0.570 | 0.910 |
