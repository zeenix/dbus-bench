candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3237 | 2.0129 | -68.17 | [-68.34, -67.99] | [-68.32, -68.02] | 0.318 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7145 | 2.1860 | -61.75 | [-62.18, -61.28] | [-62.11, -61.36] | 0.382 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.0691 | 4.2293 | -64.96 | [-65.18, -64.72] | [-65.15, -64.76] | 0.349 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.0930 | 4.0564 | -49.88 | [-50.22, -49.52] | [-50.16, -49.58] | 0.501 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 215730.8 | 2366.2 | -98.90 | [-99.00, -98.79] | [-98.99, -98.81] | 0.010 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3608 | 2.1365 | -51.01 | [-51.59, -50.39] | [-51.49, -50.49] | 0.490 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.6858 | 1.8313 | -67.79 | [-68.24, -67.30] | [-68.18, -67.38] | 0.320 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.6504 | 1.5953 | -65.70 | [-66.04, -65.34] | [-65.98, -65.40] | 0.344 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.3933 | 1.7433 | -76.42 | [-76.71, -76.09] | [-76.67, -76.14] | 0.232 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.0437 | 3.3386 | -72.28 | [-72.53, -71.99] | [-72.49, -72.04] | 0.276 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 22.750 | 15130.175 | +66406.26 | [+58831.59, +75780.28] | [+59961.17, +74103.70] | 776.091 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8439 | 11525 | +36.56 | [+34.57, +38.68] | [+34.86, +38.33] | 1.346 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20586 | 20586 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3121 | 2.0061 | -4.3109 | [-4.3274, -4.2943] |
| multi_s | 5.6977 | 2.1674 | -3.5285 | [-3.5698, -3.4872] |
| client_wall_s | 12.0288 | 4.1962 | -7.8398 | [-7.8879, -7.7918] |
| client_cpu_s | 8.0562 | 4.0353 | -4.0366 | [-4.0795, -3.9937] |
| client_vcsw | 216403.0 | 2164.5 | -213364.6 | [-215085.6, -211643.7] |
| multi_client_cpu_s | 4.3400 | 2.1200 | -2.2243 | [-2.2601, -2.1884] |
| multi_broker_cpu_s | 5.6650 | 1.8050 | -3.8545 | [-3.8935, -3.8155] |
| broker_user_s | 4.6346 | 1.5921 | -3.0552 | [-3.0829, -3.0274] |
| broker_sys_s | 7.3786 | 1.7126 | -5.6499 | [-5.6864, -5.6135] |
| broker_cpu_s | 12.0042 | 3.3114 | -8.7051 | [-8.7513, -8.6588] |
| broker_vcsw | 20.000 | 15143.500 | +15107.425 | [+14858.983, +15355.867] |
| broker_maxrss_kib | 8384 | 11490 | +3086 | [+2923, +3249] |
| broker_ru_maxrss_kib | 20628 | 20628 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
