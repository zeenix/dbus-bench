rounds: 10 measured after 1 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
zruntime-busypoll: d91ca1b99da803fbd68a1611f6e6946771d534d4
taskset: -c 0

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.071 | 0.001 | 0.071 | 0.069 | 0.074 |
| busypoll20 | 10 | 0.108 | 0.002 | 0.109 | 0.106 | 0.111 |
| spin20 | 10 | 0.108 | 0.001 | 0.108 | 0.106 | 0.110 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 1.093 | 0.049 | 1.091 | 1.017 | 1.173 |
| busypoll20 | 10 | 1.123 | 0.058 | 1.111 | 1.044 | 1.220 |
| spin20 | 10 | 1.152 | 0.049 | 1.155 | 1.045 | 1.229 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.523 | 0.018 | 0.527 | 0.496 | 0.555 |
| busypoll20 | 10 | 0.607 | 0.027 | 0.603 | 0.569 | 0.654 |
| spin20 | 10 | 0.622 | 0.023 | 0.624 | 0.572 | 0.662 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 6654 | 123 | 6618 | 6504 | 6860 |
| busypoll20 | 10 | 6710 | 96 | 6710 | 6552 | 6892 |
| spin20 | 10 | 6698 | 99 | 6692 | 6576 | 6856 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.620 | 0.034 | 0.622 | 0.570 | 0.672 |
| busypoll20 | 10 | 0.602 | 0.031 | 0.595 | 0.560 | 0.652 |
| spin20 | 10 | 0.616 | 0.027 | 0.616 | 0.558 | 0.654 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.472 | 0.018 | 0.470 | 0.450 | 0.500 |
| busypoll20 | 10 | 0.516 | 0.025 | 0.510 | 0.490 | 0.560 |
| spin20 | 10 | 0.536 | 0.021 | 0.540 | 0.490 | 0.570 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| busypoll-off | 10 | 0.566 | 0.035 | 0.570 | 0.510 | 0.620 |
| busypoll20 | 10 | 0.545 | 0.032 | 0.545 | 0.500 | 0.590 |
| spin20 | 10 | 0.556 | 0.023 | 0.555 | 0.510 | 0.590 |
