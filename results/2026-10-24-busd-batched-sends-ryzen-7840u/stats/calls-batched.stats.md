candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0708 | 0.0723 | +2.12 | [+0.70, +3.57] | [+0.92, +3.35] | 1.031 | 0.0060 | no material change; repeatable change (+) |
| multi_s | 60 | 0.4506 | 0.4528 | +0.47 | [-0.34, +1.33] | [-0.22, +1.18] | 1.002 | 0.4055 | no material change |
| client_wall_s | 60 | 0.5514 | 0.5554 | +0.74 | [-0.03, +1.54] | [+0.08, +1.40] | 1.004 | 0.0748 | no material change |
| client_cpu_s | 60 | 0.4802 | 0.4832 | +0.63 | [-0.07, +1.35] | [+0.03, +1.24] | 1.004 | 0.1491 | no material change |
| client_vcsw | 60 | 2293.9 | 2315.5 | +0.94 | [-1.12, +3.12] | [-0.81, +2.76] | 0.998 | 0.5243 | no material change |
| multi_client_cpu_s | 60 | 0.4313 | 0.4348 | +0.81 | [-0.15, +1.79] | [+0.00, +1.66] | 1.000 | 0.1230 | no material change |
| multi_broker_cpu_s | 60 | 0.3485 | 0.3555 | +2.01 | [+0.95, +3.08] | [+1.10, +2.91] | 1.029 | 0.0009 | no material change; repeatable change (+) |
| broker_user_s | 60 | 0.1951 | 0.2002 | +2.63 | [+1.07, +4.26] | [+1.32, +4.00] | 1.026 | 0.0047 | no material change; repeatable change (+) |
| broker_sys_s | 60 | 0.2185 | 0.2209 | +1.10 | [-0.63, +2.84] | [-0.34, +2.55] | 1.019 | 0.2002 | no material change |
| broker_cpu_s | 60 | 0.4136 | 0.4211 | +1.83 | [+1.15, +2.50] | [+1.26, +2.40] | 1.023 | <0.0001 | no material change; repeatable change (+) |
| broker_vcsw | 60 | 5646.1 | 5538.7 | -1.90 | [-3.30, -0.53] | [-3.06, -0.74] | 0.987 | 0.0257 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 6695 | 6694 | -0.01 | [-0.69, +0.64] | [-0.57, +0.54] | 1.004 | 0.6937 | no material change |
| broker_ru_maxrss_kib | 60 | 20612 | 20612 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0704 | 0.0722 | +0.0015 | [+0.0005, +0.0025] |
| multi_s | 0.4486 | 0.4517 | +0.0021 | [-0.0017, +0.0060] |
| client_wall_s | 0.5488 | 0.5542 | +0.0041 | [-0.0004, +0.0085] |
| client_cpu_s | 0.4781 | 0.4798 | +0.0030 | [-0.0005, +0.0065] |
| client_vcsw | 2287.0 | 2274.5 | +21.6 | [-28.3, +71.6] |
| multi_client_cpu_s | 0.4300 | 0.4300 | +0.0035 | [-0.0009, +0.0079] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | +0.0070 | [+0.0032, +0.0108] |
| broker_user_s | 0.1942 | 0.2006 | +0.0051 | [+0.0019, +0.0084] |
| broker_sys_s | 0.2189 | 0.2196 | +0.0024 | [-0.0015, +0.0063] |
| broker_cpu_s | 0.4133 | 0.4204 | +0.0076 | [+0.0047, +0.0104] |
| broker_vcsw | 5642.0 | 5607.5 | -107.3 | [-188.9, -25.8] |
| broker_maxrss_kib | 6698 | 6710 | -1 | [-47, +45] |
| broker_ru_maxrss_kib | 20704 | 20704 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
