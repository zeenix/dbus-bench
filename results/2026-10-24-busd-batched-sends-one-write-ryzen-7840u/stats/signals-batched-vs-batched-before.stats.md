candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3044 | 0.3015 | -0.97 | [-1.69, -0.24] | [-1.57, -0.36] | 0.992 | 0.0024 | no material change; repeatable change (-) |
| multi_s | 60 | 0.3727 | 0.3647 | -2.13 | [-2.99, -1.23] | [-2.86, -1.38] | 0.983 | <0.0001 | no material change; repeatable change (-) |
| client_wall_s | 60 | 0.7340 | 0.7228 | -1.53 | [-2.19, -0.87] | [-2.08, -0.97] | 0.982 | <0.0001 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 0.6793 | 0.6687 | -1.55 | [-2.20, -0.89] | [-2.10, -1.01] | 0.985 | <0.0001 | no material change; repeatable change (-) |
| client_vcsw | 60 | 49.517 | 45.100 | -8.92 | [-15.05, -2.66] | [-13.96, -3.74] | 0.926 | 0.0123 | inconclusive; repeatable change (-) |
| multi_client_cpu_s | 60 | 0.3603 | 0.3525 | -2.17 | [-3.22, -1.12] | [-3.05, -1.30] | 0.972 | 0.0006 | no material change; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.1067 | 0.0912 | -14.53 | [-16.30, -12.74] | [-16.02, -13.04] | 0.833 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2321 | 0.2329 | +0.31 | [-1.38, +2.03] | [-1.13, +1.76] | 0.990 | 0.7910 | no material change |
| broker_sys_s | 60 | 0.1466 | 0.1306 | -10.89 | [-13.06, -8.68] | [-12.73, -9.01] | 0.890 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.3787 | 0.3635 | -4.03 | [-4.74, -3.29] | [-4.63, -3.43] | 0.957 | <0.0001 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 624.5 | 672.3 | +7.66 | [+4.90, +10.55] | [+5.31, +10.05] | 1.074 | <0.0001 | inconclusive; repeatable change (+) |
| broker_maxrss_kib | 60 | 6598 | 6598 | -0.00 | [-0.74, +0.73] | [-0.63, +0.61] | 1.002 | 1.0000 | no material change |
| broker_ru_maxrss_kib | 60 | 20527 | 20527 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3032 | 0.2999 | -0.0030 | [-0.0052, -0.0007] |
| multi_s | 0.3696 | 0.3633 | -0.0079 | [-0.0113, -0.0045] |
| client_wall_s | 0.7307 | 0.7227 | -0.0112 | [-0.0162, -0.0062] |
| client_cpu_s | 0.6754 | 0.6668 | -0.0105 | [-0.0151, -0.0060] |
| client_vcsw | 49.500 | 45.500 | -4.417 | [-7.740, -1.093] |
| multi_client_cpu_s | 0.3600 | 0.3500 | -0.0078 | [-0.0118, -0.0039] |
| multi_broker_cpu_s | 0.1100 | 0.0900 | -0.0155 | [-0.0176, -0.0134] |
| broker_user_s | 0.2317 | 0.2306 | +0.0007 | [-0.0034, +0.0048] |
| broker_sys_s | 0.1472 | 0.1317 | -0.0160 | [-0.0194, -0.0125] |
| broker_cpu_s | 0.3774 | 0.3623 | -0.0153 | [-0.0181, -0.0124] |
| broker_vcsw | 620.5 | 681.0 | +47.9 | [+30.4, +65.3] |
| broker_maxrss_kib | 6596 | 6614 | -0 | [-50, +49] |
| broker_ru_maxrss_kib | 20572 | 20572 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
