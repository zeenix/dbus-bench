candidate timeout against baseline timeout-before, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3301 | 0.3131 | -5.16 | [-5.78, -4.50] | [-5.69, -4.61] | 0.947 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.3713 | 0.3786 | +1.98 | [+1.05, +2.97] | [+1.19, +2.78] | 1.015 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.7622 | 0.7513 | -1.43 | [-2.11, -0.72] | [-2.01, -0.84] | 0.978 | 0.0001 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 0.6902 | 0.6909 | +0.10 | [-0.57, +0.80] | [-0.47, +0.68] | 0.998 | 0.8081 | no material change |
| client_vcsw | 60 | 328.0 | 126.4 | -61.46 | [-62.91, -60.09] | [-62.68, -60.29] | 0.404 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3568 | 0.3620 | +1.45 | [+0.23, +2.71] | [+0.46, +2.48] | 1.000 | 0.0248 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2805 | 0.2018 | -28.05 | [-29.06, -27.00] | [-28.90, -27.16] | 0.714 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2825 | 0.2720 | -3.68 | [-4.95, -2.37] | [-4.75, -2.57] | 0.965 | <0.0001 | no material change; repeatable change (-) |
| broker_sys_s | 60 | 0.3814 | 0.2502 | -34.41 | [-35.33, -33.48] | [-35.18, -33.64] | 0.653 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6639 | 0.5222 | -21.34 | [-21.74, -20.93] | [-21.68, -20.99] | 0.784 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 230.1 | 367.4 | +59.70 | [+53.71, +65.91] | [+54.59, +64.92] | 1.581 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6542 | 6562 | +0.31 | [-0.29, +0.92] | [-0.19, +0.82] | 1.000 | 0.5147 | no material change |
| broker_ru_maxrss_kib | 60 | 20527 | 20529 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3299 | 0.3122 | -0.0170 | [-0.0192, -0.0149] |
| multi_s | 0.3689 | 0.3736 | +0.0073 | [+0.0037, +0.0109] |
| client_wall_s | 0.7607 | 0.7461 | -0.0109 | [-0.0163, -0.0055] |
| client_cpu_s | 0.6864 | 0.6844 | +0.0007 | [-0.0042, +0.0055] |
| client_vcsw | 327.0 | 131.5 | -201.6 | [-207.3, -195.9] |
| multi_client_cpu_s | 0.3600 | 0.3600 | +0.0052 | [+0.0007, +0.0097] |
| multi_broker_cpu_s | 0.2800 | 0.2000 | -0.0787 | [-0.0821, -0.0753] |
| broker_user_s | 0.2821 | 0.2727 | -0.0104 | [-0.0142, -0.0066] |
| broker_sys_s | 0.3814 | 0.2482 | -0.1312 | [-0.1355, -0.1269] |
| broker_cpu_s | 0.6634 | 0.5194 | -0.1417 | [-0.1447, -0.1386] |
| broker_vcsw | 228.0 | 364.0 | +137.3 | [+126.7, +148.0] |
| broker_maxrss_kib | 6536 | 6574 | +20 | [-20, +60] |
| broker_ru_maxrss_kib | 20576 | 20576 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
