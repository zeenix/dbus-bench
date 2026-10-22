candidate revert against baseline baseline, from calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1638 | 0.1584 | -3.31 | [-6.83, +0.33] | [-6.26, -0.29] | 0.979 | 0.1007 | inconclusive |
| multi_s | 60 | 0.7211 | 0.7307 | +1.33 | [-2.07, +4.61] | [-1.49, +4.08] | 1.018 | 0.1976 | no material change |
| client_wall_s | 60 | 0.8907 | 0.8953 | +0.52 | [-2.40, +3.26] | [-1.89, +2.83] | 1.010 | 0.4181 | no material change |
| client_cpu_s | 60 | 0.7525 | 0.7652 | +1.69 | [-1.03, +4.54] | [-0.65, +4.05] | 1.010 | 0.3613 | no material change |
| client_vcsw | 60 | 4664.2 | 4598.3 | -1.41 | [-6.87, +4.25] | [-6.03, +3.39] | 0.975 | 0.3870 | inconclusive |
| multi_client_cpu_s | 60 | 0.6673 | 0.6790 | +1.75 | [-1.33, +4.92] | [-0.89, +4.42] | 1.007 | 0.3654 | no material change |
| multi_broker_cpu_s | 60 | 0.5130 | 0.4977 | -2.99 | [-6.81, +0.86] | [-6.20, +0.26] | 0.959 | 0.0900 | inconclusive |
| broker_user_s | 60 | 0.3220 | 0.3075 | -4.51 | [-7.74, -1.07] | [-7.23, -1.67] | 0.936 | 0.0043 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.2772 | 0.2729 | -1.53 | [-6.74, +3.93] | [-5.93, +2.95] | 1.029 | 0.8829 | inconclusive |
| broker_cpu_s | 60 | 0.5992 | 0.5804 | -3.13 | [-6.51, +0.28] | [-5.93, -0.28] | 0.973 | 0.0372 | inconclusive |
| broker_vcsw | 60 | 5159.1 | 5385.1 | +4.38 | [+0.90, +8.18] | [+1.40, +7.50] | 1.051 | 0.0234 | inconclusive; repeatable change (+) |
| broker_maxrss_kib | 60 | 4904 | 4836 | -1.40 | [-2.02, -0.75] | [-1.92, -0.86] | 0.985 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18715 | 18713 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1564 | 0.1540 | -0.0054 | [-0.0116, +0.0008] |
| multi_s | 0.7043 | 0.7068 | +0.0096 | [-0.0152, +0.0344] |
| client_wall_s | 0.8711 | 0.8711 | +0.0046 | [-0.0214, +0.0307] |
| client_cpu_s | 0.7470 | 0.7447 | +0.0127 | [-0.0091, +0.0344] |
| client_vcsw | 4515.0 | 4301.5 | -65.9 | [-337.9, +206.1] |
| multi_client_cpu_s | 0.6600 | 0.6600 | +0.0117 | [-0.0101, +0.0334] |
| multi_broker_cpu_s | 0.4900 | 0.4900 | -0.0153 | [-0.0360, +0.0053] |
| broker_user_s | 0.3179 | 0.3049 | -0.0145 | [-0.0258, -0.0032] |
| broker_sys_s | 0.2653 | 0.2724 | -0.0042 | [-0.0197, +0.0112] |
| broker_cpu_s | 0.5761 | 0.5693 | -0.0188 | [-0.0402, +0.0026] |
| broker_vcsw | 5264.0 | 5386.0 | +226.1 | [+37.7, +414.5] |
| broker_maxrss_kib | 4904 | 4836 | -68 | [-100, -37] |
| broker_ru_maxrss_kib | 18668 | 18668 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
