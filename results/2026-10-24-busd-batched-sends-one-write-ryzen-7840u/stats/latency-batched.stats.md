candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3354 | 0.3386 | +0.94 | [+0.10, +1.79] | [+0.23, +1.66] | 1.006 | 0.0585 | no material change; repeatable change (+) |
| single_rtt_mean_us | 60 | 65.6 | 66.3 | +0.96 | [+0.11, +1.83] | [+0.24, +1.69] | 1.006 | 0.0556 | no material change; repeatable change (+) |
| single_rtt_p50_us | 60 | 61.9 | 62.4 | +0.80 | [-0.06, +1.73] | [+0.06, +1.57] | 1.000 | 0.1524 | no material change |
| single_rtt_p90_us | 60 | 77.5 | 78.7 | +1.48 | [-1.05, +4.05] | [-0.63, +3.60] | 1.015 | 0.3083 | no material change |
| single_rtt_p99_us | 60 | 121.6 | 124.9 | +2.70 | [-1.11, +6.63] | [-0.50, +5.96] | 1.020 | 0.1790 | inconclusive |
| single_rtt_p999_us | 60 | 221.6 | 224.4 | +1.25 | [-6.93, +9.84] | [-5.59, +8.36] | 1.048 | 0.6721 | inconclusive |
| single_rtt_max_us | 60 | 615.0 | 553.9 | -9.94 | [-27.52, +13.16] | [-25.14, +8.77] | 0.986 | 0.6115 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5083 | 0.5056 | -0.53 | [-1.42, +0.36] | [-1.27, +0.21] | 0.995 | 0.3275 | no material change |
| multi_rtt_mean_us | 60 | 502.9 | 500.7 | -0.43 | [-1.28, +0.43] | [-1.14, +0.29] | 0.996 | 0.4395 | no material change |
| multi_rtt_p50_us | 60 | 486.2 | 486.1 | -0.04 | [-0.60, +0.56] | [-0.52, +0.46] | 1.000 | 0.8193 | no material change |
| multi_rtt_p90_us | 60 | 546.7 | 537.7 | -1.65 | [-4.09, +0.89] | [-3.72, +0.49] | 0.993 | 0.2418 | no material change |
| multi_rtt_p99_us | 60 | 917.7 | 895.7 | -2.40 | [-5.59, +1.06] | [-5.07, +0.46] | 0.982 | 0.1239 | inconclusive |
| multi_rtt_p999_us | 60 | 1388.0 | 1295.2 | -6.68 | [-14.67, +2.08] | [-13.49, +0.66] | 0.952 | 0.1038 | inconclusive |
| multi_rtt_max_us | 60 | 1761.2 | 1642.1 | -6.76 | [-15.37, +2.22] | [-13.98, +0.72] | 0.966 | 0.1827 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2642 | 0.2460 | -6.86 | [-7.98, -5.84] | [-7.79, -6.00] | 0.938 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 23626.8 | 27376.6 | +15.87 | [+13.94, +17.71] | [+14.27, +17.41] | 1.168 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 23513.5 | 27871.2 | +18.53 | [+16.53, +20.48] | [+16.87, +20.17] | 1.183 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 29004.0 | 32880.5 | +13.37 | [+11.45, +15.19] | [+11.76, +14.90] | 1.139 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 30700.6 | 36553.1 | +19.06 | [+16.13, +21.87] | [+16.57, +21.45] | 1.238 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 32135.2 | 38349.3 | +19.34 | [+16.05, +22.52] | [+16.57, +22.03] | 1.220 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 33346.1 | 38965.9 | +16.85 | [+13.78, +19.90] | [+14.28, +19.40] | 1.165 | <0.0001 | slower/larger |
| client_wall_s | 60 | 1.1466 | 1.1273 | -1.68 | [-2.31, -1.05] | [-2.20, -1.16] | 0.983 | <0.0001 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 0.9874 | 0.9689 | -1.88 | [-2.54, -1.22] | [-2.42, -1.33] | 0.979 | <0.0001 | no material change; repeatable change (-) |
| broker_user_s | 60 | 0.3177 | 0.3027 | -4.72 | [-6.26, -3.10] | [-6.04, -3.39] | 0.954 | <0.0001 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.3477 | 0.3019 | -13.17 | [-14.77, -11.51] | [-14.51, -11.78] | 0.871 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6654 | 0.6046 | -9.14 | [-9.93, -8.33] | [-9.82, -8.45] | 0.904 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14030.9 | 14002.9 | -0.20 | [-0.59, +0.18] | [-0.52, +0.12] | 1.000 | 0.5123 | no material change |
| broker_maxrss_kib | 60 | 7071 | 7094 | +0.33 | [-0.16, +0.81] | [-0.08, +0.73] | 1.003 | 0.1400 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3357 | 0.3382 | +0.0032 | [+0.0002, +0.0061] |
| single_rtt_mean_us | 65.7 | 66.2 | +0.6 | [+0.0, +1.2] |
| single_rtt_p50_us | 61.7 | 61.7 | +0.5 | [-0.1, +1.1] |
| single_rtt_p90_us | 77.2 | 77.2 | +1.1 | [-0.9, +3.2] |
| single_rtt_p99_us | 121.1 | 127.0 | +3.3 | [-1.5, +8.0] |
| single_rtt_p999_us | 211.9 | 210.2 | +2.8 | [-16.3, +21.9] |
| single_rtt_max_us | 467.2 | 503.4 | -61.1 | [-200.0, +77.8] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5081 | 0.5067 | -0.0027 | [-0.0074, +0.0019] |
| multi_rtt_mean_us | 502.4 | 502.0 | -2.2 | [-6.6, +2.3] |
| multi_rtt_p50_us | 488.0 | 488.6 | -0.2 | [-3.1, +2.7] |
| multi_rtt_p90_us | 536.7 | 528.9 | -9.0 | [-23.2, +5.2] |
| multi_rtt_p99_us | 922.5 | 916.6 | -22.0 | [-53.9, +9.9] |
| multi_rtt_p999_us | 1301.9 | 1202.2 | -92.7 | [-219.6, +34.1] |
| multi_rtt_max_us | 1617.7 | 1491.9 | -119.1 | [-287.0, +48.9] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2617 | 0.2456 | -0.0181 | [-0.0211, -0.0151] |
| fanout_delivery_mean_us | 23527.8 | 27491.0 | +3749.8 | [+3326.0, +4173.6] |
| fanout_delivery_p50_us | 23236.4 | 27595.0 | +4357.6 | [+3916.8, +4798.5] |
| fanout_delivery_p90_us | 28603.7 | 32546.7 | +3876.6 | [+3355.2, +4397.9] |
| fanout_delivery_p99_us | 29918.0 | 36987.3 | +5852.5 | [+5012.4, +6692.6] |
| fanout_delivery_p999_us | 31465.7 | 38085.6 | +6214.0 | [+5259.1, +7169.0] |
| fanout_delivery_max_us | 33399.2 | 38605.0 | +5619.8 | [+4682.6, +6557.0] |
| client_wall_s | 1.1484 | 1.1296 | -0.0193 | [-0.0268, -0.0118] |
| client_cpu_s | 0.9892 | 0.9717 | -0.0186 | [-0.0253, -0.0118] |
| broker_user_s | 0.3166 | 0.3015 | -0.0150 | [-0.0203, -0.0097] |
| broker_sys_s | 0.3444 | 0.3028 | -0.0458 | [-0.0521, -0.0395] |
| broker_cpu_s | 0.6643 | 0.6029 | -0.0608 | [-0.0667, -0.0549] |
| broker_vcsw | 14023.0 | 14025.0 | -28.0 | [-83.2, +27.3] |
| broker_maxrss_kib | 7060 | 7084 | +23 | [-12, +58] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
