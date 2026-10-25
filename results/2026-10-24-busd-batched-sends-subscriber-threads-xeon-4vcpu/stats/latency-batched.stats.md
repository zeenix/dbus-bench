candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9078 | 0.9126 | +0.54 | [-1.04, +2.13] | [-0.79, +1.89] | 1.013 | 0.4752 | no material change |
| single_rtt_mean_us | 60 | 181.5 | 182.4 | +0.54 | [-1.04, +2.13] | [-0.79, +1.89] | 1.013 | 0.4752 | no material change |
| single_rtt_p50_us | 60 | 170.6 | 171.8 | +0.71 | [-0.83, +2.30] | [-0.59, +2.05] | 1.008 | 0.3536 | no material change |
| single_rtt_p90_us | 60 | 214.2 | 214.5 | +0.13 | [-1.93, +2.20] | [-1.57, +1.88] | 1.007 | 0.8138 | no material change |
| single_rtt_p99_us | 60 | 301.9 | 299.5 | -0.79 | [-6.41, +4.46] | [-5.52, +3.68] | 1.008 | 0.6167 | inconclusive |
| single_rtt_p999_us | 60 | 797.1 | 803.2 | +0.77 | [-16.23, +20.69] | [-13.78, +17.29] | 1.059 | 0.3972 | inconclusive |
| single_rtt_max_us | 60 | 2224.5 | 2750.4 | +23.64 | [+1.14, +51.79] | [+4.11, +46.83] | 1.378 | 0.0293 | inconclusive; repeatable change (+) |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7370 | 0.7514 | +1.97 | [-1.59, +5.44] | [-0.98, +4.90] | 1.034 | 0.2418 | no material change |
| multi_rtt_mean_us | 60 | 712.0 | 726.8 | +2.08 | [-1.52, +5.61] | [-0.91, +5.07] | 1.029 | 0.2302 | inconclusive |
| multi_rtt_p50_us | 60 | 686.5 | 694.4 | +1.16 | [-1.64, +3.98] | [-1.14, +3.52] | 1.015 | 0.3891 | no material change |
| multi_rtt_p90_us | 60 | 914.4 | 950.9 | +3.98 | [-2.06, +10.35] | [-1.13, +9.26] | 1.045 | 0.1641 | inconclusive |
| multi_rtt_p99_us | 60 | 1379.8 | 1465.1 | +6.18 | [-2.19, +14.93] | [-0.89, +13.45] | 1.063 | 0.1038 | inconclusive |
| multi_rtt_p999_us | 60 | 2604.3 | 2656.7 | +2.01 | [-13.64, +18.87] | [-11.33, +16.21] | 1.006 | 0.5910 | inconclusive |
| multi_rtt_max_us | 60 | 3739.7 | 4334.6 | +15.91 | [-14.15, +61.90] | [-10.82, +52.90] | 1.087 | 0.6375 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2961 | 0.1013 | -65.80 | [-67.92, -63.34] | [-67.57, -63.78] | 0.334 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 17345.6 | 4902.9 | -71.73 | [-73.64, -69.60] | [-73.35, -69.96] | 0.285 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 16526.9 | 4615.3 | -72.07 | [-74.06, -69.84] | [-73.76, -70.18] | 0.288 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 28326.2 | 8350.0 | -70.52 | [-72.60, -68.23] | [-72.29, -68.59] | 0.295 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 37178.6 | 12141.5 | -67.34 | [-70.12, -64.18] | [-69.68, -64.72] | 0.306 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 39630.0 | 14723.4 | -62.85 | [-65.82, -59.46] | [-65.37, -59.99] | 0.356 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 40444.8 | 17202.4 | -57.47 | [-61.02, -53.43] | [-60.47, -54.10] | 0.415 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.9775 | 1.7983 | -9.06 | [-10.77, -7.30] | [-10.51, -7.56] | 0.907 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.8239 | 1.4977 | -17.89 | [-19.62, -16.04] | [-19.34, -16.32] | 0.819 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5112 | 0.4960 | -2.97 | [-5.43, -0.40] | [-5.05, -0.82] | 0.956 | 0.0283 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.7684 | 0.5798 | -24.54 | [-27.57, -21.15] | [-27.14, -21.74] | 0.751 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2796 | 1.0759 | -15.92 | [-18.00, -13.75] | [-17.66, -14.08] | 0.834 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 13559.0 | 13705.0 | +1.08 | [-0.16, +2.37] | [+0.03, +2.15] | 1.005 | 0.1212 | no material change |
| broker_maxrss_kib | 60 | 5040 | 5101 | +1.21 | [+0.39, +2.05] | [+0.53, +1.91] | 1.014 | 0.0073 | no material change; repeatable change (+) |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9092 | 0.9159 | +0.0049 | [-0.0099, +0.0196] |
| single_rtt_mean_us | 181.8 | 183.1 | +1.0 | [-2.0, +3.9] |
| single_rtt_p50_us | 171.1 | 173.2 | +1.2 | [-1.5, +4.0] |
| single_rtt_p90_us | 213.4 | 213.1 | +0.3 | [-4.2, +4.7] |
| single_rtt_p99_us | 290.1 | 298.9 | -2.4 | [-19.5, +14.7] |
| single_rtt_p999_us | 687.9 | 743.4 | +6.1 | [-143.9, +156.2] |
| single_rtt_max_us | 1870.1 | 2416.4 | +526.0 | [+6.8, +1045.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7390 | 0.7465 | +0.0145 | [-0.0117, +0.0407] |
| multi_rtt_mean_us | 714.5 | 721.8 | +14.8 | [-10.8, +40.4] |
| multi_rtt_p50_us | 669.7 | 669.6 | +8.0 | [-11.4, +27.4] |
| multi_rtt_p90_us | 914.1 | 949.5 | +36.4 | [-20.5, +93.4] |
| multi_rtt_p99_us | 1327.0 | 1456.4 | +85.3 | [-32.3, +202.8] |
| multi_rtt_p999_us | 2267.5 | 2319.7 | +52.4 | [-388.1, +492.8] |
| multi_rtt_max_us | 3010.6 | 3186.6 | +595.0 | [-822.8, +2012.8] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2994 | 0.1013 | -0.1948 | [-0.2136, -0.1761] |
| fanout_delivery_mean_us | 17718.0 | 4913.4 | -12442.7 | [-13568.4, -11317.1] |
| fanout_delivery_p50_us | 17370.6 | 4635.0 | -11911.6 | [-13085.6, -10737.7] |
| fanout_delivery_p90_us | 28449.7 | 8202.9 | -19976.2 | [-21861.6, -18090.8] |
| fanout_delivery_p99_us | 36713.8 | 11833.2 | -25037.1 | [-27784.9, -22289.3] |
| fanout_delivery_p999_us | 38929.8 | 14251.2 | -24906.6 | [-27826.2, -21986.9] |
| fanout_delivery_max_us | 39365.5 | 16914.1 | -23242.5 | [-26279.1, -20205.8] |
| client_wall_s | 1.9682 | 1.8011 | -0.1792 | [-0.2172, -0.1412] |
| client_cpu_s | 1.8173 | 1.4963 | -0.3262 | [-0.3657, -0.2868] |
| broker_user_s | 0.5090 | 0.4945 | -0.0152 | [-0.0285, -0.0018] |
| broker_sys_s | 0.7664 | 0.5756 | -0.1886 | [-0.2195, -0.1576] |
| broker_cpu_s | 1.2662 | 1.0807 | -0.2038 | [-0.2355, -0.1720] |
| broker_vcsw | 13575.0 | 13749.5 | +146.0 | [-29.7, +321.8] |
| broker_maxrss_kib | 5072 | 5106 | +61 | [+18, +104] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
