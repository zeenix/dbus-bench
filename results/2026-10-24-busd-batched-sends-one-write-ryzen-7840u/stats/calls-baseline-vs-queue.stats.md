candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0719 | 0.0705 | -1.98 | [-3.06, -0.83] | [-2.88, -1.03] | 0.987 | 0.0007 | no material change; repeatable change (-) |
| multi_s | 60 | 0.4639 | 0.4674 | +0.75 | [-0.35, +1.90] | [-0.17, +1.71] | 1.005 | 0.2217 | no material change |
| client_wall_s | 60 | 0.5633 | 0.5658 | +0.45 | [-0.52, +1.46] | [-0.36, +1.29] | 1.001 | 0.3498 | no material change |
| client_cpu_s | 60 | 0.4920 | 0.4951 | +0.62 | [-0.25, +1.53] | [-0.11, +1.38] | 1.005 | 0.2162 | no material change |
| client_vcsw | 60 | 2474.3 | 2624.1 | +6.05 | [+2.37, +9.99] | [+2.95, +9.37] | 1.069 | 0.0026 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.4432 | 0.4473 | +0.94 | [-0.22, +2.15] | [-0.04, +1.96] | 1.000 | 0.1760 | no material change |
| multi_broker_cpu_s | 60 | 0.3645 | 0.3660 | +0.41 | [-0.87, +1.74] | [-0.68, +1.52] | 1.000 | 0.5114 | no material change |
| broker_user_s | 60 | 0.2083 | 0.2079 | -0.20 | [-2.59, +2.26] | [-2.20, +1.84] | 0.996 | 0.9004 | no material change |
| broker_sys_s | 60 | 0.2178 | 0.2206 | +1.28 | [-1.13, +3.73] | [-0.74, +3.33] | 1.010 | 0.2891 | no material change |
| broker_cpu_s | 60 | 0.4261 | 0.4285 | +0.55 | [-0.41, +1.56] | [-0.26, +1.41] | 1.005 | 0.2959 | no material change |
| broker_vcsw | 60 | 5423.9 | 5480.3 | +1.04 | [-0.87, +2.93] | [-0.54, +2.61] | 1.002 | 0.3711 | no material change |
| broker_maxrss_kib | 60 | 6709 | 6696 | -0.19 | [-0.84, +0.46] | [-0.75, +0.36] | 1.003 | 0.7712 | no material change |
| broker_ru_maxrss_kib | 60 | 20527 | 20523 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0718 | 0.0705 | -0.0014 | [-0.0022, -0.0006] |
| multi_s | 0.4637 | 0.4667 | +0.0035 | [-0.0018, +0.0088] |
| client_wall_s | 0.5623 | 0.5648 | +0.0025 | [-0.0031, +0.0082] |
| client_cpu_s | 0.4914 | 0.4942 | +0.0030 | [-0.0014, +0.0075] |
| client_vcsw | 2481.5 | 2646.0 | +149.8 | [+54.7, +244.9] |
| multi_client_cpu_s | 0.4400 | 0.4500 | +0.0042 | [-0.0011, +0.0094] |
| multi_broker_cpu_s | 0.3650 | 0.3700 | +0.0015 | [-0.0034, +0.0064] |
| broker_user_s | 0.2081 | 0.2089 | -0.0004 | [-0.0056, +0.0048] |
| broker_sys_s | 0.2206 | 0.2204 | +0.0028 | [-0.0025, +0.0081] |
| broker_cpu_s | 0.4266 | 0.4278 | +0.0024 | [-0.0019, +0.0067] |
| broker_vcsw | 5424.0 | 5468.5 | +56.4 | [-49.1, +161.9] |
| broker_maxrss_kib | 6720 | 6696 | -13 | [-58, +33] |
| broker_ru_maxrss_kib | 20504 | 20504 | -4 | [-10, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
