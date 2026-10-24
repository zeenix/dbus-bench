candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0714 | 0.0715 | +0.17 | [-0.97, +1.32] | [-0.80, +1.14] | 1.000 | 0.9121 | no material change |
| multi_s | 60 | 0.4651 | 0.4647 | -0.10 | [-1.20, +1.04] | [-1.03, +0.87] | 0.995 | 0.7628 | no material change |
| client_wall_s | 60 | 0.5647 | 0.5639 | -0.15 | [-1.11, +0.82] | [-0.96, +0.68] | 0.995 | 0.7684 | no material change |
| client_cpu_s | 60 | 0.4925 | 0.4929 | +0.08 | [-0.76, +0.90] | [-0.61, +0.78] | 0.994 | 0.7183 | no material change |
| client_vcsw | 60 | 2605.4 | 2554.7 | -1.95 | [-5.53, +1.79] | [-4.95, +1.22] | 0.948 | 0.2792 | no material change |
| multi_client_cpu_s | 60 | 0.4440 | 0.4450 | +0.23 | [-0.90, +1.36] | [-0.74, +1.17] | 1.000 | 0.7316 | no material change |
| multi_broker_cpu_s | 60 | 0.3667 | 0.3647 | -0.55 | [-1.95, +0.91] | [-1.72, +0.69] | 1.000 | 0.4238 | no material change |
| broker_user_s | 60 | 0.2069 | 0.2105 | +1.76 | [-0.17, +3.84] | [+0.10, +3.50] | 1.012 | 0.1686 | no material change |
| broker_sys_s | 60 | 0.2211 | 0.2161 | -2.25 | [-3.92, -0.49] | [-3.66, -0.77] | 0.974 | 0.0139 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.4280 | 0.4266 | -0.31 | [-1.34, +0.76] | [-1.17, +0.59] | 0.995 | 0.4181 | no material change |
| broker_vcsw | 60 | 5519.2 | 5534.9 | +0.29 | [-1.70, +2.24] | [-1.36, +1.91] | 1.007 | 0.4706 | no material change |
| broker_maxrss_kib | 60 | 6677 | 6694 | +0.25 | [-0.35, +0.87] | [-0.25, +0.76] | 1.000 | 0.4826 | no material change |
| broker_ru_maxrss_kib | 60 | 20527 | 20527 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0714 | 0.0711 | +0.0001 | [-0.0007, +0.0010] |
| multi_s | 0.4652 | 0.4645 | -0.0005 | [-0.0059, +0.0049] |
| client_wall_s | 0.5635 | 0.5651 | -0.0008 | [-0.0065, +0.0048] |
| client_cpu_s | 0.4923 | 0.4921 | +0.0004 | [-0.0038, +0.0046] |
| client_vcsw | 2606.5 | 2492.0 | -50.7 | [-149.2, +47.8] |
| multi_client_cpu_s | 0.4400 | 0.4450 | +0.0010 | [-0.0041, +0.0061] |
| multi_broker_cpu_s | 0.3700 | 0.3600 | -0.0020 | [-0.0074, +0.0034] |
| broker_user_s | 0.2065 | 0.2083 | +0.0036 | [-0.0006, +0.0079] |
| broker_sys_s | 0.2210 | 0.2158 | -0.0050 | [-0.0089, -0.0010] |
| broker_cpu_s | 0.4284 | 0.4256 | -0.0013 | [-0.0059, +0.0032] |
| broker_vcsw | 5457.0 | 5572.0 | +15.8 | [-94.8, +126.3] |
| broker_maxrss_kib | 6658 | 6682 | +17 | [-25, +59] |
| broker_ru_maxrss_kib | 20504 | 20504 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
