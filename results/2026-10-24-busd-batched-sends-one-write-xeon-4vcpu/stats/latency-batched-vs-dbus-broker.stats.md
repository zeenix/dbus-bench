candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9356 | 0.9484 | +1.36 | [+0.05, +2.67] | [+0.28, +2.46] | 1.007 | 0.0585 | no material change; repeatable change (+) |
| single_rtt_mean_us | 60 | 187.0 | 189.6 | +1.36 | [+0.05, +2.67] | [+0.28, +2.46] | 1.007 | 0.0585 | no material change; repeatable change (+) |
| single_rtt_p50_us | 60 | 178.0 | 178.4 | +0.22 | [-1.30, +1.79] | [-1.07, +1.54] | 1.000 | 0.8713 | no material change |
| single_rtt_p90_us | 60 | 226.1 | 224.9 | -0.53 | [-2.22, +1.19] | [-1.92, +0.91] | 0.988 | 0.5412 | no material change |
| single_rtt_p99_us | 60 | 326.6 | 324.7 | -0.58 | [-4.28, +3.27] | [-3.69, +2.64] | 1.016 | 0.8655 | no material change |
| single_rtt_p999_us | 60 | 870.6 | 908.5 | +4.36 | [-13.17, +24.86] | [-10.53, +21.24] | 1.031 | 0.8946 | inconclusive |
| single_rtt_max_us | 60 | 3507.0 | 3334.7 | -4.91 | [-37.59, +46.22] | [-33.64, +36.07] | 1.244 | 0.4055 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.3048 | 0.8068 | -38.17 | [-39.94, -36.28] | [-39.66, -36.63] | 0.613 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1265.8 | 781.7 | -38.24 | [-40.04, -36.32] | [-39.76, -36.67] | 0.609 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1210.8 | 737.4 | -39.10 | [-40.84, -37.23] | [-40.59, -37.55] | 0.604 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1831.6 | 1057.3 | -42.28 | [-44.72, -39.68] | [-44.32, -40.12] | 0.547 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2604.4 | 1616.6 | -37.93 | [-41.48, -34.13] | [-40.90, -34.76] | 0.607 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 4313.7 | 3253.7 | -24.57 | [-34.26, -13.64] | [-32.83, -15.49] | 0.648 | 0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 5847.4 | 4776.0 | -18.32 | [-34.30, +1.90] | [-31.90, -1.91] | 0.727 | 0.0121 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3441 | 0.2682 | -22.05 | [-24.94, -19.11] | [-24.43, -19.58] | 0.774 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 70059.2 | 28546.3 | -59.25 | [-60.93, -57.59] | [-60.65, -57.83] | 0.399 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 71263.0 | 28476.5 | -60.04 | [-61.56, -58.46] | [-61.32, -58.70] | 0.392 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 116610.5 | 37533.5 | -67.81 | [-69.88, -65.74] | [-69.53, -66.08] | 0.301 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 130176.9 | 43456.2 | -66.62 | [-68.79, -64.40] | [-68.45, -64.76] | 0.310 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 135503.4 | 45464.0 | -66.45 | [-68.63, -64.21] | [-68.29, -64.58] | 0.319 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 136855.7 | 46216.3 | -66.23 | [-68.43, -63.96] | [-68.09, -64.32] | 0.326 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.5976 | 2.0424 | -21.38 | [-22.66, -20.06] | [-22.46, -20.28] | 0.781 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.2371 | 1.5295 | -31.63 | [-32.86, -30.36] | [-32.66, -30.58] | 0.678 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2617 | 0.5295 | +102.36 | [+95.81, +109.31] | [+96.81, +108.20] | 1.994 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.7451 | 0.6192 | -16.91 | [-18.95, -14.83] | [-18.63, -15.13] | 0.839 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.0068 | 1.1486 | +14.09 | [+12.02, +16.16] | [+12.34, +15.85] | 1.133 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 53214.5 | 13209.1 | -75.18 | [-75.65, -74.70] | [-75.56, -74.77] | 0.251 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11100 | 5112 | -53.94 | [-54.18, -53.70] | [-54.14, -53.74] | 0.461 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9317 | 0.9543 | +0.0127 | [+0.0004, +0.0251] |
| single_rtt_mean_us | 186.2 | 190.8 | +2.5 | [+0.1, +5.0] |
| single_rtt_p50_us | 176.7 | 178.6 | +0.4 | [-2.4, +3.2] |
| single_rtt_p90_us | 224.9 | 225.4 | -1.2 | [-5.1, +2.7] |
| single_rtt_p99_us | 318.2 | 325.1 | -1.9 | [-14.4, +10.6] |
| single_rtt_p999_us | 817.7 | 813.4 | +38.0 | [-129.5, +205.5] |
| single_rtt_max_us | 2387.5 | 2426.7 | -172.4 | [-1728.4, +1383.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.2909 | 0.8025 | -0.4980 | [-0.5307, -0.4654] |
| multi_rtt_mean_us | 1254.3 | 782.8 | -484.1 | [-516.7, -451.4] |
| multi_rtt_p50_us | 1214.7 | 735.9 | -473.4 | [-504.1, -442.7] |
| multi_rtt_p90_us | 1803.4 | 1072.4 | -774.3 | [-842.5, -706.2] |
| multi_rtt_p99_us | 2611.4 | 1578.5 | -987.8 | [-1111.4, -864.3] |
| multi_rtt_p999_us | 3904.3 | 2874.4 | -1060.0 | [-1563.5, -556.4] |
| multi_rtt_max_us | 5107.4 | 3645.1 | -1071.4 | [-2217.6, +74.9] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3402 | 0.2579 | -0.0759 | [-0.0872, -0.0645] |
| fanout_delivery_mean_us | 68806.9 | 27668.2 | -41512.9 | [-43383.5, -39642.3] |
| fanout_delivery_p50_us | 70307.1 | 27557.7 | -42786.4 | [-44664.9, -40908.0] |
| fanout_delivery_p90_us | 112843.3 | 34582.1 | -79076.9 | [-83626.2, -74527.6] |
| fanout_delivery_p99_us | 124742.2 | 38993.9 | -86720.7 | [-92031.6, -81409.8] |
| fanout_delivery_p999_us | 129901.2 | 41790.7 | -90039.4 | [-95450.0, -84628.8] |
| fanout_delivery_max_us | 132699.3 | 42810.6 | -90639.4 | [-96161.1, -85117.8] |
| client_wall_s | 2.5947 | 2.0475 | -0.5553 | [-0.5953, -0.5152] |
| client_cpu_s | 2.2440 | 1.5171 | -0.7076 | [-0.7438, -0.6714] |
| broker_user_s | 0.2633 | 0.5302 | +0.2678 | [+0.2550, +0.2806] |
| broker_sys_s | 0.7468 | 0.6194 | -0.1260 | [-0.1433, -0.1086] |
| broker_cpu_s | 1.0077 | 1.1402 | +0.1419 | [+0.1215, +0.1622] |
| broker_vcsw | 53183.5 | 13251.5 | -40005.4 | [-40887.0, -39123.8] |
| broker_maxrss_kib | 11096 | 5128 | -5987 | [-6028, -5947] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
