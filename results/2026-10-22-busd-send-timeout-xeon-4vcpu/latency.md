rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
dbus-bench: 9dfa2601632a08026f83a90e98315de7aced60dd (+ uncommitted clients)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20
revert: 41407f0

### single_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 131.4 | 130.2 | 335.4 | 299.0 | 6544.2 | 3918.7 |
| timeout | 60 | 131.0 | 130.3 | 308.9 | 299.4 | 4409.2 | 3675.0 |
| revert | 60 | 130.4 | 129.2 | 315.4 | 303.6 | 7315.9 | 3592.3 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 659.6 | 623.5 | 2032.3 | 1883.3 | 7299.1 | 5713.6 |
| timeout | 60 | 658.7 | 629.0 | 1914.6 | 1855.9 | 7619.6 | 5551.3 |
| revert | 60 | 640.6 | 626.1 | 1701.8 | 1654.9 | 6689.7 | 4959.5 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 59704.1 | 57776.8 | 101684.4 | 96865.0 | 105691.2 | 99718.4 |
| timeout | 60 | 23205.6 | 22822.5 | 35917.9 | 32463.6 | 38404.0 | 34809.3 |
| revert | 60 | 22483.2 | 21539.1 | 32932.2 | 32074.5 | 35360.7 | 34346.9 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.987 | 0.961 | 6305 | 6348 | 1.769 | 1.710 |
| timeout | 60 | 0.980 | 0.967 | 5029 | 5036 | 1.748 | 1.705 |
| revert | 60 | 0.951 | 0.939 | 5000 | 4998 | 1.711 | 1.720 |
