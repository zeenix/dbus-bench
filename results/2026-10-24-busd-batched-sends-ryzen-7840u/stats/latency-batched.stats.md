candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3289 | 0.3315 | +0.80 | [-0.08, +1.71] | [+0.05, +1.56] | 1.006 | 0.1007 | no material change |
| single_rtt_mean_us | 60 | 64.4 | 64.9 | +0.82 | [-0.07, +1.74] | [+0.06, +1.59] | 1.007 | 0.0904 | no material change |
| single_rtt_p50_us | 60 | 61.1 | 61.5 | +0.75 | [-0.13, +1.69] | [-0.00, +1.53] | 1.000 | 0.1779 | no material change |
| single_rtt_p90_us | 60 | 72.0 | 72.5 | +0.71 | [-2.11, +3.70] | [-1.68, +3.21] | 1.017 | 0.6010 | no material change |
| single_rtt_p99_us | 60 | 114.1 | 116.9 | +2.44 | [-1.70, +6.69] | [-0.99, +6.00] | 1.037 | 0.2958 | inconclusive |
| single_rtt_p999_us | 60 | 196.7 | 207.4 | +5.44 | [-3.04, +14.16] | [-1.64, +12.68] | 1.062 | 0.1022 | inconclusive |
| single_rtt_max_us | 60 | 343.2 | 417.6 | +21.67 | [-0.08, +48.04] | [+2.98, +43.30] | 1.077 | 0.2245 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4942 | 0.4953 | +0.22 | [-0.72, +1.14] | [-0.58, +0.99] | 1.003 | 0.3931 | no material change |
| multi_rtt_mean_us | 60 | 490.5 | 491.8 | +0.26 | [-0.65, +1.15] | [-0.51, +1.00] | 1.004 | 0.3349 | no material change |
| multi_rtt_p50_us | 60 | 479.6 | 480.4 | +0.17 | [-0.69, +1.01] | [-0.56, +0.87] | 1.003 | 0.5029 | no material change |
| multi_rtt_p90_us | 60 | 519.3 | 517.4 | -0.37 | [-1.64, +0.89] | [-1.42, +0.70] | 0.995 | 0.6398 | no material change |
| multi_rtt_p99_us | 60 | 799.7 | 822.5 | +2.86 | [-0.55, +6.31] | [+0.03, +5.75] | 1.042 | 0.0748 | inconclusive |
| multi_rtt_p999_us | 60 | 1105.4 | 1137.4 | +2.90 | [-4.02, +9.93] | [-2.95, +8.83] | 1.033 | 0.1053 | inconclusive |
| multi_rtt_max_us | 60 | 1354.0 | 1478.9 | +9.23 | [-0.66, +19.94] | [+0.79, +18.25] | 1.098 | 0.0636 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2559 | 0.2481 | -3.04 | [-4.03, -2.04] | [-3.87, -2.19] | 0.969 | <0.0001 | no material change; repeatable change (-) |
| fanout_delivery_mean_us | 60 | 22866.5 | 26189.7 | +14.53 | [+12.91, +16.25] | [+13.16, +15.97] | 1.144 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 22766.3 | 26947.4 | +18.37 | [+16.97, +19.81] | [+17.19, +19.57] | 1.184 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 27963.1 | 32242.2 | +15.30 | [+13.85, +16.80] | [+14.08, +16.56] | 1.158 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 29082.7 | 34372.5 | +18.19 | [+15.82, +20.61] | [+16.19, +20.23] | 1.182 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 30109.9 | 37400.5 | +24.21 | [+21.75, +26.75] | [+22.14, +26.30] | 1.253 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 31506.0 | 37995.4 | +20.60 | [+17.88, +23.50] | [+18.29, +23.00] | 1.207 | <0.0001 | slower/larger |
| client_wall_s | 60 | 1.1170 | 1.1137 | -0.29 | [-0.91, +0.33] | [-0.81, +0.22] | 0.997 | 0.5910 | no material change |
| client_cpu_s | 60 | 0.9622 | 0.9568 | -0.56 | [-1.27, +0.15] | [-1.16, +0.03] | 0.997 | 0.1709 | no material change |
| broker_user_s | 60 | 0.2992 | 0.2906 | -2.87 | [-4.72, -1.03] | [-4.42, -1.32] | 0.970 | 0.0074 | no material change; repeatable change (-) |
| broker_sys_s | 60 | 0.3376 | 0.3016 | -10.65 | [-11.94, -9.36] | [-11.73, -9.57] | 0.898 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6367 | 0.5922 | -7.00 | [-7.78, -6.22] | [-7.65, -6.34] | 0.928 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14155.9 | 14118.2 | -0.27 | [-0.54, +0.01] | [-0.50, -0.03] | 0.998 | 0.1045 | no material change |
| broker_maxrss_kib | 60 | 7065 | 7091 | +0.36 | [-0.11, +0.84] | [-0.03, +0.76] | 1.006 | 0.1852 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3292 | 0.3297 | +0.0026 | [-0.0004, +0.0057] |
| single_rtt_mean_us | 64.4 | 64.5 | +0.5 | [-0.1, +1.1] |
| single_rtt_p50_us | 60.6 | 60.6 | +0.5 | [-0.1, +1.0] |
| single_rtt_p90_us | 70.1 | 70.1 | +0.5 | [-1.6, +2.7] |
| single_rtt_p99_us | 112.8 | 118.1 | +2.8 | [-2.0, +7.6] |
| single_rtt_p999_us | 185.8 | 197.1 | +10.7 | [-6.4, +27.8] |
| single_rtt_max_us | 303.4 | 333.6 | +74.4 | [-7.1, +155.8] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4900 | 0.4922 | +0.0011 | [-0.0036, +0.0058] |
| multi_rtt_mean_us | 486.4 | 489.0 | +1.3 | [-3.2, +5.8] |
| multi_rtt_p50_us | 474.9 | 476.1 | +0.8 | [-3.3, +5.0] |
| multi_rtt_p90_us | 514.7 | 515.3 | -1.9 | [-8.7, +4.8] |
| multi_rtt_p99_us | 812.7 | 839.4 | +22.8 | [-4.9, +50.5] |
| multi_rtt_p999_us | 1044.2 | 1093.5 | +32.0 | [-46.6, +110.7] |
| multi_rtt_max_us | 1283.5 | 1352.9 | +125.0 | [-14.6, +264.5] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2527 | 0.2447 | -0.0078 | [-0.0104, -0.0051] |
| fanout_delivery_mean_us | 22760.5 | 26156.4 | +3323.3 | [+2953.2, +3693.4] |
| fanout_delivery_p50_us | 22482.4 | 26690.3 | +4181.1 | [+3874.4, +4487.8] |
| fanout_delivery_p90_us | 27579.6 | 31833.7 | +4279.1 | [+3883.6, +4674.7] |
| fanout_delivery_p99_us | 28316.3 | 34097.4 | +5289.8 | [+4623.0, +5956.6] |
| fanout_delivery_p999_us | 29469.8 | 37078.1 | +7290.6 | [+6619.6, +7961.5] |
| fanout_delivery_max_us | 32061.7 | 37515.6 | +6489.4 | [+5689.3, +7289.5] |
| client_wall_s | 1.1125 | 1.1080 | -0.0033 | [-0.0104, +0.0039] |
| client_cpu_s | 0.9544 | 0.9523 | -0.0054 | [-0.0125, +0.0018] |
| broker_user_s | 0.2994 | 0.2912 | -0.0086 | [-0.0143, -0.0028] |
| broker_sys_s | 0.3372 | 0.3043 | -0.0360 | [-0.0407, -0.0312] |
| broker_cpu_s | 0.6361 | 0.5899 | -0.0446 | [-0.0498, -0.0393] |
| broker_vcsw | 14172.0 | 14121.0 | -37.7 | [-77.9, +2.6] |
| broker_maxrss_kib | 7062 | 7092 | +26 | [-8, +59] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
