candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9536 | 0.9596 | +0.63 | [-0.87, +2.13] | [-0.62, +1.90] | 1.014 | 0.3386 | no material change |
| single_rtt_mean_us | 60 | 190.6 | 191.8 | +0.63 | [-0.87, +2.13] | [-0.62, +1.90] | 1.014 | 0.3386 | no material change |
| single_rtt_p50_us | 60 | 180.6 | 180.5 | -0.06 | [-1.59, +1.49] | [-1.31, +1.24] | 0.999 | 0.7572 | no material change |
| single_rtt_p90_us | 60 | 232.7 | 229.4 | -1.42 | [-3.20, +0.38] | [-2.91, +0.08] | 0.991 | 0.1470 | no material change |
| single_rtt_p99_us | 60 | 338.5 | 334.7 | -1.15 | [-4.05, +2.02] | [-3.60, +1.50] | 0.986 | 0.4181 | no material change |
| single_rtt_p999_us | 60 | 1041.8 | 950.5 | -8.77 | [-19.14, +2.97] | [-17.48, +0.81] | 0.979 | 0.2273 | inconclusive |
| single_rtt_max_us | 60 | 3520.8 | 3036.3 | -13.76 | [-33.85, +12.22] | [-30.93, +7.86] | 0.879 | 0.5412 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.3239 | 0.8048 | -39.21 | [-41.26, -37.05] | [-40.96, -37.39] | 0.599 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1282.9 | 781.8 | -39.06 | [-41.14, -36.90] | [-40.82, -37.24] | 0.599 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1217.1 | 736.9 | -39.45 | [-41.61, -36.99] | [-41.31, -37.40] | 0.581 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1876.3 | 1056.5 | -43.69 | [-46.02, -41.31] | [-45.65, -41.70] | 0.561 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2697.1 | 1590.7 | -41.02 | [-43.93, -37.94] | [-43.49, -38.44] | 0.567 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 4360.1 | 3026.1 | -30.59 | [-39.10, -21.28] | [-37.69, -22.87] | 0.648 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 5956.1 | 4318.4 | -27.49 | [-39.54, -12.64] | [-37.85, -15.14] | 0.656 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3588 | 0.2645 | -26.28 | [-28.66, -23.57] | [-28.30, -24.06] | 0.737 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 73081.7 | 27263.8 | -62.69 | [-64.02, -61.21] | [-63.81, -61.46] | 0.363 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 74208.9 | 27626.7 | -62.77 | [-64.22, -61.20] | [-64.00, -61.45] | 0.370 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 119817.1 | 35117.2 | -70.69 | [-72.20, -69.03] | [-71.98, -69.32] | 0.291 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 133571.0 | 39961.1 | -70.08 | [-71.95, -68.08] | [-71.66, -68.39] | 0.288 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 139315.7 | 42514.6 | -69.48 | [-71.28, -67.48] | [-71.02, -67.81] | 0.296 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 140389.7 | 43540.9 | -68.99 | [-70.83, -66.97] | [-70.56, -67.28] | 0.303 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.6500 | 2.0476 | -22.73 | [-24.24, -21.13] | [-24.02, -21.37] | 0.767 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.2844 | 1.5328 | -32.90 | [-34.35, -31.37] | [-34.13, -31.62] | 0.666 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2688 | 0.5502 | +104.69 | [+96.63, +113.05] | [+97.98, +111.60] | 2.037 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.7600 | 0.6094 | -19.82 | [-22.06, -17.42] | [-21.72, -17.82] | 0.795 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.0288 | 1.1596 | +12.71 | [+10.57, +14.98] | [+10.92, +14.60] | 1.119 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 52650.1 | 13101.2 | -75.12 | [-75.57, -74.62] | [-75.50, -74.71] | 0.250 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11217 | 5161 | -53.99 | [-54.24, -53.75] | [-54.20, -53.79] | 0.459 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9464 | 0.9592 | +0.0060 | [-0.0089, +0.0210] |
| single_rtt_mean_us | 189.2 | 191.7 | +1.2 | [-1.8, +4.2] |
| single_rtt_p50_us | 180.8 | 179.6 | -0.1 | [-3.0, +2.8] |
| single_rtt_p90_us | 231.9 | 230.7 | -3.3 | [-7.6, +1.0] |
| single_rtt_p99_us | 340.7 | 326.8 | -3.9 | [-14.6, +6.8] |
| single_rtt_p999_us | 963.4 | 920.5 | -91.3 | [-215.4, +32.7] |
| single_rtt_max_us | 2381.2 | 2653.0 | -484.5 | [-1424.1, +455.2] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.3008 | 0.7859 | -0.5191 | [-0.5566, -0.4816] |
| multi_rtt_mean_us | 1264.7 | 761.5 | -501.1 | [-537.5, -464.8] |
| multi_rtt_p50_us | 1215.2 | 728.9 | -480.1 | [-517.7, -442.6] |
| multi_rtt_p90_us | 1845.4 | 1024.5 | -819.8 | [-884.5, -755.2] |
| multi_rtt_p99_us | 2670.1 | 1576.3 | -1106.4 | [-1220.7, -992.2] |
| multi_rtt_p999_us | 3858.3 | 2594.7 | -1334.0 | [-1797.8, -870.1] |
| multi_rtt_max_us | 5330.6 | 3339.5 | -1637.6 | [-2566.2, -709.0] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3488 | 0.2573 | -0.0943 | [-0.1051, -0.0835] |
| fanout_delivery_mean_us | 70828.6 | 26327.4 | -45817.9 | [-47840.7, -43795.0] |
| fanout_delivery_p50_us | 71659.7 | 26789.4 | -46582.2 | [-48926.4, -44238.1] |
| fanout_delivery_p90_us | 113307.6 | 32767.5 | -84700.0 | [-89619.4, -79780.6] |
| fanout_delivery_p99_us | 127239.5 | 36979.7 | -93609.9 | [-99170.5, -88049.3] |
| fanout_delivery_p999_us | 133625.9 | 39155.7 | -96801.2 | [-102468.7, -91133.6] |
| fanout_delivery_max_us | 134281.5 | 40966.0 | -96848.8 | [-102592.8, -91104.8] |
| client_wall_s | 2.6260 | 2.0222 | -0.6023 | [-0.6512, -0.5535] |
| client_cpu_s | 2.2708 | 1.4978 | -0.7516 | [-0.7943, -0.7089] |
| broker_user_s | 0.2676 | 0.5450 | +0.2814 | [+0.2662, +0.2966] |
| broker_sys_s | 0.7528 | 0.6091 | -0.1507 | [-0.1701, -0.1312] |
| broker_cpu_s | 1.0288 | 1.1393 | +0.1308 | [+0.1085, +0.1530] |
| broker_vcsw | 52963.0 | 13162.5 | -39548.9 | [-40516.7, -38581.1] |
| broker_maxrss_kib | 11206 | 5164 | -6056 | [-6101, -6011] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
