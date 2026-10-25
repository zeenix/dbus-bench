candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0717 | 0.0708 | -1.25 | [-2.52, +0.09] | [-2.32, -0.13] | 0.988 | 0.0414 | no material change |
| multi_s | 60 | 0.4527 | 0.4506 | -0.46 | [-1.44, +0.49] | [-1.29, +0.34] | 1.000 | 0.5461 | no material change |
| client_wall_s | 60 | 0.5545 | 0.5514 | -0.57 | [-1.46, +0.29] | [-1.32, +0.17] | 0.997 | 0.2959 | no material change |
| client_cpu_s | 60 | 0.4831 | 0.4802 | -0.59 | [-1.42, +0.22] | [-1.28, +0.10] | 0.994 | 0.2792 | no material change |
| client_vcsw | 60 | 2288.2 | 2293.9 | +0.25 | [-2.20, +2.65] | [-1.80, +2.30] | 1.007 | 0.5884 | no material change |
| multi_client_cpu_s | 60 | 0.4318 | 0.4313 | -0.12 | [-1.08, +0.82] | [-0.92, +0.66] | 1.000 | 0.9746 | no material change |
| multi_broker_cpu_s | 60 | 0.3527 | 0.3485 | -1.18 | [-2.36, +0.05] | [-2.20, -0.14] | 0.973 | 0.0837 | no material change |
| broker_user_s | 60 | 0.2020 | 0.1951 | -3.42 | [-5.23, -1.63] | [-4.96, -1.95] | 0.969 | 0.0010 | no material change; repeatable change (-) |
| broker_sys_s | 60 | 0.2149 | 0.2185 | +1.65 | [-0.27, +3.65] | [+0.04, +3.34] | 1.017 | 0.1085 | no material change |
| broker_cpu_s | 60 | 0.4169 | 0.4136 | -0.81 | [-1.74, +0.11] | [-1.57, -0.03] | 0.996 | 0.1532 | no material change |
| broker_vcsw | 60 | 5412.1 | 5646.1 | +4.32 | [+2.57, +6.12] | [+2.86, +5.84] | 1.030 | <0.0001 | inconclusive; repeatable change (+) |
| broker_maxrss_kib | 60 | 6723 | 6695 | -0.41 | [-1.13, +0.35] | [-1.02, +0.23] | 0.994 | 0.1592 | no material change |
| broker_ru_maxrss_kib | 60 | 20612 | 20612 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0715 | 0.0704 | -0.0009 | [-0.0019, +0.0001] |
| multi_s | 0.4523 | 0.4486 | -0.0021 | [-0.0067, +0.0025] |
| client_wall_s | 0.5530 | 0.5488 | -0.0032 | [-0.0082, +0.0019] |
| client_cpu_s | 0.4806 | 0.4781 | -0.0029 | [-0.0070, +0.0013] |
| client_vcsw | 2246.0 | 2287.0 | +5.7 | [-52.0, +63.4] |
| multi_client_cpu_s | 0.4300 | 0.4300 | -0.0005 | [-0.0047, +0.0037] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | -0.0042 | [-0.0086, +0.0003] |
| broker_user_s | 0.2037 | 0.1942 | -0.0069 | [-0.0107, -0.0031] |
| broker_sys_s | 0.2152 | 0.2189 | +0.0036 | [-0.0008, +0.0079] |
| broker_cpu_s | 0.4162 | 0.4133 | -0.0034 | [-0.0073, +0.0006] |
| broker_vcsw | 5375.0 | 5642.0 | +233.9 | [+138.3, +329.5] |
| broker_maxrss_kib | 6736 | 6698 | -28 | [-79, +24] |
| broker_ru_maxrss_kib | 20704 | 20704 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
