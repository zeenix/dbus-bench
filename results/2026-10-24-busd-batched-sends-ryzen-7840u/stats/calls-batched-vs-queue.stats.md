candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0717 | 0.0723 | +0.84 | [-0.20, +1.95] | [-0.04, +1.76] | 1.008 | 0.1851 | no material change |
| multi_s | 60 | 0.4527 | 0.4528 | +0.01 | [-0.78, +0.82] | [-0.65, +0.69] | 1.001 | 0.9004 | no material change |
| client_wall_s | 60 | 0.5545 | 0.5554 | +0.16 | [-0.54, +0.89] | [-0.44, +0.77] | 1.000 | 0.7128 | no material change |
| client_cpu_s | 60 | 0.4831 | 0.4832 | +0.03 | [-0.65, +0.70] | [-0.54, +0.60] | 1.004 | 0.6640 | no material change |
| client_vcsw | 60 | 2288.2 | 2315.5 | +1.20 | [-1.29, +3.73] | [-0.91, +3.33] | 1.009 | 0.3044 | no material change |
| multi_client_cpu_s | 60 | 0.4318 | 0.4348 | +0.69 | [-0.19, +1.59] | [-0.04, +1.43] | 1.000 | 0.1286 | no material change |
| multi_broker_cpu_s | 60 | 0.3527 | 0.3555 | +0.80 | [-0.24, +1.90] | [-0.09, +1.71] | 1.014 | 0.1609 | no material change |
| broker_user_s | 60 | 0.2020 | 0.2002 | -0.88 | [-3.00, +1.29] | [-2.67, +0.94] | 0.996 | 0.3498 | no material change |
| broker_sys_s | 60 | 0.2149 | 0.2209 | +2.78 | [+0.94, +4.74] | [+1.23, +4.41] | 1.016 | 0.0137 | no material change; repeatable change (+) |
| broker_cpu_s | 60 | 0.4169 | 0.4211 | +1.00 | [+0.26, +1.75] | [+0.38, +1.63] | 1.013 | 0.0096 | no material change; repeatable change (+) |
| broker_vcsw | 60 | 5412.1 | 5538.7 | +2.34 | [+0.58, +4.15] | [+0.83, +3.88] | 1.024 | 0.0181 | no material change; repeatable change (+) |
| broker_maxrss_kib | 60 | 6723 | 6694 | -0.43 | [-1.11, +0.30] | [-1.01, +0.18] | 0.992 | 0.1839 | no material change |
| broker_ru_maxrss_kib | 60 | 20612 | 20612 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0715 | 0.0722 | +0.0006 | [-0.0002, +0.0014] |
| multi_s | 0.4523 | 0.4517 | +0.0000 | [-0.0037, +0.0038] |
| client_wall_s | 0.5530 | 0.5542 | +0.0009 | [-0.0032, +0.0050] |
| client_cpu_s | 0.4806 | 0.4798 | +0.0002 | [-0.0032, +0.0035] |
| client_vcsw | 2246.0 | 2274.5 | +27.4 | [-31.7, +86.4] |
| multi_client_cpu_s | 0.4300 | 0.4300 | +0.0030 | [-0.0010, +0.0070] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | +0.0028 | [-0.0011, +0.0068] |
| broker_user_s | 0.2037 | 0.2006 | -0.0018 | [-0.0063, +0.0028] |
| broker_sys_s | 0.2152 | 0.2196 | +0.0060 | [+0.0018, +0.0101] |
| broker_cpu_s | 0.4162 | 0.4204 | +0.0042 | [+0.0010, +0.0074] |
| broker_vcsw | 5375.0 | 5607.5 | +126.6 | [+25.7, +227.4] |
| broker_maxrss_kib | 6736 | 6710 | -29 | [-78, +21] |
| broker_ru_maxrss_kib | 20704 | 20704 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
