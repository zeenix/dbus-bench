candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0705 | 0.0715 | +1.45 | [+0.06, +2.88] | [+0.28, +2.66] | 1.006 | 0.1169 | no material change; repeatable change (+) |
| multi_s | 60 | 0.4674 | 0.4647 | -0.58 | [-1.70, +0.53] | [-1.52, +0.36] | 0.994 | 0.2508 | no material change |
| client_wall_s | 60 | 0.5658 | 0.5639 | -0.34 | [-1.35, +0.67] | [-1.20, +0.51] | 0.996 | 0.4936 | no material change |
| client_cpu_s | 60 | 0.4951 | 0.4929 | -0.45 | [-1.31, +0.42] | [-1.18, +0.29] | 0.991 | 0.2569 | no material change |
| client_vcsw | 60 | 2624.1 | 2554.7 | -2.64 | [-6.20, +0.93] | [-5.64, +0.35] | 0.960 | 0.1351 | inconclusive |
| multi_client_cpu_s | 60 | 0.4473 | 0.4450 | -0.52 | [-1.67, +0.64] | [-1.49, +0.45] | 1.000 | 0.3288 | no material change |
| multi_broker_cpu_s | 60 | 0.3660 | 0.3647 | -0.36 | [-1.76, +1.10] | [-1.54, +0.87] | 1.000 | 0.4135 | no material change |
| broker_user_s | 60 | 0.2079 | 0.2105 | +1.27 | [-0.88, +3.54] | [-0.55, +3.17] | 1.003 | 0.3203 | no material change |
| broker_sys_s | 60 | 0.2206 | 0.2161 | -2.03 | [-4.06, -0.04] | [-3.73, -0.36] | 0.976 | 0.1085 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.4285 | 0.4266 | -0.43 | [-1.45, +0.60] | [-1.29, +0.43] | 0.998 | 0.4616 | no material change |
| broker_vcsw | 60 | 5480.3 | 5534.9 | +1.00 | [-0.81, +2.85] | [-0.55, +2.55] | 1.018 | 0.2418 | no material change |
| broker_maxrss_kib | 60 | 6696 | 6694 | -0.03 | [-0.69, +0.66] | [-0.59, +0.56] | 0.994 | 0.9267 | no material change |
| broker_ru_maxrss_kib | 60 | 20523 | 20527 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0705 | 0.0711 | +0.0010 | [+0.0000, +0.0020] |
| multi_s | 0.4667 | 0.4645 | -0.0027 | [-0.0081, +0.0027] |
| client_wall_s | 0.5648 | 0.5651 | -0.0019 | [-0.0079, +0.0041] |
| client_cpu_s | 0.4942 | 0.4921 | -0.0022 | [-0.0067, +0.0023] |
| client_vcsw | 2646.0 | 2492.0 | -69.4 | [-167.1, +28.4] |
| multi_client_cpu_s | 0.4500 | 0.4450 | -0.0023 | [-0.0077, +0.0030] |
| multi_broker_cpu_s | 0.3700 | 0.3600 | -0.0013 | [-0.0067, +0.0040] |
| broker_user_s | 0.2089 | 0.2083 | +0.0026 | [-0.0021, +0.0074] |
| broker_sys_s | 0.2204 | 0.2158 | -0.0045 | [-0.0091, +0.0002] |
| broker_cpu_s | 0.4278 | 0.4256 | -0.0018 | [-0.0063, +0.0026] |
| broker_vcsw | 5468.5 | 5572.0 | +54.7 | [-48.5, +157.8] |
| broker_maxrss_kib | 6696 | 6682 | -2 | [-48, +45] |
| broker_ru_maxrss_kib | 20504 | 20504 | +4 | [-2, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
