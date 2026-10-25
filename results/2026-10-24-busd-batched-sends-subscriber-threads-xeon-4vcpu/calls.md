rounds: 60 measured after 3 warmup; 4 CPUs, Intel(R) Xeon(R) Processor @ 2.80GHz
rustc: rustc 1.97.0 (2d8144b78 2026-07-07)
queue: 0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline: 0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched: ac6e6fa16f5b0b63cce856dc618ca2328c51e713
zruntime: 99e2ebd807723177bec5d7c5216e48448c3a91c9
batched-before: 4f346a36a23efe3a88b9539ff1130c55c660be70
dbus-broker: dbus-broker 35
dbus-daemon: D-Bus Message Bus Daemon 1.14.10

### single_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.200 | 0.016 | 0.198 | 0.173 | 0.248 |
| baseline | 60 | 0.199 | 0.015 | 0.199 | 0.171 | 0.230 |
| batched | 60 | 0.203 | 0.017 | 0.198 | 0.179 | 0.276 |
| batched-before | 60 | 0.198 | 0.012 | 0.197 | 0.176 | 0.228 |
| dbus-broker | 60 | 0.198 | 0.015 | 0.194 | 0.176 | 0.241 |
| dbus-daemon | 60 | 0.216 | 0.019 | 0.211 | 0.188 | 0.263 |

### multi_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.774 | 0.071 | 0.771 | 0.659 | 0.978 |
| baseline | 60 | 0.756 | 0.063 | 0.758 | 0.659 | 0.953 |
| batched | 60 | 0.784 | 0.069 | 0.779 | 0.659 | 0.962 |
| batched-before | 60 | 0.752 | 0.068 | 0.748 | 0.649 | 0.965 |
| dbus-broker | 60 | 1.267 | 0.086 | 1.269 | 1.077 | 1.500 |
| dbus-daemon | 60 | 0.897 | 0.088 | 0.888 | 0.736 | 1.147 |

### broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.665 | 0.060 | 0.663 | 0.556 | 0.821 |
| baseline | 60 | 0.642 | 0.049 | 0.644 | 0.550 | 0.748 |
| batched | 60 | 0.676 | 0.060 | 0.672 | 0.572 | 0.866 |
| batched-before | 60 | 0.639 | 0.050 | 0.632 | 0.558 | 0.774 |
| dbus-broker | 60 | 0.586 | 0.038 | 0.588 | 0.506 | 0.663 |
| dbus-daemon | 60 | 0.972 | 0.078 | 0.969 | 0.842 | 1.170 |

### broker_maxrss_kib (KiB)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 4922 | 88 | 4930 | 4732 | 5128 |
| baseline | 60 | 4857 | 79 | 4850 | 4644 | 5056 |
| batched | 60 | 4923 | 87 | 4910 | 4740 | 5152 |
| batched-before | 60 | 4937 | 94 | 4936 | 4780 | 5172 |
| dbus-broker | 60 | 7291 | 104 | 7290 | 7068 | 7540 |
| dbus-daemon | 60 | 5015 | 42 | 5016 | 4880 | 5104 |

### client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.839 | 0.066 | 0.840 | 0.732 | 1.065 |
| baseline | 60 | 0.827 | 0.060 | 0.826 | 0.736 | 1.014 |
| batched | 60 | 0.848 | 0.060 | 0.843 | 0.733 | 1.036 |
| batched-before | 60 | 0.824 | 0.060 | 0.832 | 0.720 | 0.981 |
| dbus-broker | 60 | 1.376 | 0.090 | 1.362 | 1.186 | 1.602 |
| dbus-daemon | 60 | 0.860 | 0.065 | 0.853 | 0.750 | 1.053 |

### multi_broker_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.557 | 0.057 | 0.550 | 0.460 | 0.700 |
| baseline | 60 | 0.533 | 0.047 | 0.530 | 0.430 | 0.620 |
| batched | 60 | 0.566 | 0.058 | 0.565 | 0.470 | 0.740 |
| batched-before | 60 | 0.533 | 0.050 | 0.520 | 0.460 | 0.670 |
| dbus-broker | 60 | 0.492 | 0.035 | 0.500 | 0.410 | 0.570 |
| dbus-daemon | 60 | 0.846 | 0.078 | 0.840 | 0.720 | 1.040 |

### multi_client_cpu_s (seconds)

| broker | n | mean | stddev | median | min | max |
|---|---:|---:|---:|---:|---:|---:|
| queue | 60 | 0.732 | 0.062 | 0.730 | 0.630 | 0.940 |
| baseline | 60 | 0.721 | 0.058 | 0.725 | 0.630 | 0.920 |
| batched | 60 | 0.740 | 0.057 | 0.730 | 0.620 | 0.900 |
| batched-before | 60 | 0.718 | 0.060 | 0.710 | 0.620 | 0.890 |
| dbus-broker | 60 | 1.246 | 0.085 | 1.240 | 1.070 | 1.480 |
| dbus-daemon | 60 | 0.755 | 0.060 | 0.750 | 0.660 | 0.910 |
