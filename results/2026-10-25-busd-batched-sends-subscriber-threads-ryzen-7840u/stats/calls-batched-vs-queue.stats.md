candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0712 | 0.0707 | -0.78 | [-2.11, +0.67] | [-1.91, +0.41] | 0.993 | 0.1053 | no material change |
| multi_s | 60 | 0.4472 | 0.4470 | -0.05 | [-0.90, +0.86] | [-0.76, +0.71] | 0.998 | 0.5658 | no material change |
| client_wall_s | 60 | 0.5475 | 0.5467 | -0.15 | [-0.96, +0.71] | [-0.83, +0.58] | 0.993 | 0.2825 | no material change |
| client_cpu_s | 60 | 0.4787 | 0.4784 | -0.07 | [-0.83, +0.81] | [-0.72, +0.67] | 0.993 | 0.1370 | no material change |
| client_vcsw | 60 | 2215.6 | 2276.2 | +2.74 | [+0.64, +4.93] | [+0.97, +4.58] | 1.023 | 0.0252 | no material change; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.4290 | 0.4290 | +0.00 | [-0.93, +0.98] | [-0.78, +0.82] | 1.000 | 0.7524 | no material change |
| multi_broker_cpu_s | 60 | 0.3487 | 0.3487 | +0.00 | [-1.10, +1.11] | [-0.95, +0.96] | 1.000 | 0.8532 | no material change |
| broker_user_s | 60 | 0.1987 | 0.1980 | -0.36 | [-2.05, +1.40] | [-1.80, +1.10] | 0.991 | 0.5124 | no material change |
| broker_sys_s | 60 | 0.2145 | 0.2167 | +1.00 | [-0.61, +2.57] | [-0.33, +2.35] | 1.020 | 0.1756 | no material change |
| broker_cpu_s | 60 | 0.4132 | 0.4147 | +0.35 | [-0.40, +1.13] | [-0.28, +1.00] | 1.002 | 0.6481 | no material change |
| broker_vcsw | 60 | 5619.4 | 5755.5 | +2.42 | [+0.95, +3.98] | [+1.15, +3.73] | 1.018 | 0.0025 | no material change; repeatable change (+) |
| broker_maxrss_kib | 60 | 6694 | 6708 | +0.22 | [-0.42, +0.86] | [-0.31, +0.76] | 0.999 | 0.7183 | no material change |
| broker_ru_maxrss_kib | 60 | 20391 | 20393 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0708 | 0.0707 | -0.0006 | [-0.0016, +0.0005] |
| multi_s | 0.4424 | 0.4431 | -0.0002 | [-0.0042, +0.0038] |
| client_wall_s | 0.5434 | 0.5424 | -0.0008 | [-0.0056, +0.0039] |
| client_cpu_s | 0.4744 | 0.4742 | -0.0003 | [-0.0044, +0.0038] |
| client_vcsw | 2191.0 | 2235.5 | +60.6 | [+11.9, +109.3] |
| multi_client_cpu_s | 0.4300 | 0.4300 | +0.0000 | [-0.0042, +0.0042] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | -0.0000 | [-0.0041, +0.0041] |
| broker_user_s | 0.1963 | 0.1967 | -0.0007 | [-0.0042, +0.0028] |
| broker_sys_s | 0.2140 | 0.2171 | +0.0021 | [-0.0014, +0.0056] |
| broker_cpu_s | 0.4094 | 0.4122 | +0.0014 | [-0.0018, +0.0047] |
| broker_vcsw | 5636.5 | 5772.0 | +136.1 | [+49.1, +223.0] |
| broker_maxrss_kib | 6702 | 6722 | +15 | [-28, +58] |
| broker_ru_maxrss_kib | 20444 | 20444 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
