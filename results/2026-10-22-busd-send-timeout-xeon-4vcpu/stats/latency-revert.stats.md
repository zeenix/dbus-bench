candidate revert against baseline baseline, from latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.7254 | 0.7199 | -0.75 | [-3.83, +2.15] | [-3.36, +1.68] | 1.004 | 0.8367 | no material change |
| single_rtt_mean_us | 60 | 145.0 | 143.9 | -0.75 | [-3.83, +2.15] | [-3.36, +1.68] | 1.004 | 0.8367 | no material change |
| single_rtt_p50_us | 60 | 131.4 | 130.4 | -0.82 | [-2.35, +0.77] | [-2.13, +0.51] | 0.989 | 0.2695 | no material change |
| single_rtt_p90_us | 60 | 169.1 | 168.4 | -0.44 | [-3.67, +2.84] | [-3.15, +2.33] | 1.007 | 0.9062 | no material change |
| single_rtt_p99_us | 60 | 335.4 | 315.4 | -5.98 | [-23.03, +8.81] | [-20.13, +7.39] | 1.017 | 0.5267 | inconclusive |
| single_rtt_p999_us | 60 | 1459.9 | 1344.6 | -7.90 | [-31.71, +22.02] | [-28.32, +17.48] | 1.062 | 0.6167 | inconclusive |
| single_rtt_max_us | 60 | 6544.2 | 7315.9 | +11.79 | [-33.28, +88.66] | [-27.45, +73.30] | 0.933 | 0.9883 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7542 | 0.7168 | -4.95 | [-10.27, +0.07] | [-9.36, -0.72] | 0.978 | 0.2759 | inconclusive |
| multi_rtt_mean_us | 60 | 730.9 | 689.9 | -5.61 | [-10.90, -0.69] | [-9.97, -1.44] | 0.973 | 0.1575 | inconclusive; repeatable change (-) |
| multi_rtt_p50_us | 60 | 659.6 | 640.6 | -2.88 | [-8.03, +1.31] | [-7.22, +0.77] | 1.008 | 0.8946 | inconclusive |
| multi_rtt_p90_us | 60 | 1003.7 | 903.7 | -9.97 | [-17.54, -2.03] | [-16.30, -3.32] | 0.952 | 0.1069 | inconclusive; repeatable change (-) |
| multi_rtt_p99_us | 60 | 2032.3 | 1701.8 | -16.26 | [-25.86, -5.61] | [-24.33, -7.38] | 0.795 | 0.0055 | faster/smaller |
| multi_rtt_p999_us | 60 | 4466.9 | 4218.7 | -5.55 | [-27.06, +29.48] | [-24.52, +22.47] | 0.813 | 0.0204 | inconclusive |
| multi_rtt_max_us | 60 | 7299.1 | 6689.7 | -8.35 | [-37.52, +34.26] | [-33.67, +25.95] | 0.941 | 0.1756 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2693 | 0.2567 | -4.69 | [-8.36, -0.82] | [-7.80, -1.43] | 0.936 | 0.0046 | inconclusive; repeatable change (-) |
| fanout_delivery_mean_us | 60 | 58706.1 | 22869.1 | -61.04 | [-62.51, -59.47] | [-62.29, -59.70] | 0.383 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 59704.1 | 22483.2 | -62.34 | [-63.89, -60.71] | [-63.64, -60.96] | 0.375 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 92487.1 | 28775.1 | -68.89 | [-70.47, -67.13] | [-70.23, -67.44] | 0.307 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 101684.4 | 32932.2 | -67.61 | [-69.50, -65.60] | [-69.19, -65.95] | 0.324 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 104818.9 | 34460.0 | -67.12 | [-68.98, -65.15] | [-68.70, -65.48] | 0.323 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 105691.2 | 35360.7 | -66.54 | [-68.38, -64.60] | [-68.10, -64.91] | 0.338 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.7685 | 1.7108 | -3.26 | [-6.47, -0.30] | [-5.94, -0.74] | 0.986 | 0.0657 | inconclusive; repeatable change (-) |
| client_cpu_s | 60 | 1.3513 | 1.3211 | -2.23 | [-5.60, +0.46] | [-5.01, +0.10] | 0.995 | 0.3972 | inconclusive |
| broker_user_s | 60 | 0.4588 | 0.4318 | -5.88 | [-9.31, -2.30] | [-8.79, -2.86] | 0.957 | 0.0038 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.5285 | 0.5196 | -1.67 | [-5.16, +1.87] | [-4.58, +1.31] | 0.981 | 0.4181 | no material change |
| broker_cpu_s | 60 | 0.9873 | 0.9515 | -3.63 | [-6.48, -0.79] | [-5.97, -1.27] | 0.974 | 0.0100 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 13820.8 | 13560.5 | -1.88 | [-3.96, -0.01] | [-3.61, -0.27] | 0.986 | 0.0810 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 6305 | 5000 | -20.69 | [-21.41, -19.96] | [-21.29, -20.08] | 0.789 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.7119 | 0.7131 | -0.0055 | [-0.0281, +0.0171] |
| single_rtt_mean_us | 142.3 | 142.5 | -1.1 | [-5.6, +3.4] |
| single_rtt_p50_us | 130.2 | 129.2 | -1.1 | [-3.2, +1.0] |
| single_rtt_p90_us | 165.7 | 166.1 | -0.7 | [-6.4, +4.9] |
| single_rtt_p99_us | 299.0 | 303.6 | -20.0 | [-83.7, +43.7] |
| single_rtt_p999_us | 1151.7 | 1172.9 | -115.3 | [-561.7, +331.1] |
| single_rtt_max_us | 3918.7 | 3592.3 | +771.7 | [-2918.4, +4461.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7011 | 0.7145 | -0.0373 | [-0.0795, +0.0049] |
| multi_rtt_mean_us | 679.5 | 687.6 | -41.0 | [-81.5, -0.4] |
| multi_rtt_p50_us | 623.5 | 626.1 | -19.0 | [-52.6, +14.5] |
| multi_rtt_p90_us | 920.8 | 877.1 | -100.1 | [-187.7, -12.4] |
| multi_rtt_p99_us | 1883.3 | 1654.9 | -330.5 | [-571.7, -89.3] |
| multi_rtt_p999_us | 3918.1 | 3596.0 | -248.1 | [-1580.9, +1084.6] |
| multi_rtt_max_us | 5713.6 | 4959.5 | -609.4 | [-3419.5, +2200.7] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2619 | 0.2482 | -0.0126 | [-0.0235, -0.0018] |
| fanout_delivery_mean_us | 58278.9 | 22038.1 | -35837.0 | [-37635.0, -34039.0] |
| fanout_delivery_p50_us | 57776.8 | 21539.1 | -37220.9 | [-39274.6, -35167.2] |
| fanout_delivery_p90_us | 88753.1 | 27407.2 | -63712.0 | [-67360.9, -60063.2] |
| fanout_delivery_p99_us | 96865.0 | 32074.5 | -68752.2 | [-73181.0, -64323.4] |
| fanout_delivery_p999_us | 99621.1 | 34146.3 | -70358.9 | [-74889.0, -65828.8] |
| fanout_delivery_max_us | 99718.4 | 34346.9 | -70330.5 | [-74869.2, -65791.8] |
| client_wall_s | 1.7101 | 1.7197 | -0.0577 | [-0.1158, +0.0003] |
| client_cpu_s | 1.3085 | 1.3268 | -0.0302 | [-0.0741, +0.0137] |
| broker_user_s | 0.4455 | 0.4242 | -0.0270 | [-0.0442, -0.0098] |
| broker_sys_s | 0.5171 | 0.5110 | -0.0088 | [-0.0282, +0.0106] |
| broker_cpu_s | 0.9611 | 0.9390 | -0.0358 | [-0.0652, -0.0064] |
| broker_vcsw | 13822.5 | 13691.5 | -260.3 | [-549.8, +29.2] |
| broker_maxrss_kib | 6348 | 4998 | -1304 | [-1361, -1248] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
