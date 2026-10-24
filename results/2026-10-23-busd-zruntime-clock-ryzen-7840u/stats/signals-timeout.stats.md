candidate timeout against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3805 | 0.3131 | -17.72 | [-18.32, -17.13] | [-18.22, -17.22] | 0.822 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3827 | 0.3786 | -1.08 | [-2.23, +0.09] | [-2.05, -0.10] | 0.990 | 0.0407 | no material change |
| client_wall_s | 60 | 0.8251 | 0.7513 | -8.94 | [-9.63, -8.22] | [-9.53, -8.33] | 0.911 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.7000 | 0.6909 | -1.30 | [-2.12, -0.47] | [-1.99, -0.61] | 0.987 | 0.0009 | no material change; repeatable change (-) |
| client_vcsw | 60 | 209.2 | 126.4 | -39.58 | [-41.84, -37.45] | [-41.44, -37.76] | 0.626 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3673 | 0.3620 | -1.45 | [-2.75, -0.09] | [-2.52, -0.36] | 0.974 | 0.0471 | no material change; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.1860 | 0.2018 | +8.51 | [+6.47, +10.69] | [+6.80, +10.32] | 1.105 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.2611 | 0.2720 | +4.19 | [+2.56, +5.88] | [+2.81, +5.61] | 1.040 | <0.0001 | inconclusive; repeatable change (+) |
| broker_sys_s | 60 | 0.2617 | 0.2502 | -4.41 | [-6.14, -2.67] | [-5.86, -2.97] | 0.957 | <0.0001 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.5228 | 0.5222 | -0.12 | [-0.83, +0.61] | [-0.73, +0.49] | 0.998 | 0.8252 | no material change |
| broker_vcsw | 60 | 813.8 | 367.4 | -54.85 | [-56.40, -53.30] | [-56.16, -53.55] | 0.471 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 54207 | 6562 | -87.89 | [-87.98, -87.81] | [-87.96, -87.83] | 0.121 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 53987 | 20529 | -61.97 | [-62.18, -61.77] | [-62.15, -61.80] | 0.380 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3785 | 0.3122 | -0.0674 | [-0.0699, -0.0649] |
| multi_s | 0.3767 | 0.3736 | -0.0041 | [-0.0087, +0.0004] |
| client_wall_s | 0.8195 | 0.7461 | -0.0738 | [-0.0801, -0.0674] |
| client_cpu_s | 0.6922 | 0.6844 | -0.0091 | [-0.0151, -0.0032] |
| client_vcsw | 210.5 | 131.5 | -82.8 | [-87.9, -77.8] |
| multi_client_cpu_s | 0.3600 | 0.3600 | -0.0053 | [-0.0102, -0.0004] |
| multi_broker_cpu_s | 0.1900 | 0.2000 | +0.0158 | [+0.0120, +0.0196] |
| broker_user_s | 0.2609 | 0.2727 | +0.0109 | [+0.0065, +0.0154] |
| broker_sys_s | 0.2604 | 0.2482 | -0.0116 | [-0.0164, -0.0067] |
| broker_cpu_s | 0.5206 | 0.5194 | -0.0006 | [-0.0046, +0.0033] |
| broker_vcsw | 782.5 | 364.0 | -446.4 | [-474.1, -418.8] |
| broker_maxrss_kib | 54236 | 6574 | -47644 | [-47960, -47328] |
| broker_ru_maxrss_kib | 54080 | 20576 | -33458 | [-33746, -33170] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
