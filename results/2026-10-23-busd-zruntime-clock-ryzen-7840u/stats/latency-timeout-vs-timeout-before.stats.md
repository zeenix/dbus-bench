candidate timeout against baseline timeout-before, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3409 | 0.3283 | -3.69 | [-4.74, -2.65] | [-4.58, -2.82] | 0.968 | <0.0001 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 66.8 | 64.3 | -3.77 | [-4.84, -2.71] | [-4.67, -2.88] | 0.967 | <0.0001 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 63.4 | 61.6 | -2.78 | [-4.30, -1.34] | [-4.03, -1.57] | 0.981 | 0.0002 | no material change; repeatable change (-) |
| single_rtt_p90_us | 60 | 74.2 | 70.4 | -5.04 | [-7.50, -2.58] | [-7.11, -3.00] | 0.947 | 0.0003 | inconclusive; repeatable change (-) |
| single_rtt_p99_us | 60 | 117.8 | 109.1 | -7.33 | [-10.75, -3.86] | [-10.18, -4.42] | 0.931 | 0.0002 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 195.8 | 188.5 | -3.73 | [-10.58, +4.19] | [-9.65, +2.88] | 0.940 | 0.0533 | inconclusive |
| single_rtt_max_us | 60 | 365.6 | 377.0 | +3.12 | [-17.84, +27.26] | [-14.80, +23.31] | 0.997 | 0.8326 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4879 | 0.4953 | +1.53 | [+0.80, +2.28] | [+0.92, +2.15] | 1.015 | 0.0002 | no material change; repeatable change (+) |
| multi_rtt_mean_us | 60 | 484.7 | 491.6 | +1.42 | [+0.72, +2.14] | [+0.84, +2.02] | 1.014 | 0.0003 | no material change; repeatable change (+) |
| multi_rtt_p50_us | 60 | 475.6 | 480.3 | +0.98 | [+0.47, +1.50] | [+0.56, +1.41] | 1.008 | 0.0005 | no material change; repeatable change (+) |
| multi_rtt_p90_us | 60 | 509.2 | 521.8 | +2.49 | [+1.12, +4.28] | [+1.28, +3.93] | 1.018 | 0.0003 | no material change; repeatable change (+) |
| multi_rtt_p99_us | 60 | 749.3 | 807.5 | +7.77 | [+2.73, +12.79] | [+3.65, +11.96] | 1.103 | 0.0046 | inconclusive; repeatable change (+) |
| multi_rtt_p999_us | 60 | 1153.0 | 1194.5 | +3.60 | [-5.25, +13.28] | [-3.89, +11.85] | 1.015 | 0.6219 | inconclusive |
| multi_rtt_max_us | 60 | 1442.6 | 1502.9 | +4.18 | [-5.54, +15.22] | [-3.96, +13.30] | 1.014 | 0.4439 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2540 | 0.2570 | +1.19 | [+0.42, +2.03] | [+0.53, +1.87] | 1.007 | 0.0044 | no material change; repeatable change (+) |
| fanout_delivery_mean_us | 60 | 22041.0 | 22711.9 | +3.04 | [+1.96, +4.14] | [+2.13, +3.95] | 1.031 | <0.0001 | no material change; repeatable change (+) |
| fanout_delivery_p50_us | 60 | 22320.9 | 22765.9 | +1.99 | [+1.15, +2.91] | [+1.28, +2.75] | 1.016 | <0.0001 | no material change; repeatable change (+) |
| fanout_delivery_p90_us | 60 | 27582.6 | 28026.7 | +1.61 | [+0.69, +2.64] | [+0.82, +2.47] | 1.012 | 0.0011 | no material change; repeatable change (+) |
| fanout_delivery_p99_us | 60 | 28588.1 | 29121.6 | +1.87 | [+0.32, +3.44] | [+0.55, +3.19] | 1.017 | 0.0062 | no material change; repeatable change (+) |
| fanout_delivery_p999_us | 60 | 29144.9 | 30036.2 | +3.06 | [+1.17, +5.01] | [+1.44, +4.70] | 1.022 | 0.0007 | no material change; repeatable change (+) |
| fanout_delivery_max_us | 60 | 30440.9 | 31217.9 | +2.55 | [-0.14, +5.27] | [+0.30, +4.80] | 1.038 | 0.0469 | no material change |
| client_wall_s | 60 | 1.1216 | 1.1192 | -0.21 | [-0.78, +0.39] | [-0.69, +0.29] | 0.999 | 0.4244 | no material change |
| client_cpu_s | 60 | 0.9657 | 0.9646 | -0.12 | [-0.77, +0.58] | [-0.67, +0.46] | 0.996 | 0.3731 | no material change |
| broker_user_s | 60 | 0.3137 | 0.2965 | -5.48 | [-7.36, -3.63] | [-7.05, -3.94] | 0.948 | <0.0001 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.4331 | 0.3435 | -20.69 | [-21.91, -19.44] | [-21.72, -19.62] | 0.784 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.7467 | 0.6400 | -14.30 | [-14.87, -13.69] | [-14.78, -13.79] | 0.856 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14000.4 | 14165.6 | +1.18 | [+0.82, +1.56] | [+0.88, +1.50] | 1.009 | <0.0001 | no material change; repeatable change (+) |
| broker_maxrss_kib | 60 | 7016 | 7072 | +0.79 | [+0.27, +1.30] | [+0.35, +1.22] | 1.009 | 0.0051 | no material change; repeatable change (+) |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3366 | 0.3271 | -0.0126 | [-0.0164, -0.0088] |
| single_rtt_mean_us | 65.9 | 64.0 | -2.5 | [-3.3, -1.8] |
| single_rtt_p50_us | 61.7 | 60.6 | -1.8 | [-2.7, -0.8] |
| single_rtt_p90_us | 72.4 | 70.1 | -3.7 | [-5.6, -1.8] |
| single_rtt_p99_us | 118.7 | 107.5 | -8.6 | [-13.0, -4.3] |
| single_rtt_p999_us | 192.3 | 176.9 | -7.3 | [-22.7, +8.1] |
| single_rtt_max_us | 289.7 | 252.3 | +11.4 | [-72.9, +95.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4835 | 0.4927 | +0.0075 | [+0.0038, +0.0111] |
| multi_rtt_mean_us | 480.4 | 488.9 | +6.9 | [+3.4, +10.4] |
| multi_rtt_p50_us | 472.6 | 477.9 | +4.7 | [+2.2, +7.1] |
| multi_rtt_p90_us | 505.8 | 516.5 | +12.7 | [+4.4, +20.9] |
| multi_rtt_p99_us | 711.8 | 819.2 | +58.2 | [+21.0, +95.4] |
| multi_rtt_p999_us | 1103.6 | 1086.4 | +41.5 | [-66.9, +149.9] |
| multi_rtt_max_us | 1278.7 | 1339.3 | +60.3 | [-88.4, +209.1] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2517 | 0.2538 | +0.0030 | [+0.0009, +0.0051] |
| fanout_delivery_mean_us | 21869.4 | 22507.6 | +670.8 | [+427.9, +913.8] |
| fanout_delivery_p50_us | 22131.0 | 22493.7 | +445.0 | [+245.8, +644.2] |
| fanout_delivery_p90_us | 27302.9 | 27570.1 | +444.1 | [+165.7, +722.4] |
| fanout_delivery_p99_us | 28033.7 | 28553.2 | +533.5 | [+76.5, +990.5] |
| fanout_delivery_p999_us | 28416.1 | 29441.3 | +891.3 | [+318.3, +1464.3] |
| fanout_delivery_max_us | 29413.4 | 31008.6 | +777.1 | [-49.5, +1603.6] |
| client_wall_s | 1.1132 | 1.1148 | -0.0024 | [-0.0092, +0.0045] |
| client_cpu_s | 0.9575 | 0.9565 | -0.0011 | [-0.0078, +0.0056] |
| broker_user_s | 0.3129 | 0.2969 | -0.0172 | [-0.0234, -0.0110] |
| broker_sys_s | 0.4355 | 0.3402 | -0.0896 | [-0.0956, -0.0835] |
| broker_cpu_s | 0.7439 | 0.6383 | -0.1068 | [-0.1115, -0.1020] |
| broker_vcsw | 14054.0 | 14189.5 | +165.2 | [+111.4, +219.1] |
| broker_maxrss_kib | 7012 | 7078 | +55 | [+18, +93] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
