candidate timeout-before against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3275 | 0.3409 | +4.10 | [+3.10, +5.16] | [+3.26, +4.99] | 1.037 | <0.0001 | no material change; repeatable change (+) |
| single_rtt_mean_us | 60 | 64.1 | 66.8 | +4.19 | [+3.17, +5.26] | [+3.33, +5.09] | 1.038 | <0.0001 | inconclusive; repeatable change (+) |
| single_rtt_p50_us | 60 | 61.0 | 63.4 | +3.96 | [+2.70, +5.34] | [+2.89, +5.11] | 1.020 | <0.0001 | inconclusive; repeatable change (+) |
| single_rtt_p90_us | 60 | 70.1 | 74.2 | +5.79 | [+3.21, +8.43] | [+3.64, +7.99] | 1.052 | <0.0001 | inconclusive; repeatable change (+) |
| single_rtt_p99_us | 60 | 114.7 | 117.8 | +2.71 | [-1.26, +6.75] | [-0.62, +6.15] | 1.029 | 0.1537 | inconclusive |
| single_rtt_p999_us | 60 | 196.1 | 195.8 | -0.14 | [-5.73, +5.88] | [-4.79, +4.98] | 1.007 | 0.7426 | no material change |
| single_rtt_max_us | 60 | 385.5 | 365.6 | -5.17 | [-23.32, +17.99] | [-20.85, +13.75] | 0.978 | 0.5029 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4926 | 0.4879 | -0.96 | [-1.81, -0.15] | [-1.67, -0.27] | 0.991 | 0.0262 | no material change; repeatable change (-) |
| multi_rtt_mean_us | 60 | 489.4 | 484.7 | -0.96 | [-1.79, -0.16] | [-1.64, -0.28] | 0.991 | 0.0247 | no material change; repeatable change (-) |
| multi_rtt_p50_us | 60 | 478.0 | 475.6 | -0.49 | [-1.24, +0.20] | [-1.10, +0.10] | 0.996 | 0.2019 | no material change |
| multi_rtt_p90_us | 60 | 516.3 | 509.2 | -1.38 | [-2.44, -0.31] | [-2.27, -0.47] | 0.985 | 0.0180 | no material change; repeatable change (-) |
| multi_rtt_p99_us | 60 | 788.6 | 749.3 | -4.98 | [-9.14, -0.51] | [-8.48, -1.30] | 0.951 | 0.0346 | inconclusive; repeatable change (-) |
| multi_rtt_p999_us | 60 | 1137.6 | 1153.0 | +1.35 | [-7.05, +10.22] | [-5.81, +8.80] | 1.066 | 0.4352 | inconclusive |
| multi_rtt_max_us | 60 | 1405.1 | 1442.6 | +2.67 | [-6.53, +12.93] | [-5.15, +11.28] | 0.999 | 0.8024 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2553 | 0.2540 | -0.52 | [-1.35, +0.31] | [-1.22, +0.17] | 0.997 | 0.2959 | no material change |
| fanout_delivery_mean_us | 60 | 56443.2 | 22041.0 | -60.95 | [-61.42, -60.46] | [-61.35, -60.54] | 0.389 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 57505.1 | 22320.9 | -61.18 | [-61.71, -60.67] | [-61.62, -60.75] | 0.394 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 88729.0 | 27582.6 | -68.91 | [-69.24, -68.57] | [-69.19, -68.63] | 0.310 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 95828.8 | 28588.1 | -70.17 | [-70.55, -69.76] | [-70.49, -69.83] | 0.297 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 97620.5 | 29144.9 | -70.14 | [-70.63, -69.62] | [-70.56, -69.71] | 0.296 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 97897.5 | 30440.9 | -68.91 | [-69.62, -68.18] | [-69.51, -68.29] | 0.303 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1126 | 1.1216 | +0.81 | [+0.15, +1.47] | [+0.26, +1.36] | 1.010 | 0.0174 | no material change; repeatable change (+) |
| client_cpu_s | 60 | 0.9572 | 0.9657 | +0.89 | [+0.24, +1.56] | [+0.34, +1.44] | 1.010 | 0.0128 | no material change; repeatable change (+) |
| broker_user_s | 60 | 0.2980 | 0.3137 | +5.26 | [+3.39, +7.17] | [+3.69, +6.85] | 1.055 | <0.0001 | inconclusive; repeatable change (+) |
| broker_sys_s | 60 | 0.3336 | 0.4331 | +29.83 | [+28.26, +31.39] | [+28.51, +31.15] | 1.294 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.6315 | 0.7467 | +18.24 | [+17.34, +19.10] | [+17.50, +18.96] | 1.190 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 14479.7 | 14000.4 | -3.31 | [-3.69, -2.94] | [-3.62, -2.99] | 0.969 | <0.0001 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 8150 | 7016 | -13.91 | [-14.53, -13.26] | [-14.44, -13.37] | 0.856 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3270 | 0.3366 | +0.0134 | [+0.0100, +0.0168] |
| single_rtt_mean_us | 64.0 | 65.9 | +2.7 | [+2.0, +3.4] |
| single_rtt_p50_us | 60.6 | 61.7 | +2.4 | [+1.6, +3.2] |
| single_rtt_p90_us | 68.9 | 72.4 | +4.1 | [+2.3, +5.9] |
| single_rtt_p99_us | 115.2 | 118.7 | +3.1 | [-1.6, +7.8] |
| single_rtt_p999_us | 190.0 | 192.3 | -0.3 | [-12.1, +11.6] |
| single_rtt_max_us | 320.0 | 289.7 | -19.9 | [-104.3, +64.4] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4894 | 0.4835 | -0.0048 | [-0.0090, -0.0005] |
| multi_rtt_mean_us | 486.4 | 480.4 | -4.7 | [-8.8, -0.6] |
| multi_rtt_p50_us | 474.3 | 472.6 | -2.3 | [-5.9, +1.2] |
| multi_rtt_p90_us | 513.5 | 505.8 | -7.1 | [-12.9, -1.4] |
| multi_rtt_p99_us | 802.0 | 711.8 | -39.3 | [-75.2, -3.4] |
| multi_rtt_p999_us | 1059.7 | 1103.6 | +15.4 | [-87.0, +117.7] |
| multi_rtt_max_us | 1331.0 | 1278.7 | +37.5 | [-103.1, +178.2] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2525 | 0.2517 | -0.0013 | [-0.0035, +0.0008] |
| fanout_delivery_mean_us | 55930.8 | 21869.4 | -34402.2 | [-34942.8, -33861.6] |
| fanout_delivery_p50_us | 56042.5 | 22131.0 | -35184.2 | [-35888.1, -34480.3] |
| fanout_delivery_p90_us | 88024.1 | 27302.9 | -61146.3 | [-61918.9, -60373.7] |
| fanout_delivery_p99_us | 94699.8 | 28033.7 | -67240.7 | [-68030.8, -66450.7] |
| fanout_delivery_p999_us | 96027.8 | 28416.1 | -68475.6 | [-69455.0, -67496.1] |
| fanout_delivery_max_us | 96164.4 | 29413.4 | -67456.6 | [-68560.4, -66352.8] |
| client_wall_s | 1.1114 | 1.1132 | +0.0090 | [+0.0015, +0.0165] |
| client_cpu_s | 0.9512 | 0.9575 | +0.0085 | [+0.0021, +0.0150] |
| broker_user_s | 0.2960 | 0.3129 | +0.0157 | [+0.0100, +0.0214] |
| broker_sys_s | 0.3330 | 0.4355 | +0.0995 | [+0.0946, +0.1044] |
| broker_cpu_s | 0.6280 | 0.7439 | +0.1152 | [+0.1100, +0.1204] |
| broker_vcsw | 14467.5 | 14054.0 | -479.3 | [-535.7, -423.0] |
| broker_maxrss_kib | 8218 | 7012 | -1134 | [-1194, -1074] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
