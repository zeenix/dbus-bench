candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0707 | 0.0707 | -0.03 | [-1.32, +1.28] | [-1.12, +1.06] | 0.999 | 0.9238 | no material change |
| multi_s | 60 | 0.4480 | 0.4470 | -0.23 | [-1.04, +0.58] | [-0.90, +0.45] | 0.999 | 0.7404 | no material change |
| client_wall_s | 60 | 0.5479 | 0.5467 | -0.21 | [-0.93, +0.51] | [-0.83, +0.39] | 1.000 | 0.7967 | no material change |
| client_cpu_s | 60 | 0.4791 | 0.4784 | -0.15 | [-0.88, +0.62] | [-0.77, +0.49] | 1.001 | 0.8829 | no material change |
| client_vcsw | 60 | 2236.0 | 2276.2 | +1.80 | [-0.74, +4.38] | [-0.33, +3.96] | 1.006 | 0.2569 | no material change |
| multi_client_cpu_s | 60 | 0.4300 | 0.4290 | -0.23 | [-1.15, +0.70] | [-1.00, +0.54] | 1.000 | 0.5642 | no material change |
| multi_broker_cpu_s | 60 | 0.3497 | 0.3487 | -0.29 | [-1.41, +0.81] | [-1.23, +0.67] | 1.000 | 0.7548 | no material change |
| broker_user_s | 60 | 0.2017 | 0.1980 | -1.83 | [-3.56, -0.03] | [-3.28, -0.33] | 0.993 | 0.0701 | no material change; repeatable change (-) |
| broker_sys_s | 60 | 0.2126 | 0.2167 | +1.92 | [-0.30, +4.14] | [+0.09, +3.79] | 1.032 | 0.0585 | no material change |
| broker_cpu_s | 60 | 0.4143 | 0.4147 | +0.09 | [-0.68, +0.86] | [-0.55, +0.74] | 1.004 | 0.5559 | no material change |
| broker_vcsw | 60 | 5802.2 | 5755.5 | -0.81 | [-2.35, +0.72] | [-2.12, +0.48] | 1.002 | 0.5123 | no material change |
| broker_maxrss_kib | 60 | 6710 | 6708 | -0.02 | [-0.65, +0.61] | [-0.55, +0.51] | 0.999 | 0.9560 | no material change |
| broker_ru_maxrss_kib | 60 | 20393 | 20393 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0705 | 0.0707 | -0.0000 | [-0.0010, +0.0009] |
| multi_s | 0.4431 | 0.4431 | -0.0010 | [-0.0048, +0.0027] |
| client_wall_s | 0.5426 | 0.5424 | -0.0012 | [-0.0053, +0.0029] |
| client_cpu_s | 0.4739 | 0.4742 | -0.0007 | [-0.0044, +0.0030] |
| client_vcsw | 2213.0 | 2235.5 | +40.1 | [-17.9, +98.2] |
| multi_client_cpu_s | 0.4300 | 0.4300 | -0.0010 | [-0.0051, +0.0031] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | -0.0010 | [-0.0051, +0.0031] |
| broker_user_s | 0.2009 | 0.1967 | -0.0037 | [-0.0074, +0.0000] |
| broker_sys_s | 0.2141 | 0.2171 | +0.0041 | [-0.0007, +0.0088] |
| broker_cpu_s | 0.4123 | 0.4122 | +0.0004 | [-0.0029, +0.0037] |
| broker_vcsw | 5792.0 | 5772.0 | -46.7 | [-140.4, +47.0] |
| broker_maxrss_kib | 6706 | 6722 | -1 | [-44, +42] |
| broker_ru_maxrss_kib | 20444 | 20444 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
