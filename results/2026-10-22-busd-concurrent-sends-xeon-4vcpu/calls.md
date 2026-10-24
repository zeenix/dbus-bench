rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20 (the code of e93cec5)
concurrent100: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.151 | 0.017 | 0.147 | 0.131 | 0.247 |
| timeout | 60 | 0.148 | 0.010 | 0.148 | 0.132 | 0.172 |
| concurrent100 | 60 | 0.149 | 0.010 | 0.149 | 0.130 | 0.177 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.664 | 0.055 | 0.658 | 0.558 | 0.800 |
| timeout | 60 | 0.683 | 0.055 | 0.674 | 0.583 | 0.845 |
| concurrent100 | 60 | 0.670 | 0.059 | 0.655 | 0.596 | 0.861 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.559 | 0.033 | 0.553 | 0.500 | 0.631 |
| timeout | 60 | 0.559 | 0.032 | 0.554 | 0.502 | 0.658 |
| concurrent100 | 60 | 0.556 | 0.045 | 0.540 | 0.496 | 0.699 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 4807 | 90 | 4814 | 4596 | 5200 |
| timeout | 60 | 4792 | 93 | 4792 | 4544 | 4972 |
| concurrent100 | 60 | 4784 | 88 | 4786 | 4632 | 4996 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.712 | 0.052 | 0.699 | 0.625 | 0.828 |
| timeout | 60 | 0.730 | 0.054 | 0.721 | 0.647 | 0.922 |
| concurrent100 | 60 | 0.716 | 0.046 | 0.700 | 0.654 | 0.833 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.479 | 0.031 | 0.480 | 0.420 | 0.550 |
| timeout | 60 | 0.479 | 0.032 | 0.470 | 0.430 | 0.580 |
| concurrent100 | 60 | 0.476 | 0.043 | 0.460 | 0.420 | 0.620 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.631 | 0.050 | 0.620 | 0.550 | 0.740 |
| timeout | 60 | 0.648 | 0.053 | 0.640 | 0.570 | 0.840 |
| concurrent100 | 60 | 0.633 | 0.047 | 0.610 | 0.570 | 0.750 |
