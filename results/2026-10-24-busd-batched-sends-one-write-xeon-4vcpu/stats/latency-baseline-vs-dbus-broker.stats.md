candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9356 | 0.9409 | +0.56 | [-1.13, +2.32] | [-0.86, +2.04] | 1.009 | 0.4936 | no material change |
| single_rtt_mean_us | 60 | 187.0 | 188.1 | +0.56 | [-1.13, +2.32] | [-0.86, +2.04] | 1.009 | 0.4936 | no material change |
| single_rtt_p50_us | 60 | 178.0 | 177.4 | -0.33 | [-2.12, +1.54] | [-1.87, +1.24] | 0.999 | 0.8540 | no material change |
| single_rtt_p90_us | 60 | 226.1 | 224.8 | -0.59 | [-2.52, +1.43] | [-2.21, +1.13] | 0.990 | 0.5961 | no material change |
| single_rtt_p99_us | 60 | 326.6 | 324.6 | -0.61 | [-4.68, +3.74] | [-3.99, +3.04] | 1.002 | 0.9706 | no material change |
| single_rtt_p999_us | 60 | 870.6 | 865.9 | -0.53 | [-13.92, +15.43] | [-11.78, +12.73] | 0.996 | 0.9589 | inconclusive |
| single_rtt_max_us | 60 | 3507.0 | 3025.0 | -13.74 | [-44.54, +37.41] | [-40.65, +27.24] | 1.022 | 0.9472 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.3048 | 0.7869 | -39.69 | [-41.44, -37.87] | [-41.15, -38.18] | 0.603 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1265.8 | 762.5 | -39.76 | [-41.54, -37.90] | [-41.25, -38.23] | 0.602 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1210.8 | 716.3 | -40.84 | [-42.46, -39.16] | [-42.21, -39.46] | 0.592 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1831.6 | 1039.9 | -43.23 | [-45.77, -40.52] | [-45.38, -41.01] | 0.568 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2604.4 | 1548.8 | -40.53 | [-43.79, -37.02] | [-43.28, -37.59] | 0.608 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 4313.7 | 2994.8 | -30.57 | [-39.57, -20.33] | [-38.15, -21.96] | 0.645 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 5847.4 | 4277.7 | -26.84 | [-39.64, -11.59] | [-37.65, -14.14] | 0.675 | 0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3441 | 0.3047 | -11.44 | [-14.81, -7.84] | [-14.26, -8.49] | 0.860 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 70059.2 | 27093.4 | -61.33 | [-62.85, -59.72] | [-62.61, -59.99] | 0.376 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 71263.0 | 26823.6 | -62.36 | [-63.85, -60.80] | [-63.64, -61.05] | 0.367 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 116610.5 | 34879.1 | -70.09 | [-71.82, -68.34] | [-71.51, -68.64] | 0.285 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 130176.9 | 39544.9 | -69.62 | [-71.54, -67.64] | [-71.24, -67.99] | 0.285 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 135503.4 | 40732.9 | -69.94 | [-71.77, -68.07] | [-71.47, -68.42] | 0.283 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 136855.7 | 41930.0 | -69.36 | [-71.22, -67.47] | [-70.93, -67.80] | 0.298 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.5976 | 2.0535 | -20.95 | [-22.25, -19.59] | [-22.05, -19.81] | 0.791 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.2371 | 1.5500 | -30.71 | [-31.95, -29.44] | [-31.77, -29.65] | 0.692 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2617 | 0.5449 | +108.26 | [+101.48, +115.54] | [+102.51, +114.31] | 2.108 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.7451 | 0.6359 | -14.66 | [-16.97, -12.39] | [-16.60, -12.73] | 0.861 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.0068 | 1.1808 | +17.29 | [+14.81, +19.77] | [+15.22, +19.39] | 1.176 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 53214.5 | 13285.0 | -75.04 | [-75.47, -74.59] | [-75.40, -74.66] | 0.250 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11100 | 5079 | -54.24 | [-54.50, -54.00] | [-54.45, -54.03] | 0.458 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9317 | 0.9380 | +0.0053 | [-0.0113, +0.0218] |
| single_rtt_mean_us | 186.2 | 187.5 | +1.1 | [-2.3, +4.4] |
| single_rtt_p50_us | 176.7 | 176.4 | -0.6 | [-4.0, +2.8] |
| single_rtt_p90_us | 224.9 | 224.7 | -1.3 | [-6.0, +3.3] |
| single_rtt_p99_us | 318.2 | 318.6 | -2.0 | [-16.0, +12.1] |
| single_rtt_p999_us | 817.7 | 819.9 | -4.6 | [-134.1, +124.8] |
| single_rtt_max_us | 2387.5 | 2312.8 | -482.0 | [-2059.6, +1095.6] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.2909 | 0.7867 | -0.5179 | [-0.5503, -0.4856] |
| multi_rtt_mean_us | 1254.3 | 765.1 | -503.2 | [-535.4, -471.1] |
| multi_rtt_p50_us | 1214.7 | 717.1 | -494.5 | [-523.5, -465.6] |
| multi_rtt_p90_us | 1803.4 | 1043.5 | -791.8 | [-863.5, -720.0] |
| multi_rtt_p99_us | 2611.4 | 1539.2 | -1055.6 | [-1174.8, -936.4] |
| multi_rtt_p999_us | 3904.3 | 2567.7 | -1318.9 | [-1821.9, -815.8] |
| multi_rtt_max_us | 5107.4 | 3509.3 | -1569.6 | [-2530.8, -608.5] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3402 | 0.2971 | -0.0394 | [-0.0520, -0.0267] |
| fanout_delivery_mean_us | 68806.9 | 26448.1 | -42965.8 | [-44789.2, -41142.4] |
| fanout_delivery_p50_us | 70307.1 | 26643.3 | -44439.4 | [-46281.8, -42597.0] |
| fanout_delivery_p90_us | 112843.3 | 33267.7 | -81731.4 | [-86046.1, -77416.7] |
| fanout_delivery_p99_us | 124742.2 | 37934.3 | -90632.0 | [-95735.1, -85528.8] |
| fanout_delivery_p999_us | 129901.2 | 40606.9 | -94770.5 | [-99707.3, -89833.8] |
| fanout_delivery_max_us | 132699.3 | 40699.3 | -94925.7 | [-99986.9, -89864.4] |
| client_wall_s | 2.5947 | 2.0530 | -0.5441 | [-0.5852, -0.5030] |
| client_cpu_s | 2.2440 | 1.5451 | -0.6871 | [-0.7230, -0.6512] |
| broker_user_s | 0.2633 | 0.5460 | +0.2833 | [+0.2694, +0.2971] |
| broker_sys_s | 0.7468 | 0.6370 | -0.1092 | [-0.1281, -0.0903] |
| broker_cpu_s | 1.0077 | 1.1842 | +0.1741 | [+0.1500, +0.1981] |
| broker_vcsw | 53183.5 | 13340.5 | -39929.6 | [-40786.7, -39072.4] |
| broker_maxrss_kib | 11096 | 5084 | -6021 | [-6062, -5980] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
