rounds: 10 measured after 1 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
zruntime-busypoll: 27d5df4ccdc1c4e574a417ea4f92837223c800f9
taskset: -c 0

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.091 | 0.001 | 0.090 | 0.090 | 0.092 |
| busypoll20 | 10 | 0.126 | 0.003 | 0.127 | 0.119 | 0.130 |
| spin20 | 10 | 0.129 | 0.002 | 0.129 | 0.127 | 0.132 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 1.611 | 0.026 | 1.602 | 1.587 | 1.667 |
| busypoll20 | 10 | 1.633 | 0.031 | 1.637 | 1.554 | 1.665 |
| spin20 | 10 | 1.613 | 0.039 | 1.617 | 1.558 | 1.659 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.571 | 0.008 | 0.571 | 0.558 | 0.583 |
| busypoll20 | 10 | 0.695 | 0.025 | 0.704 | 0.634 | 0.716 |
| spin20 | 10 | 0.688 | 0.035 | 0.689 | 0.642 | 0.727 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 6688 | 105 | 6690 | 6512 | 6836 |
| busypoll20 | 10 | 6705 | 85 | 6694 | 6552 | 6812 |
| spin20 | 10 | 6696 | 55 | 6700 | 6608 | 6784 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 1.108 | 0.018 | 1.101 | 1.094 | 1.147 |
| busypoll20 | 10 | 1.042 | 0.021 | 1.033 | 1.026 | 1.093 |
| spin20 | 10 | 1.033 | 0.008 | 1.031 | 1.021 | 1.044 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.517 | 0.008 | 0.515 | 0.510 | 0.530 |
| busypoll20 | 10 | 0.605 | 0.028 | 0.620 | 0.540 | 0.630 |
| spin20 | 10 | 0.590 | 0.037 | 0.590 | 0.540 | 0.640 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 1.039 | 0.015 | 1.035 | 1.020 | 1.070 |
| busypoll20 | 10 | 0.966 | 0.020 | 0.960 | 0.950 | 1.010 |
| spin20 | 10 | 0.958 | 0.009 | 0.960 | 0.940 | 0.970 |
