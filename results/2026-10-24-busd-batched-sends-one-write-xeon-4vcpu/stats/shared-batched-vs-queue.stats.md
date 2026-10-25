candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.3978 | 3.6464 | +7.32 | [+5.06, +9.79] | [+5.38, +9.38] | 1.073 | <0.0001 | slower/larger |
| multi_s | 40 | 4.3793 | 4.2749 | -2.38 | [-4.95, +0.16] | [-4.53, -0.23] | 0.980 | 0.1158 | no material change |
| client_wall_s | 40 | 7.7845 | 7.9283 | +1.85 | [-0.05, +3.74] | [+0.23, +3.44] | 1.028 | 0.0410 | no material change |
| client_cpu_s | 40 | 7.0706 | 7.2823 | +2.99 | [+1.02, +5.02] | [+1.34, +4.66] | 1.033 | 0.0020 | no material change; repeatable change (+) |
| client_vcsw | 40 | 16670.0 | 10657.0 | -36.07 | [-41.71, -29.73] | [-40.87, -30.74] | 0.626 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.9270 | 3.9062 | -0.53 | [-2.83, +1.78] | [-2.45, +1.44] | 0.997 | 0.8278 | no material change |
| multi_broker_cpu_s | 40 | 3.3712 | 3.2337 | -4.08 | [-7.22, -1.01] | [-6.71, -1.46] | 0.961 | 0.0390 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 3.0343 | 2.9727 | -2.03 | [-4.40, +0.34] | [-4.00, -0.02] | 0.983 | 0.1878 | no material change |
| broker_sys_s | 40 | 2.7111 | 2.5155 | -7.22 | [-9.95, -4.55] | [-9.51, -4.96] | 0.947 | <0.0001 | inconclusive; repeatable change (-) |
| broker_cpu_s | 40 | 5.7454 | 5.4882 | -4.48 | [-6.65, -2.44] | [-6.24, -2.77] | 0.964 | 0.0004 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 16947.6 | 18508.0 | +9.21 | [+5.97, +12.60] | [+6.49, +12.07] | 1.091 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7460 | 7195 | -3.56 | [-4.81, -2.24] | [-4.63, -2.45] | 0.957 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18778 | 18778 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.3754 | 3.5956 | +0.2486 | [+0.1667, +0.3306] |
| multi_s | 4.2960 | 4.1986 | -0.1044 | [-0.2249, +0.0161] |
| client_wall_s | 7.6561 | 7.7311 | +0.1438 | [-0.0105, +0.2980] |
| client_cpu_s | 6.9960 | 7.1287 | +0.2117 | [+0.0660, +0.3574] |
| client_vcsw | 15918.0 | 10077.0 | -6013.1 | [-7435.5, -4590.6] |
| multi_client_cpu_s | 3.9000 | 3.8550 | -0.0207 | [-0.1161, +0.0746] |
| multi_broker_cpu_s | 3.3050 | 3.1650 | -0.1375 | [-0.2529, -0.0221] |
| broker_user_s | 2.9558 | 2.9255 | -0.0617 | [-0.1386, +0.0153] |
| broker_sys_s | 2.6510 | 2.4816 | -0.1956 | [-0.2759, -0.1153] |
| broker_cpu_s | 5.6791 | 5.3672 | -0.2573 | [-0.3888, -0.1258] |
| broker_vcsw | 17047.5 | 18497.5 | +1560.4 | [+1003.3, +2117.4] |
| broker_maxrss_kib | 7458 | 7168 | -265 | [-369, -162] |
| broker_ru_maxrss_kib | 18708 | 18708 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
