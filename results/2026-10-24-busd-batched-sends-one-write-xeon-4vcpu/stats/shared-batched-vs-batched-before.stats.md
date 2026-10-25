candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.6069 | 3.6464 | +1.09 | [-1.50, +3.75] | [-1.10, +3.31] | 1.007 | 0.3537 | no material change |
| multi_s | 40 | 4.3351 | 4.2749 | -1.39 | [-3.58, +0.70] | [-3.21, +0.36] | 0.994 | 0.2589 | no material change |
| client_wall_s | 40 | 7.9493 | 7.9283 | -0.26 | [-2.19, +1.56] | [-1.87, +1.27] | 1.005 | 0.8193 | no material change |
| client_cpu_s | 40 | 7.3151 | 7.2823 | -0.45 | [-2.16, +1.22] | [-1.88, +0.96] | 1.001 | 0.8507 | no material change |
| client_vcsw | 40 | 10648.5 | 10657.0 | +0.08 | [-9.54, +10.03] | [-8.02, +8.49] | 1.027 | 0.9250 | inconclusive |
| multi_client_cpu_s | 40 | 3.9652 | 3.9062 | -1.49 | [-3.46, +0.38] | [-3.13, +0.09] | 0.996 | 0.2058 | no material change |
| multi_broker_cpu_s | 40 | 3.2575 | 3.2337 | -0.73 | [-3.55, +2.04] | [-3.09, +1.58] | 1.000 | 0.7059 | no material change |
| broker_user_s | 40 | 2.9729 | 2.9727 | -0.01 | [-1.96, +2.01] | [-1.64, +1.68] | 0.991 | 0.7675 | no material change |
| broker_sys_s | 40 | 2.5231 | 2.5155 | -0.30 | [-4.25, +3.54] | [-3.57, +2.89] | 1.004 | 0.9250 | no material change |
| broker_cpu_s | 40 | 5.4960 | 5.4882 | -0.14 | [-2.45, +2.05] | [-2.04, +1.70] | 1.010 | 0.8825 | no material change |
| broker_vcsw | 40 | 18602.3 | 18508.0 | -0.51 | [-2.96, +1.94] | [-2.56, +1.57] | 0.996 | 0.8878 | no material change |
| broker_maxrss_kib | 40 | 7099 | 7195 | +1.35 | [-0.01, +2.71] | [+0.22, +2.50] | 1.016 | 0.0665 | no material change |
| broker_ru_maxrss_kib | 40 | 18778 | 18778 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.6303 | 3.5956 | +0.0395 | [-0.0594, +0.1383] |
| multi_s | 4.2404 | 4.1986 | -0.0602 | [-0.1583, +0.0378] |
| client_wall_s | 7.8891 | 7.7311 | -0.0210 | [-0.1756, +0.1335] |
| client_cpu_s | 7.2442 | 7.1287 | -0.0328 | [-0.1620, +0.0964] |
| client_vcsw | 9937.5 | 10077.0 | +8.4 | [-1085.4, +1102.2] |
| multi_client_cpu_s | 3.9050 | 3.8550 | -0.0590 | [-0.1394, +0.0214] |
| multi_broker_cpu_s | 3.2350 | 3.1650 | -0.0238 | [-0.1198, +0.0723] |
| broker_user_s | 2.9016 | 2.9255 | -0.0003 | [-0.0618, +0.0613] |
| broker_sys_s | 2.5625 | 2.4816 | -0.0076 | [-0.1104, +0.0953] |
| broker_cpu_s | 5.4953 | 5.3672 | -0.0078 | [-0.1365, +0.1209] |
| broker_vcsw | 18361.5 | 18497.5 | -94.3 | [-576.4, +387.8] |
| broker_maxrss_kib | 7078 | 7168 | +96 | [-4, +196] |
| broker_ru_maxrss_kib | 18708 | 18708 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
