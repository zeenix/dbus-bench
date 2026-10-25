candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2047 | 0.1997 | -2.47 | [-4.66, -0.25] | [-4.32, -0.65] | 0.981 | 0.0400 | no material change; repeatable change (-) |
| multi_s | 60 | 0.8125 | 0.7999 | -1.55 | [-4.75, +1.82] | [-4.29, +1.33] | 0.967 | 0.2891 | no material change |
| client_wall_s | 60 | 1.0238 | 1.0061 | -1.73 | [-4.32, +0.99] | [-3.94, +0.56] | 0.971 | 0.1221 | no material change |
| client_cpu_s | 60 | 0.8645 | 0.8608 | -0.43 | [-3.44, +2.77] | [-2.93, +2.21] | 0.974 | 0.4527 | no material change |
| client_vcsw | 60 | 4928.6 | 4937.2 | +0.17 | [-4.43, +4.83] | [-3.73, +4.06] | 1.006 | 0.6089 | no material change |
| multi_client_cpu_s | 60 | 0.7578 | 0.7528 | -0.66 | [-4.01, +2.94] | [-3.47, +2.31] | 0.986 | 0.3984 | no material change |
| multi_broker_cpu_s | 60 | 0.5988 | 0.5752 | -3.95 | [-7.45, -0.45] | [-6.88, -1.00] | 0.953 | 0.1106 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.3772 | 0.3619 | -4.07 | [-7.39, -0.79] | [-6.90, -1.27] | 0.974 | 0.0452 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.3350 | 0.3215 | -4.01 | [-9.71, +1.86] | [-8.82, +1.00] | 0.963 | 0.2081 | inconclusive |
| broker_cpu_s | 60 | 0.7122 | 0.6834 | -4.04 | [-7.16, -0.95] | [-6.67, -1.46] | 0.970 | 0.0460 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 4970.1 | 5101.7 | +2.65 | [-1.76, +7.36] | [-1.01, +6.60] | 1.030 | 0.2028 | inconclusive |
| broker_maxrss_kib | 60 | 4924 | 4880 | -0.89 | [-1.52, -0.27] | [-1.41, -0.37] | 0.990 | 0.0105 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 19033 | 19033 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2043 | 0.1988 | -0.0051 | [-0.0097, -0.0004] |
| multi_s | 0.8030 | 0.7874 | -0.0126 | [-0.0405, +0.0153] |
| client_wall_s | 1.0116 | 0.9811 | -0.0177 | [-0.0462, +0.0107] |
| client_cpu_s | 0.8617 | 0.8417 | -0.0037 | [-0.0313, +0.0238] |
| client_vcsw | 4717.5 | 4847.0 | +8.6 | [-228.6, +245.7] |
| multi_client_cpu_s | 0.7500 | 0.7300 | -0.0050 | [-0.0322, +0.0222] |
| multi_broker_cpu_s | 0.6000 | 0.5700 | -0.0237 | [-0.0459, -0.0015] |
| broker_user_s | 0.3711 | 0.3569 | -0.0154 | [-0.0285, -0.0022] |
| broker_sys_s | 0.3221 | 0.3179 | -0.0134 | [-0.0343, +0.0074] |
| broker_cpu_s | 0.7053 | 0.6789 | -0.0288 | [-0.0522, -0.0054] |
| broker_vcsw | 5121.5 | 5178.0 | +131.7 | [-100.8, +364.1] |
| broker_maxrss_kib | 4908 | 4884 | -44 | [-76, -12] |
| broker_ru_maxrss_kib | 19016 | 19016 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
