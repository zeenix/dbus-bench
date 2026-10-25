candidate batched against baseline baseline, from $WORK/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9503 | 0.9596 | +0.98 | [-0.52, +2.48] | [-0.28, +2.25] | 1.014 | 0.1851 | no material change |
| single_rtt_mean_us | 60 | 190.0 | 191.8 | +0.98 | [-0.52, +2.48] | [-0.28, +2.25] | 1.014 | 0.1876 | no material change |
| single_rtt_p50_us | 60 | 179.1 | 180.5 | +0.80 | [-0.85, +2.51] | [-0.60, +2.21] | 1.011 | 0.2759 | no material change |
| single_rtt_p90_us | 60 | 227.2 | 229.4 | +0.95 | [-0.81, +2.73] | [-0.52, +2.46] | 1.020 | 0.2448 | no material change |
| single_rtt_p99_us | 60 | 332.4 | 334.7 | +0.67 | [-3.06, +4.72] | [-2.50, +4.08] | 0.999 | 0.8713 | no material change |
| single_rtt_p999_us | 60 | 961.6 | 950.5 | -1.16 | [-13.67, +12.68] | [-11.72, +10.37] | 1.163 | 0.9765 | inconclusive |
| single_rtt_max_us | 60 | 2763.8 | 3036.3 | +9.86 | [-11.31, +35.52] | [-8.34, +31.00] | 1.005 | 0.5461 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.8090 | 0.8048 | -0.52 | [-3.98, +2.96] | [-3.40, +2.39] | 0.999 | 0.8367 | no material change |
| multi_rtt_mean_us | 60 | 783.1 | 781.8 | -0.18 | [-3.62, +3.31] | [-3.10, +2.74] | 1.002 | 0.9824 | no material change |
| multi_rtt_p50_us | 60 | 743.0 | 736.9 | -0.81 | [-4.60, +3.06] | [-3.98, +2.39] | 1.009 | 0.9765 | no material change |
| multi_rtt_p90_us | 60 | 1051.3 | 1056.5 | +0.49 | [-4.39, +5.67] | [-3.59, +4.73] | 0.994 | 0.9648 | no material change |
| multi_rtt_p99_us | 60 | 1593.1 | 1590.7 | -0.15 | [-5.70, +5.64] | [-4.82, +4.64] | 0.996 | 0.9472 | no material change |
| multi_rtt_p999_us | 60 | 3034.9 | 3026.1 | -0.29 | [-14.04, +15.17] | [-11.94, +12.56] | 0.893 | 0.9121 | inconclusive |
| multi_rtt_max_us | 60 | 4092.9 | 4318.4 | +5.51 | [-14.33, +30.45] | [-11.64, +26.13] | 0.972 | 0.8195 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3132 | 0.2645 | -15.56 | [-19.23, -11.83] | [-18.62, -12.35] | 0.871 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 27804.6 | 27263.8 | -1.95 | [-6.53, +2.67] | [-5.80, +2.05] | 0.995 | 0.7740 | inconclusive |
| fanout_delivery_p50_us | 60 | 27482.5 | 27626.7 | +0.52 | [-4.59, +5.71] | [-3.79, +4.86] | 1.035 | 0.0976 | no material change |
| fanout_delivery_p90_us | 60 | 36111.3 | 35117.2 | -2.75 | [-8.86, +3.50] | [-7.88, +2.50] | 1.004 | 0.7910 | inconclusive |
| fanout_delivery_p99_us | 60 | 41635.0 | 39961.1 | -4.02 | [-11.26, +3.71] | [-10.07, +2.45] | 0.964 | 0.3850 | inconclusive |
| fanout_delivery_p999_us | 60 | 43214.3 | 42514.6 | -1.62 | [-9.30, +6.72] | [-8.08, +5.24] | 1.008 | 0.8195 | inconclusive |
| fanout_delivery_max_us | 60 | 44706.3 | 43540.9 | -2.61 | [-10.22, +5.64] | [-9.02, +4.35] | 0.986 | 0.6063 | inconclusive |
| client_wall_s | 60 | 2.0939 | 2.0476 | -2.21 | [-4.26, -0.14] | [-3.90, -0.48] | 0.979 | 0.0334 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 1.5862 | 1.5328 | -3.36 | [-5.68, -1.02] | [-5.28, -1.44] | 0.968 | 0.0077 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.5477 | 0.5502 | +0.47 | [-2.69, +3.82] | [-2.21, +3.27] | 1.013 | 0.9121 | no material change |
| broker_sys_s | 60 | 0.6476 | 0.6094 | -5.91 | [-9.04, -2.73] | [-8.51, -3.20] | 0.941 | 0.0009 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 1.1953 | 1.1596 | -2.99 | [-5.05, -0.87] | [-4.72, -1.23] | 0.958 | 0.0032 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 13415.5 | 13101.2 | -2.34 | [-3.79, -0.88] | [-3.56, -1.08] | 0.981 | 0.0069 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 5083 | 5161 | +1.53 | [+0.92, +2.13] | [+1.02, +2.04] | 1.019 | <0.0001 | no material change; repeatable change (+) |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9489 | 0.9592 | +0.0093 | [-0.0056, +0.0242] |
| single_rtt_mean_us | 189.7 | 191.7 | +1.9 | [-1.1, +4.8] |
| single_rtt_p50_us | 177.9 | 179.6 | +1.4 | [-1.7, +4.6] |
| single_rtt_p90_us | 227.0 | 230.7 | +2.2 | [-2.0, +6.4] |
| single_rtt_p99_us | 331.3 | 326.8 | +2.2 | [-11.1, +15.6] |
| single_rtt_p999_us | 948.2 | 920.5 | -11.1 | [-141.6, +119.3] |
| single_rtt_max_us | 2343.7 | 2653.0 | +272.5 | [-366.3, +911.3] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7962 | 0.7859 | -0.0042 | [-0.0331, +0.0247] |
| multi_rtt_mean_us | 769.6 | 761.5 | -1.4 | [-29.6, +26.8] |
| multi_rtt_p50_us | 729.9 | 728.9 | -6.0 | [-35.4, +23.3] |
| multi_rtt_p90_us | 1085.0 | 1024.5 | +5.2 | [-49.1, +59.4] |
| multi_rtt_p99_us | 1557.7 | 1576.3 | -2.4 | [-96.1, +91.3] |
| multi_rtt_p999_us | 2694.6 | 2594.7 | -8.8 | [-467.2, +449.7] |
| multi_rtt_max_us | 3472.8 | 3339.5 | +225.5 | [-695.6, +1146.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2975 | 0.2573 | -0.0487 | [-0.0625, -0.0350] |
| fanout_delivery_mean_us | 26330.7 | 26327.4 | -540.8 | [-1900.1, +818.4] |
| fanout_delivery_p50_us | 25965.5 | 26789.4 | +144.2 | [-1337.6, +1625.9] |
| fanout_delivery_p90_us | 33593.7 | 32767.5 | -994.1 | [-3330.6, +1342.3] |
| fanout_delivery_p99_us | 39047.7 | 36979.7 | -1673.9 | [-4957.8, +1609.9] |
| fanout_delivery_p999_us | 40398.0 | 39155.7 | -699.8 | [-4306.7, +2907.2] |
| fanout_delivery_max_us | 40483.2 | 40966.0 | -1165.4 | [-4905.0, +2574.1] |
| client_wall_s | 2.0715 | 2.0222 | -0.0463 | [-0.0912, -0.0013] |
| client_cpu_s | 1.5598 | 1.4978 | -0.0533 | [-0.0918, -0.0148] |
| broker_user_s | 0.5372 | 0.5450 | +0.0026 | [-0.0158, +0.0210] |
| broker_sys_s | 0.6468 | 0.6091 | -0.0383 | [-0.0598, -0.0168] |
| broker_cpu_s | 1.1810 | 1.1393 | -0.0357 | [-0.0618, -0.0096] |
| broker_vcsw | 13516.5 | 13162.5 | -314.3 | [-521.0, -107.5] |
| broker_maxrss_kib | 5084 | 5164 | +78 | [+46, +110] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
