candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3332 | 0.3293 | -1.17 | [-2.01, -0.30] | [-1.87, -0.45] | 0.982 | 0.0137 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 65.2 | 64.4 | -1.20 | [-2.04, -0.31] | [-1.91, -0.46] | 0.982 | 0.0137 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 62.6 | 62.2 | -0.63 | [-1.64, +0.41] | [-1.48, +0.22] | 1.000 | 0.3324 | no material change |
| single_rtt_p90_us | 60 | 73.4 | 72.1 | -1.75 | [-3.83, +0.46] | [-3.53, +0.11] | 0.983 | 0.0361 | no material change |
| single_rtt_p99_us | 60 | 115.7 | 110.8 | -4.21 | [-8.49, +0.28] | [-7.83, -0.51] | 0.970 | 0.0724 | inconclusive |
| single_rtt_p999_us | 60 | 202.1 | 193.3 | -4.38 | [-12.70, +4.91] | [-11.45, +3.11] | 0.927 | 0.1470 | inconclusive |
| single_rtt_max_us | 60 | 471.3 | 335.8 | -28.75 | [-44.40, -7.36] | [-42.37, -11.24] | 0.819 | 0.0275 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5042 | 0.5021 | -0.42 | [-1.02, +0.17] | [-0.92, +0.08] | 1.000 | 0.4982 | no material change |
| multi_rtt_mean_us | 60 | 500.0 | 497.1 | -0.57 | [-1.16, -0.00] | [-1.06, -0.09] | 0.999 | 0.2054 | no material change; repeatable change (-) |
| multi_rtt_p50_us | 60 | 485.1 | 484.3 | -0.15 | [-0.41, +0.10] | [-0.37, +0.06] | 1.000 | 0.5645 | no material change |
| multi_rtt_p90_us | 60 | 538.5 | 532.9 | -1.05 | [-3.01, +0.92] | [-2.69, +0.60] | 1.000 | 0.4797 | no material change |
| multi_rtt_p99_us | 60 | 877.7 | 881.7 | +0.45 | [-2.42, +3.20] | [-1.90, +2.84] | 1.025 | 0.2345 | no material change |
| multi_rtt_p999_us | 60 | 1191.5 | 1155.0 | -3.06 | [-7.84, +2.47] | [-7.15, +1.53] | 0.981 | 0.0969 | inconclusive |
| multi_rtt_max_us | 60 | 1462.5 | 1389.4 | -5.00 | [-10.71, +1.38] | [-9.81, +0.26] | 0.901 | 0.0353 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.0852 | 0.1265 | +48.56 | [+47.16, +49.99] | [+47.39, +49.77] | 1.478 | <0.0001 | slower/larger |
| fanout_delivery_mean_us | 60 | 6230.2 | 7451.2 | +19.60 | [+18.41, +20.80] | [+18.63, +20.61] | 1.190 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 6297.3 | 7541.8 | +19.76 | [+18.59, +20.97] | [+18.80, +20.78] | 1.193 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 8906.2 | 9320.5 | +4.65 | [+3.54, +5.80] | [+3.73, +5.61] | 1.044 | <0.0001 | inconclusive; repeatable change (+) |
| fanout_delivery_p99_us | 60 | 10039.3 | 9891.7 | -1.47 | [-2.77, -0.07] | [-2.58, -0.31] | 0.979 | 0.0334 | no material change; repeatable change (-) |
| fanout_delivery_p999_us | 60 | 10434.0 | 10188.4 | -2.35 | [-3.78, -0.86] | [-3.55, -1.11] | 0.970 | 0.0041 | no material change; repeatable change (-) |
| fanout_delivery_max_us | 60 | 10544.4 | 10273.1 | -2.57 | [-3.99, -1.08] | [-3.77, -1.32] | 0.963 | 0.0023 | no material change; repeatable change (-) |
| client_wall_s | 60 | 0.9703 | 1.0052 | +3.60 | [+3.09, +4.12] | [+3.17, +4.04] | 1.036 | <0.0001 | no material change; repeatable change (+) |
| client_cpu_s | 60 | 1.0302 | 1.4990 | +45.51 | [+44.95, +46.08] | [+45.04, +45.99] | 1.453 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.3047 | 0.3066 | +0.62 | [-1.07, +2.42] | [-0.78, +2.11] | 1.002 | 0.6219 | no material change |
| broker_sys_s | 60 | 0.3267 | 0.3618 | +10.74 | [+9.15, +12.38] | [+9.39, +12.10] | 1.106 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.6314 | 0.6684 | +5.86 | [+5.24, +6.48] | [+5.35, +6.39] | 1.059 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 14006.5 | 13973.0 | -0.24 | [-0.53, +0.06] | [-0.48, +0.01] | 0.996 | 0.0810 | no material change |
| broker_maxrss_kib | 60 | 7052 | 7005 | -0.67 | [-1.46, +0.15] | [-1.33, +0.01] | 0.992 | 0.1178 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3331 | 0.3296 | -0.0039 | [-0.0068, -0.0010] |
| single_rtt_mean_us | 65.2 | 64.5 | -0.8 | [-1.4, -0.2] |
| single_rtt_p50_us | 61.7 | 61.7 | -0.4 | [-1.1, +0.3] |
| single_rtt_p90_us | 72.4 | 71.2 | -1.3 | [-2.9, +0.4] |
| single_rtt_p99_us | 117.5 | 109.2 | -4.9 | [-10.2, +0.5] |
| single_rtt_p999_us | 196.5 | 180.5 | -8.8 | [-27.5, +9.8] |
| single_rtt_max_us | 337.8 | 267.1 | -135.5 | [-248.3, -22.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5044 | 0.5025 | -0.0021 | [-0.0052, +0.0010] |
| multi_rtt_mean_us | 499.9 | 497.7 | -2.9 | [-5.9, +0.2] |
| multi_rtt_p50_us | 485.6 | 485.6 | -0.7 | [-2.0, +0.6] |
| multi_rtt_p90_us | 533.7 | 525.4 | -5.7 | [-16.7, +5.3] |
| multi_rtt_p99_us | 882.8 | 910.1 | +4.0 | [-21.2, +29.1] |
| multi_rtt_p999_us | 1195.6 | 1094.1 | -36.5 | [-101.1, +28.2] |
| multi_rtt_max_us | 1484.1 | 1339.9 | -73.1 | [-166.4, +20.3] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.0857 | 0.1264 | +0.0414 | [+0.0405, +0.0422] |
| fanout_delivery_mean_us | 6257.9 | 7441.5 | +1221.0 | [+1157.6, +1284.4] |
| fanout_delivery_p50_us | 6347.4 | 7525.8 | +1244.5 | [+1180.2, +1308.7] |
| fanout_delivery_p90_us | 8957.1 | 9311.5 | +414.4 | [+317.0, +511.7] |
| fanout_delivery_p99_us | 10089.8 | 9869.0 | -147.5 | [-287.0, -8.1] |
| fanout_delivery_p999_us | 10491.7 | 10134.9 | -245.6 | [-404.0, -87.2] |
| fanout_delivery_max_us | 10589.1 | 10230.5 | -271.3 | [-432.2, -110.3] |
| client_wall_s | 0.9736 | 1.0027 | +0.0349 | [+0.0298, +0.0400] |
| client_cpu_s | 1.0341 | 1.4998 | +0.4688 | [+0.4641, +0.4735] |
| broker_user_s | 0.3064 | 0.3058 | +0.0019 | [-0.0035, +0.0073] |
| broker_sys_s | 0.3280 | 0.3597 | +0.0351 | [+0.0298, +0.0403] |
| broker_cpu_s | 0.6341 | 0.6713 | +0.0370 | [+0.0331, +0.0408] |
| broker_vcsw | 13993.0 | 13968.0 | -33.4 | [-75.1, +8.3] |
| broker_maxrss_kib | 7090 | 7014 | -47 | [-106, +12] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
