candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 4.1310 | 3.7058 | -10.29 | [-12.73, -7.84] | [-12.31, -8.23] | 0.918 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.4240 | 4.3901 | -19.06 | [-21.27, -16.97] | [-20.87, -17.30] | 0.801 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 9.5619 | 8.1037 | -15.25 | [-16.94, -13.64] | [-16.66, -13.88] | 0.846 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 7.7126 | 7.4607 | -3.27 | [-4.89, -1.63] | [-4.63, -1.87] | 0.963 | 0.0013 | no material change; repeatable change (-) |
| client_vcsw | 40 | 56181.8 | 10858.4 | -80.67 | [-82.36, -78.89] | [-82.07, -79.21] | 0.195 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.1245 | 4.0178 | -2.59 | [-4.80, -0.26] | [-4.49, -0.62] | 0.970 | 0.0248 | no material change; repeatable change (-) |
| multi_broker_cpu_s | 40 | 5.1748 | 3.2625 | -36.95 | [-38.88, -35.06] | [-38.55, -35.37] | 0.632 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 5.4209 | 3.0305 | -44.10 | [-45.35, -42.82] | [-45.14, -43.03] | 0.563 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 3.6041 | 2.5272 | -29.88 | [-31.82, -27.91] | [-31.52, -28.22] | 0.707 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 9.0250 | 5.5577 | -38.42 | [-39.76, -37.09] | [-39.54, -37.32] | 0.614 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 3658.6 | 18781.2 | +413.34 | [+379.35, +451.15] | [+385.17, +444.43] | 5.129 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7172 | 7043 | -1.80 | [-2.91, -0.70] | [-2.74, -0.87] | 0.971 | 0.0062 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18775 | 18772 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 4.0396 | 3.7073 | -0.4253 | [-0.5383, -0.3122] |
| multi_s | 5.4076 | 4.3492 | -1.0339 | [-1.1738, -0.8941] |
| client_wall_s | 9.4812 | 8.0934 | -1.4582 | [-1.6446, -1.2718] |
| client_cpu_s | 7.6650 | 7.3674 | -0.2519 | [-0.3859, -0.1180] |
| client_vcsw | 56734.5 | 10653.0 | -45323.4 | [-47209.6, -43437.3] |
| multi_client_cpu_s | 4.0850 | 3.9700 | -0.1068 | [-0.2066, -0.0069] |
| multi_broker_cpu_s | 5.1400 | 3.2350 | -1.9122 | [-2.0392, -1.7853] |
| broker_user_s | 5.3430 | 2.9792 | -2.3904 | [-2.4895, -2.2913] |
| broker_sys_s | 3.5787 | 2.5386 | -1.0769 | [-1.1657, -0.9881] |
| broker_cpu_s | 8.9766 | 5.5213 | -3.4673 | [-3.6317, -3.3029] |
| broker_vcsw | 3676.0 | 18682.0 | +15122.6 | [+14721.1, +15524.0] |
| broker_maxrss_kib | 7164 | 7020 | -129 | [-214, -44] |
| broker_ru_maxrss_kib | 18708 | 18708 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
