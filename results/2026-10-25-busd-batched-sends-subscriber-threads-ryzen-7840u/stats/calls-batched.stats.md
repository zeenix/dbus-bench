candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0696 | 0.0707 | +1.50 | [-0.06, +3.02] | [+0.22, +2.77] | 1.014 | 0.0414 | no material change |
| multi_s | 60 | 0.4494 | 0.4470 | -0.54 | [-1.37, +0.34] | [-1.24, +0.19] | 0.996 | 0.1827 | no material change |
| client_wall_s | 60 | 0.5482 | 0.5467 | -0.28 | [-1.07, +0.55] | [-0.95, +0.41] | 1.000 | 0.4936 | no material change |
| client_cpu_s | 60 | 0.4774 | 0.4784 | +0.21 | [-0.52, +1.02] | [-0.41, +0.89] | 1.004 | 0.6115 | no material change |
| client_vcsw | 60 | 2227.2 | 2276.2 | +2.20 | [+0.04, +4.38] | [+0.37, +4.02] | 1.020 | 0.0481 | no material change; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.4317 | 0.4290 | -0.62 | [-1.61, +0.39] | [-1.45, +0.23] | 1.000 | 0.1965 | no material change |
| multi_broker_cpu_s | 60 | 0.3507 | 0.3487 | -0.57 | [-1.75, +0.62] | [-1.56, +0.43] | 1.000 | 0.4417 | no material change |
| broker_user_s | 60 | 0.1948 | 0.1980 | +1.65 | [-0.48, +3.93] | [-0.13, +3.53] | 1.005 | 0.1827 | no material change |
| broker_sys_s | 60 | 0.2189 | 0.2167 | -1.00 | [-3.01, +0.99] | [-2.67, +0.68] | 0.991 | 0.4097 | no material change |
| broker_cpu_s | 60 | 0.4136 | 0.4147 | +0.25 | [-0.47, +0.98] | [-0.35, +0.87] | 1.003 | 0.4797 | no material change |
| broker_vcsw | 60 | 5735.5 | 5755.5 | +0.35 | [-0.89, +1.58] | [-0.71, +1.40] | 1.011 | 0.3275 | no material change |
| broker_maxrss_kib | 60 | 6682 | 6708 | +0.40 | [-0.21, +0.99] | [-0.10, +0.90] | 1.008 | 0.0938 | no material change |
| broker_ru_maxrss_kib | 60 | 20393 | 20393 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0687 | 0.0707 | +0.0010 | [-0.0000, +0.0021] |
| multi_s | 0.4461 | 0.4431 | -0.0024 | [-0.0064, +0.0016] |
| client_wall_s | 0.5427 | 0.5424 | -0.0015 | [-0.0061, +0.0030] |
| client_cpu_s | 0.4714 | 0.4742 | +0.0010 | [-0.0028, +0.0048] |
| client_vcsw | 2222.0 | 2235.5 | +48.9 | [-1.3, +99.1] |
| multi_client_cpu_s | 0.4300 | 0.4300 | -0.0027 | [-0.0071, +0.0017] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | -0.0020 | [-0.0063, +0.0023] |
| broker_user_s | 0.1965 | 0.1967 | +0.0032 | [-0.0010, +0.0075] |
| broker_sys_s | 0.2185 | 0.2171 | -0.0022 | [-0.0067, +0.0023] |
| broker_cpu_s | 0.4091 | 0.4122 | +0.0010 | [-0.0021, +0.0041] |
| broker_vcsw | 5717.0 | 5772.0 | +19.9 | [-53.3, +93.2] |
| broker_maxrss_kib | 6658 | 6722 | +27 | [-14, +68] |
| broker_ru_maxrss_kib | 20444 | 20444 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
