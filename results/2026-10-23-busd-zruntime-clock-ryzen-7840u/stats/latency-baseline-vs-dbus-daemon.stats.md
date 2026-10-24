candidate baseline against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5377 | 0.3275 | -39.09 | [-39.64, -38.53] | [-39.56, -38.62] | 0.612 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 106.1 | 64.1 | -39.61 | [-40.17, -39.05] | [-40.08, -39.14] | 0.607 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 100.1 | 61.0 | -39.05 | [-39.58, -38.62] | [-39.48, -38.68] | 0.614 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 116.3 | 70.1 | -39.73 | [-41.03, -38.39] | [-40.83, -38.61] | 0.609 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 194.1 | 114.7 | -40.94 | [-42.79, -39.06] | [-42.48, -39.33] | 0.599 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 304.7 | 196.1 | -35.64 | [-38.48, -32.67] | [-38.02, -33.23] | 0.640 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 606.7 | 385.5 | -36.46 | [-47.87, -22.45] | [-46.21, -25.00] | 0.659 | <0.0001 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1379 | 0.4926 | -56.71 | [-56.98, -56.42] | [-56.94, -56.47] | 0.431 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1123.6 | 489.4 | -56.45 | [-56.71, -56.16] | [-56.68, -56.21] | 0.434 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1062.7 | 478.0 | -55.02 | [-55.26, -54.75] | [-55.23, -54.80] | 0.448 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1364.8 | 516.3 | -62.17 | [-62.49, -61.84] | [-62.44, -61.89] | 0.375 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1669.1 | 788.6 | -52.76 | [-54.24, -51.33] | [-54.00, -51.52] | 0.477 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 1967.9 | 1137.6 | -42.19 | [-45.64, -38.27] | [-45.14, -38.92] | 0.557 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2484.1 | 1405.1 | -43.44 | [-47.50, -39.14] | [-46.85, -39.79] | 0.586 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6075 | 0.2553 | -57.97 | [-58.26, -57.65] | [-58.22, -57.70] | 0.418 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 18349.0 | 56443.2 | +207.61 | [+204.80, +210.56] | [+205.27, +210.08] | 3.060 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 18355.6 | 57505.1 | +213.28 | [+209.57, +217.27] | [+210.13, +216.63] | 3.071 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 27110.9 | 88729.0 | +227.28 | [+224.46, +230.34] | [+224.88, +229.84] | 3.261 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 29351.7 | 95828.8 | +226.48 | [+223.35, +229.81] | [+223.84, +229.22] | 3.259 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 30529.0 | 97620.5 | +219.76 | [+215.54, +224.24] | [+216.13, +223.49] | 3.169 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 30982.3 | 97897.5 | +215.98 | [+211.54, +220.71] | [+212.19, +219.91] | 3.122 | <0.0001 | slower/larger |
| client_wall_s | 60 | 2.2951 | 1.1126 | -51.53 | [-51.76, -51.28] | [-51.72, -51.32] | 0.484 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.5047 | 0.9572 | -36.39 | [-36.67, -36.09] | [-36.62, -36.14] | 0.634 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7608 | 0.2980 | -60.83 | [-61.29, -60.36] | [-61.22, -60.44] | 0.393 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3162 | 0.3336 | -74.66 | [-74.92, -74.40] | [-74.88, -74.44] | 0.254 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0770 | 0.6315 | -69.59 | [-69.77, -69.41] | [-69.74, -69.44] | 0.303 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10032.5 | 14479.7 | +44.33 | [+44.03, +44.61] | [+44.08, +44.57] | 1.442 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6314 | 8150 | +29.08 | [+27.92, +30.26] | [+28.11, +30.04] | 1.295 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5325 | 0.3270 | -0.2102 | [-0.2150, -0.2054] |
| single_rtt_mean_us | 105.1 | 64.0 | -42.0 | [-43.0, -41.1] |
| single_rtt_p50_us | 98.5 | 60.6 | -39.1 | [-39.9, -38.3] |
| single_rtt_p90_us | 116.4 | 68.9 | -46.2 | [-48.6, -43.9] |
| single_rtt_p99_us | 197.1 | 115.2 | -79.5 | [-85.1, -73.8] |
| single_rtt_p999_us | 302.2 | 190.0 | -108.6 | [-119.8, -97.4] |
| single_rtt_max_us | 457.1 | 320.0 | -221.2 | [-327.1, -115.4] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1323 | 0.4894 | -0.6453 | [-0.6500, -0.6406] |
| multi_rtt_mean_us | 1117.7 | 486.4 | -634.3 | [-639.0, -629.6] |
| multi_rtt_p50_us | 1058.5 | 474.3 | -584.7 | [-588.8, -580.7] |
| multi_rtt_p90_us | 1358.9 | 513.5 | -848.5 | [-855.9, -841.1] |
| multi_rtt_p99_us | 1665.2 | 802.0 | -880.6 | [-908.9, -852.2] |
| multi_rtt_p999_us | 1905.1 | 1059.7 | -830.3 | [-916.0, -744.6] |
| multi_rtt_max_us | 2434.6 | 1331.0 | -1079.1 | [-1234.9, -923.3] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6060 | 0.2525 | -0.3522 | [-0.3549, -0.3495] |
| fanout_delivery_mean_us | 18300.5 | 55930.8 | +38094.2 | [+37577.0, +38611.5] |
| fanout_delivery_p50_us | 18304.9 | 56042.5 | +39149.5 | [+38445.2, +39853.8] |
| fanout_delivery_p90_us | 27050.6 | 88024.1 | +61618.1 | [+60832.4, +62403.8] |
| fanout_delivery_p99_us | 29294.7 | 94699.8 | +66477.1 | [+65668.8, +67285.5] |
| fanout_delivery_p999_us | 30630.4 | 96027.8 | +67091.4 | [+66109.2, +68073.7] |
| fanout_delivery_max_us | 31288.8 | 96164.4 | +66915.2 | [+65905.7, +67924.8] |
| client_wall_s | 2.2863 | 1.1114 | -1.1826 | [-1.1911, -1.1741] |
| client_cpu_s | 1.4977 | 0.9512 | -0.5475 | [-0.5532, -0.5418] |
| broker_user_s | 0.7592 | 0.2960 | -0.4628 | [-0.4683, -0.4573] |
| broker_sys_s | 1.3149 | 0.3330 | -0.9827 | [-0.9897, -0.9756] |
| broker_cpu_s | 2.0689 | 0.6280 | -1.4455 | [-1.4528, -1.4382] |
| broker_vcsw | 10026.5 | 14467.5 | +4447.2 | [+4417.1, +4477.4] |
| broker_maxrss_kib | 6302 | 8218 | +1836 | [+1768, +1904] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
