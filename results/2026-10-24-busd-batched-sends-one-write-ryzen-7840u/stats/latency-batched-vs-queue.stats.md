candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3361 | 0.3386 | +0.75 | [-0.12, +1.67] | [+0.01, +1.51] | 1.008 | 0.1102 | no material change |
| single_rtt_mean_us | 60 | 65.8 | 66.3 | +0.77 | [-0.12, +1.70] | [+0.01, +1.54] | 1.008 | 0.1102 | no material change |
| single_rtt_p50_us | 60 | 61.9 | 62.4 | +0.80 | [-0.10, +1.73] | [+0.06, +1.57] | 1.000 | 0.0866 | no material change |
| single_rtt_p90_us | 60 | 77.4 | 78.7 | +1.64 | [-1.04, +4.49] | [-0.61, +3.97] | 1.000 | 0.2720 | no material change |
| single_rtt_p99_us | 60 | 121.5 | 124.9 | +2.82 | [-1.58, +7.56] | [-0.99, +6.78] | 1.027 | 0.2607 | inconclusive |
| single_rtt_p999_us | 60 | 223.9 | 224.4 | +0.19 | [-8.37, +9.88] | [-7.05, +8.36] | 0.965 | 0.7995 | inconclusive |
| single_rtt_max_us | 60 | 610.7 | 553.9 | -9.30 | [-25.51, +10.39] | [-23.10, +6.67] | 0.944 | 0.4181 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5062 | 0.5056 | -0.13 | [-0.81, +0.55] | [-0.70, +0.44] | 0.996 | 0.6063 | no material change |
| multi_rtt_mean_us | 60 | 501.6 | 500.7 | -0.18 | [-0.83, +0.46] | [-0.72, +0.36] | 0.997 | 0.4527 | no material change |
| multi_rtt_p50_us | 60 | 484.9 | 486.1 | +0.23 | [-0.20, +0.67] | [-0.13, +0.60] | 1.002 | 0.2646 | no material change |
| multi_rtt_p90_us | 60 | 545.4 | 537.7 | -1.40 | [-3.62, +0.87] | [-3.28, +0.50] | 0.991 | 0.2316 | no material change |
| multi_rtt_p99_us | 60 | 889.5 | 895.7 | +0.70 | [-2.71, +4.30] | [-2.14, +3.74] | 0.993 | 0.7967 | no material change |
| multi_rtt_p999_us | 60 | 1347.2 | 1295.2 | -3.86 | [-11.84, +5.08] | [-10.68, +3.57] | 0.990 | 0.4913 | inconclusive |
| multi_rtt_max_us | 60 | 1727.1 | 1642.1 | -4.92 | [-12.64, +3.81] | [-11.60, +2.32] | 0.991 | 0.3239 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2637 | 0.2460 | -6.69 | [-7.46, -5.87] | [-7.34, -6.02] | 0.932 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 58013.5 | 27376.6 | -52.81 | [-53.42, -52.21] | [-53.32, -52.31] | 0.471 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 59221.1 | 27871.2 | -52.94 | [-53.66, -52.21] | [-53.55, -52.33] | 0.467 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 91077.0 | 32880.5 | -63.90 | [-64.36, -63.42] | [-64.29, -63.50] | 0.362 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 98946.2 | 36553.1 | -63.06 | [-63.66, -62.47] | [-63.56, -62.57] | 0.373 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 100916.1 | 38349.3 | -62.00 | [-62.60, -61.42] | [-62.50, -61.52] | 0.379 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 101338.9 | 38965.9 | -61.55 | [-62.12, -60.96] | [-62.03, -61.06] | 0.384 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1448 | 1.1273 | -1.53 | [-2.00, -1.07] | [-1.92, -1.15] | 0.987 | <0.0001 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 0.9846 | 0.9689 | -1.60 | [-2.08, -1.13] | [-2.00, -1.20] | 0.984 | <0.0001 | no material change; repeatable change (-) |
| broker_user_s | 60 | 0.3201 | 0.3027 | -5.42 | [-6.99, -3.87] | [-6.76, -4.11] | 0.945 | <0.0001 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.3416 | 0.3019 | -11.61 | [-13.00, -10.13] | [-12.80, -10.40] | 0.888 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6617 | 0.6046 | -8.62 | [-9.31, -7.94] | [-9.20, -8.05] | 0.913 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14334.3 | 14002.9 | -2.31 | [-2.64, -1.98] | [-2.59, -2.03] | 0.976 | <0.0001 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 8155 | 7094 | -13.01 | [-13.71, -12.29] | [-13.61, -12.41] | 0.867 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3345 | 0.3382 | +0.0025 | [-0.0006, +0.0056] |
| single_rtt_mean_us | 65.5 | 66.2 | +0.5 | [-0.1, +1.1] |
| single_rtt_p50_us | 61.7 | 61.7 | +0.5 | [-0.1, +1.1] |
| single_rtt_p90_us | 78.4 | 77.2 | +1.3 | [-0.9, +3.4] |
| single_rtt_p99_us | 123.5 | 127.0 | +3.4 | [-2.3, +9.1] |
| single_rtt_p999_us | 222.6 | 210.2 | +0.4 | [-20.9, +21.7] |
| single_rtt_max_us | 514.1 | 503.4 | -56.8 | [-174.7, +61.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5062 | 0.5067 | -0.0007 | [-0.0042, +0.0029] |
| multi_rtt_mean_us | 501.3 | 502.0 | -0.9 | [-4.3, +2.4] |
| multi_rtt_p50_us | 485.6 | 488.6 | +1.1 | [-1.1, +3.3] |
| multi_rtt_p90_us | 534.3 | 528.9 | -7.6 | [-20.3, +5.0] |
| multi_rtt_p99_us | 890.5 | 916.6 | +6.2 | [-25.4, +37.9] |
| multi_rtt_p999_us | 1261.5 | 1202.2 | -52.0 | [-172.6, +68.7] |
| multi_rtt_max_us | 1666.4 | 1491.9 | -85.0 | [-237.4, +67.5] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2631 | 0.2456 | -0.0176 | [-0.0199, -0.0154] |
| fanout_delivery_mean_us | 57979.0 | 27491.0 | -30636.9 | [-31241.1, -30032.7] |
| fanout_delivery_p50_us | 58629.1 | 27595.0 | -31349.9 | [-32092.8, -30607.0] |
| fanout_delivery_p90_us | 91517.2 | 32546.7 | -58196.4 | [-59114.1, -57278.8] |
| fanout_delivery_p99_us | 98669.6 | 36987.3 | -62393.1 | [-63300.6, -61485.7] |
| fanout_delivery_p999_us | 100302.8 | 38085.6 | -62566.9 | [-63679.6, -61454.1] |
| fanout_delivery_max_us | 100378.7 | 38605.0 | -62373.0 | [-63540.7, -61205.4] |
| client_wall_s | 1.1485 | 1.1296 | -0.0175 | [-0.0231, -0.0120] |
| client_cpu_s | 0.9854 | 0.9717 | -0.0157 | [-0.0206, -0.0108] |
| broker_user_s | 0.3190 | 0.3015 | -0.0174 | [-0.0227, -0.0121] |
| broker_sys_s | 0.3398 | 0.3028 | -0.0397 | [-0.0451, -0.0343] |
| broker_cpu_s | 0.6634 | 0.6029 | -0.0570 | [-0.0620, -0.0521] |
| broker_vcsw | 14348.5 | 14025.0 | -331.4 | [-381.2, -281.5] |
| broker_maxrss_kib | 8204 | 7084 | -1061 | [-1128, -995] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
