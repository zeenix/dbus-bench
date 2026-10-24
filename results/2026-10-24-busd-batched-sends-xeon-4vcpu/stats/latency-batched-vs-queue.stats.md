candidate batched against baseline queue, from $WORK/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9751 | 0.9596 | -1.59 | [-3.21, -0.01] | [-2.95, -0.26] | 0.980 | 0.1221 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 194.9 | 191.8 | -1.59 | [-3.22, -0.02] | [-2.96, -0.26] | 0.980 | 0.1239 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 183.2 | 180.5 | -1.47 | [-3.33, +0.29] | [-3.01, -0.00] | 0.987 | 0.1619 | no material change |
| single_rtt_p90_us | 60 | 234.1 | 229.4 | -2.00 | [-3.96, -0.09] | [-3.62, -0.40] | 0.985 | 0.1275 | no material change; repeatable change (-) |
| single_rtt_p99_us | 60 | 346.4 | 334.7 | -3.38 | [-7.31, +0.86] | [-6.68, +0.14] | 0.974 | 0.0547 | inconclusive |
| single_rtt_p999_us | 60 | 1056.3 | 950.5 | -10.02 | [-21.90, +3.31] | [-20.12, +1.10] | 0.928 | 0.1901 | inconclusive |
| single_rtt_max_us | 60 | 3819.9 | 3036.3 | -20.52 | [-44.55, +12.74] | [-41.31, +7.99] | 1.055 | 0.9589 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.8151 | 0.8048 | -1.27 | [-4.51, +1.98] | [-3.98, +1.44] | 0.987 | 0.4889 | no material change |
| multi_rtt_mean_us | 60 | 793.1 | 781.8 | -1.43 | [-4.67, +1.77] | [-4.11, +1.26] | 0.981 | 0.3891 | no material change |
| multi_rtt_p50_us | 60 | 746.4 | 736.9 | -1.28 | [-4.41, +1.73] | [-3.91, +1.25] | 0.999 | 0.5961 | no material change |
| multi_rtt_p90_us | 60 | 1072.9 | 1056.5 | -1.53 | [-5.98, +3.07] | [-5.29, +2.33] | 0.988 | 0.5124 | inconclusive |
| multi_rtt_p99_us | 60 | 1582.1 | 1590.7 | +0.54 | [-5.03, +6.42] | [-4.19, +5.46] | 1.025 | 0.7853 | inconclusive |
| multi_rtt_p999_us | 60 | 3409.5 | 3026.1 | -11.24 | [-29.95, +9.89] | [-27.07, +6.43] | 0.936 | 0.4309 | inconclusive |
| multi_rtt_max_us | 60 | 4582.0 | 4318.4 | -5.75 | [-26.75, +20.66] | [-23.71, +16.06] | 0.927 | 0.2993 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3224 | 0.2645 | -17.95 | [-20.88, -14.88] | [-20.40, -15.39] | 0.828 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 71072.7 | 27263.8 | -61.64 | [-63.16, -60.02] | [-62.90, -60.30] | 0.390 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 72582.7 | 27626.7 | -61.94 | [-63.65, -60.16] | [-63.35, -60.42] | 0.398 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 112880.0 | 35117.2 | -68.89 | [-70.78, -67.03] | [-70.47, -67.31] | 0.318 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 122476.3 | 39961.1 | -67.37 | [-69.65, -65.09] | [-69.27, -65.46] | 0.321 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 126145.7 | 42514.6 | -66.30 | [-68.52, -64.05] | [-68.17, -64.40] | 0.333 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 127414.5 | 43540.9 | -65.83 | [-68.08, -63.58] | [-67.70, -63.94] | 0.346 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1322 | 2.0476 | -3.96 | [-5.80, -2.24] | [-5.48, -2.49] | 0.963 | <0.0001 | inconclusive; repeatable change (-) |
| client_cpu_s | 60 | 1.5983 | 1.5328 | -4.10 | [-6.18, -2.09] | [-5.84, -2.39] | 0.960 | 0.0006 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.5706 | 0.5502 | -3.56 | [-6.33, -0.79] | [-5.88, -1.25] | 0.986 | 0.0359 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.6533 | 0.6094 | -6.73 | [-9.97, -3.51] | [-9.44, -4.03] | 0.946 | 0.0002 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 1.2239 | 1.1596 | -5.25 | [-7.10, -3.50] | [-6.79, -3.75] | 0.956 | <0.0001 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 13550.8 | 13101.2 | -3.32 | [-4.61, -2.00] | [-4.41, -2.21] | 0.967 | <0.0001 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 6317 | 5161 | -18.30 | [-18.95, -17.60] | [-18.86, -17.71] | 0.810 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9632 | 0.9592 | -0.0155 | [-0.0319, +0.0009] |
| single_rtt_mean_us | 192.5 | 191.7 | -3.1 | [-6.4, +0.2] |
| single_rtt_p50_us | 181.1 | 179.6 | -2.7 | [-6.2, +0.8] |
| single_rtt_p90_us | 231.9 | 230.7 | -4.7 | [-9.4, +0.1] |
| single_rtt_p99_us | 334.5 | 326.8 | -11.7 | [-26.5, +3.1] |
| single_rtt_p999_us | 925.9 | 920.5 | -105.9 | [-250.0, +38.2] |
| single_rtt_max_us | 2498.9 | 2653.0 | -783.7 | [-2236.8, +669.5] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.8072 | 0.7859 | -0.0103 | [-0.0378, +0.0172] |
| multi_rtt_mean_us | 783.4 | 761.5 | -11.4 | [-37.9, +15.1] |
| multi_rtt_p50_us | 730.5 | 728.9 | -9.5 | [-33.6, +14.5] |
| multi_rtt_p90_us | 1078.3 | 1024.5 | -16.4 | [-66.8, +34.0] |
| multi_rtt_p99_us | 1549.0 | 1576.3 | +8.6 | [-83.4, +100.6] |
| multi_rtt_p999_us | 2920.9 | 2594.7 | -383.3 | [-1177.3, +410.6] |
| multi_rtt_max_us | 3859.1 | 3339.5 | -263.6 | [-1422.1, +895.0] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3179 | 0.2573 | -0.0579 | [-0.0693, -0.0464] |
| fanout_delivery_mean_us | 67628.8 | 26327.4 | -43808.9 | [-46394.0, -41223.8] |
| fanout_delivery_p50_us | 65902.3 | 26789.4 | -44956.1 | [-48367.1, -41545.1] |
| fanout_delivery_p90_us | 104889.2 | 32767.5 | -77762.8 | [-83336.6, -72188.9] |
| fanout_delivery_p99_us | 113716.1 | 36979.7 | -82515.2 | [-88783.6, -76246.9] |
| fanout_delivery_p999_us | 116820.9 | 39155.7 | -83631.2 | [-89886.5, -77375.8] |
| fanout_delivery_max_us | 119610.2 | 40966.0 | -83873.6 | [-90181.5, -77565.7] |
| client_wall_s | 2.1094 | 2.0222 | -0.0845 | [-0.1246, -0.0444] |
| client_cpu_s | 1.5759 | 1.4978 | -0.0655 | [-0.1001, -0.0309] |
| broker_user_s | 0.5604 | 0.5450 | -0.0203 | [-0.0369, -0.0038] |
| broker_sys_s | 0.6510 | 0.6091 | -0.0439 | [-0.0663, -0.0216] |
| broker_cpu_s | 1.2125 | 1.1393 | -0.0643 | [-0.0877, -0.0408] |
| broker_vcsw | 13647.0 | 13162.5 | -449.6 | [-634.2, -265.1] |
| broker_maxrss_kib | 6376 | 5164 | -1156 | [-1209, -1104] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
