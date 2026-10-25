candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9958 | 0.9596 | -3.64 | [-5.02, -2.19] | [-4.79, -2.42] | 0.968 | 0.0001 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 199.1 | 191.8 | -3.64 | [-5.02, -2.19] | [-4.79, -2.42] | 0.968 | 0.0001 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 188.4 | 180.5 | -4.21 | [-5.71, -2.67] | [-5.46, -2.94] | 0.961 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p90_us | 60 | 236.5 | 229.4 | -3.00 | [-4.74, -1.22] | [-4.46, -1.49] | 0.969 | 0.0071 | no material change; repeatable change (-) |
| single_rtt_p99_us | 60 | 347.4 | 334.7 | -3.67 | [-7.74, +0.92] | [-7.05, +0.10] | 0.941 | 0.0538 | inconclusive |
| single_rtt_p999_us | 60 | 988.2 | 950.5 | -3.82 | [-17.05, +11.64] | [-14.91, +9.31] | 1.054 | 0.9824 | inconclusive |
| single_rtt_max_us | 60 | 3301.9 | 3036.3 | -8.05 | [-26.73, +16.79] | [-24.21, +12.31] | 1.034 | 0.9941 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.9567 | 0.8048 | -15.88 | [-18.69, -12.83] | [-18.26, -13.39] | 0.825 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 938.3 | 781.8 | -16.68 | [-19.49, -13.66] | [-19.04, -14.20] | 0.814 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 850.6 | 736.9 | -13.37 | [-16.40, -10.00] | [-15.97, -10.61] | 0.859 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1375.4 | 1056.5 | -23.18 | [-26.90, -19.17] | [-26.38, -19.82] | 0.778 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2098.6 | 1590.7 | -24.20 | [-27.66, -20.64] | [-27.14, -21.19] | 0.747 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3929.8 | 3026.1 | -22.99 | [-33.98, -10.84] | [-32.19, -12.88] | 0.781 | 0.0005 | faster/smaller |
| multi_rtt_max_us | 60 | 5763.5 | 4318.4 | -25.07 | [-40.42, -7.23] | [-38.09, -10.16] | 0.788 | 0.0039 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3935 | 0.2645 | -32.79 | [-35.06, -30.40] | [-34.68, -30.79] | 0.676 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 74573.4 | 27263.8 | -63.44 | [-64.96, -61.84] | [-64.70, -62.10] | 0.367 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 60838.2 | 27626.7 | -54.59 | [-56.90, -52.20] | [-56.55, -52.61] | 0.474 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 161406.1 | 35117.2 | -78.24 | [-79.27, -77.09] | [-79.11, -77.28] | 0.211 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 192619.1 | 39961.1 | -79.25 | [-80.43, -77.98] | [-80.24, -78.21] | 0.197 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 196942.8 | 42514.6 | -78.41 | [-79.58, -77.12] | [-79.38, -77.34] | 0.204 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 198432.1 | 43540.9 | -78.06 | [-79.20, -76.78] | [-79.02, -77.00] | 0.209 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.3637 | 2.0476 | -13.37 | [-14.90, -11.70] | [-14.67, -12.00] | 0.864 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.6924 | 1.5328 | -9.43 | [-11.04, -7.67] | [-10.78, -7.99] | 0.893 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.8643 | 0.5502 | -36.33 | [-38.38, -34.19] | [-38.05, -34.56] | 0.635 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7790 | 0.6094 | -21.78 | [-24.36, -19.13] | [-23.91, -19.56] | 0.782 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.6433 | 1.1596 | -29.43 | [-31.03, -27.73] | [-30.79, -28.00] | 0.701 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14990.7 | 13101.2 | -12.60 | [-14.17, -11.00] | [-13.92, -11.25] | 0.865 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 6156 | 5161 | -16.17 | [-16.71, -15.64] | [-16.63, -15.72] | 0.840 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 1.0098 | 0.9592 | -0.0362 | [-0.0511, -0.0213] |
| single_rtt_mean_us | 201.8 | 191.7 | -7.2 | [-10.2, -4.3] |
| single_rtt_p50_us | 191.0 | 179.6 | -7.9 | [-11.0, -4.9] |
| single_rtt_p90_us | 238.8 | 230.7 | -7.1 | [-11.5, -2.7] |
| single_rtt_p99_us | 343.8 | 326.8 | -12.7 | [-28.5, +3.0] |
| single_rtt_p999_us | 962.3 | 920.5 | -37.7 | [-187.3, +111.8] |
| single_rtt_max_us | 2680.4 | 2653.0 | -265.7 | [-1043.8, +512.4] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.9358 | 0.7859 | -0.1519 | [-0.1840, -0.1198] |
| multi_rtt_mean_us | 918.1 | 761.5 | -156.5 | [-188.0, -125.0] |
| multi_rtt_p50_us | 836.5 | 728.9 | -113.7 | [-144.3, -83.1] |
| multi_rtt_p90_us | 1334.8 | 1024.5 | -318.9 | [-386.2, -251.6] |
| multi_rtt_p99_us | 2115.8 | 1576.3 | -507.9 | [-597.3, -418.5] |
| multi_rtt_p999_us | 3384.6 | 2594.7 | -903.6 | [-1467.2, -340.0] |
| multi_rtt_max_us | 4321.4 | 3339.5 | -1445.1 | [-2667.8, -222.4] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3844 | 0.2573 | -0.1290 | [-0.1409, -0.1172] |
| fanout_delivery_mean_us | 72030.9 | 26327.4 | -47309.6 | [-49902.0, -44717.2] |
| fanout_delivery_p50_us | 57982.2 | 26789.4 | -33211.5 | [-36035.2, -30387.8] |
| fanout_delivery_p90_us | 160735.0 | 32767.5 | -126288.9 | [-131510.2, -121067.7] |
| fanout_delivery_p99_us | 193834.7 | 36979.7 | -152658.0 | [-158515.2, -146800.8] |
| fanout_delivery_p999_us | 197017.5 | 39155.7 | -154428.2 | [-160383.1, -148473.3] |
| fanout_delivery_max_us | 200583.2 | 40966.0 | -154891.2 | [-160896.6, -148885.7] |
| client_wall_s | 2.3488 | 2.0222 | -0.3160 | [-0.3587, -0.2734] |
| client_cpu_s | 1.6833 | 1.4978 | -0.1596 | [-0.1901, -0.1290] |
| broker_user_s | 0.8496 | 0.5450 | -0.3140 | [-0.3382, -0.2899] |
| broker_sys_s | 0.7770 | 0.6091 | -0.1696 | [-0.1939, -0.1454] |
| broker_cpu_s | 1.6279 | 1.1393 | -0.4837 | [-0.5199, -0.4475] |
| broker_vcsw | 15057.0 | 13162.5 | -1889.5 | [-2158.5, -1620.5] |
| broker_maxrss_kib | 6178 | 5164 | -996 | [-1033, -958] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
