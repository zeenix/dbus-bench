candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3360 | 0.3278 | -2.44 | [-6.35, +2.04] | [-5.80, +1.19] | 0.989 | 0.1641 | inconclusive |
| multi_s | 60 | 0.2916 | 0.2830 | -2.95 | [-6.33, +0.45] | [-5.77, -0.10] | 0.979 | 0.2245 | inconclusive |
| client_wall_s | 60 | 0.6580 | 0.6430 | -2.27 | [-4.98, +0.46] | [-4.57, +0.02] | 0.989 | 0.1876 | no material change |
| client_cpu_s | 60 | 1.2391 | 1.2327 | -0.51 | [-2.84, +1.80] | [-2.45, +1.45] | 0.998 | 0.9238 | no material change |
| client_vcsw | 60 | 5476.3 | 5040.4 | -7.96 | [-14.72, -0.84] | [-13.65, -2.04] | 0.916 | 0.0316 | inconclusive; repeatable change (-) |
| multi_client_cpu_s | 60 | 0.7980 | 0.7828 | -1.90 | [-4.56, +0.81] | [-4.15, +0.40] | 0.981 | 0.2118 | no material change |
| multi_broker_cpu_s | 60 | 0.2057 | 0.1910 | -7.13 | [-11.73, -2.45] | [-10.92, -3.20] | 0.946 | 0.0101 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.3567 | 0.3462 | -2.94 | [-6.79, +1.18] | [-6.18, +0.45] | 0.973 | 0.0668 | inconclusive |
| broker_sys_s | 60 | 0.1863 | 0.1757 | -5.71 | [-10.54, -0.59] | [-9.76, -1.47] | 0.945 | 0.0277 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.5430 | 0.5219 | -3.89 | [-6.86, -0.86] | [-6.37, -1.36] | 0.967 | 0.0128 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 481.7 | 579.6 | +20.32 | [-5.02, +51.60] | [-1.10, +46.22] | 1.183 | 0.0810 | inconclusive |
| broker_maxrss_kib | 60 | 4798 | 4787 | -0.23 | [-0.58, +0.13] | [-0.52, +0.07] | 0.998 | 0.1370 | no material change |
| broker_ru_maxrss_kib | 60 | 18834 | 18836 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3277 | 0.3187 | -0.0082 | [-0.0228, +0.0064] |
| multi_s | 0.2891 | 0.2807 | -0.0086 | [-0.0190, +0.0018] |
| client_wall_s | 0.6480 | 0.6342 | -0.0149 | [-0.0338, +0.0039] |
| client_cpu_s | 1.2141 | 1.2223 | -0.0063 | [-0.0362, +0.0235] |
| client_vcsw | 5278.0 | 4831.5 | -435.9 | [-839.0, -32.8] |
| multi_client_cpu_s | 0.7800 | 0.7700 | -0.0152 | [-0.0377, +0.0073] |
| multi_broker_cpu_s | 0.2000 | 0.1800 | -0.0147 | [-0.0248, -0.0045] |
| broker_user_s | 0.3516 | 0.3436 | -0.0105 | [-0.0253, +0.0043] |
| broker_sys_s | 0.1801 | 0.1739 | -0.0106 | [-0.0203, -0.0010] |
| broker_cpu_s | 0.5354 | 0.5152 | -0.0211 | [-0.0382, -0.0040] |
| broker_vcsw | 396.0 | 498.5 | +97.9 | [-27.5, +223.2] |
| broker_maxrss_kib | 4810 | 4786 | -11 | [-28, +7] |
| broker_ru_maxrss_kib | 18840 | 18840 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
