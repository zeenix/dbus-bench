candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 2.0774 | 2.0382 | -1.89 | [-3.01, -0.80] | [-2.82, -0.97] | 0.975 | 0.0026 | no material change; repeatable change (-) |
| multi_s | 40 | 2.2495 | 2.2409 | -0.38 | [-1.64, +0.98] | [-1.45, +0.74] | 0.988 | 0.2113 | no material change |
| client_wall_s | 40 | 4.3598 | 4.3121 | -1.09 | [-1.97, -0.23] | [-1.82, -0.37] | 0.987 | 0.0124 | no material change; repeatable change (-) |
| client_cpu_s | 40 | 4.1674 | 4.1228 | -1.07 | [-1.97, -0.18] | [-1.83, -0.33] | 0.985 | 0.0139 | no material change; repeatable change (-) |
| client_vcsw | 40 | 2871.6 | 2832.1 | -1.37 | [-7.79, +5.46] | [-6.74, +4.36] | 1.013 | 0.8666 | inconclusive |
| multi_client_cpu_s | 40 | 2.1957 | 2.1825 | -0.60 | [-1.87, +0.78] | [-1.68, +0.53] | 0.986 | 0.1078 | no material change |
| multi_broker_cpu_s | 40 | 1.8837 | 1.9395 | +2.96 | [+1.41, +4.56] | [+1.66, +4.27] | 1.030 | 0.0007 | no material change; repeatable change (+) |
| broker_user_s | 40 | 1.6426 | 1.6382 | -0.27 | [-1.57, +1.06] | [-1.37, +0.84] | 0.994 | 0.6095 | no material change |
| broker_sys_s | 40 | 1.8073 | 1.7629 | -2.46 | [-4.07, -0.78] | [-3.81, -1.05] | 0.972 | 0.0059 | no material change; repeatable change (-) |
| broker_cpu_s | 40 | 3.4500 | 3.4011 | -1.42 | [-2.51, -0.32] | [-2.30, -0.51] | 0.992 | 0.0039 | no material change; repeatable change (-) |
| broker_vcsw | 40 | 14886.8 | 14890.4 | +0.02 | [-2.47, +2.45] | [-2.07, +2.04] | 0.997 | 0.9037 | no material change |
| broker_maxrss_kib | 40 | 11361 | 11238 | -1.08 | [-2.70, +0.58] | [-2.43, +0.32] | 0.986 | 0.1969 | no material change |
| broker_ru_maxrss_kib | 40 | 20510 | 20510 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 2.0683 | 2.0329 | -0.0392 | [-0.0637, -0.0148] |
| multi_s | 2.2407 | 2.2364 | -0.0086 | [-0.0394, +0.0222] |
| client_wall_s | 4.3412 | 4.2919 | -0.0477 | [-0.0871, -0.0082] |
| client_cpu_s | 4.1478 | 4.1102 | -0.0446 | [-0.0835, -0.0056] |
| client_vcsw | 2812.0 | 2788.0 | -39.5 | [-239.3, +160.4] |
| multi_client_cpu_s | 2.1900 | 2.1700 | -0.0133 | [-0.0436, +0.0171] |
| multi_broker_cpu_s | 1.8850 | 1.9200 | +0.0558 | [+0.0251, +0.0864] |
| broker_user_s | 1.6272 | 1.6309 | -0.0044 | [-0.0270, +0.0181] |
| broker_sys_s | 1.7948 | 1.7500 | -0.0444 | [-0.0758, -0.0130] |
| broker_cpu_s | 3.4485 | 3.3710 | -0.0488 | [-0.0877, -0.0099] |
| broker_vcsw | 14919.5 | 14992.5 | +3.6 | [-377.8, +385.0] |
| broker_maxrss_kib | 11322 | 11222 | -123 | [-319, +73] |
| broker_ru_maxrss_kib | 20564 | 20564 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
