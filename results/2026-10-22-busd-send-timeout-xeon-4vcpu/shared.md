rounds: 40 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
dbus-bench: 9dfa2601632a08026f83a90e98315de7aced60dd (+ uncommitted clients)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20
revert: 41407f0

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 3.158 | 0.268 | 3.130 | 2.755 | 3.818 |
| timeout | 40 | 3.561 | 0.247 | 3.532 | 3.201 | 4.274 |
| revert | 40 | 3.495 | 0.231 | 3.522 | 3.034 | 4.009 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 4.356 | 0.314 | 4.360 | 3.739 | 4.962 |
| timeout | 40 | 4.216 | 0.402 | 4.202 | 3.518 | 5.261 |
| revert | 40 | 4.284 | 0.388 | 4.267 | 3.529 | 5.285 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 5.759 | 0.412 | 5.822 | 4.894 | 6.976 |
| timeout | 40 | 5.481 | 0.408 | 5.489 | 4.572 | 6.493 |
| revert | 40 | 5.402 | 0.437 | 5.466 | 4.631 | 6.056 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 7520 | 243 | 7542 | 7028 | 8156 |
| timeout | 40 | 7054 | 224 | 7008 | 6596 | 7544 |
| revert | 40 | 7015 | 276 | 6984 | 6504 | 7744 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 6.587 | 0.351 | 6.540 | 5.936 | 7.564 |
| timeout | 40 | 6.951 | 0.372 | 6.932 | 6.279 | 8.186 |
| revert | 40 | 7.008 | 0.372 | 6.948 | 6.173 | 8.010 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 3.577 | 0.311 | 3.660 | 2.920 | 4.270 |
| timeout | 40 | 3.354 | 0.381 | 3.330 | 2.730 | 4.400 |
| revert | 40 | 3.333 | 0.336 | 3.415 | 2.670 | 3.880 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 40 | 3.723 | 0.220 | 3.695 | 3.370 | 4.190 |
| timeout | 40 | 3.695 | 0.244 | 3.665 | 3.260 | 4.370 |
| revert | 40 | 3.783 | 0.273 | 3.735 | 3.290 | 4.620 |
