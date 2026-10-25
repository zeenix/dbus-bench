candidate baseline against baseline queue, from $WORK/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.6434 | 3.8893 | +6.75 | [+4.31, +9.37] | [+4.68, +8.94] | 1.053 | <0.0001 | inconclusive; repeatable change (+) |
| multi_s | 40 | 4.9083 | 4.7799 | -2.62 | [-5.97, +0.83] | [-5.40, +0.29] | 0.981 | 0.1466 | inconclusive |
| client_wall_s | 40 | 8.5593 | 8.6766 | +1.37 | [-0.92, +3.73] | [-0.52, +3.34] | 1.023 | 0.2316 | no material change |
| client_cpu_s | 40 | 7.6558 | 7.9002 | +3.19 | [+1.17, +5.27] | [+1.51, +4.93] | 1.037 | 0.0075 | no material change; repeatable change (+) |
| client_vcsw | 40 | 20694.2 | 13245.7 | -35.99 | [-42.30, -28.43] | [-41.38, -29.66] | 0.602 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3115 | 4.2910 | -0.48 | [-3.34, +2.46] | [-2.89, +2.03] | 0.993 | 0.6525 | no material change |
| multi_broker_cpu_s | 40 | 3.8237 | 3.6010 | -5.83 | [-9.69, -1.70] | [-9.07, -2.30] | 0.943 | 0.0173 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 3.3668 | 3.2945 | -2.15 | [-4.60, +0.41] | [-4.21, -0.00] | 0.969 | 0.1662 | no material change |
| broker_sys_s | 40 | 2.9805 | 2.7198 | -8.75 | [-12.61, -4.58] | [-12.04, -5.20] | 0.904 | 0.0006 | inconclusive; repeatable change (-) |
| broker_cpu_s | 40 | 6.3473 | 6.0143 | -5.25 | [-7.96, -2.42] | [-7.50, -2.86] | 0.940 | 0.0024 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 16810.7 | 18122.1 | +7.80 | [+4.09, +11.69] | [+4.70, +11.07] | 1.079 | 0.0003 | inconclusive; repeatable change (+) |
| broker_maxrss_kib | 40 | 7481 | 7089 | -5.24 | [-6.76, -3.72] | [-6.52, -3.96] | 0.941 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18749 | 18746 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.6478 | 3.8441 | +0.2459 | [+0.1553, +0.3366] |
| multi_s | 4.8944 | 4.7416 | -0.1285 | [-0.3054, +0.0485] |
| client_wall_s | 8.5062 | 8.5486 | +0.1172 | [-0.0912, +0.3257] |
| client_cpu_s | 7.6277 | 7.7152 | +0.2443 | [+0.0802, +0.4084] |
| client_vcsw | 20085.0 | 13249.0 | -7448.6 | [-9330.7, -5566.4] |
| multi_client_cpu_s | 4.2950 | 4.2150 | -0.0205 | [-0.1544, +0.1134] |
| multi_broker_cpu_s | 3.7500 | 3.6100 | -0.2228 | [-0.3896, -0.0559] |
| broker_user_s | 3.3250 | 3.2543 | -0.0723 | [-0.1626, +0.0180] |
| broker_sys_s | 2.9398 | 2.6961 | -0.2606 | [-0.3943, -0.1270] |
| broker_cpu_s | 6.3061 | 5.9590 | -0.3330 | [-0.5255, -0.1404] |
| broker_vcsw | 16943.5 | 18168.0 | +1311.4 | [+681.5, +1941.3] |
| broker_maxrss_kib | 7448 | 7032 | -392 | [-515, -269] |
| broker_ru_maxrss_kib | 18784 | 18784 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
