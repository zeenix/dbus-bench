rounds: 30 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
dbus-bench: 4b30671ba666b1e5a077a114f7019f9ccdfa3f11
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20 (code of 63d08b0)
timeout-rq256: 63d08b0 + max_queued(256) on the peer connections (scratch)

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 30 | 3.115 | 0.217 | 3.111 | 2.584 | 3.645 |
| timeout | 30 | 3.510 | 0.160 | 3.486 | 3.226 | 3.801 |
| timeout-rq256 | 30 | 3.295 | 0.217 | 3.276 | 2.904 | 3.861 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 30 | 4.221 | 0.287 | 4.239 | 3.641 | 4.917 |
| timeout | 30 | 4.162 | 0.320 | 4.121 | 3.776 | 5.155 |
| timeout-rq256 | 30 | 4.181 | 0.379 | 4.119 | 3.670 | 5.333 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 30 | 5.632 | 0.301 | 5.596 | 5.025 | 6.245 |
| timeout | 30 | 5.325 | 0.346 | 5.237 | 4.766 | 6.041 |
| timeout-rq256 | 30 | 5.495 | 0.328 | 5.528 | 4.788 | 6.429 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 30 | 7491 | 287 | 7474 | 7028 | 8224 |
| timeout | 30 | 7030 | 283 | 7056 | 6492 | 7552 |
| timeout-rq256 | 30 | 7947 | 235 | 7898 | 7624 | 8532 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 30 | 6.494 | 0.291 | 6.477 | 6.014 | 7.181 |
| timeout | 30 | 6.962 | 0.298 | 6.862 | 6.602 | 7.641 |
| timeout-rq256 | 30 | 6.731 | 0.380 | 6.728 | 6.093 | 7.927 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 30 | 3.478 | 0.249 | 3.445 | 3.160 | 4.100 |
| timeout | 30 | 3.234 | 0.265 | 3.220 | 2.820 | 3.900 |
| timeout-rq256 | 30 | 3.278 | 0.213 | 3.300 | 2.770 | 3.690 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 30 | 3.658 | 0.195 | 3.645 | 3.230 | 4.100 |
| timeout | 30 | 3.721 | 0.223 | 3.690 | 3.390 | 4.410 |
| timeout-rq256 | 30 | 3.725 | 0.281 | 3.635 | 3.340 | 4.670 |
