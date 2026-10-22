candidate concurrent100 against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.6870 | 0.6821 | -0.72 | [-2.35, +0.86] | [-2.08, +0.58] | 0.992 | 0.5758 | no material change |
| single_rtt_mean_us | 60 | 137.3 | 136.3 | -0.72 | [-2.36, +0.85] | [-2.08, +0.58] | 0.992 | 0.5658 | no material change |
| single_rtt_p50_us | 60 | 127.8 | 125.9 | -1.51 | [-2.86, -0.16] | [-2.64, -0.38] | 0.978 | 0.0460 | no material change; repeatable change (-) |
| single_rtt_p90_us | 60 | 158.2 | 156.5 | -1.03 | [-2.95, +0.86] | [-2.63, +0.56] | 0.989 | 0.3239 | no material change |
| single_rtt_p99_us | 60 | 260.8 | 270.7 | +3.78 | [-3.09, +10.57] | [-1.89, +9.44] | 1.046 | 0.1851 | inconclusive |
| single_rtt_p999_us | 60 | 942.4 | 963.5 | +2.24 | [-9.33, +15.32] | [-7.54, +12.90] | 1.030 | 0.4889 | inconclusive |
| single_rtt_max_us | 60 | 4199.3 | 6872.2 | +63.65 | [-24.88, +228.47] | [-14.71, +196.62] | 0.932 | 0.9413 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.6647 | 0.6586 | -0.91 | [-3.51, +1.75] | [-3.09, +1.28] | 0.993 | 0.7019 | no material change |
| multi_rtt_mean_us | 60 | 643.5 | 635.7 | -1.21 | [-3.81, +1.44] | [-3.40, +0.97] | 0.989 | 0.5124 | no material change |
| multi_rtt_p50_us | 60 | 608.4 | 602.4 | -0.98 | [-3.39, +1.43] | [-2.97, +1.00] | 0.994 | 0.6271 | no material change |
| multi_rtt_p90_us | 60 | 833.1 | 820.0 | -1.57 | [-5.83, +2.71] | [-5.14, +2.00] | 0.984 | 0.7460 | inconclusive |
| multi_rtt_p99_us | 60 | 1418.4 | 1405.4 | -0.92 | [-7.43, +5.99] | [-6.41, +4.87] | 0.990 | 0.6640 | inconclusive |
| multi_rtt_p999_us | 60 | 3140.5 | 3129.4 | -0.36 | [-12.98, +14.29] | [-11.19, +11.91] | 1.042 | 0.9648 | inconclusive |
| multi_rtt_max_us | 60 | 4806.1 | 5526.8 | +14.99 | [-20.92, +71.66] | [-16.87, +60.89] | 1.077 | 0.4843 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2492 | 0.2394 | -3.93 | [-6.94, -0.86] | [-6.48, -1.37] | 0.970 | 0.0080 | inconclusive; repeatable change (-) |
| fanout_delivery_mean_us | 60 | 54698.7 | 21363.9 | -60.94 | [-62.23, -59.61] | [-62.04, -59.84] | 0.398 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 56451.7 | 21068.2 | -62.68 | [-64.19, -61.13] | [-63.96, -61.39] | 0.384 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 85919.9 | 26592.0 | -69.05 | [-70.34, -67.70] | [-70.15, -67.92] | 0.313 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 94109.2 | 30241.6 | -67.87 | [-69.79, -65.48] | [-69.55, -65.92] | 0.308 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 96679.0 | 31479.5 | -67.44 | [-69.48, -65.04] | [-69.19, -65.46] | 0.310 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 97487.8 | 32301.4 | -66.87 | [-68.87, -64.47] | [-68.58, -64.92] | 0.322 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.6178 | 1.5975 | -1.26 | [-2.73, +0.24] | [-2.49, -0.03] | 0.990 | 0.0748 | no material change |
| client_cpu_s | 60 | 1.2584 | 1.2458 | -1.00 | [-2.72, +0.70] | [-2.44, +0.41] | 0.997 | 0.3536 | no material change |
| broker_user_s | 60 | 0.4235 | 0.4147 | -2.09 | [-4.95, +0.77] | [-4.50, +0.30] | 0.972 | 0.1169 | no material change |
| broker_sys_s | 60 | 0.5091 | 0.4960 | -2.57 | [-4.78, -0.28] | [-4.43, -0.63] | 0.960 | 0.0247 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.9326 | 0.9107 | -2.35 | [-3.66, -1.04] | [-3.45, -1.26] | 0.976 | 0.0014 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 13618.6 | 13485.6 | -0.98 | [-2.36, +0.39] | [-2.15, +0.17] | 0.997 | 0.2316 | no material change |
| broker_maxrss_kib | 60 | 6237 | 4972 | -20.28 | [-20.92, -19.60] | [-20.82, -19.72] | 0.793 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.6800 | 0.6828 | -0.0049 | [-0.0163, +0.0065] |
| single_rtt_mean_us | 135.9 | 136.5 | -1.0 | [-3.3, +1.3] |
| single_rtt_p50_us | 127.2 | 125.3 | -1.9 | [-3.7, -0.1] |
| single_rtt_p90_us | 155.9 | 156.1 | -1.6 | [-4.8, +1.5] |
| single_rtt_p99_us | 254.3 | 267.4 | +9.9 | [-7.9, +27.7] |
| single_rtt_p999_us | 905.2 | 915.6 | +21.1 | [-95.8, +138.0] |
| single_rtt_max_us | 2584.0 | 2480.6 | +2672.9 | [-1767.2, +7113.0] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.6554 | 0.6487 | -0.0061 | [-0.0241, +0.0120] |
| multi_rtt_mean_us | 637.1 | 625.7 | -7.8 | [-25.3, +9.6] |
| multi_rtt_p50_us | 592.5 | 592.8 | -6.0 | [-21.0, +9.1] |
| multi_rtt_p90_us | 843.5 | 803.4 | -13.1 | [-49.9, +23.8] |
| multi_rtt_p99_us | 1343.1 | 1368.7 | -13.0 | [-111.6, +85.6] |
| multi_rtt_p999_us | 2980.0 | 2912.9 | -11.1 | [-460.5, +438.2] |
| multi_rtt_max_us | 3763.9 | 4312.5 | +720.6 | [-1476.4, +2917.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2441 | 0.2332 | -0.0098 | [-0.0177, -0.0019] |
| fanout_delivery_mean_us | 52867.5 | 20846.1 | -33334.8 | [-34932.1, -31737.4] |
| fanout_delivery_p50_us | 53231.7 | 20161.7 | -35383.4 | [-37410.2, -33356.7] |
| fanout_delivery_p90_us | 81248.7 | 25301.4 | -59328.0 | [-62344.5, -56311.4] |
| fanout_delivery_p99_us | 89099.5 | 28682.9 | -63867.6 | [-67637.9, -60097.2] |
| fanout_delivery_p999_us | 92217.4 | 30180.4 | -65199.5 | [-69116.9, -61282.1] |
| fanout_delivery_max_us | 93498.4 | 30420.4 | -65186.4 | [-69088.0, -61284.8] |
| client_wall_s | 1.6055 | 1.5823 | -0.0204 | [-0.0450, +0.0043] |
| client_cpu_s | 1.2371 | 1.2350 | -0.0126 | [-0.0348, +0.0096] |
| broker_user_s | 0.4188 | 0.4120 | -0.0088 | [-0.0215, +0.0038] |
| broker_sys_s | 0.5099 | 0.5009 | -0.0131 | [-0.0251, -0.0011] |
| broker_cpu_s | 0.9274 | 0.9055 | -0.0219 | [-0.0347, -0.0092] |
| broker_vcsw | 13687.5 | 13490.5 | -133.1 | [-325.0, +58.8] |
| broker_maxrss_kib | 6282 | 4964 | -1265 | [-1314, -1215] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
