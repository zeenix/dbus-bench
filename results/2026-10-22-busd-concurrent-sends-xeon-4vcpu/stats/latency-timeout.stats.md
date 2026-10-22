candidate timeout against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.6870 | 0.6899 | +0.42 | [-1.41, +2.18] | [-1.10, +1.89] | 1.010 | 0.4889 | no material change |
| single_rtt_mean_us | 60 | 137.3 | 137.9 | +0.42 | [-1.41, +2.18] | [-1.10, +1.89] | 1.010 | 0.4936 | no material change |
| single_rtt_p50_us | 60 | 127.8 | 126.9 | -0.70 | [-2.27, +0.85] | [-2.01, +0.60] | 0.994 | 0.4223 | no material change |
| single_rtt_p90_us | 60 | 158.2 | 159.0 | +0.55 | [-1.61, +2.60] | [-1.26, +2.28] | 1.022 | 0.4527 | no material change |
| single_rtt_p99_us | 60 | 260.8 | 272.7 | +4.56 | [-3.75, +13.07] | [-2.45, +11.74] | 1.073 | 0.2825 | inconclusive |
| single_rtt_p999_us | 60 | 942.4 | 967.4 | +2.66 | [-10.64, +17.22] | [-8.69, +14.92] | 1.065 | 0.6694 | inconclusive |
| single_rtt_max_us | 60 | 4199.3 | 8062.3 | +91.99 | [-9.96, +264.22] | [+2.34, +232.61] | 1.157 | 0.1221 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.6647 | 0.6681 | +0.52 | [-2.35, +3.41] | [-1.86, +2.93] | 1.006 | 0.6063 | no material change |
| multi_rtt_mean_us | 60 | 643.5 | 644.7 | +0.19 | [-2.65, +3.04] | [-2.16, +2.54] | 1.003 | 0.7684 | no material change |
| multi_rtt_p50_us | 60 | 608.4 | 608.8 | +0.07 | [-2.44, +2.58] | [-2.03, +2.18] | 1.010 | 0.5171 | no material change |
| multi_rtt_p90_us | 60 | 833.1 | 825.3 | -0.94 | [-5.33, +3.59] | [-4.59, +2.89] | 0.999 | 0.7740 | no material change |
| multi_rtt_p99_us | 60 | 1418.4 | 1445.7 | +1.93 | [-4.92, +9.50] | [-3.90, +8.11] | 0.999 | 0.8713 | inconclusive |
| multi_rtt_p999_us | 60 | 3140.5 | 3351.7 | +6.72 | [-9.48, +25.17] | [-7.12, +22.12] | 1.096 | 0.6167 | inconclusive |
| multi_rtt_max_us | 60 | 4806.1 | 7579.8 | +57.71 | [-4.43, +154.78] | [+2.94, +134.93] | 1.394 | 0.0460 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2492 | 0.2471 | -0.83 | [-4.24, +2.52] | [-3.69, +1.97] | 1.000 | 0.7460 | no material change |
| fanout_delivery_mean_us | 60 | 54698.7 | 22073.8 | -59.64 | [-61.09, -58.20] | [-60.88, -58.43] | 0.405 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 56451.7 | 21801.1 | -61.38 | [-63.12, -59.66] | [-62.86, -59.91] | 0.392 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 85919.9 | 27296.4 | -68.23 | [-69.62, -66.83] | [-69.41, -67.05] | 0.317 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 94109.2 | 31702.9 | -66.31 | [-68.57, -63.46] | [-68.28, -64.04] | 0.318 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 96679.0 | 33220.8 | -65.64 | [-68.10, -62.57] | [-67.77, -63.20] | 0.325 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 97487.8 | 34159.9 | -64.96 | [-67.46, -61.82] | [-67.11, -62.46] | 0.325 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.6178 | 1.6228 | +0.31 | [-1.45, +1.98] | [-1.15, +1.72] | 1.004 | 0.4706 | no material change |
| client_cpu_s | 60 | 1.2584 | 1.2566 | -0.14 | [-2.12, +1.78] | [-1.78, +1.47] | 1.008 | 0.9765 | no material change |
| broker_user_s | 60 | 0.4235 | 0.4244 | +0.21 | [-2.47, +2.89] | [-2.03, +2.47] | 1.007 | 0.7404 | no material change |
| broker_sys_s | 60 | 0.5091 | 0.4946 | -2.85 | [-5.53, -0.08] | [-5.10, -0.49] | 0.976 | 0.0595 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.9326 | 0.9190 | -1.46 | [-3.08, +0.23] | [-2.81, -0.06] | 0.978 | 0.0547 | no material change |
| broker_vcsw | 60 | 13618.6 | 13514.8 | -0.76 | [-2.09, +0.56] | [-1.88, +0.35] | 0.993 | 0.1839 | no material change |
| broker_maxrss_kib | 60 | 6237 | 4946 | -20.70 | [-21.37, -19.99] | [-21.27, -20.11] | 0.790 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.6800 | 0.6837 | +0.0029 | [-0.0097, +0.0155] |
| single_rtt_mean_us | 135.9 | 136.7 | +0.6 | [-1.9, +3.1] |
| single_rtt_p50_us | 127.2 | 126.2 | -0.9 | [-3.0, +1.2] |
| single_rtt_p90_us | 155.9 | 157.3 | +0.9 | [-2.6, +4.3] |
| single_rtt_p99_us | 254.3 | 255.9 | +11.9 | [-10.7, +34.5] |
| single_rtt_p999_us | 905.2 | 855.6 | +25.0 | [-109.8, +159.8] |
| single_rtt_max_us | 2584.0 | 2547.4 | +3863.0 | [-885.3, +8611.3] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.6554 | 0.6552 | +0.0034 | [-0.0158, +0.0227] |
| multi_rtt_mean_us | 637.1 | 633.5 | +1.2 | [-17.2, +19.6] |
| multi_rtt_p50_us | 592.5 | 594.2 | +0.4 | [-15.1, +16.0] |
| multi_rtt_p90_us | 843.5 | 806.1 | -7.8 | [-45.5, +29.9] |
| multi_rtt_p99_us | 1343.1 | 1363.4 | +27.3 | [-77.4, +132.1] |
| multi_rtt_p999_us | 2980.0 | 3032.6 | +211.2 | [-330.5, +752.9] |
| multi_rtt_max_us | 3763.9 | 4481.4 | +2773.6 | [-789.5, +6336.8] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2441 | 0.2366 | -0.0021 | [-0.0107, +0.0066] |
| fanout_delivery_mean_us | 52867.5 | 21197.1 | -32624.9 | [-34237.9, -31011.9] |
| fanout_delivery_p50_us | 53231.7 | 20757.6 | -34650.5 | [-36767.6, -32533.5] |
| fanout_delivery_p90_us | 81248.7 | 25625.8 | -58623.6 | [-61666.2, -55581.0] |
| fanout_delivery_p99_us | 89099.5 | 28560.8 | -62406.3 | [-66342.1, -58470.5] |
| fanout_delivery_p999_us | 92217.4 | 29684.3 | -63458.2 | [-67643.6, -59272.8] |
| fanout_delivery_max_us | 93498.4 | 30372.0 | -63327.9 | [-67560.7, -59095.0] |
| client_wall_s | 1.6055 | 1.6027 | +0.0049 | [-0.0232, +0.0331] |
| client_cpu_s | 1.2371 | 1.2376 | -0.0018 | [-0.0265, +0.0230] |
| broker_user_s | 0.4188 | 0.4186 | +0.0009 | [-0.0107, +0.0124] |
| broker_sys_s | 0.5099 | 0.4933 | -0.0145 | [-0.0289, -0.0001] |
| broker_cpu_s | 0.9274 | 0.9021 | -0.0136 | [-0.0294, +0.0021] |
| broker_vcsw | 13687.5 | 13560.0 | -103.8 | [-289.3, +81.6] |
| broker_maxrss_kib | 6282 | 4946 | -1291 | [-1343, -1239] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
