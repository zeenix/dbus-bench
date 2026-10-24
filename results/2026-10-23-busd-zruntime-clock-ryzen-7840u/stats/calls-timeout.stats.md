candidate timeout against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0713 | 0.0700 | -1.81 | [-3.02, -0.54] | [-2.83, -0.77] | 0.980 | 0.0071 | no material change; repeatable change (-) |
| multi_s | 60 | 0.4521 | 0.4523 | +0.05 | [-0.76, +0.87] | [-0.62, +0.74] | 1.002 | 0.8829 | no material change |
| client_wall_s | 60 | 0.5542 | 0.5532 | -0.18 | [-0.89, +0.52] | [-0.78, +0.41] | 1.001 | 0.6910 | no material change |
| client_cpu_s | 60 | 0.4835 | 0.4828 | -0.15 | [-0.86, +0.59] | [-0.74, +0.47] | 0.999 | 0.6063 | no material change |
| client_vcsw | 60 | 2234.9 | 2280.4 | +2.04 | [-0.07, +4.16] | [+0.29, +3.79] | 1.026 | 0.0441 | no material change |
| multi_client_cpu_s | 60 | 0.4347 | 0.4342 | -0.12 | [-0.99, +0.73] | [-0.84, +0.61] | 1.000 | 0.7746 | no material change |
| multi_broker_cpu_s | 60 | 0.3512 | 0.3527 | +0.43 | [-0.66, +1.53] | [-0.47, +1.33] | 1.000 | 0.4075 | no material change |
| broker_user_s | 60 | 0.1969 | 0.1963 | -0.28 | [-2.34, +1.88] | [-2.01, +1.50] | 0.995 | 0.5510 | no material change |
| broker_sys_s | 60 | 0.2190 | 0.2219 | +1.30 | [-0.60, +3.24] | [-0.28, +2.93] | 1.014 | 0.1118 | no material change |
| broker_cpu_s | 60 | 0.4159 | 0.4182 | +0.55 | [-0.11, +1.26] | [-0.02, +1.14] | 1.004 | 0.1756 | no material change |
| broker_vcsw | 60 | 5542.6 | 5744.4 | +3.64 | [+2.12, +5.22] | [+2.38, +4.95] | 1.035 | <0.0001 | no material change; repeatable change (+) |
| broker_maxrss_kib | 60 | 6669 | 6664 | -0.08 | [-0.65, +0.49] | [-0.56, +0.40] | 1.000 | 0.7348 | no material change |
| broker_ru_maxrss_kib | 60 | 20660 | 20658 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0707 | 0.0696 | -0.0013 | [-0.0022, -0.0004] |
| multi_s | 0.4500 | 0.4506 | +0.0002 | [-0.0035, +0.0040] |
| client_wall_s | 0.5506 | 0.5505 | -0.0010 | [-0.0050, +0.0030] |
| client_cpu_s | 0.4804 | 0.4798 | -0.0007 | [-0.0043, +0.0029] |
| client_vcsw | 2203.0 | 2278.0 | +45.5 | [-2.4, +93.4] |
| multi_client_cpu_s | 0.4300 | 0.4300 | -0.0005 | [-0.0043, +0.0033] |
| multi_broker_cpu_s | 0.3500 | 0.3500 | +0.0015 | [-0.0024, +0.0054] |
| broker_user_s | 0.1968 | 0.1957 | -0.0005 | [-0.0048, +0.0037] |
| broker_sys_s | 0.2206 | 0.2224 | +0.0029 | [-0.0015, +0.0072] |
| broker_cpu_s | 0.4145 | 0.4182 | +0.0023 | [-0.0006, +0.0052] |
| broker_vcsw | 5559.0 | 5719.5 | +201.8 | [+113.4, +290.3] |
| broker_maxrss_kib | 6688 | 6676 | -5 | [-44, +33] |
| broker_ru_maxrss_kib | 20696 | 20696 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
