candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9425 | 0.9484 | +0.62 | [-0.83, +2.09] | [-0.61, +1.85] | 1.007 | 0.3536 | no material change |
| single_rtt_mean_us | 60 | 188.4 | 189.6 | +0.62 | [-0.83, +2.09] | [-0.61, +1.85] | 1.007 | 0.3536 | no material change |
| single_rtt_p50_us | 60 | 177.8 | 178.4 | +0.34 | [-1.26, +1.96] | [-1.00, +1.72] | 1.002 | 0.6428 | no material change |
| single_rtt_p90_us | 60 | 223.4 | 224.9 | +0.68 | [-1.02, +2.45] | [-0.74, +2.14] | 1.006 | 0.4266 | no material change |
| single_rtt_p99_us | 60 | 328.1 | 324.7 | -1.02 | [-4.97, +2.96] | [-4.30, +2.31] | 1.010 | 0.8888 | no material change |
| single_rtt_p999_us | 60 | 915.2 | 908.5 | -0.73 | [-16.82, +18.09] | [-14.58, +15.03] | 0.910 | 0.4982 | inconclusive |
| single_rtt_max_us | 60 | 2850.1 | 3334.7 | +17.00 | [-13.97, +62.63] | [-10.31, +53.67] | 1.061 | 0.4661 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7832 | 0.8068 | +3.01 | [-0.14, +6.23] | [+0.36, +5.72] | 1.028 | 0.0257 | inconclusive |
| multi_rtt_mean_us | 60 | 758.9 | 781.7 | +3.00 | [-0.16, +6.25] | [+0.34, +5.72] | 1.028 | 0.0262 | inconclusive |
| multi_rtt_p50_us | 60 | 714.8 | 737.4 | +3.16 | [-0.13, +6.59] | [+0.37, +5.95] | 1.032 | 0.0074 | inconclusive |
| multi_rtt_p90_us | 60 | 1021.0 | 1057.3 | +3.56 | [-0.91, +8.27] | [-0.14, +7.49] | 1.022 | 0.1732 | inconclusive |
| multi_rtt_p99_us | 60 | 1502.5 | 1616.6 | +7.60 | [+1.39, +14.25] | [+2.33, +13.21] | 1.029 | 0.0445 | inconclusive; repeatable change (+) |
| multi_rtt_p999_us | 60 | 3106.6 | 3253.7 | +4.73 | [-11.69, +23.85] | [-8.91, +20.67] | 0.997 | 0.6587 | inconclusive |
| multi_rtt_max_us | 60 | 4620.1 | 4776.0 | +3.37 | [-24.80, +41.22] | [-20.92, +34.17] | 1.095 | 0.4266 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2703 | 0.2682 | -0.77 | [-4.48, +3.08] | [-3.86, +2.51] | 1.005 | 0.8888 | no material change |
| fanout_delivery_mean_us | 60 | 28082.9 | 28546.3 | +1.65 | [-2.86, +6.23] | [-2.11, +5.59] | 1.032 | 0.2792 | inconclusive |
| fanout_delivery_p50_us | 60 | 28286.3 | 28476.5 | +0.67 | [-3.48, +4.72] | [-2.74, +4.11] | 0.996 | 0.4982 | no material change |
| fanout_delivery_p90_us | 60 | 36753.6 | 37533.5 | +2.12 | [-4.94, +9.68] | [-3.87, +8.52] | 1.013 | 0.4527 | inconclusive |
| fanout_delivery_p99_us | 60 | 40880.0 | 43456.2 | +6.30 | [-1.30, +14.58] | [-0.12, +13.25] | 1.088 | 0.0494 | inconclusive |
| fanout_delivery_p999_us | 60 | 44395.5 | 45464.0 | +2.41 | [-4.81, +10.18] | [-3.66, +8.92] | 1.029 | 0.3132 | inconclusive |
| fanout_delivery_max_us | 60 | 45485.0 | 46216.3 | +1.61 | [-5.71, +9.45] | [-4.55, +8.25] | 1.009 | 0.5219 | inconclusive |
| client_wall_s | 60 | 2.0147 | 2.0424 | +1.37 | [-0.21, +2.99] | [+0.04, +2.74] | 1.020 | 0.0679 | no material change |
| client_cpu_s | 60 | 1.5080 | 1.5295 | +1.43 | [-0.32, +3.30] | [-0.08, +2.98] | 1.015 | 0.1664 | no material change |
| broker_user_s | 60 | 0.5316 | 0.5295 | -0.40 | [-3.26, +2.62] | [-2.80, +2.11] | 0.988 | 0.7238 | no material change |
| broker_sys_s | 60 | 0.6060 | 0.6192 | +2.17 | [-1.07, +5.44] | [-0.53, +4.92] | 1.025 | 0.2054 | no material change |
| broker_cpu_s | 60 | 1.1376 | 1.1486 | +0.97 | [-1.10, +3.07] | [-0.76, +2.73] | 1.009 | 0.3386 | no material change |
| broker_vcsw | 60 | 13167.6 | 13209.1 | +0.32 | [-1.29, +1.93] | [-1.03, +1.67] | 1.007 | 0.4461 | no material change |
| broker_maxrss_kib | 60 | 5114 | 5112 | -0.03 | [-0.68, +0.60] | [-0.57, +0.51] | 0.999 | 0.9308 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9407 | 0.9543 | +0.0058 | [-0.0082, +0.0199] |
| single_rtt_mean_us | 188.0 | 190.8 | +1.2 | [-1.6, +4.0] |
| single_rtt_p50_us | 176.9 | 178.6 | +0.6 | [-2.3, +3.5] |
| single_rtt_p90_us | 222.7 | 225.4 | +1.5 | [-2.4, +5.4] |
| single_rtt_p99_us | 323.6 | 325.1 | -3.3 | [-16.7, +10.1] |
| single_rtt_p999_us | 858.3 | 813.4 | -6.7 | [-172.6, +159.3] |
| single_rtt_max_us | 2619.3 | 2426.7 | +484.6 | [-596.0, +1565.2] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7756 | 0.8025 | +0.0236 | [-0.0020, +0.0491] |
| multi_rtt_mean_us | 753.1 | 782.8 | +22.8 | [-2.2, +47.8] |
| multi_rtt_p50_us | 707.5 | 735.9 | +22.6 | [-2.1, +47.3] |
| multi_rtt_p90_us | 1032.4 | 1072.4 | +36.3 | [-10.7, +83.3] |
| multi_rtt_p99_us | 1510.3 | 1578.5 | +114.1 | [+19.1, +209.2] |
| multi_rtt_p999_us | 2592.7 | 2874.4 | +147.1 | [-398.7, +692.9] |
| multi_rtt_max_us | 3389.1 | 3645.1 | +155.9 | [-1392.8, +1704.5] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2557 | 0.2579 | -0.0021 | [-0.0127, +0.0085] |
| fanout_delivery_mean_us | 26569.4 | 27668.2 | +463.4 | [-846.9, +1773.7] |
| fanout_delivery_p50_us | 26666.0 | 27557.7 | +190.2 | [-1003.0, +1383.5] |
| fanout_delivery_p90_us | 32816.6 | 34582.1 | +779.9 | [-1957.7, +3517.5] |
| fanout_delivery_p99_us | 37986.2 | 38993.9 | +2576.3 | [-632.7, +5785.2] |
| fanout_delivery_p999_us | 40800.1 | 41790.7 | +1068.5 | [-2301.8, +4438.9] |
| fanout_delivery_max_us | 41838.4 | 42810.6 | +731.3 | [-2780.8, +4243.5] |
| client_wall_s | 2.0015 | 2.0475 | +0.0276 | [-0.0060, +0.0613] |
| client_cpu_s | 1.4987 | 1.5171 | +0.0215 | [-0.0068, +0.0498] |
| broker_user_s | 0.5204 | 0.5302 | -0.0021 | [-0.0180, +0.0138] |
| broker_sys_s | 0.6021 | 0.6194 | +0.0132 | [-0.0067, +0.0330] |
| broker_cpu_s | 1.1372 | 1.1402 | +0.0110 | [-0.0130, +0.0351] |
| broker_vcsw | 13223.0 | 13251.5 | +41.5 | [-175.2, +258.2] |
| broker_maxrss_kib | 5114 | 5128 | -1 | [-35, +32] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
