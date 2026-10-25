candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.2320 | 3.3924 | +4.96 | [+1.78, +8.42] | [+2.25, +7.89] | 1.042 | 0.0052 | inconclusive; repeatable change (+) |
| multi_s | 40 | 3.9286 | 3.8161 | -2.86 | [-5.82, +0.23] | [-5.34, -0.25] | 0.954 | 0.0829 | inconclusive |
| client_wall_s | 40 | 7.1675 | 7.2153 | +0.67 | [-1.83, +3.22] | [-1.40, +2.81] | 1.025 | 0.4123 | no material change |
| client_cpu_s | 40 | 6.5765 | 6.6771 | +1.53 | [-0.63, +3.70] | [-0.29, +3.34] | 1.028 | 0.1222 | no material change |
| client_vcsw | 40 | 13968.7 | 8680.6 | -37.86 | [-44.74, -30.04] | [-43.72, -31.37] | 0.561 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.5688 | 3.5290 | -1.11 | [-3.75, +1.49] | [-3.33, +1.14] | 0.984 | 0.4940 | no material change |
| multi_broker_cpu_s | 40 | 3.0255 | 2.8758 | -4.95 | [-8.11, -1.50] | [-7.66, -2.04] | 0.936 | 0.0102 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 2.7534 | 2.6996 | -1.95 | [-3.94, -0.01] | [-3.58, -0.29] | 0.995 | 0.0983 | no material change; repeatable change (-) |
| broker_sys_s | 40 | 2.5354 | 2.2825 | -9.97 | [-14.17, -5.37] | [-13.54, -6.09] | 0.879 | 0.0004 | faster/smaller |
| broker_cpu_s | 40 | 5.2888 | 4.9822 | -5.80 | [-8.46, -2.94] | [-8.02, -3.40] | 0.933 | 0.0005 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 16508.1 | 18966.3 | +14.89 | [+10.18, +19.23] | [+11.00, +18.64] | 1.164 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7558 | 7090 | -6.19 | [-7.69, -4.62] | [-7.47, -4.86] | 0.944 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18754 | 18754 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.1972 | 3.3471 | +0.1604 | [+0.0528, +0.2680] |
| multi_s | 3.9432 | 3.7686 | -0.1125 | [-0.2379, +0.0129] |
| client_wall_s | 7.0740 | 7.1474 | +0.0477 | [-0.1375, +0.2330] |
| client_cpu_s | 6.5257 | 6.6199 | +0.1006 | [-0.0462, +0.2473] |
| client_vcsw | 13301.0 | 8168.0 | -5288.1 | [-6699.3, -3876.8] |
| multi_client_cpu_s | 3.5450 | 3.5000 | -0.0398 | [-0.1379, +0.0584] |
| multi_broker_cpu_s | 3.0500 | 2.8150 | -0.1497 | [-0.2578, -0.0417] |
| broker_user_s | 2.7364 | 2.6899 | -0.0538 | [-0.1109, +0.0033] |
| broker_sys_s | 2.5540 | 2.2716 | -0.2529 | [-0.3747, -0.1310] |
| broker_cpu_s | 5.2764 | 4.8978 | -0.3067 | [-0.4619, -0.1514] |
| broker_vcsw | 16331.0 | 18978.5 | +2458.2 | [+1755.9, +3160.6] |
| broker_maxrss_kib | 7528 | 7052 | -468 | [-592, -343] |
| broker_ru_maxrss_kib | 18744 | 18744 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
