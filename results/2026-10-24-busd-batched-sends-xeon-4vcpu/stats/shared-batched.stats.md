candidate batched against baseline baseline, from $WORK/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.8893 | 3.9477 | +1.50 | [-1.39, +4.58] | [-0.93, +4.08] | 0.998 | 0.6477 | no material change |
| multi_s | 40 | 4.7799 | 4.6709 | -2.28 | [-5.79, +1.06] | [-5.15, +0.50] | 0.972 | 0.2532 | inconclusive |
| client_wall_s | 40 | 8.6766 | 8.6262 | -0.58 | [-3.29, +2.11] | [-2.85, +1.68] | 1.004 | 0.6001 | no material change |
| client_cpu_s | 40 | 7.9002 | 7.8247 | -0.96 | [-3.48, +1.67] | [-3.09, +1.26] | 0.990 | 0.3537 | no material change |
| client_vcsw | 40 | 13245.7 | 13366.0 | +0.91 | [-13.78, +18.29] | [-11.48, +15.04] | 1.040 | 0.9464 | inconclusive |
| multi_client_cpu_s | 40 | 4.2910 | 4.1940 | -2.26 | [-5.27, +0.77] | [-4.77, +0.24] | 0.993 | 0.2064 | no material change |
| multi_broker_cpu_s | 40 | 3.6010 | 3.5515 | -1.37 | [-5.93, +3.01] | [-5.14, +2.32] | 0.991 | 0.5723 | inconclusive |
| broker_user_s | 40 | 3.2945 | 3.2830 | -0.35 | [-3.05, +2.32] | [-2.57, +1.88] | 1.007 | 0.7267 | no material change |
| broker_sys_s | 40 | 2.7198 | 2.7392 | +0.71 | [-4.15, +5.65] | [-3.37, +4.82] | 1.010 | 0.7368 | no material change |
| broker_cpu_s | 40 | 6.0143 | 6.0222 | +0.13 | [-3.01, +3.16] | [-2.50, +2.64] | 0.998 | 0.9037 | no material change |
| broker_vcsw | 40 | 18122.1 | 17722.0 | -2.21 | [-5.12, +0.67] | [-4.62, +0.24] | 0.976 | 0.1662 | no material change |
| broker_maxrss_kib | 40 | 7089 | 7038 | -0.71 | [-2.15, +0.70] | [-1.93, +0.47] | 0.992 | 0.4316 | no material change |
| broker_ru_maxrss_kib | 40 | 18746 | 18746 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.8441 | 3.8763 | +0.0584 | [-0.0631, +0.1800] |
| multi_s | 4.7416 | 4.6217 | -0.1090 | [-0.2811, +0.0631] |
| client_wall_s | 8.5486 | 8.6545 | -0.0504 | [-0.2972, +0.1963] |
| client_cpu_s | 7.7152 | 7.7658 | -0.0755 | [-0.2923, +0.1414] |
| client_vcsw | 13249.0 | 12306.0 | +120.3 | [-2072.8, +2313.5] |
| multi_client_cpu_s | 4.2150 | 4.1650 | -0.0970 | [-0.2339, +0.0399] |
| multi_broker_cpu_s | 3.6100 | 3.4750 | -0.0495 | [-0.2181, +0.1191] |
| broker_user_s | 3.2543 | 3.2388 | -0.0115 | [-0.1032, +0.0802] |
| broker_sys_s | 2.6961 | 2.7052 | +0.0194 | [-0.1184, +0.1572] |
| broker_cpu_s | 5.9590 | 5.9373 | +0.0079 | [-0.1838, +0.1996] |
| broker_vcsw | 18168.0 | 17605.5 | -400.1 | [-952.1, +151.9] |
| broker_maxrss_kib | 7032 | 7014 | -50 | [-158, +57] |
| broker_ru_maxrss_kib | 18784 | 18784 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
