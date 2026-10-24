candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 4.4977 | 3.9477 | -12.23 | [-14.44, -9.98] | [-14.12, -10.34] | 0.880 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7821 | 4.6709 | -19.22 | [-21.83, -16.48] | [-21.45, -16.91] | 0.816 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 10.2871 | 8.6262 | -16.15 | [-18.16, -14.00] | [-17.88, -14.32] | 0.828 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.3415 | 7.8247 | -6.20 | [-8.24, -4.08] | [-7.93, -4.41] | 0.931 | <0.0001 | inconclusive; repeatable change (-) |
| client_vcsw | 40 | 55872.3 | 13366.0 | -76.08 | [-78.82, -72.92] | [-78.41, -73.49] | 0.220 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.4473 | 4.1940 | -5.69 | [-8.29, -2.96] | [-7.86, -3.39] | 0.940 | 0.0004 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 40 | 5.4778 | 3.5515 | -35.16 | [-37.56, -32.78] | [-37.17, -33.15] | 0.649 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 5.8512 | 3.2830 | -43.89 | [-45.32, -42.43] | [-45.10, -42.66] | 0.558 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 3.7520 | 2.7392 | -26.99 | [-29.84, -24.09] | [-29.38, -24.54] | 0.737 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 9.6032 | 6.0222 | -37.29 | [-38.96, -35.54] | [-38.71, -35.81] | 0.622 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 4799.3 | 17722.0 | +269.26 | [+246.02, +294.60] | [+249.66, +290.51] | 3.729 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7249 | 7038 | -2.91 | [-4.07, -1.72] | [-3.88, -1.90] | 0.974 | 0.0002 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18746 | 18746 | +0.00 | [-0.05, +0.05] | [-0.03, +0.03] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 4.4467 | 3.8763 | -0.5500 | [-0.6637, -0.4363] |
| multi_s | 5.7551 | 4.6217 | -1.1112 | [-1.2886, -0.9339] |
| client_wall_s | 10.2649 | 8.6545 | -1.6610 | [-1.9037, -1.4183] |
| client_cpu_s | 8.2712 | 7.7658 | -0.5169 | [-0.7033, -0.3304] |
| client_vcsw | 55100.5 | 12306.0 | -42506.3 | [-45028.5, -39984.1] |
| multi_client_cpu_s | 4.3950 | 4.1650 | -0.2533 | [-0.3797, -0.1268] |
| multi_broker_cpu_s | 5.4800 | 3.4750 | -1.9263 | [-2.0831, -1.7694] |
| broker_user_s | 5.8184 | 3.2388 | -2.5683 | [-2.6876, -2.4490] |
| broker_sys_s | 3.7481 | 2.7052 | -1.0127 | [-1.1383, -0.8872] |
| broker_cpu_s | 9.6182 | 5.9373 | -3.5810 | [-3.7879, -3.3741] |
| broker_vcsw | 4805.5 | 17605.5 | +12922.7 | [+12407.1, +13438.3] |
| broker_maxrss_kib | 7236 | 7014 | -211 | [-303, -119] |
| broker_ru_maxrss_kib | 18784 | 18784 | +0 | [-9, +9] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
