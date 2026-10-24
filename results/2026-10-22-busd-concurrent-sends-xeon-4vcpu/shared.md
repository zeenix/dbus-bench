rounds: 40 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20 (the code of e93cec5)
concurrent100: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 2.932 | 0.190 | 2.933 | 2.536 | 3.588 |
| timeout | 40 | 3.296 | 0.171 | 3.255 | 2.978 | 3.902 |
| concurrent100 | 40 | 3.289 | 0.165 | 3.275 | 2.915 | 3.782 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 3.887 | 0.269 | 3.795 | 3.435 | 4.620 |
| timeout | 40 | 3.768 | 0.226 | 3.710 | 3.377 | 4.422 |
| concurrent100 | 40 | 3.754 | 0.183 | 3.728 | 3.425 | 4.253 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 5.239 | 0.243 | 5.195 | 4.769 | 6.097 |
| timeout | 40 | 4.918 | 0.247 | 4.906 | 4.476 | 5.520 |
| concurrent100 | 40 | 4.877 | 0.210 | 4.892 | 4.518 | 5.384 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 7484 | 246 | 7446 | 7084 | 8132 |
| timeout | 40 | 6997 | 236 | 6982 | 6588 | 7644 |
| concurrent100 | 40 | 7054 | 225 | 7024 | 6604 | 7596 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 6.080 | 0.226 | 6.079 | 5.776 | 6.951 |
| timeout | 40 | 6.479 | 0.240 | 6.490 | 5.968 | 7.249 |
| concurrent100 | 40 | 6.474 | 0.181 | 6.444 | 6.159 | 6.838 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 3.227 | 0.199 | 3.210 | 2.890 | 3.680 |
| timeout | 40 | 2.974 | 0.201 | 2.950 | 2.700 | 3.390 |
| concurrent100 | 40 | 2.945 | 0.174 | 2.935 | 2.650 | 3.440 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 3.395 | 0.154 | 3.400 | 3.100 | 3.770 |
| timeout | 40 | 3.422 | 0.147 | 3.415 | 3.160 | 3.860 |
| concurrent100 | 40 | 3.430 | 0.138 | 3.435 | 3.140 | 3.810 |
