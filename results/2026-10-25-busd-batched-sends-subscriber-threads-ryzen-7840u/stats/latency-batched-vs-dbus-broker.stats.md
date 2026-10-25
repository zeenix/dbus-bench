candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2852 | 0.3333 | +16.89 | [+15.79, +17.97] | [+15.96, +17.80] | 1.181 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.6 | 65.2 | +17.41 | [+16.28, +18.51] | [+16.45, +18.34] | 1.186 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 54.4 | 62.5 | +15.03 | [+13.72, +16.39] | [+13.92, +16.17] | 1.156 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 60.6 | 73.9 | +21.97 | [+19.60, +24.48] | [+19.97, +24.04] | 1.206 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 84.8 | 114.0 | +34.39 | [+28.99, +39.68] | [+29.87, +38.82] | 1.400 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 147.0 | 205.9 | +40.04 | [+28.73, +52.14] | [+30.48, +50.18] | 1.413 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 384.4 | 452.3 | +17.67 | [-12.27, +60.18] | [-7.98, +51.97] | 1.114 | 0.2135 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5017 | 0.5030 | +0.26 | [-0.30, +0.79] | [-0.20, +0.71] | 1.002 | 0.2993 | no material change |
| multi_rtt_mean_us | 60 | 474.4 | 498.1 | +5.00 | [+4.38, +5.60] | [+4.48, +5.51] | 1.051 | <0.0001 | inconclusive; repeatable change (+) |
| multi_rtt_p50_us | 60 | 514.2 | 485.0 | -5.67 | [-5.97, -5.35] | [-5.92, -5.40] | 0.942 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 562.1 | 531.2 | -5.49 | [-6.59, -4.35] | [-6.43, -4.55] | 0.938 | <0.0001 | inconclusive; repeatable change (-) |
| multi_rtt_p99_us | 60 | 725.4 | 889.7 | +22.64 | [+17.03, +27.99] | [+17.93, +27.15] | 1.293 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 1008.2 | 1170.3 | +16.08 | [+9.58, +23.22] | [+10.56, +22.01] | 1.158 | <0.0001 | slower/larger |
| multi_rtt_max_us | 60 | 1356.8 | 1414.3 | +4.23 | [-4.35, +13.35] | [-3.08, +11.99] | 1.079 | 0.1061 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.0703 | 0.0502 | -28.53 | [-29.22, -27.83] | [-29.12, -27.94] | 0.709 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 2121.7 | 2246.2 | +5.87 | [+4.75, +6.99] | [+4.94, +6.80] | 1.059 | <0.0001 | inconclusive; repeatable change (+) |
| fanout_delivery_p50_us | 60 | 2113.9 | 2261.4 | +6.98 | [+5.87, +8.07] | [+6.04, +7.91] | 1.070 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 3115.9 | 3378.6 | +8.43 | [+7.33, +9.51] | [+7.52, +9.33] | 1.087 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 3495.6 | 3836.8 | +9.76 | [+7.47, +12.21] | [+7.80, +11.80] | 1.076 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 3681.0 | 4083.3 | +10.93 | [+8.34, +13.56] | [+8.75, +13.14] | 1.098 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 3783.2 | 4365.4 | +15.39 | [+12.66, +18.18] | [+13.07, +17.70] | 1.135 | <0.0001 | slower/larger |
| client_wall_s | 60 | 0.8771 | 0.9347 | +6.56 | [+6.01, +7.09] | [+6.10, +7.00] | 1.067 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 1.1564 | 1.0681 | -7.63 | [-7.96, -7.28] | [-7.91, -7.34] | 0.924 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.1804 | 0.2970 | +64.61 | [+60.95, +68.43] | [+61.52, +67.84] | 1.651 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3571 | 0.2983 | -16.46 | [-17.72, -15.21] | [-17.54, -15.40] | 0.831 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5375 | 0.5953 | +10.75 | [+10.03, +11.46] | [+10.15, +11.34] | 1.106 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 45385.7 | 13979.9 | -69.20 | [-69.42, -68.97] | [-69.38, -69.01] | 0.308 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8247 | 7001 | -15.11 | [-15.74, -14.51] | [-15.64, -14.60] | 0.850 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2826 | 0.3327 | +0.0482 | [+0.0452, +0.0512] |
| single_rtt_mean_us | 55.1 | 65.1 | +9.7 | [+9.1, +10.3] |
| single_rtt_p50_us | 53.4 | 61.7 | +8.2 | [+7.5, +8.9] |
| single_rtt_p90_us | 60.6 | 73.0 | +13.3 | [+11.9, +14.8] |
| single_rtt_p99_us | 85.5 | 112.8 | +29.2 | [+25.0, +33.4] |
| single_rtt_p999_us | 143.1 | 190.0 | +58.9 | [+42.8, +75.0] |
| single_rtt_max_us | 256.5 | 316.4 | +67.9 | [-65.6, +201.4] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5006 | 0.5043 | +0.0013 | [-0.0015, +0.0041] |
| multi_rtt_mean_us | 473.0 | 499.2 | +23.7 | [+20.9, +26.6] |
| multi_rtt_p50_us | 514.1 | 485.6 | -29.1 | [-30.8, -27.4] |
| multi_rtt_p90_us | 558.0 | 523.6 | -30.9 | [-37.6, -24.1] |
| multi_rtt_p99_us | 708.2 | 913.6 | +164.3 | [+128.6, +199.9] |
| multi_rtt_p999_us | 964.7 | 1144.0 | +162.1 | [+99.1, +225.1] |
| multi_rtt_max_us | 1227.7 | 1383.2 | +57.4 | [-62.1, +177.0] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.0703 | 0.0501 | -0.0200 | [-0.0207, -0.0194] |
| fanout_delivery_mean_us | 2122.7 | 2243.7 | +124.5 | [+101.2, +147.9] |
| fanout_delivery_p50_us | 2114.6 | 2260.1 | +147.5 | [+124.6, +170.4] |
| fanout_delivery_p90_us | 3115.5 | 3380.9 | +262.7 | [+229.7, +295.7] |
| fanout_delivery_p99_us | 3510.9 | 3751.3 | +341.3 | [+256.9, +425.6] |
| fanout_delivery_p999_us | 3646.3 | 3986.4 | +402.2 | [+305.2, +499.3] |
| fanout_delivery_max_us | 3725.2 | 4258.9 | +582.3 | [+479.4, +685.1] |
| client_wall_s | 0.8757 | 0.9359 | +0.0576 | [+0.0528, +0.0623] |
| client_cpu_s | 1.1553 | 1.0655 | -0.0882 | [-0.0925, -0.0840] |
| broker_user_s | 0.1813 | 0.2947 | +0.1166 | [+0.1109, +0.1223] |
| broker_sys_s | 0.3594 | 0.2963 | -0.0588 | [-0.0638, -0.0537] |
| broker_cpu_s | 0.5383 | 0.5975 | +0.0578 | [+0.0540, +0.0615] |
| broker_vcsw | 45491.0 | 13980.5 | -31405.8 | [-31724.5, -31087.0] |
| broker_maxrss_kib | 8258 | 7024 | -1246 | [-1304, -1189] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
