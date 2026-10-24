candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2843 | 0.3289 | +15.71 | [+14.74, +16.63] | [+14.91, +16.49] | 1.159 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.4 | 64.4 | +16.19 | [+15.21, +17.13] | [+15.38, +16.99] | 1.164 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 53.9 | 61.1 | +13.37 | [+12.45, +14.26] | [+12.61, +14.12] | 1.133 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 60.2 | 72.0 | +19.67 | [+16.79, +22.64] | [+17.27, +22.09] | 1.188 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 84.7 | 114.1 | +34.70 | [+29.18, +40.44] | [+30.09, +39.49] | 1.319 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 147.5 | 196.7 | +33.36 | [+23.82, +44.17] | [+25.28, +42.32] | 1.258 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 357.2 | 343.2 | -3.92 | [-20.16, +16.71] | [-18.07, +13.22] | 0.979 | 0.8396 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4958 | 0.4942 | -0.33 | [-1.34, +0.69] | [-1.19, +0.52] | 0.992 | 0.2993 | no material change |
| multi_rtt_mean_us | 60 | 468.4 | 490.5 | +4.73 | [+3.64, +5.82] | [+3.80, +5.66] | 1.045 | <0.0001 | inconclusive; repeatable change (+) |
| multi_rtt_p50_us | 60 | 510.8 | 479.6 | -6.12 | [-6.80, -5.36] | [-6.71, -5.49] | 0.934 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 558.8 | 519.3 | -7.06 | [-8.57, -5.63] | [-8.28, -5.85] | 0.924 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 675.0 | 799.7 | +18.47 | [+14.17, +22.74] | [+14.90, +22.05] | 1.191 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 974.3 | 1105.4 | +13.45 | [+3.37, +24.26] | [+4.77, +22.55] | 1.198 | 0.0003 | inconclusive; repeatable change (+) |
| multi_rtt_max_us | 60 | 1271.8 | 1354.0 | +6.46 | [-5.21, +19.33] | [-3.19, +17.08] | 1.116 | 0.0538 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2548 | 0.2559 | +0.44 | [-0.65, +1.55] | [-0.47, +1.35] | 1.004 | 0.1532 | no material change |
| fanout_delivery_mean_us | 60 | 52713.9 | 22866.5 | -56.62 | [-57.21, -56.03] | [-57.12, -56.12] | 0.434 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 55321.0 | 22766.3 | -58.85 | [-59.39, -58.27] | [-59.31, -58.37] | 0.411 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 84386.7 | 27963.1 | -66.86 | [-67.31, -66.41] | [-67.23, -66.49] | 0.331 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 89894.3 | 29082.7 | -67.65 | [-68.16, -67.10] | [-68.08, -67.19] | 0.319 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 94314.3 | 30109.9 | -68.07 | [-68.65, -67.46] | [-68.57, -67.57] | 0.314 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 94768.5 | 31506.0 | -66.75 | [-67.42, -66.06] | [-67.32, -66.17] | 0.330 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0418 | 1.1170 | +7.22 | [+6.40, +8.00] | [+6.53, +7.88] | 1.071 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.9629 | 0.9622 | -0.07 | [-0.90, +0.75] | [-0.76, +0.62] | 1.000 | 0.9179 | no material change |
| broker_user_s | 60 | 0.1706 | 0.2992 | +75.33 | [+71.77, +78.90] | [+72.34, +78.35] | 1.726 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3562 | 0.3376 | -5.22 | [-6.39, -4.08] | [-6.20, -4.25] | 0.959 | <0.0001 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.5268 | 0.6367 | +20.87 | [+19.71, +21.97] | [+19.91, +21.80] | 1.216 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 47687.6 | 14155.9 | -70.32 | [-70.54, -70.09] | [-70.50, -70.12] | 0.297 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11864 | 7065 | -40.45 | [-40.79, -40.11] | [-40.73, -40.16] | 0.597 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2832 | 0.3292 | +0.0447 | [+0.0421, +0.0472] |
| single_rtt_mean_us | 55.2 | 64.4 | +9.0 | [+8.5, +9.5] |
| single_rtt_p50_us | 53.4 | 60.6 | +7.2 | [+6.7, +7.7] |
| single_rtt_p90_us | 59.4 | 70.1 | +11.8 | [+10.1, +13.6] |
| single_rtt_p99_us | 86.7 | 112.8 | +29.4 | [+25.0, +33.8] |
| single_rtt_p999_us | 147.2 | 185.8 | +49.2 | [+34.9, +63.5] |
| single_rtt_max_us | 263.6 | 303.4 | -14.0 | [-83.6, +55.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4915 | 0.4900 | -0.0016 | [-0.0068, +0.0035] |
| multi_rtt_mean_us | 464.2 | 486.4 | +22.2 | [+17.0, +27.3] |
| multi_rtt_p50_us | 510.5 | 474.9 | -31.3 | [-35.2, -27.4] |
| multi_rtt_p90_us | 550.9 | 514.7 | -39.5 | [-48.3, -30.7] |
| multi_rtt_p99_us | 643.5 | 812.7 | +124.6 | [+98.0, +151.3] |
| multi_rtt_p999_us | 876.8 | 1044.2 | +131.1 | [+35.6, +226.5] |
| multi_rtt_max_us | 1107.8 | 1283.5 | +82.1 | [-67.5, +231.7] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2505 | 0.2527 | +0.0011 | [-0.0017, +0.0040] |
| fanout_delivery_mean_us | 52020.2 | 22760.5 | -29847.4 | [-30408.2, -29286.7] |
| fanout_delivery_p50_us | 54410.0 | 22482.4 | -32554.7 | [-33188.5, -31920.9] |
| fanout_delivery_p90_us | 83277.8 | 27579.6 | -56423.7 | [-57295.3, -55552.0] |
| fanout_delivery_p99_us | 88668.8 | 28316.3 | -60811.5 | [-61744.7, -59878.3] |
| fanout_delivery_p999_us | 93098.1 | 29469.8 | -64204.4 | [-65216.3, -63192.6] |
| fanout_delivery_max_us | 93580.1 | 32061.7 | -63262.5 | [-64325.6, -62199.4] |
| client_wall_s | 1.0343 | 1.1125 | +0.0752 | [+0.0670, +0.0834] |
| client_cpu_s | 0.9594 | 0.9544 | -0.0006 | [-0.0087, +0.0074] |
| broker_user_s | 0.1707 | 0.2994 | +0.1285 | [+0.1239, +0.1332] |
| broker_sys_s | 0.3554 | 0.3372 | -0.0186 | [-0.0230, -0.0142] |
| broker_cpu_s | 0.5237 | 0.6361 | +0.1099 | [+0.1044, +0.1155] |
| broker_vcsw | 47855.5 | 14172.0 | -33531.7 | [-33893.8, -33169.7] |
| broker_maxrss_kib | 11838 | 7062 | -4798 | [-4857, -4739] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
