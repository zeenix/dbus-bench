candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 4.1310 | 3.6464 | -11.73 | [-13.68, -9.75] | [-13.39, -10.05] | 0.888 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.4240 | 4.2749 | -21.19 | [-23.04, -19.34] | [-22.72, -19.65] | 0.778 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 9.5619 | 7.9283 | -17.08 | [-18.41, -15.74] | [-18.21, -15.94] | 0.826 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 7.7126 | 7.2823 | -5.58 | [-7.12, -3.97] | [-6.89, -4.23] | 0.943 | <0.0001 | inconclusive; repeatable change (-) |
| client_vcsw | 40 | 56181.8 | 10657.0 | -81.03 | [-82.71, -79.25] | [-82.45, -79.56] | 0.184 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.1245 | 3.9062 | -5.29 | [-7.14, -3.48] | [-6.84, -3.77] | 0.945 | <0.0001 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 40 | 5.1748 | 3.2337 | -37.51 | [-39.27, -35.73] | [-38.98, -36.04] | 0.625 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 5.4209 | 2.9727 | -45.16 | [-46.34, -43.99] | [-46.15, -44.19] | 0.557 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 3.6041 | 2.5155 | -30.20 | [-32.41, -28.05] | [-32.02, -28.38] | 0.701 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 9.0250 | 5.4882 | -39.19 | [-40.38, -37.93] | [-40.21, -38.16] | 0.600 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 3658.6 | 18508.0 | +405.87 | [+367.94, +446.95] | [+374.84, +440.23] | 5.130 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7172 | 7195 | +0.32 | [-0.87, +1.47] | [-0.69, +1.28] | 1.003 | 0.5587 | no material change |
| broker_ru_maxrss_kib | 40 | 18775 | 18778 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 4.0396 | 3.5956 | -0.4846 | [-0.5757, -0.3935] |
| multi_s | 5.4076 | 4.1986 | -1.1491 | [-1.2679, -1.0303] |
| client_wall_s | 9.4812 | 7.7311 | -1.6336 | [-1.7787, -1.4886] |
| client_cpu_s | 7.6650 | 7.1287 | -0.4303 | [-0.5596, -0.3009] |
| client_vcsw | 56734.5 | 10077.0 | -45524.8 | [-47297.0, -43752.7] |
| multi_client_cpu_s | 4.0850 | 3.8550 | -0.2183 | [-0.2997, -0.1368] |
| multi_broker_cpu_s | 5.1400 | 3.1650 | -1.9410 | [-2.0546, -1.8274] |
| broker_user_s | 5.3430 | 2.9255 | -2.4482 | [-2.5369, -2.3596] |
| broker_sys_s | 3.5787 | 2.4816 | -1.0886 | [-1.1756, -1.0015] |
| broker_cpu_s | 8.9766 | 5.3672 | -3.5368 | [-3.6672, -3.4065] |
| broker_vcsw | 3676.0 | 18497.5 | +14849.4 | [+14332.2, +15366.5] |
| broker_maxrss_kib | 7164 | 7168 | +23 | [-65, +112] |
| broker_ru_maxrss_kib | 18708 | 18708 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
