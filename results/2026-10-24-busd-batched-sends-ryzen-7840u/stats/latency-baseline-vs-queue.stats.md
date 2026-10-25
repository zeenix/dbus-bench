candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3319 | 0.3289 | -0.90 | [-1.78, +0.00] | [-1.63, -0.13] | 0.990 | 0.0386 | no material change |
| single_rtt_mean_us | 60 | 65.0 | 64.4 | -0.91 | [-1.81, +0.01] | [-1.65, -0.13] | 0.990 | 0.0389 | no material change |
| single_rtt_p50_us | 60 | 61.8 | 61.1 | -1.25 | [-2.44, -0.13] | [-2.22, -0.29] | 1.000 | 0.0930 | no material change; repeatable change (-) |
| single_rtt_p90_us | 60 | 73.5 | 72.0 | -1.99 | [-4.90, +0.99] | [-4.44, +0.57] | 0.982 | 0.2347 | no material change |
| single_rtt_p99_us | 60 | 115.2 | 114.1 | -0.96 | [-4.91, +3.13] | [-4.23, +2.48] | 0.989 | 0.5712 | no material change |
| single_rtt_p999_us | 60 | 199.7 | 196.7 | -1.48 | [-7.85, +5.74] | [-6.89, +4.56] | 0.981 | 0.5100 | inconclusive |
| single_rtt_max_us | 60 | 426.5 | 343.2 | -19.52 | [-36.61, +2.85] | [-34.20, -0.81] | 0.984 | 0.5363 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4950 | 0.4942 | -0.16 | [-1.31, +1.05] | [-1.13, +0.86] | 0.994 | 0.6115 | no material change |
| multi_rtt_mean_us | 60 | 491.7 | 490.5 | -0.24 | [-1.36, +0.95] | [-1.18, +0.75] | 0.993 | 0.5171 | no material change |
| multi_rtt_p50_us | 60 | 479.0 | 479.6 | +0.12 | [-0.89, +1.18] | [-0.74, +1.00] | 1.001 | 0.8326 | no material change |
| multi_rtt_p90_us | 60 | 521.7 | 519.3 | -0.47 | [-2.02, +1.16] | [-1.80, +0.89] | 0.992 | 0.4620 | no material change |
| multi_rtt_p99_us | 60 | 807.0 | 799.7 | -0.90 | [-4.33, +2.75] | [-3.86, +2.20] | 0.996 | 0.7019 | no material change |
| multi_rtt_p999_us | 60 | 1192.7 | 1105.4 | -7.33 | [-15.09, +1.32] | [-13.94, +0.02] | 0.984 | 0.1221 | inconclusive |
| multi_rtt_max_us | 60 | 1527.9 | 1354.0 | -11.38 | [-20.48, -1.18] | [-19.08, -2.89] | 0.939 | 0.0798 | inconclusive; repeatable change (-) |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2561 | 0.2559 | -0.08 | [-1.19, +1.07] | [-1.02, +0.87] | 0.997 | 0.7238 | no material change |
| fanout_delivery_mean_us | 60 | 56817.6 | 22866.5 | -59.75 | [-60.39, -59.11] | [-60.29, -59.22] | 0.404 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 57753.5 | 22766.3 | -60.58 | [-61.30, -59.85] | [-61.18, -59.97] | 0.401 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 88909.3 | 27963.1 | -68.55 | [-68.96, -68.12] | [-68.90, -68.19] | 0.313 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 96316.5 | 29082.7 | -69.81 | [-70.29, -69.30] | [-70.22, -69.37] | 0.300 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 97743.6 | 30109.9 | -69.20 | [-69.79, -68.59] | [-69.69, -68.68] | 0.306 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 98078.3 | 31506.0 | -67.88 | [-68.57, -67.17] | [-68.46, -67.29] | 0.323 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1209 | 1.1170 | -0.35 | [-1.09, +0.42] | [-0.98, +0.29] | 0.994 | 0.2959 | no material change |
| client_cpu_s | 60 | 0.9645 | 0.9622 | -0.24 | [-1.07, +0.62] | [-0.94, +0.48] | 0.994 | 0.4181 | no material change |
| broker_user_s | 60 | 0.3020 | 0.2992 | -0.94 | [-2.69, +0.82] | [-2.41, +0.53] | 0.999 | 0.3349 | no material change |
| broker_sys_s | 60 | 0.3349 | 0.3376 | +0.81 | [-0.95, +2.46] | [-0.65, +2.22] | 1.023 | 0.0947 | no material change |
| broker_cpu_s | 60 | 0.6369 | 0.6367 | -0.02 | [-1.02, +0.95] | [-0.85, +0.79] | 0.998 | 0.7797 | no material change |
| broker_vcsw | 60 | 14443.5 | 14155.9 | -1.99 | [-2.27, -1.72] | [-2.23, -1.76] | 0.980 | <0.0001 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 8087 | 7065 | -12.63 | [-13.32, -11.90] | [-13.21, -12.03] | 0.873 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3310 | 0.3292 | -0.0030 | [-0.0060, +0.0001] |
| single_rtt_mean_us | 64.7 | 64.4 | -0.6 | [-1.2, +0.0] |
| single_rtt_p50_us | 60.6 | 60.6 | -0.8 | [-1.5, -0.0] |
| single_rtt_p90_us | 71.8 | 70.1 | -1.5 | [-3.7, +0.8] |
| single_rtt_p99_us | 114.0 | 112.8 | -1.1 | [-5.9, +3.7] |
| single_rtt_p999_us | 192.9 | 185.8 | -2.9 | [-17.2, +11.3] |
| single_rtt_max_us | 293.3 | 303.4 | -83.3 | [-185.2, +18.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4916 | 0.4900 | -0.0008 | [-0.0068, +0.0052] |
| multi_rtt_mean_us | 488.6 | 486.4 | -1.2 | [-7.0, +4.7] |
| multi_rtt_p50_us | 474.9 | 474.9 | +0.6 | [-4.5, +5.7] |
| multi_rtt_p90_us | 519.5 | 514.7 | -2.4 | [-11.1, +6.2] |
| multi_rtt_p99_us | 810.9 | 812.7 | -7.3 | [-37.1, +22.5] |
| multi_rtt_p999_us | 1103.0 | 1044.2 | -87.4 | [-194.1, +19.3] |
| multi_rtt_max_us | 1368.4 | 1283.5 | -173.9 | [-339.7, -8.1] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2527 | 0.2527 | -0.0002 | [-0.0032, +0.0028] |
| fanout_delivery_mean_us | 55818.7 | 22760.5 | -33951.1 | [-34655.0, -33247.2] |
| fanout_delivery_p50_us | 56060.9 | 22482.4 | -34987.2 | [-35907.2, -34067.3] |
| fanout_delivery_p90_us | 87856.1 | 27579.6 | -60946.2 | [-61829.1, -60063.4] |
| fanout_delivery_p99_us | 94497.3 | 28316.3 | -67233.8 | [-68272.9, -66194.7] |
| fanout_delivery_p999_us | 96495.6 | 29469.8 | -67633.7 | [-68784.1, -66483.3] |
| fanout_delivery_max_us | 97119.5 | 32061.7 | -66572.3 | [-67813.1, -65331.4] |
| client_wall_s | 1.1174 | 1.1125 | -0.0039 | [-0.0127, +0.0049] |
| client_cpu_s | 0.9612 | 0.9544 | -0.0023 | [-0.0107, +0.0061] |
| broker_user_s | 0.3015 | 0.2994 | -0.0028 | [-0.0083, +0.0026] |
| broker_sys_s | 0.3328 | 0.3372 | +0.0027 | [-0.0031, +0.0085] |
| broker_cpu_s | 0.6334 | 0.6361 | -0.0001 | [-0.0065, +0.0063] |
| broker_vcsw | 14445.5 | 14172.0 | -287.6 | [-329.7, -245.5] |
| broker_maxrss_kib | 8156 | 7062 | -1021 | [-1088, -954] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
