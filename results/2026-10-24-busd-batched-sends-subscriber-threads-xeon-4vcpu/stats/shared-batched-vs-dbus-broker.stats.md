candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.6125 | 3.3924 | -6.09 | [-7.88, -4.20] | [-7.58, -4.51] | 0.924 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 40 | 6.3354 | 3.8161 | -39.76 | [-41.23, -38.27] | [-40.99, -38.51] | 0.599 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 9.9543 | 7.2153 | -27.52 | [-28.66, -26.29] | [-28.49, -26.51] | 0.721 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 9.8355 | 6.6771 | -32.11 | [-33.01, -31.14] | [-32.87, -31.31] | 0.682 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 254.2 | 8680.6 | +3315.56 | [+2346.78, +4684.22] | [+2483.46, +4499.29] | 45.744 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 6.2700 | 3.5290 | -43.72 | [-44.90, -42.48] | [-44.71, -42.69] | 0.565 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 2.3925 | 2.8758 | +20.20 | [+16.95, +23.71] | [+17.47, +23.12] | 1.197 | <0.0001 | slower/larger |
| broker_user_s | 40 | 1.2642 | 2.6996 | +113.55 | [+108.44, +118.96] | [+109.20, +118.03] | 2.142 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 2.7138 | 2.2825 | -15.89 | [-18.56, -13.17] | [-18.15, -13.60] | 0.857 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 3.9780 | 4.9822 | +25.24 | [+22.54, +28.03] | [+22.99, +27.58] | 1.260 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 199154.4 | 18966.3 | -90.48 | [-90.65, -90.30] | [-90.62, -90.33] | 0.095 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 8651 | 7090 | -18.05 | [-19.10, -16.92] | [-18.93, -17.12] | 0.814 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18750 | 18754 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.6179 | 3.3471 | -0.2201 | [-0.2905, -0.1498] |
| multi_s | 6.3087 | 3.7686 | -2.5192 | [-2.6396, -2.3988] |
| client_wall_s | 9.9180 | 7.1474 | -2.7390 | [-2.8757, -2.6023] |
| client_cpu_s | 9.7732 | 6.6199 | -3.1585 | [-3.2750, -3.0419] |
| client_vcsw | 176.0 | 8168.0 | +8426.5 | [+7663.8, +9189.2] |
| multi_client_cpu_s | 6.2300 | 3.5000 | -2.7410 | [-2.8496, -2.6324] |
| multi_broker_cpu_s | 2.3650 | 2.8150 | +0.4832 | [+0.4037, +0.5628] |
| broker_user_s | 1.2704 | 2.6899 | +1.4355 | [+1.3881, +1.4828] |
| broker_sys_s | 2.6939 | 2.2716 | -0.4313 | [-0.5110, -0.3516] |
| broker_cpu_s | 3.9498 | 4.8978 | +1.0042 | [+0.8996, +1.1087] |
| broker_vcsw | 201200.0 | 18978.5 | -180188.1 | [-183569.5, -176806.7] |
| broker_maxrss_kib | 8658 | 7052 | -1562 | [-1664, -1459] |
| broker_ru_maxrss_kib | 18744 | 18744 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
