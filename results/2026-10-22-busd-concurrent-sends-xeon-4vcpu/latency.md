rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.10GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 8d57e20 (the code of e93cec5)
concurrent100: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c

### single_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 127.8 | 127.2 | 260.8 | 254.3 | 4199.3 | 2584.0 |
| timeout | 60 | 126.9 | 126.2 | 272.7 | 255.9 | 8062.3 | 2547.4 |
| concurrent100 | 60 | 125.9 | 125.3 | 270.7 | 267.4 | 6872.2 | 2480.6 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 608.4 | 592.5 | 1418.4 | 1343.1 | 4806.1 | 3763.9 |
| timeout | 60 | 608.8 | 594.2 | 1445.7 | 1363.4 | 7579.8 | 4481.4 |
| concurrent100 | 60 | 602.4 | 592.8 | 1405.4 | 1368.7 | 5526.8 | 4312.5 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 56451.7 | 53231.7 | 94109.2 | 89099.5 | 97487.8 | 93498.4 |
| timeout | 60 | 21801.1 | 20757.6 | 31702.9 | 28560.8 | 34159.9 | 30372.0 |
| concurrent100 | 60 | 21068.2 | 20161.7 | 30241.6 | 28682.9 | 32301.4 | 30420.4 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.933 | 0.927 | 6237 | 6282 | 1.618 | 1.606 |
| timeout | 60 | 0.919 | 0.902 | 4946 | 4946 | 1.623 | 1.603 |
| concurrent100 | 60 | 0.911 | 0.905 | 4972 | 4964 | 1.597 | 1.582 |
