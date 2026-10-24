candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5205 | 0.4207 | -19.18 | [-21.95, -16.21] | [-21.49, -16.72] | 0.806 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.7385 | 0.4862 | -34.16 | [-35.78, -32.49] | [-35.54, -32.78] | 0.661 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.2708 | 0.9200 | -27.61 | [-29.14, -26.04] | [-28.88, -26.31] | 0.732 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.1914 | 0.8888 | -25.40 | [-26.82, -23.99] | [-26.57, -24.21] | 0.749 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 2088.8 | 106.8 | -94.89 | [-95.59, -94.04] | [-95.48, -94.17] | 0.052 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7315 | 0.4810 | -34.24 | [-35.76, -32.67] | [-35.53, -32.92] | 0.651 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.3792 | 0.1318 | -65.23 | [-66.48, -63.96] | [-66.30, -64.19] | 0.346 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5832 | 0.3271 | -43.91 | [-45.45, -42.32] | [-45.22, -42.57] | 0.561 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3090 | 0.1464 | -52.64 | [-55.16, -49.98] | [-54.78, -50.44] | 0.488 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.8922 | 0.4735 | -46.94 | [-48.10, -45.74] | [-47.92, -45.91] | 0.545 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 9568.7 | 342.4 | -96.42 | [-96.64, -96.19] | [-96.60, -96.23] | 0.034 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7903 | 4976 | -37.05 | [-39.04, -35.32] | [-38.66, -35.54] | 0.647 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18914 | 18914 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5103 | 0.4179 | -0.0998 | [-0.1173, -0.0824] |
| multi_s | 0.7331 | 0.4857 | -0.2523 | [-0.2677, -0.2369] |
| client_wall_s | 1.2665 | 0.9255 | -0.3508 | [-0.3749, -0.3268] |
| client_cpu_s | 1.1817 | 0.8911 | -0.3026 | [-0.3227, -0.2826] |
| client_vcsw | 1984.0 | 103.5 | -1982.0 | [-2254.8, -1709.1] |
| multi_client_cpu_s | 0.7250 | 0.4800 | -0.2505 | [-0.2651, -0.2359] |
| multi_broker_cpu_s | 0.3750 | 0.1300 | -0.2473 | [-0.2563, -0.2383] |
| broker_user_s | 0.5800 | 0.3245 | -0.2561 | [-0.2690, -0.2433] |
| broker_sys_s | 0.3086 | 0.1435 | -0.1627 | [-0.1757, -0.1496] |
| broker_cpu_s | 0.8874 | 0.4710 | -0.4188 | [-0.4354, -0.4021] |
| broker_vcsw | 9764.0 | 326.0 | -9226.3 | [-9572.6, -8879.9] |
| broker_maxrss_kib | 7684 | 4980 | -2928 | [-3172, -2684] |
| broker_ru_maxrss_kib | 19012 | 19012 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
