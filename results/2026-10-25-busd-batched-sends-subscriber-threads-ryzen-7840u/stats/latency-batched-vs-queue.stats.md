candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3332 | 0.3333 | +0.03 | [-1.01, +1.10] | [-0.83, +0.93] | 1.004 | 0.9941 | no material change |
| single_rtt_mean_us | 60 | 65.2 | 65.2 | +0.03 | [-1.03, +1.13] | [-0.85, +0.95] | 1.004 | 0.9706 | no material change |
| single_rtt_p50_us | 60 | 62.6 | 62.5 | -0.13 | [-1.42, +1.27] | [-1.23, +1.05] | 1.000 | 0.7916 | no material change |
| single_rtt_p90_us | 60 | 73.4 | 73.9 | +0.78 | [-1.53, +3.15] | [-1.18, +2.76] | 1.007 | 0.5623 | no material change |
| single_rtt_p99_us | 60 | 115.7 | 114.0 | -1.45 | [-5.43, +2.57] | [-4.78, +1.91] | 1.009 | 0.6236 | no material change |
| single_rtt_p999_us | 60 | 202.1 | 205.9 | +1.87 | [-5.55, +10.28] | [-4.44, +8.90] | 1.025 | 0.7293 | inconclusive |
| single_rtt_max_us | 60 | 471.3 | 452.3 | -4.03 | [-28.87, +31.04] | [-25.50, +24.67] | 0.966 | 0.6759 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5042 | 0.5030 | -0.26 | [-0.82, +0.31] | [-0.72, +0.21] | 1.000 | 0.5859 | no material change |
| multi_rtt_mean_us | 60 | 500.0 | 498.1 | -0.37 | [-0.91, +0.18] | [-0.82, +0.08] | 0.999 | 0.3275 | no material change |
| multi_rtt_p50_us | 60 | 485.1 | 485.0 | -0.00 | [-0.27, +0.29] | [-0.23, +0.24] | 1.000 | 0.9365 | no material change |
| multi_rtt_p90_us | 60 | 538.5 | 531.2 | -1.37 | [-3.16, +0.39] | [-2.86, +0.12] | 0.997 | 0.2787 | no material change |
| multi_rtt_p99_us | 60 | 877.7 | 889.7 | +1.36 | [-1.42, +4.13] | [-1.00, +3.71] | 1.031 | 0.1675 | no material change |
| multi_rtt_p999_us | 60 | 1191.5 | 1170.3 | -1.78 | [-6.20, +2.78] | [-5.43, +2.04] | 0.997 | 0.5609 | inconclusive |
| multi_rtt_max_us | 60 | 1462.5 | 1414.3 | -3.29 | [-9.17, +2.85] | [-8.13, +1.82] | 0.959 | 0.2478 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.0852 | 0.0502 | -41.04 | [-41.63, -40.42] | [-41.54, -40.50] | 0.587 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 6230.2 | 2246.2 | -63.95 | [-64.32, -63.55] | [-64.26, -63.62] | 0.361 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 6297.3 | 2261.4 | -64.09 | [-64.46, -63.70] | [-64.40, -63.76] | 0.359 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 8906.2 | 3378.6 | -62.06 | [-62.49, -61.62] | [-62.42, -61.69] | 0.377 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 10039.3 | 3836.8 | -61.78 | [-62.64, -60.81] | [-62.51, -60.97] | 0.375 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 10434.0 | 4083.3 | -60.87 | [-61.82, -59.76] | [-61.68, -59.97] | 0.383 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 10544.4 | 4365.4 | -58.60 | [-59.62, -57.41] | [-59.47, -57.62] | 0.408 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.9703 | 0.9347 | -3.67 | [-4.19, -3.12] | [-4.11, -3.21] | 0.960 | <0.0001 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 1.0302 | 1.0681 | +3.69 | [+3.20, +4.21] | [+3.28, +4.12] | 1.036 | <0.0001 | no material change; repeatable change (+) |
| broker_user_s | 60 | 0.3047 | 0.2970 | -2.54 | [-4.29, -0.75] | [-4.02, -1.04] | 0.971 | 0.0074 | no material change; repeatable change (-) |
| broker_sys_s | 60 | 0.3267 | 0.2983 | -8.68 | [-10.18, -7.13] | [-9.95, -7.38] | 0.911 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6314 | 0.5953 | -5.72 | [-6.33, -5.10] | [-6.23, -5.20] | 0.943 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14006.5 | 13979.9 | -0.19 | [-0.46, +0.10] | [-0.41, +0.04] | 0.997 | 0.1429 | no material change |
| broker_maxrss_kib | 60 | 7052 | 7001 | -0.72 | [-1.49, +0.08] | [-1.37, -0.04] | 0.989 | 0.0615 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3331 | 0.3327 | +0.0001 | [-0.0036, +0.0038] |
| single_rtt_mean_us | 65.2 | 65.1 | +0.0 | [-0.7, +0.7] |
| single_rtt_p50_us | 61.7 | 61.7 | -0.1 | [-1.0, +0.8] |
| single_rtt_p90_us | 72.4 | 73.0 | +0.6 | [-1.2, +2.4] |
| single_rtt_p99_us | 117.5 | 112.8 | -1.7 | [-6.5, +3.1] |
| single_rtt_p999_us | 196.5 | 190.0 | +3.8 | [-12.5, +20.1] |
| single_rtt_max_us | 337.8 | 316.4 | -19.0 | [-165.5, +127.5] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5044 | 0.5043 | -0.0013 | [-0.0042, +0.0017] |
| multi_rtt_mean_us | 499.9 | 499.2 | -1.8 | [-4.7, +1.0] |
| multi_rtt_p50_us | 485.6 | 485.6 | -0.0 | [-1.4, +1.4] |
| multi_rtt_p90_us | 533.7 | 523.6 | -7.4 | [-17.4, +2.7] |
| multi_rtt_p99_us | 882.8 | 913.6 | +12.0 | [-13.3, +37.2] |
| multi_rtt_p999_us | 1195.6 | 1144.0 | -21.2 | [-76.6, +34.2] |
| multi_rtt_max_us | 1484.1 | 1383.2 | -48.2 | [-139.7, +43.3] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.0857 | 0.0501 | -0.0350 | [-0.0358, -0.0341] |
| fanout_delivery_mean_us | 6257.9 | 2243.7 | -3984.0 | [-4046.4, -3921.7] |
| fanout_delivery_p50_us | 6347.4 | 2260.1 | -4035.9 | [-4098.6, -3973.1] |
| fanout_delivery_p90_us | 8957.1 | 3380.9 | -5527.5 | [-5624.4, -5430.7] |
| fanout_delivery_p99_us | 10089.8 | 3751.3 | -6202.4 | [-6362.8, -6042.1] |
| fanout_delivery_p999_us | 10491.7 | 3986.4 | -6350.8 | [-6533.0, -6168.5] |
| fanout_delivery_max_us | 10589.1 | 4258.9 | -6178.9 | [-6367.9, -5990.0] |
| client_wall_s | 0.9736 | 0.9359 | -0.0356 | [-0.0411, -0.0302] |
| client_cpu_s | 1.0341 | 1.0655 | +0.0380 | [+0.0327, +0.0432] |
| broker_user_s | 0.3064 | 0.2947 | -0.0078 | [-0.0134, -0.0021] |
| broker_sys_s | 0.3280 | 0.2963 | -0.0284 | [-0.0338, -0.0230] |
| broker_cpu_s | 0.6341 | 0.5975 | -0.0361 | [-0.0402, -0.0320] |
| broker_vcsw | 13993.0 | 13980.5 | -26.6 | [-66.4, +13.2] |
| broker_maxrss_kib | 7090 | 7024 | -51 | [-108, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
