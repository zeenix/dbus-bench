candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.7058 | 3.6464 | -1.60 | [-4.35, +1.25] | [-3.93, +0.80] | 0.988 | 0.2532 | no material change |
| multi_s | 40 | 4.3901 | 4.2749 | -2.62 | [-5.39, +0.16] | [-4.93, -0.27] | 0.968 | 0.0497 | no material change |
| client_wall_s | 40 | 8.1037 | 7.9283 | -2.16 | [-4.53, +0.31] | [-4.17, -0.12] | 0.976 | 0.0410 | no material change |
| client_cpu_s | 40 | 7.4607 | 7.2823 | -2.39 | [-4.63, -0.06] | [-4.30, -0.45] | 0.969 | 0.0326 | no material change; repeatable change (-) |
| client_vcsw | 40 | 10858.4 | 10657.0 | -1.85 | [-12.09, +9.29] | [-10.47, +7.35] | 0.927 | 0.7572 | inconclusive |
| multi_client_cpu_s | 40 | 4.0178 | 3.9062 | -2.78 | [-5.45, -0.13] | [-5.00, -0.53] | 0.966 | 0.0497 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 40 | 3.2625 | 3.2337 | -0.88 | [-4.10, +2.40] | [-3.55, +1.80] | 0.977 | 0.3642 | no material change |
| broker_user_s | 40 | 3.0305 | 2.9727 | -1.91 | [-4.69, +0.87] | [-4.24, +0.44] | 0.982 | 0.1158 | no material change |
| broker_sys_s | 40 | 2.5272 | 2.5155 | -0.46 | [-4.20, +3.38] | [-3.60, +2.72] | 0.995 | 0.7572 | no material change |
| broker_cpu_s | 40 | 5.5577 | 5.4882 | -1.25 | [-3.96, +1.59] | [-3.55, +1.04] | 1.000 | 0.4436 | no material change |
| broker_vcsw | 40 | 18781.2 | 18508.0 | -1.45 | [-3.63, +0.88] | [-3.28, +0.49] | 0.974 | 0.1789 | no material change |
| broker_maxrss_kib | 40 | 7043 | 7195 | +2.17 | [+0.78, +3.56] | [+1.03, +3.34] | 1.021 | 0.0078 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 40 | 18772 | 18778 | +0.03 | [+0.00, +0.10] | [+0.00, +0.10] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.7073 | 3.5956 | -0.0594 | [-0.1687, +0.0499] |
| multi_s | 4.3492 | 4.1986 | -0.1152 | [-0.2433, +0.0128] |
| client_wall_s | 8.0934 | 7.7311 | -0.1754 | [-0.3797, +0.0289] |
| client_cpu_s | 7.3674 | 7.1287 | -0.1784 | [-0.3563, -0.0004] |
| client_vcsw | 10653.0 | 10077.0 | -201.4 | [-1447.0, +1044.2] |
| multi_client_cpu_s | 3.9700 | 3.8550 | -0.1115 | [-0.2238, +0.0008] |
| multi_broker_cpu_s | 3.2350 | 3.1650 | -0.0288 | [-0.1392, +0.0817] |
| broker_user_s | 2.9792 | 2.9255 | -0.0578 | [-0.1476, +0.0319] |
| broker_sys_s | 2.5386 | 2.4816 | -0.0117 | [-0.1113, +0.0879] |
| broker_cpu_s | 5.5213 | 5.3672 | -0.0695 | [-0.2300, +0.0910] |
| broker_vcsw | 18682.0 | 18497.5 | -273.2 | [-716.5, +170.1] |
| broker_maxrss_kib | 7020 | 7168 | +152 | [+51, +254] |
| broker_ru_maxrss_kib | 18708 | 18708 | +6 | [-7, +19] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
