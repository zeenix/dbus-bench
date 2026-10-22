rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
dbus-bench: 9dfa2601632a08026f83a90e98315de7aced60dd (+ uncommitted clients)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20
revert: 41407f0

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.519 | 0.064 | 0.502 | 0.418 | 0.700 |
| timeout | 60 | 0.417 | 0.055 | 0.409 | 0.332 | 0.575 |
| revert | 60 | 0.426 | 0.052 | 0.415 | 0.336 | 0.567 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.501 | 0.051 | 0.485 | 0.432 | 0.656 |
| timeout | 60 | 0.495 | 0.055 | 0.487 | 0.428 | 0.709 |
| revert | 60 | 0.510 | 0.077 | 0.496 | 0.418 | 0.764 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.613 | 0.054 | 0.596 | 0.532 | 0.785 |
| timeout | 60 | 0.564 | 0.051 | 0.560 | 0.490 | 0.721 |
| revert | 60 | 0.556 | 0.050 | 0.550 | 0.480 | 0.702 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 51375 | 5199 | 52876 | 32912 | 58168 |
| timeout | 60 | 4827 | 84 | 4838 | 4652 | 4984 |
| revert | 60 | 4809 | 93 | 4796 | 4596 | 5016 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.889 | 0.063 | 0.884 | 0.783 | 1.011 |
| timeout | 60 | 0.862 | 0.068 | 0.852 | 0.760 | 1.090 |
| revert | 60 | 0.883 | 0.076 | 0.875 | 0.765 | 1.102 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.223 | 0.037 | 0.210 | 0.180 | 0.390 |
| timeout | 60 | 0.211 | 0.025 | 0.210 | 0.180 | 0.300 |
| revert | 60 | 0.209 | 0.026 | 0.200 | 0.180 | 0.310 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.486 | 0.047 | 0.475 | 0.420 | 0.610 |
| timeout | 60 | 0.480 | 0.046 | 0.470 | 0.410 | 0.660 |
| revert | 60 | 0.491 | 0.059 | 0.480 | 0.410 | 0.680 |
