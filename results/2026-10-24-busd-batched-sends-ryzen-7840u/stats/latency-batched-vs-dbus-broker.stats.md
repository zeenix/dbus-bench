candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2843 | 0.3315 | +16.63 | [+15.60, +17.67] | [+15.76, +17.50] | 1.158 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.4 | 64.9 | +17.14 | [+16.09, +18.20] | [+16.25, +18.02] | 1.163 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 53.9 | 61.5 | +14.22 | [+13.16, +15.31] | [+13.32, +15.14] | 1.133 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 60.2 | 72.5 | +20.53 | [+17.71, +23.55] | [+18.11, +23.04] | 1.178 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 84.7 | 116.9 | +38.00 | [+32.70, +43.45] | [+33.54, +42.58] | 1.401 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 147.5 | 207.4 | +40.62 | [+32.14, +49.55] | [+33.49, +47.99] | 1.380 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 357.2 | 417.6 | +16.90 | [-6.87, +47.57] | [-3.95, +42.41] | 1.097 | 0.1586 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4958 | 0.4953 | -0.11 | [-1.16, +0.93] | [-0.99, +0.77] | 0.998 | 0.8713 | no material change |
| multi_rtt_mean_us | 60 | 468.4 | 491.8 | +5.00 | [+3.85, +6.13] | [+4.04, +5.96] | 1.049 | <0.0001 | inconclusive; repeatable change (+) |
| multi_rtt_p50_us | 60 | 510.8 | 480.4 | -5.96 | [-6.67, -5.22] | [-6.57, -5.34] | 0.937 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 558.8 | 517.4 | -7.41 | [-8.95, -5.93] | [-8.69, -6.15] | 0.930 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 675.0 | 822.5 | +21.85 | [+16.98, +26.88] | [+17.71, +25.99] | 1.235 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 974.3 | 1137.4 | +16.74 | [+6.19, +27.72] | [+7.80, +25.98] | 1.264 | <0.0001 | slower/larger |
| multi_rtt_max_us | 60 | 1271.8 | 1478.9 | +16.28 | [+3.27, +30.34] | [+5.32, +28.11] | 1.226 | 0.0005 | inconclusive; repeatable change (+) |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2548 | 0.2481 | -2.61 | [-3.69, -1.51] | [-3.52, -1.70] | 0.976 | <0.0001 | no material change; repeatable change (-) |
| fanout_delivery_mean_us | 60 | 52713.9 | 26189.7 | -50.32 | [-50.99, -49.63] | [-50.88, -49.75] | 0.497 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 55321.0 | 26947.4 | -51.29 | [-51.92, -50.65] | [-51.82, -50.75] | 0.487 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 84386.7 | 32242.2 | -61.79 | [-62.28, -61.29] | [-62.20, -61.38] | 0.380 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 89894.3 | 34372.5 | -61.76 | [-62.39, -61.12] | [-62.29, -61.23] | 0.379 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 94314.3 | 37400.5 | -60.34 | [-60.90, -59.81] | [-60.80, -59.89] | 0.396 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 94768.5 | 37995.4 | -59.91 | [-60.43, -59.36] | [-60.34, -59.45] | 0.399 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0418 | 1.1137 | +6.91 | [+6.08, +7.69] | [+6.22, +7.56] | 1.072 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.9629 | 0.9568 | -0.63 | [-1.47, +0.20] | [-1.32, +0.06] | 0.994 | 0.1619 | no material change |
| broker_user_s | 60 | 0.1706 | 0.2906 | +70.29 | [+66.62, +74.03] | [+67.17, +73.46] | 1.719 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3562 | 0.3016 | -15.32 | [-16.69, -13.97] | [-16.45, -14.18] | 0.851 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5268 | 0.5922 | +12.41 | [+11.33, +13.47] | [+11.51, +13.31] | 1.123 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 47687.6 | 14118.2 | -70.39 | [-70.61, -70.17] | [-70.58, -70.21] | 0.296 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11864 | 7091 | -40.23 | [-40.56, -39.92] | [-40.50, -39.97] | 0.599 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2832 | 0.3297 | +0.0473 | [+0.0443, +0.0502] |
| single_rtt_mean_us | 55.2 | 64.5 | +9.5 | [+8.9, +10.1] |
| single_rtt_p50_us | 53.4 | 60.6 | +7.7 | [+7.1, +8.2] |
| single_rtt_p90_us | 59.4 | 70.1 | +12.3 | [+10.6, +14.1] |
| single_rtt_p99_us | 86.7 | 118.1 | +32.2 | [+28.1, +36.3] |
| single_rtt_p999_us | 147.2 | 197.1 | +59.9 | [+48.0, +71.9] |
| single_rtt_max_us | 263.6 | 333.6 | +60.4 | [-34.9, +155.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4915 | 0.4922 | -0.0005 | [-0.0059, +0.0048] |
| multi_rtt_mean_us | 464.2 | 489.0 | +23.4 | [+18.1, +28.8] |
| multi_rtt_p50_us | 510.5 | 476.1 | -30.4 | [-34.4, -26.4] |
| multi_rtt_p90_us | 550.9 | 515.3 | -41.4 | [-50.5, -32.3] |
| multi_rtt_p99_us | 643.5 | 839.4 | +147.5 | [+116.3, +178.6] |
| multi_rtt_p999_us | 876.8 | 1093.5 | +163.1 | [+66.2, +260.0] |
| multi_rtt_max_us | 1107.8 | 1352.9 | +207.1 | [+45.3, +368.9] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2505 | 0.2447 | -0.0066 | [-0.0096, -0.0037] |
| fanout_delivery_mean_us | 52020.2 | 26156.4 | -26524.2 | [-27104.6, -25943.8] |
| fanout_delivery_p50_us | 54410.0 | 26690.3 | -28373.6 | [-29006.0, -27741.2] |
| fanout_delivery_p90_us | 83277.8 | 31833.7 | -52144.5 | [-53018.1, -51270.9] |
| fanout_delivery_p99_us | 88668.8 | 34097.4 | -55521.8 | [-56513.9, -54529.6] |
| fanout_delivery_p999_us | 93098.1 | 37078.1 | -56913.9 | [-57879.2, -55948.5] |
| fanout_delivery_max_us | 93580.1 | 37515.6 | -56773.1 | [-57732.0, -55814.3] |
| client_wall_s | 1.0343 | 1.1080 | +0.0719 | [+0.0636, +0.0803] |
| client_cpu_s | 0.9594 | 0.9523 | -0.0060 | [-0.0144, +0.0024] |
| broker_user_s | 0.1707 | 0.2912 | +0.1199 | [+0.1148, +0.1251] |
| broker_sys_s | 0.3554 | 0.3043 | -0.0546 | [-0.0599, -0.0492] |
| broker_cpu_s | 0.5237 | 0.5899 | +0.0654 | [+0.0598, +0.0709] |
| broker_vcsw | 47855.5 | 14121.0 | -33569.4 | [-33929.9, -33208.9] |
| broker_maxrss_kib | 11838 | 7092 | -4773 | [-4830, -4715] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
