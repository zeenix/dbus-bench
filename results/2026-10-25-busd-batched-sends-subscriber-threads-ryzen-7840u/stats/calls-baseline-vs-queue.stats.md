candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0712 | 0.0696 | -2.25 | [-3.69, -0.72] | [-3.48, -0.94] | 0.981 | 0.0066 | no material change; repeatable change (-) |
| multi_s | 60 | 0.4472 | 0.4494 | +0.49 | [-0.39, +1.40] | [-0.25, +1.25] | 1.004 | 0.2162 | no material change |
| client_wall_s | 60 | 0.5475 | 0.5482 | +0.13 | [-0.64, +0.96] | [-0.53, +0.82] | 1.000 | 0.8888 | no material change |
| client_cpu_s | 60 | 0.4787 | 0.4774 | -0.28 | [-1.00, +0.49] | [-0.89, +0.36] | 0.997 | 0.3386 | no material change |
| client_vcsw | 60 | 2215.6 | 2227.2 | +0.53 | [-1.44, +2.48] | [-1.14, +2.17] | 1.007 | 0.4661 | no material change |
| multi_client_cpu_s | 60 | 0.4290 | 0.4317 | +0.62 | [-0.35, +1.64] | [-0.19, +1.46] | 1.000 | 0.2903 | no material change |
| multi_broker_cpu_s | 60 | 0.3487 | 0.3507 | +0.57 | [-0.57, +1.82] | [-0.38, +1.59] | 1.000 | 0.4263 | no material change |
| broker_user_s | 60 | 0.1987 | 0.1948 | -1.97 | [-3.67, -0.23] | [-3.42, -0.55] | 0.981 | 0.0121 | no material change; repeatable change (-) |
| broker_sys_s | 60 | 0.2145 | 0.2189 | +2.02 | [+0.36, +3.68] | [+0.62, +3.43] | 1.017 | 0.0299 | no material change; repeatable change (+) |
| broker_cpu_s | 60 | 0.4132 | 0.4136 | +0.10 | [-0.53, +0.74] | [-0.44, +0.63] | 1.001 | 0.7238 | no material change |
| broker_vcsw | 60 | 5619.4 | 5735.5 | +2.07 | [+0.65, +3.47] | [+0.89, +3.24] | 1.022 | 0.0080 | no material change; repeatable change (+) |
| broker_maxrss_kib | 60 | 6694 | 6682 | -0.18 | [-0.84, +0.46] | [-0.73, +0.36] | 0.996 | 0.5411 | no material change |
| broker_ru_maxrss_kib | 60 | 20391 | 20393 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0708 | 0.0687 | -0.0016 | [-0.0027, -0.0005] |
| multi_s | 0.4424 | 0.4461 | +0.0022 | [-0.0019, +0.0063] |
| client_wall_s | 0.5434 | 0.5427 | +0.0007 | [-0.0038, +0.0052] |
| client_cpu_s | 0.4744 | 0.4714 | -0.0013 | [-0.0050, +0.0024] |
| client_vcsw | 2191.0 | 2222.0 | +11.7 | [-32.6, +56.0] |
| multi_client_cpu_s | 0.4300 | 0.4300 | +0.0027 | [-0.0017, +0.0070] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | +0.0020 | [-0.0022, +0.0062] |
| broker_user_s | 0.1963 | 0.1965 | -0.0039 | [-0.0074, -0.0004] |
| broker_sys_s | 0.2140 | 0.2185 | +0.0043 | [+0.0007, +0.0080] |
| broker_cpu_s | 0.4094 | 0.4091 | +0.0004 | [-0.0023, +0.0031] |
| broker_vcsw | 5636.5 | 5717.0 | +116.1 | [+36.7, +195.5] |
| broker_maxrss_kib | 6702 | 6658 | -12 | [-56, +32] |
| broker_ru_maxrss_kib | 20444 | 20444 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
