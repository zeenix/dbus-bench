rounds: 40 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: 4f346a36a23efe3a88b9539ff1130c55c660be70
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
dbus-broker: dbus-broker 35
dbus-daemon: D-Bus Message Bus Daemon 1.14.10

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.643 | 0.319 | 3.648 | 2.993 | 4.661 |
| baseline | 40 | 3.889 | 0.250 | 3.844 | 3.338 | 4.442 |
| batched | 40 | 3.948 | 0.311 | 3.876 | 3.454 | 4.707 |
| dbus-broker | 40 | 3.878 | 0.197 | 3.884 | 3.406 | 4.259 |
| dbus-daemon | 40 | 4.498 | 0.368 | 4.447 | 3.890 | 5.628 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 4.908 | 0.423 | 4.894 | 4.306 | 6.571 |
| baseline | 40 | 4.780 | 0.469 | 4.742 | 3.789 | 5.726 |
| batched | 40 | 4.671 | 0.498 | 4.622 | 3.499 | 5.924 |
| dbus-broker | 40 | 7.187 | 0.502 | 7.149 | 6.094 | 8.513 |
| dbus-daemon | 40 | 5.782 | 0.502 | 5.755 | 4.844 | 7.248 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 6.347 | 0.558 | 6.306 | 5.479 | 8.492 |
| baseline | 40 | 6.014 | 0.443 | 5.959 | 5.034 | 7.113 |
| batched | 40 | 6.022 | 0.596 | 5.937 | 4.727 | 7.705 |
| dbus-broker | 40 | 4.460 | 0.241 | 4.433 | 4.025 | 5.006 |
| dbus-daemon | 40 | 9.603 | 0.668 | 9.618 | 8.514 | 11.239 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 7481 | 288 | 7448 | 6988 | 8408 |
| baseline | 40 | 7089 | 241 | 7032 | 6592 | 7620 |
| batched | 40 | 7038 | 206 | 7014 | 6644 | 7464 |
| dbus-broker | 40 | 8618 | 198 | 8630 | 8084 | 8992 |
| dbus-daemon | 40 | 7249 | 169 | 7236 | 6868 | 7656 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 7.656 | 0.499 | 7.628 | 6.612 | 9.144 |
| baseline | 40 | 7.900 | 0.565 | 7.715 | 6.891 | 9.347 |
| batched | 40 | 7.825 | 0.596 | 7.766 | 6.609 | 9.324 |
| dbus-broker | 40 | 10.915 | 0.556 | 10.896 | 9.595 | 12.067 |
| dbus-daemon | 40 | 8.342 | 0.553 | 8.271 | 7.441 | 9.583 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 3.824 | 0.443 | 3.750 | 3.260 | 5.660 |
| baseline | 40 | 3.601 | 0.388 | 3.610 | 2.780 | 4.670 |
| batched | 40 | 3.551 | 0.475 | 3.475 | 2.550 | 5.200 |
| dbus-broker | 40 | 2.737 | 0.185 | 2.700 | 2.460 | 3.210 |
| dbus-daemon | 40 | 5.478 | 0.474 | 5.480 | 4.690 | 6.960 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 40 | 4.312 | 0.321 | 4.295 | 3.740 | 5.350 |
| baseline | 40 | 4.291 | 0.400 | 4.215 | 3.520 | 5.280 |
| batched | 40 | 4.194 | 0.369 | 4.165 | 3.370 | 5.040 |
| dbus-broker | 40 | 7.100 | 0.496 | 7.080 | 6.040 | 8.390 |
| dbus-daemon | 40 | 4.447 | 0.351 | 4.395 | 3.750 | 5.440 |
