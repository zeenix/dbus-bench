candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9268 | 0.9126 | -1.53 | [-2.98, -0.03] | [-2.76, -0.26] | 0.971 | 0.0585 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 185.3 | 182.4 | -1.53 | [-2.98, -0.02] | [-2.76, -0.26] | 0.971 | 0.0585 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 173.8 | 171.8 | -1.19 | [-2.55, +0.22] | [-2.33, +0.00] | 0.987 | 0.0760 | no material change |
| single_rtt_p90_us | 60 | 218.3 | 214.5 | -1.74 | [-3.79, +0.35] | [-3.45, +0.01] | 0.972 | 0.0918 | no material change |
| single_rtt_p99_us | 60 | 314.0 | 299.5 | -4.62 | [-8.48, -0.56] | [-7.92, -1.19] | 0.964 | 0.0445 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 893.2 | 803.2 | -10.08 | [-21.15, +1.70] | [-19.42, -0.11] | 0.944 | 0.2695 | inconclusive |
| single_rtt_max_us | 60 | 3611.4 | 2750.4 | -23.84 | [-43.69, +2.81] | [-40.88, -1.61] | 0.847 | 0.2925 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7614 | 0.7514 | -1.31 | [-4.20, +1.61] | [-3.69, +1.11] | 0.994 | 0.4483 | no material change |
| multi_rtt_mean_us | 60 | 736.0 | 726.8 | -1.24 | [-4.17, +1.72] | [-3.65, +1.23] | 0.992 | 0.4797 | no material change |
| multi_rtt_p50_us | 60 | 701.7 | 694.4 | -1.04 | [-3.32, +1.29] | [-2.94, +0.93] | 1.003 | 0.5510 | no material change |
| multi_rtt_p90_us | 60 | 952.7 | 950.9 | -0.19 | [-6.03, +5.84] | [-5.11, +4.85] | 1.018 | 0.8195 | inconclusive |
| multi_rtt_p99_us | 60 | 1526.1 | 1465.1 | -4.00 | [-11.89, +4.31] | [-10.59, +2.88] | 0.991 | 0.4661 | inconclusive |
| multi_rtt_p999_us | 60 | 3436.2 | 2656.7 | -22.69 | [-34.68, -7.93] | [-32.80, -10.31] | 0.806 | 0.0058 | faster/smaller |
| multi_rtt_max_us | 60 | 5775.5 | 4334.6 | -24.95 | [-49.59, +13.15] | [-46.34, +6.74] | 0.849 | 0.0646 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.1000 | 0.1013 | +1.31 | [-2.93, +5.64] | [-2.24, +4.96] | 1.044 | 0.3097 | no material change |
| fanout_delivery_mean_us | 60 | 5132.6 | 4902.9 | -4.48 | [-10.06, +1.57] | [-9.19, +0.50] | 0.947 | 0.0877 | inconclusive |
| fanout_delivery_p50_us | 60 | 5019.0 | 4615.3 | -8.04 | [-13.51, -2.16] | [-12.66, -3.19] | 0.909 | 0.0066 | inconclusive; repeatable change (-) |
| fanout_delivery_p90_us | 60 | 8306.1 | 8350.0 | +0.53 | [-4.85, +6.31] | [-4.00, +5.42] | 0.986 | 0.8424 | inconclusive |
| fanout_delivery_p99_us | 60 | 11502.0 | 12141.5 | +5.56 | [-1.15, +13.48] | [-0.22, +12.06] | 1.034 | 0.2600 | inconclusive |
| fanout_delivery_p999_us | 60 | 13895.3 | 14723.4 | +5.96 | [-0.26, +12.99] | [+0.60, +11.75] | 1.041 | 0.1732 | inconclusive |
| fanout_delivery_max_us | 60 | 15746.4 | 17202.4 | +9.25 | [+2.58, +17.01] | [+3.51, +15.62] | 1.093 | 0.0304 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 1.8252 | 1.7983 | -1.47 | [-2.88, -0.04] | [-2.64, -0.26] | 0.982 | 0.0304 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 1.5035 | 1.4977 | -0.39 | [-1.91, +1.16] | [-1.66, +0.91] | 0.996 | 0.6534 | no material change |
| broker_user_s | 60 | 0.4979 | 0.4960 | -0.37 | [-3.08, +2.44] | [-2.64, +1.99] | 0.994 | 0.9530 | no material change |
| broker_sys_s | 60 | 0.5997 | 0.5798 | -3.31 | [-6.54, +0.13] | [-6.03, -0.42] | 0.953 | 0.0238 | inconclusive |
| broker_cpu_s | 60 | 1.0976 | 1.0759 | -1.98 | [-3.71, -0.15] | [-3.45, -0.47] | 0.978 | 0.0196 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 13623.7 | 13705.0 | +0.60 | [-0.61, +1.81] | [-0.42, +1.62] | 1.002 | 0.4330 | no material change |
| broker_maxrss_kib | 60 | 5086 | 5101 | +0.30 | [-0.59, +1.18] | [-0.44, +1.04] | 1.007 | 0.4774 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9288 | 0.9159 | -0.0141 | [-0.0284, +0.0001] |
| single_rtt_mean_us | 185.7 | 183.1 | -2.8 | [-5.7, +0.0] |
| single_rtt_p50_us | 174.5 | 173.2 | -2.1 | [-4.6, +0.4] |
| single_rtt_p90_us | 217.8 | 213.1 | -3.8 | [-8.4, +0.8] |
| single_rtt_p99_us | 306.9 | 298.9 | -14.5 | [-27.8, -1.2] |
| single_rtt_p999_us | 849.6 | 743.4 | -90.0 | [-200.0, +20.0] |
| single_rtt_max_us | 2388.9 | 2416.4 | -861.0 | [-1954.9, +232.9] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7575 | 0.7465 | -0.0100 | [-0.0324, +0.0124] |
| multi_rtt_mean_us | 733.8 | 721.8 | -9.1 | [-31.1, +12.8] |
| multi_rtt_p50_us | 699.3 | 669.6 | -7.3 | [-24.0, +9.4] |
| multi_rtt_p90_us | 918.3 | 949.5 | -1.8 | [-59.5, +55.8] |
| multi_rtt_p99_us | 1488.0 | 1456.4 | -61.1 | [-189.1, +67.0] |
| multi_rtt_p999_us | 3012.0 | 2319.7 | -779.5 | [-1326.6, -232.4] |
| multi_rtt_max_us | 3803.6 | 3186.6 | -1440.8 | [-3801.4, +919.7] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.0982 | 0.1013 | +0.0013 | [-0.0030, +0.0056] |
| fanout_delivery_mean_us | 5187.1 | 4913.4 | -229.7 | [-537.7, +78.2] |
| fanout_delivery_p50_us | 5008.9 | 4635.0 | -403.6 | [-706.0, -101.3] |
| fanout_delivery_p90_us | 8146.5 | 8202.9 | +43.9 | [-425.1, +512.9] |
| fanout_delivery_p99_us | 11569.1 | 11833.2 | +639.5 | [-197.5, +1476.5] |
| fanout_delivery_p999_us | 13864.1 | 14251.2 | +828.1 | [-82.7, +1739.0] |
| fanout_delivery_max_us | 15577.8 | 16914.1 | +1456.0 | [+335.2, +2576.8] |
| client_wall_s | 1.8185 | 1.8011 | -0.0269 | [-0.0536, -0.0002] |
| client_cpu_s | 1.4969 | 1.4963 | -0.0059 | [-0.0294, +0.0176] |
| broker_user_s | 0.4977 | 0.4945 | -0.0018 | [-0.0161, +0.0124] |
| broker_sys_s | 0.5999 | 0.5756 | -0.0199 | [-0.0406, +0.0009] |
| broker_cpu_s | 1.0988 | 1.0807 | -0.0217 | [-0.0418, -0.0016] |
| broker_vcsw | 13664.0 | 13749.5 | +81.3 | [-89.0, +251.6] |
| broker_maxrss_kib | 5106 | 5106 | +15 | [-31, +61] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
