candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.8667 | 3.3924 | -12.27 | [-14.28, -10.14] | [-13.96, -10.47] | 0.874 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.1988 | 3.8161 | -26.60 | [-28.64, -24.36] | [-28.35, -24.71] | 0.723 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 9.0720 | 7.2153 | -20.47 | [-22.11, -18.68] | [-21.87, -18.98] | 0.779 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 7.2476 | 6.6771 | -7.87 | [-9.54, -6.07] | [-9.26, -6.39] | 0.908 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 59181.4 | 8680.6 | -85.33 | [-86.66, -83.92] | [-86.45, -84.14] | 0.141 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.8498 | 3.5290 | -8.33 | [-10.65, -5.83] | [-10.24, -6.25] | 0.896 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 4.9820 | 2.8758 | -42.28 | [-43.96, -40.48] | [-43.68, -40.79] | 0.558 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 5.1778 | 2.6996 | -47.86 | [-48.85, -46.85] | [-48.70, -47.01] | 0.520 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 3.4369 | 2.2825 | -33.59 | [-36.03, -30.93] | [-35.67, -31.36] | 0.639 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 8.6146 | 4.9822 | -42.17 | [-43.42, -40.80] | [-43.23, -41.03] | 0.566 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 3209.3 | 18966.3 | +490.97 | [+445.12, +546.89] | [+452.00, +536.30] | 6.040 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7283 | 7090 | -2.66 | [-3.79, -1.47] | [-3.63, -1.64] | 0.978 | 0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18750 | 18754 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.8390 | 3.3471 | -0.4743 | [-0.5646, -0.3840] |
| multi_s | 5.1624 | 3.7686 | -1.3827 | [-1.5083, -1.2571] |
| client_wall_s | 9.0027 | 7.1474 | -1.8567 | [-2.0362, -1.6772] |
| client_cpu_s | 7.1882 | 6.6199 | -0.5705 | [-0.7056, -0.4355] |
| client_vcsw | 59638.0 | 8168.0 | -50500.8 | [-52808.8, -48192.8] |
| multi_client_cpu_s | 3.8100 | 3.5000 | -0.3207 | [-0.4201, -0.2214] |
| multi_broker_cpu_s | 4.9550 | 2.8150 | -2.1063 | [-2.2102, -2.0023] |
| broker_user_s | 5.1349 | 2.6899 | -2.4781 | [-2.5590, -2.3972] |
| broker_sys_s | 3.4381 | 2.2716 | -1.1543 | [-1.2579, -1.0508] |
| broker_cpu_s | 8.5537 | 4.8978 | -3.6325 | [-3.7784, -3.4865] |
| broker_vcsw | 3073.0 | 18978.5 | +15757.0 | [+15383.1, +16130.8] |
| broker_maxrss_kib | 7240 | 7052 | -194 | [-284, -103] |
| broker_ru_maxrss_kib | 18744 | 18744 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
