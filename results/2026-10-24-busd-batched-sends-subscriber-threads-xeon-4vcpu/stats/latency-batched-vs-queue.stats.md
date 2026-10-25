candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9315 | 0.9126 | -2.03 | [-3.51, -0.49] | [-3.26, -0.74] | 0.975 | 0.0096 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 186.2 | 182.4 | -2.03 | [-3.51, -0.49] | [-3.26, -0.74] | 0.975 | 0.0096 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 174.5 | 171.8 | -1.56 | [-2.94, -0.12] | [-2.71, -0.37] | 0.990 | 0.0247 | no material change; repeatable change (-) |
| single_rtt_p90_us | 60 | 219.1 | 214.5 | -2.11 | [-4.08, -0.11] | [-3.77, -0.42] | 0.970 | 0.0293 | no material change; repeatable change (-) |
| single_rtt_p99_us | 60 | 318.6 | 299.5 | -6.01 | [-10.19, -1.51] | [-9.51, -2.34] | 0.928 | 0.0109 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 949.2 | 803.2 | -15.39 | [-27.04, -2.41] | [-25.29, -4.34] | 0.830 | 0.0679 | inconclusive; repeatable change (-) |
| single_rtt_max_us | 60 | 4399.0 | 2750.4 | -37.48 | [-64.01, +20.45] | [-60.92, +13.25] | 1.077 | 0.5363 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7507 | 0.7514 | +0.10 | [-3.08, +3.26] | [-2.58, +2.76] | 1.011 | 0.6910 | no material change |
| multi_rtt_mean_us | 60 | 726.8 | 726.8 | -0.00 | [-3.25, +3.23] | [-2.74, +2.71] | 1.007 | 0.7516 | no material change |
| multi_rtt_p50_us | 60 | 694.1 | 694.4 | +0.04 | [-2.57, +2.70] | [-2.17, +2.28] | 1.001 | 0.9883 | no material change |
| multi_rtt_p90_us | 60 | 948.7 | 950.9 | +0.23 | [-5.25, +5.82] | [-4.34, +4.78] | 0.985 | 0.7349 | no material change |
| multi_rtt_p99_us | 60 | 1439.1 | 1465.1 | +1.81 | [-6.12, +10.49] | [-4.98, +9.10] | 1.020 | 0.6534 | inconclusive |
| multi_rtt_p999_us | 60 | 2804.8 | 2656.7 | -5.28 | [-20.83, +13.52] | [-18.47, +10.11] | 0.985 | 0.6375 | inconclusive |
| multi_rtt_max_us | 60 | 4519.8 | 4334.6 | -4.10 | [-31.39, +37.78] | [-28.19, +29.59] | 0.931 | 0.4439 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.1170 | 0.1013 | -13.45 | [-17.33, -9.59] | [-16.69, -10.22] | 0.894 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 9802.3 | 4902.9 | -49.98 | [-54.42, -45.38] | [-53.66, -46.10] | 0.542 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 9066.1 | 4615.3 | -49.09 | [-53.69, -44.57] | [-52.87, -45.24] | 0.537 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 15691.5 | 8350.0 | -46.79 | [-52.81, -40.18] | [-51.86, -41.16] | 0.609 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 24369.0 | 12141.5 | -50.18 | [-55.48, -44.04] | [-54.70, -45.13] | 0.531 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 28460.3 | 14723.4 | -48.27 | [-53.70, -42.07] | [-52.86, -43.17] | 0.569 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 29904.4 | 17202.4 | -42.48 | [-48.40, -35.88] | [-47.38, -36.96] | 0.624 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.8329 | 1.7983 | -1.89 | [-3.46, -0.32] | [-3.20, -0.57] | 0.985 | 0.0272 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 1.5118 | 1.4977 | -0.94 | [-2.46, +0.61] | [-2.21, +0.35] | 0.992 | 0.2359 | no material change |
| broker_user_s | 60 | 0.5169 | 0.4960 | -4.04 | [-6.61, -1.45] | [-6.17, -1.83] | 0.966 | 0.0055 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.6056 | 0.5798 | -4.25 | [-7.53, -0.89] | [-6.98, -1.40] | 0.949 | 0.0252 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 1.1225 | 1.0759 | -4.15 | [-6.09, -2.29] | [-5.75, -2.60] | 0.967 | 0.0001 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 13586.2 | 13705.0 | +0.87 | [-0.26, +2.01] | [-0.08, +1.82] | 1.010 | 0.1230 | no material change |
| broker_maxrss_kib | 60 | 5715 | 5101 | -10.74 | [-12.49, -9.00] | [-12.22, -9.26] | 0.890 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9239 | 0.9159 | -0.0189 | [-0.0334, -0.0043] |
| single_rtt_mean_us | 184.7 | 183.1 | -3.8 | [-6.7, -0.9] |
| single_rtt_p50_us | 174.3 | 173.2 | -2.7 | [-5.3, -0.2] |
| single_rtt_p90_us | 217.0 | 213.1 | -4.6 | [-9.1, -0.1] |
| single_rtt_p99_us | 310.8 | 298.9 | -19.2 | [-34.0, -4.3] |
| single_rtt_p999_us | 869.9 | 743.4 | -146.1 | [-280.5, -11.6] |
| single_rtt_max_us | 2421.8 | 2416.4 | -1648.6 | [-4512.9, +1215.8] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7485 | 0.7465 | +0.0007 | [-0.0237, +0.0251] |
| multi_rtt_mean_us | 725.1 | 721.8 | -0.0 | [-24.1, +24.1] |
| multi_rtt_p50_us | 673.9 | 669.6 | +0.3 | [-18.4, +18.9] |
| multi_rtt_p90_us | 942.5 | 949.5 | +2.2 | [-51.4, +55.7] |
| multi_rtt_p99_us | 1424.3 | 1456.4 | +26.0 | [-96.0, +148.0] |
| multi_rtt_p999_us | 2485.5 | 2319.7 | -148.2 | [-650.1, +353.7] |
| multi_rtt_max_us | 3263.7 | 3186.6 | -185.2 | [-1774.0, +1403.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.1149 | 0.1013 | -0.0157 | [-0.0208, -0.0106] |
| fanout_delivery_mean_us | 9200.4 | 4913.4 | -4899.4 | [-5724.3, -4074.5] |
| fanout_delivery_p50_us | 8408.1 | 4635.0 | -4450.8 | [-5212.1, -3689.6] |
| fanout_delivery_p90_us | 14252.0 | 8202.9 | -7341.5 | [-9181.7, -5501.3] |
| fanout_delivery_p99_us | 21186.9 | 11833.2 | -12227.5 | [-14932.0, -9522.9] |
| fanout_delivery_p999_us | 25294.7 | 14251.2 | -13736.9 | [-16828.8, -10645.0] |
| fanout_delivery_max_us | 27447.0 | 16914.1 | -12702.1 | [-15832.7, -9571.4] |
| client_wall_s | 1.8244 | 1.8011 | -0.0346 | [-0.0646, -0.0047] |
| client_cpu_s | 1.5045 | 1.4963 | -0.0142 | [-0.0380, +0.0096] |
| broker_user_s | 0.5113 | 0.4945 | -0.0209 | [-0.0348, -0.0069] |
| broker_sys_s | 0.5972 | 0.5756 | -0.0257 | [-0.0469, -0.0045] |
| broker_cpu_s | 1.1154 | 1.0807 | -0.0466 | [-0.0687, -0.0245] |
| broker_vcsw | 13609.0 | 13749.5 | +118.8 | [-38.5, +276.2] |
| broker_maxrss_kib | 5646 | 5106 | -614 | [-728, -499] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
