rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20 (the code of e93cec5)
concurrent100: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.501 | 0.081 | 0.481 | 0.420 | 0.860 |
| timeout | 60 | 0.393 | 0.040 | 0.380 | 0.341 | 0.550 |
| concurrent100 | 60 | 0.385 | 0.037 | 0.379 | 0.335 | 0.496 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.473 | 0.035 | 0.467 | 0.421 | 0.557 |
| timeout | 60 | 0.466 | 0.034 | 0.464 | 0.391 | 0.550 |
| concurrent100 | 60 | 0.470 | 0.043 | 0.459 | 0.410 | 0.636 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.599 | 0.076 | 0.571 | 0.520 | 0.923 |
| timeout | 60 | 0.535 | 0.041 | 0.526 | 0.480 | 0.727 |
| concurrent100 | 60 | 0.532 | 0.036 | 0.530 | 0.477 | 0.653 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 52759 | 4039 | 53966 | 42176 | 58676 |
| timeout | 60 | 4735 | 93 | 4722 | 4544 | 4968 |
| concurrent100 | 60 | 4761 | 90 | 4744 | 4556 | 4984 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.848 | 0.046 | 0.836 | 0.763 | 0.966 |
| timeout | 60 | 0.821 | 0.049 | 0.817 | 0.741 | 0.957 |
| concurrent100 | 60 | 0.816 | 0.052 | 0.807 | 0.740 | 0.996 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.210 | 0.023 | 0.210 | 0.180 | 0.310 |
| timeout | 60 | 0.204 | 0.020 | 0.200 | 0.170 | 0.300 |
| concurrent100 | 60 | 0.202 | 0.018 | 0.200 | 0.180 | 0.280 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.463 | 0.033 | 0.460 | 0.420 | 0.540 |
| timeout | 60 | 0.455 | 0.030 | 0.450 | 0.390 | 0.530 |
| concurrent100 | 60 | 0.454 | 0.039 | 0.450 | 0.400 | 0.630 |
