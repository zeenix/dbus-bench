candidate timeout against baseline baseline, from shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.1583 | 3.5614 | +12.77 | [+9.13, +16.57] | [+9.75, +15.94] | 1.117 | <0.0001 | slower/larger |
| multi_s | 40 | 4.3565 | 4.2156 | -3.23 | [-6.57, +0.10] | [-5.99, -0.42] | 0.975 | 0.1158 | inconclusive |
| client_wall_s | 40 | 7.5214 | 7.7835 | +3.49 | [+1.18, +5.93] | [+1.54, +5.53] | 1.024 | 0.0099 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 6.5868 | 6.9515 | +5.54 | [+3.70, +7.47] | [+3.99, +7.14] | 1.061 | <0.0001 | inconclusive; repeatable change (+) |
| client_vcsw | 40 | 25082.6 | 15365.0 | -38.74 | [-45.35, -31.65] | [-44.36, -32.90] | 0.619 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.7230 | 3.6950 | -0.75 | [-3.10, +1.72] | [-2.72, +1.35] | 0.988 | 0.4516 | no material change |
| multi_broker_cpu_s | 40 | 3.5767 | 3.3535 | -6.24 | [-9.94, -2.45] | [-9.35, -3.13] | 0.947 | 0.0029 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 2.9613 | 2.8364 | -4.22 | [-6.66, -1.68] | [-6.29, -2.11] | 0.954 | 0.0034 | inconclusive; repeatable change (-) |
| broker_sys_s | 40 | 2.7973 | 2.6448 | -5.45 | [-8.33, -2.40] | [-7.92, -2.92] | 0.934 | 0.0020 | inconclusive; repeatable change (-) |
| broker_cpu_s | 40 | 5.7586 | 5.4812 | -4.82 | [-7.31, -2.30] | [-6.93, -2.67] | 0.952 | 0.0013 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 14301.0 | 17758.6 | +24.18 | [+19.71, +28.88] | [+20.47, +28.08] | 1.246 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7520 | 7054 | -6.20 | [-7.36, -5.07] | [-7.17, -5.24] | 0.938 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18722 | 18722 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.1297 | 3.5321 | +0.4032 | [+0.2891, +0.5172] |
| multi_s | 4.3602 | 4.2020 | -0.1409 | [-0.2955, +0.0137] |
| client_wall_s | 7.5399 | 7.6928 | +0.2622 | [+0.0770, +0.4474] |
| client_cpu_s | 6.5395 | 6.9318 | +0.3647 | [+0.2366, +0.4928] |
| client_vcsw | 24642.0 | 14266.0 | -9717.5 | [-11855.0, -7580.1] |
| multi_client_cpu_s | 3.6950 | 3.6650 | -0.0280 | [-0.1223, +0.0663] |
| multi_broker_cpu_s | 3.6600 | 3.3300 | -0.2233 | [-0.3661, -0.0804] |
| broker_user_s | 2.9722 | 2.8089 | -0.1249 | [-0.2037, -0.0462] |
| broker_sys_s | 2.8021 | 2.6062 | -0.1525 | [-0.2413, -0.0637] |
| broker_cpu_s | 5.8224 | 5.4894 | -0.2774 | [-0.4328, -0.1220] |
| broker_vcsw | 14013.5 | 17634.0 | +3457.6 | [+2869.9, +4045.3] |
| broker_maxrss_kib | 7542 | 7008 | -466 | [-559, -374] |
| broker_ru_maxrss_kib | 18712 | 18712 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
