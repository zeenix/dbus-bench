candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3319 | 0.3315 | -0.10 | [-1.09, +0.92] | [-0.93, +0.74] | 0.987 | 0.4752 | no material change |
| single_rtt_mean_us | 60 | 65.0 | 64.9 | -0.09 | [-1.10, +0.94] | [-0.93, +0.76] | 0.988 | 0.4982 | no material change |
| single_rtt_p50_us | 60 | 61.8 | 61.5 | -0.51 | [-1.66, +0.65] | [-1.49, +0.45] | 1.000 | 0.2468 | no material change |
| single_rtt_p90_us | 60 | 73.5 | 72.5 | -1.29 | [-4.22, +1.82] | [-3.76, +1.31] | 1.000 | 0.5185 | no material change |
| single_rtt_p99_us | 60 | 115.2 | 116.9 | +1.46 | [-2.74, +6.00] | [-2.09, +5.23] | 1.024 | 0.6166 | inconclusive |
| single_rtt_p999_us | 60 | 199.7 | 207.4 | +3.88 | [-3.53, +11.72] | [-2.35, +10.48] | 1.014 | 0.3142 | inconclusive |
| single_rtt_max_us | 60 | 426.5 | 417.6 | -2.09 | [-26.88, +32.60] | [-23.72, +25.38] | 1.029 | 0.8888 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4950 | 0.4953 | +0.06 | [-0.99, +1.18] | [-0.82, +0.98] | 1.006 | 0.7516 | no material change |
| multi_rtt_mean_us | 60 | 491.7 | 491.8 | +0.02 | [-1.01, +1.09] | [-0.84, +0.92] | 1.006 | 0.7740 | no material change |
| multi_rtt_p50_us | 60 | 479.0 | 480.4 | +0.29 | [-0.63, +1.21] | [-0.47, +1.06] | 1.008 | 0.3587 | no material change |
| multi_rtt_p90_us | 60 | 521.7 | 517.4 | -0.84 | [-2.22, +0.64] | [-2.00, +0.40] | 0.994 | 0.2359 | no material change |
| multi_rtt_p99_us | 60 | 807.0 | 822.5 | +1.92 | [-2.50, +6.54] | [-1.81, +5.75] | 1.052 | 0.2993 | inconclusive |
| multi_rtt_p999_us | 60 | 1192.7 | 1137.4 | -4.64 | [-11.84, +2.93] | [-10.66, +1.78] | 1.005 | 0.6402 | inconclusive |
| multi_rtt_max_us | 60 | 1527.9 | 1478.9 | -3.20 | [-12.40, +7.18] | [-10.93, +5.48] | 0.959 | 0.4889 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2561 | 0.2481 | -3.11 | [-4.08, -2.16] | [-3.92, -2.32] | 0.970 | <0.0001 | no material change; repeatable change (-) |
| fanout_delivery_mean_us | 60 | 56817.6 | 26189.7 | -53.91 | [-54.53, -53.25] | [-54.44, -53.37] | 0.461 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 57753.5 | 26947.4 | -53.34 | [-54.09, -52.61] | [-53.97, -52.72] | 0.473 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 88909.3 | 32242.2 | -63.74 | [-64.16, -63.32] | [-64.09, -63.38] | 0.361 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 96316.5 | 34372.5 | -64.31 | [-64.84, -63.77] | [-64.75, -63.87] | 0.355 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 97743.6 | 37400.5 | -61.74 | [-62.25, -61.21] | [-62.18, -61.30] | 0.384 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 98078.3 | 37995.4 | -61.26 | [-61.80, -60.72] | [-61.72, -60.80] | 0.388 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1209 | 1.1137 | -0.64 | [-1.37, +0.12] | [-1.26, -0.01] | 0.998 | 0.1619 | no material change |
| client_cpu_s | 60 | 0.9645 | 0.9568 | -0.80 | [-1.58, -0.02] | [-1.46, -0.13] | 0.995 | 0.1022 | no material change; repeatable change (-) |
| broker_user_s | 60 | 0.3020 | 0.2906 | -3.79 | [-5.75, -1.85] | [-5.42, -2.16] | 0.974 | 0.0009 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.3349 | 0.3016 | -9.93 | [-11.43, -8.44] | [-11.18, -8.65] | 0.902 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6369 | 0.5922 | -7.02 | [-7.91, -6.14] | [-7.76, -6.26] | 0.931 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14443.5 | 14118.2 | -2.25 | [-2.53, -1.97] | [-2.49, -2.01] | 0.976 | <0.0001 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 8087 | 7091 | -12.31 | [-13.10, -11.53] | [-12.97, -11.65] | 0.870 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3310 | 0.3297 | -0.0003 | [-0.0038, +0.0031] |
| single_rtt_mean_us | 64.7 | 64.5 | -0.1 | [-0.7, +0.6] |
| single_rtt_p50_us | 60.6 | 60.6 | -0.3 | [-1.1, +0.4] |
| single_rtt_p90_us | 71.8 | 70.1 | -0.9 | [-3.2, +1.3] |
| single_rtt_p99_us | 114.0 | 118.1 | +1.7 | [-3.4, +6.7] |
| single_rtt_p999_us | 192.9 | 197.1 | +7.8 | [-7.8, +23.3] |
| single_rtt_max_us | 293.3 | 333.6 | -8.9 | [-137.4, +119.6] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4916 | 0.4922 | +0.0003 | [-0.0052, +0.0058] |
| multi_rtt_mean_us | 488.6 | 489.0 | +0.1 | [-5.2, +5.4] |
| multi_rtt_p50_us | 474.9 | 476.1 | +1.4 | [-3.1, +5.9] |
| multi_rtt_p90_us | 519.5 | 515.3 | -4.4 | [-12.1, +3.3] |
| multi_rtt_p99_us | 810.9 | 839.4 | +15.5 | [-21.6, +52.6] |
| multi_rtt_p999_us | 1103.0 | 1093.5 | -55.3 | [-150.1, +39.4] |
| multi_rtt_max_us | 1368.4 | 1352.9 | -49.0 | [-206.0, +108.1] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2527 | 0.2447 | -0.0080 | [-0.0105, -0.0054] |
| fanout_delivery_mean_us | 55818.7 | 26156.4 | -30627.9 | [-31285.4, -29970.4] |
| fanout_delivery_p50_us | 56060.9 | 26690.3 | -30806.2 | [-31668.2, -29944.2] |
| fanout_delivery_p90_us | 87856.1 | 31833.7 | -56667.1 | [-57494.7, -55839.5] |
| fanout_delivery_p99_us | 94497.3 | 34097.4 | -61944.0 | [-62921.8, -60966.2] |
| fanout_delivery_p999_us | 96495.6 | 37078.1 | -60343.1 | [-61388.1, -59298.2] |
| fanout_delivery_max_us | 97119.5 | 37515.6 | -60082.9 | [-61180.4, -58985.4] |
| client_wall_s | 1.1174 | 1.1080 | -0.0072 | [-0.0158, +0.0014] |
| client_cpu_s | 0.9612 | 0.9523 | -0.0077 | [-0.0155, +0.0001] |
| broker_user_s | 0.3015 | 0.2912 | -0.0114 | [-0.0176, -0.0053] |
| broker_sys_s | 0.3328 | 0.3043 | -0.0332 | [-0.0387, -0.0278] |
| broker_cpu_s | 0.6334 | 0.5899 | -0.0447 | [-0.0507, -0.0386] |
| broker_vcsw | 14445.5 | 14121.0 | -325.3 | [-367.7, -282.8] |
| broker_maxrss_kib | 8156 | 7092 | -995 | [-1068, -923] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
