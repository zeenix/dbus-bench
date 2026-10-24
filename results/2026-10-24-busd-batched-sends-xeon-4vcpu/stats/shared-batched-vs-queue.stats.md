candidate batched against baseline queue, from $WORK/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.6434 | 3.9477 | +8.35 | [+5.00, +11.95] | [+5.51, +11.28] | 1.059 | <0.0001 | inconclusive; repeatable change (+) |
| multi_s | 40 | 4.9083 | 4.6709 | -4.84 | [-8.40, -1.29] | [-7.75, -1.83] | 0.965 | 0.0180 | inconclusive; repeatable change (-) |
| client_wall_s | 40 | 8.5593 | 8.6262 | +0.78 | [-1.85, +3.47] | [-1.45, +3.05] | 1.004 | 0.5453 | no material change |
| client_cpu_s | 40 | 7.6558 | 7.8247 | +2.21 | [-0.26, +4.77] | [+0.15, +4.36] | 1.025 | 0.1254 | no material change |
| client_vcsw | 40 | 20694.2 | 13366.0 | -35.41 | [-43.09, -27.06] | [-41.98, -28.44] | 0.674 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3115 | 4.1940 | -2.73 | [-5.78, +0.56] | [-5.30, -0.02] | 0.954 | 0.0760 | inconclusive |
| multi_broker_cpu_s | 40 | 3.8237 | 3.5515 | -7.12 | [-11.57, -2.68] | [-10.83, -3.40] | 0.939 | 0.0093 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 3.3668 | 3.2830 | -2.49 | [-5.31, +0.48] | [-4.91, -0.02] | 0.987 | 0.1288 | no material change |
| broker_sys_s | 40 | 2.9805 | 2.7392 | -8.09 | [-12.21, -4.14] | [-11.55, -4.73] | 0.926 | 0.0006 | inconclusive; repeatable change (-) |
| broker_cpu_s | 40 | 6.3473 | 6.0222 | -5.12 | [-8.24, -2.12] | [-7.69, -2.57] | 0.956 | 0.0052 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 16810.7 | 17722.0 | +5.42 | [+1.43, +9.43] | [+2.07, +8.79] | 1.070 | 0.0059 | inconclusive; repeatable change (+) |
| broker_maxrss_kib | 40 | 7481 | 7038 | -5.91 | [-7.26, -4.56] | [-7.06, -4.77] | 0.939 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18749 | 18746 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.6478 | 3.8763 | +0.3043 | [+0.1782, +0.4304] |
| multi_s | 4.8944 | 4.6217 | -0.2375 | [-0.4217, -0.0532] |
| client_wall_s | 8.5062 | 8.6545 | +0.0668 | [-0.1713, +0.3050] |
| client_cpu_s | 7.6277 | 7.7658 | +0.1689 | [-0.0297, +0.3674] |
| client_vcsw | 20085.0 | 12306.0 | -7328.2 | [-9313.8, -5342.6] |
| multi_client_cpu_s | 4.2950 | 4.1650 | -0.1175 | [-0.2599, +0.0249] |
| multi_broker_cpu_s | 3.7500 | 3.4750 | -0.2722 | [-0.4538, -0.0907] |
| broker_user_s | 3.3250 | 3.2388 | -0.0838 | [-0.1864, +0.0188] |
| broker_sys_s | 2.9398 | 2.7052 | -0.2412 | [-0.3718, -0.1107] |
| broker_cpu_s | 6.3061 | 5.9373 | -0.3251 | [-0.5315, -0.1186] |
| broker_vcsw | 16943.5 | 17605.5 | +911.4 | [+230.6, +1592.1] |
| broker_maxrss_kib | 7448 | 7014 | -442 | [-553, -332] |
| broker_ru_maxrss_kib | 18784 | 18784 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
