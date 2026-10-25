candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.4275 | 3.3924 | -1.02 | [-3.20, +1.25] | [-2.85, +0.87] | 0.981 | 0.2532 | no material change |
| multi_s | 40 | 3.8721 | 3.8161 | -1.44 | [-4.35, +1.64] | [-3.88, +1.11] | 0.992 | 0.3070 | no material change |
| client_wall_s | 40 | 7.3059 | 7.2153 | -1.24 | [-3.30, +0.97] | [-2.98, +0.58] | 0.981 | 0.1878 | no material change |
| client_cpu_s | 40 | 6.7420 | 6.6771 | -0.96 | [-2.68, +0.84] | [-2.40, +0.51] | 0.994 | 0.2646 | no material change |
| client_vcsw | 40 | 9372.2 | 8680.6 | -7.38 | [-17.21, +4.37] | [-15.72, +2.27] | 0.954 | 0.1746 | inconclusive |
| multi_client_cpu_s | 40 | 3.5670 | 3.5290 | -1.07 | [-3.44, +1.41] | [-3.04, +0.98] | 0.993 | 0.3398 | no material change |
| multi_broker_cpu_s | 40 | 2.9075 | 2.8758 | -1.09 | [-4.30, +2.35] | [-3.79, +1.77] | 0.976 | 0.4803 | no material change |
| broker_user_s | 40 | 2.7290 | 2.6996 | -1.08 | [-2.87, +0.77] | [-2.57, +0.49] | 0.989 | 0.2883 | no material change |
| broker_sys_s | 40 | 2.3175 | 2.2825 | -1.51 | [-5.65, +2.99] | [-5.04, +2.25] | 0.973 | 0.3823 | inconclusive |
| broker_cpu_s | 40 | 5.0465 | 4.9822 | -1.27 | [-3.70, +1.36] | [-3.31, +0.91] | 0.983 | 0.2113 | no material change |
| broker_vcsw | 40 | 18890.7 | 18966.3 | +0.40 | [-1.81, +2.55] | [-1.45, +2.19] | 1.013 | 0.6001 | no material change |
| broker_maxrss_kib | 40 | 7145 | 7090 | -0.78 | [-2.26, +0.82] | [-2.04, +0.52] | 0.981 | 0.2289 | no material change |
| broker_ru_maxrss_kib | 40 | 18754 | 18754 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.4270 | 3.3471 | -0.0351 | [-0.1151, +0.0449] |
| multi_s | 3.8926 | 3.7686 | -0.0559 | [-0.1766, +0.0647] |
| client_wall_s | 7.3345 | 7.1474 | -0.0906 | [-0.2546, +0.0733] |
| client_cpu_s | 6.7320 | 6.6199 | -0.0650 | [-0.1889, +0.0590] |
| client_vcsw | 9141.5 | 8168.0 | -691.5 | [-1789.7, +406.6] |
| multi_client_cpu_s | 3.6000 | 3.5000 | -0.0380 | [-0.1278, +0.0518] |
| multi_broker_cpu_s | 2.9250 | 2.8150 | -0.0317 | [-0.1328, +0.0693] |
| broker_user_s | 2.7024 | 2.6899 | -0.0293 | [-0.0813, +0.0227] |
| broker_sys_s | 2.3455 | 2.2716 | -0.0350 | [-0.1402, +0.0703] |
| broker_cpu_s | 5.0773 | 4.8978 | -0.0643 | [-0.1982, +0.0696] |
| broker_vcsw | 18804.0 | 18978.5 | +75.6 | [-352.3, +503.5] |
| broker_maxrss_kib | 7160 | 7052 | -55 | [-170, +59] |
| broker_ru_maxrss_kib | 18744 | 18744 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
