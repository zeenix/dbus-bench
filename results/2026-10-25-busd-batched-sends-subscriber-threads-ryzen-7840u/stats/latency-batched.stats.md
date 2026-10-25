candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3293 | 0.3333 | +1.22 | [+0.38, +2.10] | [+0.52, +1.95] | 1.011 | 0.0121 | no material change; repeatable change (+) |
| single_rtt_mean_us | 60 | 64.4 | 65.2 | +1.24 | [+0.39, +2.14] | [+0.53, +1.99] | 1.011 | 0.0118 | no material change; repeatable change (+) |
| single_rtt_p50_us | 60 | 62.2 | 62.5 | +0.51 | [-0.35, +1.46] | [-0.22, +1.30] | 1.000 | 0.1277 | no material change |
| single_rtt_p90_us | 60 | 72.1 | 73.9 | +2.58 | [+0.16, +5.10] | [+0.55, +4.70] | 1.017 | 0.0538 | no material change; repeatable change (+) |
| single_rtt_p99_us | 60 | 110.8 | 114.0 | +2.88 | [-0.79, +6.89] | [-0.23, +6.23] | 1.026 | 0.2175 | inconclusive |
| single_rtt_p999_us | 60 | 193.3 | 205.9 | +6.53 | [-3.20, +17.71] | [-1.79, +15.78] | 1.037 | 0.0931 | inconclusive |
| single_rtt_max_us | 60 | 335.8 | 452.3 | +34.69 | [+2.97, +76.01] | [+7.63, +69.03] | 1.098 | 0.0707 | inconclusive; repeatable change (+) |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5021 | 0.5030 | +0.16 | [-0.26, +0.60] | [-0.19, +0.53] | 1.000 | 0.7238 | no material change |
| multi_rtt_mean_us | 60 | 497.1 | 498.1 | +0.20 | [-0.20, +0.62] | [-0.14, +0.56] | 1.000 | 0.5708 | no material change |
| multi_rtt_p50_us | 60 | 484.3 | 485.0 | +0.15 | [-0.11, +0.44] | [-0.07, +0.39] | 1.000 | 0.3269 | no material change |
| multi_rtt_p90_us | 60 | 532.9 | 531.2 | -0.32 | [-1.59, +0.91] | [-1.38, +0.72] | 0.999 | 0.4258 | no material change |
| multi_rtt_p99_us | 60 | 881.7 | 889.7 | +0.90 | [-1.82, +3.61] | [-1.37, +3.20] | 1.009 | 0.4982 | no material change |
| multi_rtt_p999_us | 60 | 1155.0 | 1170.3 | +1.32 | [-3.07, +5.82] | [-2.41, +5.12] | 1.015 | 0.3275 | inconclusive |
| multi_rtt_max_us | 60 | 1389.4 | 1414.3 | +1.79 | [-4.51, +8.50] | [-3.56, +7.31] | 1.015 | 0.5935 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.1265 | 0.0502 | -60.31 | [-60.52, -60.09] | [-60.49, -60.13] | 0.397 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 7451.2 | 2246.2 | -69.85 | [-70.02, -69.69] | [-69.99, -69.72] | 0.301 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 7541.8 | 2261.4 | -70.01 | [-70.18, -69.85] | [-70.15, -69.88] | 0.300 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 9320.5 | 3378.6 | -63.75 | [-63.94, -63.55] | [-63.91, -63.59] | 0.362 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 9891.7 | 3836.8 | -61.21 | [-61.91, -60.39] | [-61.81, -60.53] | 0.379 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 10188.4 | 4083.3 | -59.92 | [-60.71, -58.99] | [-60.60, -59.15] | 0.392 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 10273.1 | 4365.4 | -57.51 | [-58.35, -56.51] | [-58.24, -56.68] | 0.416 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0052 | 0.9347 | -7.02 | [-7.44, -6.58] | [-7.37, -6.65] | 0.930 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.4990 | 1.0681 | -28.74 | [-28.99, -28.48] | [-28.95, -28.53] | 0.712 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.3066 | 0.2970 | -3.15 | [-4.77, -1.53] | [-4.51, -1.79] | 0.965 | 0.0006 | no material change; repeatable change (-) |
| broker_sys_s | 60 | 0.3618 | 0.2983 | -17.53 | [-18.65, -16.46] | [-18.48, -16.63] | 0.827 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6684 | 0.5953 | -10.93 | [-11.39, -10.47] | [-11.32, -10.55] | 0.890 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 13973.0 | 13979.9 | +0.05 | [-0.19, +0.30] | [-0.15, +0.25] | 1.001 | 0.7656 | no material change |
| broker_maxrss_kib | 60 | 7005 | 7001 | -0.06 | [-0.76, +0.66] | [-0.65, +0.54] | 1.000 | 0.8444 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3296 | 0.3327 | +0.0040 | [+0.0012, +0.0069] |
| single_rtt_mean_us | 64.5 | 65.1 | +0.8 | [+0.2, +1.4] |
| single_rtt_p50_us | 61.7 | 61.7 | +0.3 | [-0.3, +0.9] |
| single_rtt_p90_us | 71.2 | 73.0 | +1.9 | [+0.1, +3.6] |
| single_rtt_p99_us | 109.2 | 112.8 | +3.2 | [-1.1, +7.5] |
| single_rtt_p999_us | 180.5 | 190.0 | +12.6 | [-7.6, +32.8] |
| single_rtt_max_us | 267.1 | 316.4 | +116.5 | [-2.1, +235.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5025 | 0.5043 | +0.0008 | [-0.0014, +0.0030] |
| multi_rtt_mean_us | 497.7 | 499.2 | +1.0 | [-1.1, +3.1] |
| multi_rtt_p50_us | 485.6 | 485.6 | +0.7 | [-0.6, +2.1] |
| multi_rtt_p90_us | 525.4 | 523.6 | -1.7 | [-8.7, +5.3] |
| multi_rtt_p99_us | 910.1 | 913.6 | +8.0 | [-16.4, +32.4] |
| multi_rtt_p999_us | 1094.1 | 1144.0 | +15.3 | [-37.3, +67.9] |
| multi_rtt_max_us | 1339.9 | 1383.2 | +24.9 | [-67.1, +116.9] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.1264 | 0.0501 | -0.0763 | [-0.0767, -0.0759] |
| fanout_delivery_mean_us | 7441.5 | 2243.7 | -5205.0 | [-5225.5, -5184.6] |
| fanout_delivery_p50_us | 7525.8 | 2260.1 | -5280.4 | [-5300.8, -5260.0] |
| fanout_delivery_p90_us | 9311.5 | 3380.9 | -5941.9 | [-5968.7, -5915.1] |
| fanout_delivery_p99_us | 9869.0 | 3751.3 | -6054.9 | [-6139.9, -5969.9] |
| fanout_delivery_p999_us | 10134.9 | 3986.4 | -6105.2 | [-6208.7, -6001.7] |
| fanout_delivery_max_us | 10230.5 | 4258.9 | -5907.7 | [-6020.3, -5795.0] |
| client_wall_s | 1.0027 | 0.9359 | -0.0705 | [-0.0751, -0.0660] |
| client_cpu_s | 1.4998 | 1.0655 | -0.4308 | [-0.4354, -0.4263] |
| broker_user_s | 0.3058 | 0.2947 | -0.0096 | [-0.0149, -0.0044] |
| broker_sys_s | 0.3597 | 0.2963 | -0.0634 | [-0.0680, -0.0589] |
| broker_cpu_s | 0.6713 | 0.5975 | -0.0731 | [-0.0764, -0.0697] |
| broker_vcsw | 13968.0 | 13980.5 | +6.8 | [-28.9, +42.5] |
| broker_maxrss_kib | 7014 | 7024 | -4 | [-54, +46] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
