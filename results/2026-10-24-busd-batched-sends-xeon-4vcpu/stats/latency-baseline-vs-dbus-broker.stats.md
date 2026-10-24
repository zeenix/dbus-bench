candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9536 | 0.9503 | -0.34 | [-1.86, +1.20] | [-1.62, +0.93] | 0.992 | 0.6587 | no material change |
| single_rtt_mean_us | 60 | 190.6 | 190.0 | -0.34 | [-1.86, +1.20] | [-1.62, +0.93] | 0.992 | 0.6587 | no material change |
| single_rtt_p50_us | 60 | 180.6 | 179.1 | -0.85 | [-2.42, +0.76] | [-2.18, +0.51] | 0.992 | 0.2302 | no material change |
| single_rtt_p90_us | 60 | 232.7 | 227.2 | -2.36 | [-4.04, -0.66] | [-3.77, -0.96] | 0.975 | 0.0161 | no material change; repeatable change (-) |
| single_rtt_p99_us | 60 | 338.5 | 332.4 | -1.81 | [-5.20, +1.78] | [-4.65, +1.20] | 0.982 | 0.4352 | no material change |
| single_rtt_p999_us | 60 | 1041.8 | 961.6 | -7.70 | [-18.61, +5.27] | [-16.96, +3.07] | 0.945 | 0.2330 | inconclusive |
| single_rtt_max_us | 60 | 3520.8 | 2763.8 | -21.50 | [-40.35, +3.67] | [-37.56, -0.65] | 0.822 | 0.1709 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.3239 | 0.8090 | -38.89 | [-41.06, -36.52] | [-40.72, -36.92] | 0.607 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1282.9 | 783.1 | -38.96 | [-41.13, -36.58] | [-40.79, -36.96] | 0.608 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1217.1 | 743.0 | -38.95 | [-41.34, -36.18] | [-41.01, -36.65] | 0.591 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1876.3 | 1051.3 | -43.97 | [-46.68, -41.10] | [-46.23, -41.59] | 0.570 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2697.1 | 1593.1 | -40.93 | [-44.40, -37.26] | [-43.82, -37.88] | 0.609 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 4360.1 | 3034.9 | -30.39 | [-37.87, -22.14] | [-36.71, -23.55] | 0.685 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 5956.1 | 4092.9 | -31.28 | [-41.03, -20.13] | [-39.59, -21.89] | 0.642 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3588 | 0.3132 | -12.70 | [-16.17, -8.94] | [-15.69, -9.57] | 0.848 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 73081.7 | 27804.6 | -61.95 | [-63.56, -60.18] | [-63.36, -60.47] | 0.371 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 74208.9 | 27482.5 | -62.97 | [-64.74, -61.05] | [-64.48, -61.36] | 0.359 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 119817.1 | 36111.3 | -69.86 | [-71.61, -67.93] | [-71.33, -68.24] | 0.286 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 133571.0 | 41635.0 | -68.83 | [-70.76, -66.68] | [-70.49, -67.04] | 0.294 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 139315.7 | 43214.3 | -68.98 | [-71.01, -66.69] | [-70.72, -67.10] | 0.298 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 140389.7 | 44706.3 | -68.16 | [-70.22, -65.86] | [-69.92, -66.24] | 0.301 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.6500 | 2.0939 | -20.98 | [-22.69, -19.19] | [-22.42, -19.50] | 0.785 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.2844 | 1.5862 | -30.57 | [-32.22, -28.84] | [-31.94, -29.14] | 0.683 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2688 | 0.5477 | +103.72 | [+95.66, +112.37] | [+96.91, +110.81] | 2.073 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.7600 | 0.6476 | -14.78 | [-17.03, -12.46] | [-16.69, -12.85] | 0.865 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.0288 | 1.1953 | +16.18 | [+13.93, +18.60] | [+14.30, +18.18] | 1.152 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 52650.1 | 13415.5 | -74.52 | [-74.99, -74.03] | [-74.92, -74.11] | 0.254 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11217 | 5083 | -54.69 | [-54.91, -54.47] | [-54.88, -54.50] | 0.454 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9464 | 0.9489 | -0.0033 | [-0.0180, +0.0115] |
| single_rtt_mean_us | 189.2 | 189.7 | -0.7 | [-3.6, +2.3] |
| single_rtt_p50_us | 180.8 | 177.9 | -1.5 | [-4.5, +1.4] |
| single_rtt_p90_us | 231.9 | 227.0 | -5.5 | [-9.5, -1.5] |
| single_rtt_p99_us | 340.7 | 331.3 | -6.1 | [-18.4, +6.2] |
| single_rtt_p999_us | 963.4 | 948.2 | -80.2 | [-214.0, +53.6] |
| single_rtt_max_us | 2381.2 | 2343.7 | -757.0 | [-1707.5, +193.6] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.3008 | 0.7962 | -0.5149 | [-0.5550, -0.4748] |
| multi_rtt_mean_us | 1264.7 | 769.6 | -499.8 | [-538.9, -460.7] |
| multi_rtt_p50_us | 1215.2 | 729.9 | -474.1 | [-515.3, -432.9] |
| multi_rtt_p90_us | 1845.4 | 1085.0 | -825.0 | [-901.1, -748.9] |
| multi_rtt_p99_us | 2670.1 | 1557.7 | -1104.0 | [-1233.9, -974.2] |
| multi_rtt_p999_us | 3858.3 | 2694.6 | -1325.2 | [-1740.2, -910.2] |
| multi_rtt_max_us | 5330.6 | 3472.8 | -1863.1 | [-2630.1, -1096.1] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3488 | 0.2975 | -0.0456 | [-0.0596, -0.0315] |
| fanout_delivery_mean_us | 70828.6 | 26330.7 | -45277.0 | [-47440.6, -43113.4] |
| fanout_delivery_p50_us | 71659.7 | 25965.5 | -46726.4 | [-49144.2, -44308.6] |
| fanout_delivery_p90_us | 113307.6 | 33593.7 | -83705.8 | [-88774.7, -78636.9] |
| fanout_delivery_p99_us | 127239.5 | 39047.7 | -91936.0 | [-97191.0, -86681.0] |
| fanout_delivery_p999_us | 133625.9 | 40398.0 | -96101.4 | [-101615.5, -90587.2] |
| fanout_delivery_max_us | 134281.5 | 40483.2 | -95683.4 | [-101201.7, -90165.1] |
| client_wall_s | 2.6260 | 2.0715 | -0.5561 | [-0.6094, -0.5028] |
| client_cpu_s | 2.2708 | 1.5598 | -0.6983 | [-0.7449, -0.6517] |
| broker_user_s | 0.2676 | 0.5372 | +0.2788 | [+0.2631, +0.2945] |
| broker_sys_s | 0.7528 | 0.6468 | -0.1124 | [-0.1313, -0.0934] |
| broker_cpu_s | 1.0288 | 1.1810 | +0.1665 | [+0.1432, +0.1897] |
| broker_vcsw | 52963.0 | 13516.5 | -39234.6 | [-40199.8, -38269.4] |
| broker_maxrss_kib | 11206 | 5084 | -6134 | [-6175, -6093] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
