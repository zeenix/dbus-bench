rounds: 60 measured after 3 warmup; 16 CPUs, AMD Ryzen 7 7840U w/ Radeon  780M Graphics
rustc: rustc 1.99.0 (b940084d7 2026-09-28)
baseline: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
timeout: 7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
zruntime-before: 20771cf16b21bc7aa84b3f3ec471b94cf23d7973
dbus-broker: dbus-broker 37
dbus-daemon: D-Bus Message Bus Daemon 1.16.2

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.071 | 0.003 | 0.071 | 0.067 | 0.078 |
| timeout | 60 | 0.070 | 0.002 | 0.070 | 0.066 | 0.076 |
| timeout-before | 60 | 0.075 | 0.003 | 0.075 | 0.070 | 0.084 |
| dbus-broker | 60 | 0.061 | 0.002 | 0.061 | 0.058 | 0.065 |
| dbus-daemon | 60 | 0.136 | 0.005 | 0.135 | 0.126 | 0.151 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.452 | 0.011 | 0.450 | 0.433 | 0.478 |
| timeout | 60 | 0.452 | 0.013 | 0.451 | 0.433 | 0.510 |
| timeout-before | 60 | 0.455 | 0.012 | 0.452 | 0.437 | 0.477 |
| dbus-broker | 60 | 0.439 | 0.013 | 0.436 | 0.417 | 0.470 |
| dbus-daemon | 60 | 1.159 | 0.019 | 1.153 | 1.133 | 1.210 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.416 | 0.009 | 0.415 | 0.400 | 0.438 |
| timeout | 60 | 0.418 | 0.010 | 0.418 | 0.400 | 0.448 |
| timeout-before | 60 | 0.469 | 0.009 | 0.466 | 0.454 | 0.491 |
| dbus-broker | 60 | 0.348 | 0.010 | 0.346 | 0.331 | 0.382 |
| dbus-daemon | 60 | 1.255 | 0.020 | 1.248 | 1.227 | 1.317 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 6669 | 114 | 6688 | 6360 | 6880 |
| timeout | 60 | 6664 | 103 | 6676 | 6448 | 7008 |
| timeout-before | 60 | 6660 | 115 | 6658 | 6356 | 6916 |
| dbus-broker | 60 | 8228 | 157 | 8230 | 7896 | 8540 |
| dbus-daemon | 60 | 6201 | 129 | 6176 | 6016 | 6560 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.484 | 0.011 | 0.480 | 0.464 | 0.510 |
| timeout | 60 | 0.483 | 0.014 | 0.480 | 0.464 | 0.549 |
| timeout-before | 60 | 0.489 | 0.011 | 0.487 | 0.469 | 0.512 |
| dbus-broker | 60 | 0.482 | 0.013 | 0.479 | 0.460 | 0.511 |
| dbus-daemon | 60 | 0.948 | 0.015 | 0.945 | 0.922 | 0.999 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.351 | 0.011 | 0.350 | 0.330 | 0.380 |
| timeout | 60 | 0.353 | 0.011 | 0.350 | 0.330 | 0.380 |
| timeout-before | 60 | 0.398 | 0.010 | 0.400 | 0.380 | 0.420 |
| dbus-broker | 60 | 0.287 | 0.010 | 0.290 | 0.270 | 0.320 |
| dbus-daemon | 60 | 1.131 | 0.019 | 1.130 | 1.100 | 1.180 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| baseline | 60 | 0.435 | 0.012 | 0.430 | 0.410 | 0.470 |
| timeout | 60 | 0.434 | 0.013 | 0.430 | 0.420 | 0.490 |
| timeout-before | 60 | 0.436 | 0.011 | 0.440 | 0.420 | 0.460 |
| dbus-broker | 60 | 0.423 | 0.014 | 0.420 | 0.400 | 0.460 |
| dbus-daemon | 60 | 0.879 | 0.014 | 0.880 | 0.850 | 0.910 |
