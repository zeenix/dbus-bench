candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5575 | 0.3354 | -39.84 | [-40.32, -39.37] | [-40.25, -39.44] | 0.601 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 110.1 | 65.6 | -40.35 | [-40.83, -39.88] | [-40.76, -39.95] | 0.596 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 101.6 | 61.9 | -39.10 | [-39.49, -38.73] | [-39.42, -38.79] | 0.612 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 130.1 | 77.5 | -40.40 | [-41.89, -38.91] | [-41.66, -39.15] | 0.594 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 218.6 | 121.6 | -44.36 | [-46.29, -42.32] | [-45.99, -42.66] | 0.556 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 369.8 | 221.6 | -40.08 | [-44.66, -35.06] | [-43.96, -35.84] | 0.611 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 801.7 | 615.0 | -23.29 | [-40.23, -2.25] | [-37.55, -6.09] | 0.642 | 0.0042 | inconclusive; repeatable change (-) |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1764 | 0.5083 | -56.79 | [-57.06, -56.52] | [-57.02, -56.56] | 0.433 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1162.8 | 502.9 | -56.75 | [-57.02, -56.48] | [-56.98, -56.52] | 0.434 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1094.6 | 486.2 | -55.58 | [-55.77, -55.39] | [-55.74, -55.42] | 0.444 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1424.0 | 546.7 | -61.60 | [-62.29, -60.87] | [-62.19, -60.99] | 0.380 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1788.1 | 917.7 | -48.68 | [-50.36, -47.09] | [-50.06, -47.35] | 0.523 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 2399.6 | 1388.0 | -42.16 | [-45.96, -38.07] | [-45.40, -38.72] | 0.584 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2937.7 | 1761.2 | -40.05 | [-44.20, -35.34] | [-43.60, -36.17] | 0.578 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6205 | 0.2642 | -57.43 | [-57.78, -57.05] | [-57.72, -57.11] | 0.422 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 18754.1 | 23626.8 | +25.98 | [+24.71, +27.35] | [+24.91, +27.14] | 1.248 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 18765.6 | 23513.5 | +25.30 | [+24.05, +26.70] | [+24.25, +26.46] | 1.240 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 27699.6 | 29004.0 | +4.71 | [+3.61, +5.94] | [+3.78, +5.72] | 1.035 | <0.0001 | inconclusive; repeatable change (+) |
| fanout_delivery_p99_us | 60 | 29981.6 | 30700.6 | +2.40 | [+0.87, +4.08] | [+1.10, +3.81] | 1.003 | 0.0823 | no material change; repeatable change (+) |
| fanout_delivery_p999_us | 60 | 31073.0 | 32135.2 | +3.42 | [+1.22, +5.82] | [+1.57, +5.41] | 1.011 | 0.0316 | inconclusive; repeatable change (+) |
| fanout_delivery_max_us | 60 | 31464.7 | 33346.1 | +5.98 | [+3.55, +8.53] | [+3.93, +8.11] | 1.074 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 2.3665 | 1.1466 | -51.55 | [-51.78, -51.31] | [-51.74, -51.35] | 0.484 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.5488 | 0.9874 | -36.24 | [-36.56, -35.92] | [-36.51, -35.98] | 0.637 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7861 | 0.3177 | -59.58 | [-60.07, -59.07] | [-59.99, -59.16] | 0.402 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3566 | 0.3477 | -74.37 | [-74.72, -74.02] | [-74.66, -74.08] | 0.256 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.1427 | 0.6654 | -68.94 | [-69.13, -68.76] | [-69.10, -68.79] | 0.310 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10035.4 | 14030.9 | +39.81 | [+39.49, +40.16] | [+39.54, +40.10] | 1.397 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6329 | 7071 | +11.71 | [+11.07, +12.37] | [+11.18, +12.27] | 1.119 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5565 | 0.3357 | -0.2221 | [-0.2258, -0.2184] |
| single_rtt_mean_us | 109.8 | 65.7 | -44.4 | [-45.2, -43.7] |
| single_rtt_p50_us | 100.9 | 61.7 | -39.7 | [-40.3, -39.2] |
| single_rtt_p90_us | 129.4 | 77.2 | -52.6 | [-55.2, -49.9] |
| single_rtt_p99_us | 218.5 | 121.1 | -97.0 | [-103.1, -90.8] |
| single_rtt_p999_us | 354.4 | 211.9 | -148.2 | [-173.1, -123.4] |
| single_rtt_max_us | 740.9 | 467.2 | -186.7 | [-357.0, -16.5] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1724 | 0.5081 | -0.6681 | [-0.6735, -0.6627] |
| multi_rtt_mean_us | 1160.1 | 502.4 | -659.9 | [-665.3, -654.5] |
| multi_rtt_p50_us | 1093.5 | 488.0 | -608.3 | [-611.8, -604.8] |
| multi_rtt_p90_us | 1413.5 | 536.7 | -877.2 | [-890.3, -864.1] |
| multi_rtt_p99_us | 1715.7 | 922.5 | -870.5 | [-916.2, -824.7] |
| multi_rtt_p999_us | 2470.8 | 1301.9 | -1011.7 | [-1137.0, -886.4] |
| multi_rtt_max_us | 3062.1 | 1617.7 | -1176.5 | [-1339.9, -1013.2] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6203 | 0.2617 | -0.3564 | [-0.3592, -0.3536] |
| fanout_delivery_mean_us | 18728.9 | 23527.8 | +4872.7 | [+4617.9, +5127.5] |
| fanout_delivery_p50_us | 18732.3 | 23236.4 | +4747.9 | [+4493.6, +5002.2] |
| fanout_delivery_p90_us | 27671.0 | 28603.7 | +1304.4 | [+973.5, +1635.2] |
| fanout_delivery_p99_us | 29817.7 | 29918.0 | +719.0 | [+219.5, +1218.5] |
| fanout_delivery_p999_us | 30663.6 | 31465.7 | +1062.3 | [+319.9, +1804.7] |
| fanout_delivery_max_us | 31159.9 | 33399.2 | +1881.3 | [+1075.8, +2686.9] |
| client_wall_s | 2.3662 | 1.1484 | -1.2199 | [-1.2277, -1.2120] |
| client_cpu_s | 1.5519 | 0.9892 | -0.5614 | [-0.5675, -0.5553] |
| broker_user_s | 0.7814 | 0.3166 | -0.4684 | [-0.4747, -0.4621] |
| broker_sys_s | 1.3574 | 0.3444 | -1.0089 | [-1.0162, -1.0016] |
| broker_cpu_s | 2.1411 | 0.6643 | -1.4773 | [-1.4840, -1.4706] |
| broker_vcsw | 10031.0 | 14023.0 | +3995.5 | [+3960.8, +4030.2] |
| broker_maxrss_kib | 6328 | 7060 | +741 | [+702, +781] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
