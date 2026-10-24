rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: 4f346a36a23efe3a88b9539ff1130c55c660be70
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
dbus-broker: dbus-broker 35
dbus-daemon: D-Bus Message Bus Daemon 1.14.10

### single_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 183.2 | 181.1 | 346.4 | 334.5 | 3819.9 | 2498.9 |
| baseline | 60 | 179.1 | 177.9 | 332.4 | 331.3 | 2763.8 | 2343.7 |
| batched | 60 | 180.5 | 179.6 | 334.7 | 326.8 | 3036.3 | 2653.0 |
| dbus-broker | 60 | 180.6 | 180.8 | 338.5 | 340.7 | 3520.8 | 2381.2 |
| dbus-daemon | 60 | 188.4 | 191.0 | 347.4 | 343.8 | 3301.9 | 2680.4 |

### multi_rtt (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 746.4 | 730.5 | 1582.1 | 1549.0 | 4582.0 | 3859.1 |
| baseline | 60 | 743.0 | 729.9 | 1593.1 | 1557.7 | 4092.9 | 3472.8 |
| batched | 60 | 736.9 | 728.9 | 1590.7 | 1576.3 | 4318.4 | 3339.5 |
| dbus-broker | 60 | 1217.1 | 1215.2 | 2697.1 | 2670.1 | 5956.1 | 5330.6 |
| dbus-daemon | 60 | 850.6 | 836.5 | 2098.6 | 2115.8 | 5763.5 | 4321.4 |

### fanout_delivery (microseconds, over the measured rounds)

| broker | n | p50 mean | p50 median | p99 mean | p99 median | max mean | max median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 72582.7 | 65902.3 | 122476.3 | 113716.1 | 127414.5 | 119610.2 |
| baseline | 60 | 27482.5 | 25965.5 | 41635.0 | 39047.7 | 44706.3 | 40483.2 |
| batched | 60 | 27626.7 | 26789.4 | 39961.1 | 36979.7 | 43540.9 | 40966.0 |
| dbus-broker | 60 | 74208.9 | 71659.7 | 133571.0 | 127239.5 | 140389.7 | 134281.5 |
| dbus-daemon | 60 | 60838.2 | 57982.2 | 192619.1 | 193834.7 | 198432.1 | 200583.2 |

### broker and client (over the measured rounds)

| broker | n | broker_cpu_s mean | broker_cpu_s median | broker_maxrss_kib mean | broker_maxrss_kib median | client_wall_s mean | client_wall_s median |
|---|---:|---:|---:|---:|---:|---:|---:|
| queue | 60 | 1.224 | 1.212 | 6317 | 6376 | 2.132 | 2.109 |
| baseline | 60 | 1.195 | 1.181 | 5083 | 5084 | 2.094 | 2.071 |
| batched | 60 | 1.160 | 1.139 | 5161 | 5164 | 2.048 | 2.022 |
| dbus-broker | 60 | 1.029 | 1.029 | 11217 | 11206 | 2.650 | 2.626 |
| dbus-daemon | 60 | 1.643 | 1.628 | 6156 | 6178 | 2.364 | 2.349 |
