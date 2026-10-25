candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3361 | 0.3354 | -0.19 | [-1.13, +0.75] | [-0.98, +0.60] | 1.003 | 0.6012 | no material change |
| single_rtt_mean_us | 60 | 65.8 | 65.6 | -0.19 | [-1.15, +0.76] | [-0.99, +0.61] | 1.003 | 0.6167 | no material change |
| single_rtt_p50_us | 60 | 61.9 | 61.9 | -0.00 | [-0.73, +0.64] | [-0.57, +0.55] | 1.000 | 0.8687 | no material change |
| single_rtt_p90_us | 60 | 77.4 | 77.5 | +0.15 | [-2.65, +3.10] | [-2.22, +2.63] | 1.000 | 0.8900 | no material change |
| single_rtt_p99_us | 60 | 121.5 | 121.6 | +0.11 | [-3.98, +4.40] | [-3.37, +3.73] | 1.019 | 0.7853 | no material change |
| single_rtt_p999_us | 60 | 223.9 | 221.6 | -1.05 | [-8.79, +7.68] | [-7.57, +6.18] | 0.984 | 0.8655 | inconclusive |
| single_rtt_max_us | 60 | 610.7 | 615.0 | +0.71 | [-21.80, +29.09] | [-18.55, +23.99] | 1.031 | 0.9092 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5062 | 0.5083 | +0.40 | [-0.39, +1.21] | [-0.26, +1.07] | 1.000 | 0.5461 | no material change |
| multi_rtt_mean_us | 60 | 501.6 | 502.9 | +0.25 | [-0.50, +1.01] | [-0.39, +0.88] | 1.000 | 0.7797 | no material change |
| multi_rtt_p50_us | 60 | 484.9 | 486.2 | +0.27 | [-0.24, +0.78] | [-0.16, +0.70] | 1.004 | 0.2905 | no material change |
| multi_rtt_p90_us | 60 | 545.4 | 546.7 | +0.25 | [-2.26, +2.82] | [-1.85, +2.44] | 0.993 | 0.9579 | no material change |
| multi_rtt_p99_us | 60 | 889.5 | 917.7 | +3.17 | [-0.62, +7.15] | [-0.04, +6.44] | 1.016 | 0.1707 | inconclusive |
| multi_rtt_p999_us | 60 | 1347.2 | 1388.0 | +3.03 | [-4.67, +11.43] | [-3.51, +10.10] | 1.044 | 0.3810 | inconclusive |
| multi_rtt_max_us | 60 | 1727.1 | 1761.2 | +1.98 | [-6.82, +12.27] | [-5.60, +10.53] | 1.015 | 0.7488 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2637 | 0.2642 | +0.19 | [-0.87, +1.33] | [-0.70, +1.13] | 0.994 | 0.8138 | no material change |
| fanout_delivery_mean_us | 60 | 58013.5 | 23626.8 | -59.27 | [-59.88, -58.66] | [-59.78, -58.76] | 0.410 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 59221.1 | 23513.5 | -60.30 | [-60.93, -59.63] | [-60.82, -59.73] | 0.396 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 91077.0 | 29004.0 | -68.15 | [-68.62, -67.67] | [-68.55, -67.74] | 0.316 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 98946.2 | 30700.6 | -68.97 | [-69.52, -68.36] | [-69.44, -68.47] | 0.304 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 100916.1 | 32135.2 | -68.16 | [-68.88, -67.38] | [-68.77, -67.50] | 0.308 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 101338.9 | 33346.1 | -67.09 | [-67.88, -66.26] | [-67.77, -66.40] | 0.330 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1448 | 1.1466 | +0.16 | [-0.39, +0.71] | [-0.31, +0.62] | 1.002 | 0.6587 | no material change |
| client_cpu_s | 60 | 0.9846 | 0.9874 | +0.29 | [-0.29, +0.87] | [-0.20, +0.77] | 1.003 | 0.3972 | no material change |
| broker_user_s | 60 | 0.3201 | 0.3177 | -0.74 | [-2.26, +0.80] | [-2.02, +0.55] | 0.991 | 0.3097 | no material change |
| broker_sys_s | 60 | 0.3416 | 0.3477 | +1.80 | [+0.04, +3.57] | [+0.31, +3.29] | 1.012 | 0.0760 | no material change; repeatable change (+) |
| broker_cpu_s | 60 | 0.6617 | 0.6654 | +0.57 | [-0.22, +1.35] | [-0.09, +1.22] | 1.003 | 0.2538 | no material change |
| broker_vcsw | 60 | 14334.3 | 14030.9 | -2.12 | [-2.50, -1.72] | [-2.44, -1.79] | 0.978 | <0.0001 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 8155 | 7071 | -13.30 | [-13.94, -12.62] | [-13.84, -12.74] | 0.865 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3345 | 0.3357 | -0.0006 | [-0.0039, +0.0026] |
| single_rtt_mean_us | 65.5 | 65.7 | -0.1 | [-0.8, +0.5] |
| single_rtt_p50_us | 61.7 | 61.7 | -0.0 | [-0.4, +0.4] |
| single_rtt_p90_us | 78.4 | 77.2 | +0.1 | [-2.2, +2.4] |
| single_rtt_p99_us | 123.5 | 121.1 | +0.1 | [-5.2, +5.5] |
| single_rtt_p999_us | 222.6 | 211.9 | -2.4 | [-21.5, +16.8] |
| single_rtt_max_us | 514.1 | 467.2 | +4.3 | [-153.2, +161.9] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5062 | 0.5081 | +0.0020 | [-0.0020, +0.0061] |
| multi_rtt_mean_us | 501.3 | 502.4 | +1.2 | [-2.6, +5.1] |
| multi_rtt_p50_us | 485.6 | 488.0 | +1.3 | [-1.2, +3.8] |
| multi_rtt_p90_us | 534.3 | 536.7 | +1.4 | [-12.9, +15.7] |
| multi_rtt_p99_us | 890.5 | 922.5 | +28.2 | [-6.3, +62.7] |
| multi_rtt_p999_us | 1261.5 | 1301.9 | +40.8 | [-69.5, +151.0] |
| multi_rtt_max_us | 1666.4 | 1617.7 | +34.1 | [-134.2, +202.4] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2631 | 0.2617 | +0.0005 | [-0.0025, +0.0035] |
| fanout_delivery_mean_us | 57979.0 | 23527.8 | -34386.7 | [-35048.2, -33725.2] |
| fanout_delivery_p50_us | 58629.1 | 23236.4 | -35707.5 | [-36471.6, -34943.5] |
| fanout_delivery_p90_us | 91517.2 | 28603.7 | -62073.0 | [-63032.7, -61113.3] |
| fanout_delivery_p99_us | 98669.6 | 29918.0 | -68245.6 | [-69231.3, -67259.9] |
| fanout_delivery_p999_us | 100302.8 | 31465.7 | -68780.9 | [-70056.6, -67505.2] |
| fanout_delivery_max_us | 100378.7 | 33399.2 | -67992.8 | [-69380.9, -66604.8] |
| client_wall_s | 1.1485 | 1.1484 | +0.0018 | [-0.0046, +0.0082] |
| client_cpu_s | 0.9854 | 0.9892 | +0.0029 | [-0.0030, +0.0087] |
| broker_user_s | 0.3190 | 0.3166 | -0.0024 | [-0.0074, +0.0026] |
| broker_sys_s | 0.3398 | 0.3444 | +0.0061 | [+0.0000, +0.0123] |
| broker_cpu_s | 0.6634 | 0.6643 | +0.0038 | [-0.0016, +0.0091] |
| broker_vcsw | 14348.5 | 14023.0 | -303.4 | [-362.6, -244.2] |
| broker_maxrss_kib | 8204 | 7060 | -1085 | [-1147, -1022] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
