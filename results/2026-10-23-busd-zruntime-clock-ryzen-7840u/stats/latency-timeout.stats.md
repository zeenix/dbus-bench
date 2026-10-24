candidate timeout against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3275 | 0.3283 | +0.26 | [-0.60, +1.14] | [-0.46, +0.99] | 0.996 | 0.8482 | no material change |
| single_rtt_mean_us | 60 | 64.1 | 64.3 | +0.26 | [-0.61, +1.15] | [-0.47, +1.01] | 0.996 | 0.8598 | no material change |
| single_rtt_p50_us | 60 | 61.0 | 61.6 | +1.07 | [+0.29, +1.95] | [+0.39, +1.79] | 1.000 | 0.0237 | no material change; repeatable change (+) |
| single_rtt_p90_us | 60 | 70.1 | 70.4 | +0.45 | [-2.05, +3.15] | [-1.66, +2.69] | 0.983 | 0.7324 | no material change |
| single_rtt_p99_us | 60 | 114.7 | 109.1 | -4.82 | [-8.30, -0.96] | [-7.80, -1.65] | 0.953 | 0.0042 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 196.1 | 188.5 | -3.87 | [-10.32, +3.85] | [-9.40, +2.51] | 0.928 | 0.0169 | inconclusive |
| single_rtt_max_us | 60 | 385.5 | 377.0 | -2.22 | [-25.32, +27.46] | [-22.22, +22.61] | 0.912 | 0.4352 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4926 | 0.4953 | +0.55 | [-0.33, +1.44] | [-0.18, +1.29] | 1.008 | 0.1686 | no material change |
| multi_rtt_mean_us | 60 | 489.4 | 491.6 | +0.45 | [-0.41, +1.31] | [-0.26, +1.16] | 1.007 | 0.1976 | no material change |
| multi_rtt_p50_us | 60 | 478.0 | 480.3 | +0.49 | [-0.26, +1.20] | [-0.13, +1.09] | 1.009 | 0.0635 | no material change |
| multi_rtt_p90_us | 60 | 516.3 | 521.8 | +1.07 | [-0.45, +2.95] | [-0.20, +2.57] | 1.007 | 0.3531 | no material change |
| multi_rtt_p99_us | 60 | 788.6 | 807.5 | +2.40 | [-1.69, +6.73] | [-1.02, +6.00] | 1.005 | 0.5006 | inconclusive |
| multi_rtt_p999_us | 60 | 1137.6 | 1194.5 | +5.00 | [-5.09, +16.14] | [-3.58, +14.29] | 1.017 | 0.4395 | inconclusive |
| multi_rtt_max_us | 60 | 1405.1 | 1502.9 | +6.96 | [-2.54, +17.82] | [-1.21, +15.88] | 1.011 | 0.3810 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2553 | 0.2570 | +0.67 | [-0.30, +1.72] | [-0.16, +1.53] | 1.003 | 0.2217 | no material change |
| fanout_delivery_mean_us | 60 | 56443.2 | 22711.9 | -59.76 | [-60.32, -59.18] | [-60.22, -59.28] | 0.403 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 57505.1 | 22765.9 | -60.41 | [-61.00, -59.81] | [-60.91, -59.90] | 0.399 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 88729.0 | 28026.7 | -68.41 | [-68.78, -68.01] | [-68.73, -68.08] | 0.314 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 95828.8 | 29121.6 | -69.61 | [-70.02, -69.17] | [-69.96, -69.24] | 0.299 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 97620.5 | 30036.2 | -69.23 | [-69.77, -68.67] | [-69.69, -68.76] | 0.305 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 97897.5 | 31217.9 | -68.11 | [-68.72, -67.50] | [-68.63, -67.60] | 0.320 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1126 | 1.1192 | +0.60 | [-0.01, +1.20] | [+0.09, +1.11] | 1.007 | 0.0701 | no material change |
| client_cpu_s | 60 | 0.9572 | 0.9646 | +0.78 | [+0.09, +1.46] | [+0.20, +1.37] | 1.008 | 0.0400 | no material change; repeatable change (+) |
| broker_user_s | 60 | 0.2980 | 0.2965 | -0.51 | [-2.34, +1.36] | [-2.08, +1.06] | 1.000 | 0.6725 | no material change |
| broker_sys_s | 60 | 0.3336 | 0.3435 | +2.97 | [+1.38, +4.59] | [+1.62, +4.36] | 1.031 | 0.0012 | no material change; repeatable change (+) |
| broker_cpu_s | 60 | 0.6315 | 0.6400 | +1.33 | [+0.43, +2.25] | [+0.58, +2.09] | 1.011 | 0.0031 | no material change; repeatable change (+) |
| broker_vcsw | 60 | 14479.7 | 14165.6 | -2.17 | [-2.46, -1.89] | [-2.40, -1.93] | 0.980 | <0.0001 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 8150 | 7072 | -13.23 | [-13.82, -12.61] | [-13.74, -12.72] | 0.863 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3270 | 0.3271 | +0.0008 | [-0.0021, +0.0038] |
| single_rtt_mean_us | 64.0 | 64.0 | +0.2 | [-0.4, +0.7] |
| single_rtt_p50_us | 60.6 | 60.6 | +0.7 | [+0.1, +1.2] |
| single_rtt_p90_us | 68.9 | 70.1 | +0.3 | [-1.6, +2.2] |
| single_rtt_p99_us | 115.2 | 107.5 | -5.5 | [-9.9, -1.2] |
| single_rtt_p999_us | 190.0 | 176.9 | -7.6 | [-22.1, +6.9] |
| single_rtt_max_us | 320.0 | 252.3 | -8.5 | [-115.2, +98.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4894 | 0.4927 | +0.0027 | [-0.0017, +0.0071] |
| multi_rtt_mean_us | 486.4 | 488.9 | +2.2 | [-2.1, +6.5] |
| multi_rtt_p50_us | 474.3 | 477.9 | +2.3 | [-1.2, +5.9] |
| multi_rtt_p90_us | 513.5 | 516.5 | +5.5 | [-3.3, +14.4] |
| multi_rtt_p99_us | 802.0 | 819.2 | +18.9 | [-15.0, +52.8] |
| multi_rtt_p999_us | 1059.7 | 1086.4 | +56.9 | [-64.7, +178.4] |
| multi_rtt_max_us | 1331.0 | 1339.3 | +97.9 | [-44.0, +239.7] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2525 | 0.2538 | +0.0017 | [-0.0009, +0.0043] |
| fanout_delivery_mean_us | 55930.8 | 22507.6 | -33731.4 | [-34310.0, -33152.8] |
| fanout_delivery_p50_us | 56042.5 | 22493.7 | -34739.2 | [-35476.6, -34001.7] |
| fanout_delivery_p90_us | 88024.1 | 27570.1 | -60702.3 | [-61499.6, -59904.9] |
| fanout_delivery_p99_us | 94699.8 | 28553.2 | -66707.2 | [-67562.0, -65852.5] |
| fanout_delivery_p999_us | 96027.8 | 29441.3 | -67584.3 | [-68611.1, -66557.5] |
| fanout_delivery_max_us | 96164.4 | 31008.6 | -66679.6 | [-67717.6, -65641.5] |
| client_wall_s | 1.1114 | 1.1148 | +0.0067 | [-0.0002, +0.0136] |
| client_cpu_s | 0.9512 | 0.9565 | +0.0074 | [+0.0007, +0.0142] |
| broker_user_s | 0.2960 | 0.2969 | -0.0015 | [-0.0072, +0.0042] |
| broker_sys_s | 0.3330 | 0.3402 | +0.0099 | [+0.0044, +0.0154] |
| broker_cpu_s | 0.6280 | 0.6383 | +0.0084 | [+0.0026, +0.0142] |
| broker_vcsw | 14467.5 | 14189.5 | -314.1 | [-356.7, -271.5] |
| broker_maxrss_kib | 8218 | 7078 | -1079 | [-1135, -1022] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
