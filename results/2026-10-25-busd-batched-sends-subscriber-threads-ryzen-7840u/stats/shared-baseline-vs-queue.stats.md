candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8755 | 2.0654 | +10.12 | [+8.86, +11.33] | [+9.06, +11.13] | 1.111 | <0.0001 | slower/larger |
| multi_s | 40 | 2.2216 | 2.2259 | +0.19 | [-0.82, +1.24] | [-0.66, +1.06] | 0.997 | 0.7368 | no material change |
| client_wall_s | 40 | 4.1280 | 4.3220 | +4.70 | [+3.79, +5.63] | [+3.94, +5.47] | 1.046 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 3.9879 | 4.1221 | +3.37 | [+2.64, +4.11] | [+2.76, +3.99] | 1.031 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 3216.3 | 3233.9 | +0.55 | [-13.04, +18.15] | [-11.00, +14.88] | 1.049 | 0.4046 | inconclusive |
| multi_client_cpu_s | 40 | 2.1562 | 2.1655 | +0.43 | [-0.44, +1.32] | [-0.31, +1.18] | 1.005 | 0.3835 | no material change |
| multi_broker_cpu_s | 40 | 1.9563 | 1.8725 | -4.28 | [-5.93, -2.65] | [-5.65, -2.91] | 0.962 | <0.0001 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 1.6481 | 1.6324 | -0.95 | [-2.22, +0.29] | [-2.01, +0.09] | 0.995 | 0.3332 | no material change |
| broker_sys_s | 40 | 1.7622 | 1.7880 | +1.46 | [-0.44, +3.33] | [-0.12, +3.02] | 1.024 | 0.1288 | no material change |
| broker_cpu_s | 40 | 3.4104 | 3.4205 | +0.30 | [-0.92, +1.48] | [-0.70, +1.30] | 1.010 | 0.5276 | no material change |
| broker_vcsw | 40 | 11818.0 | 14949.4 | +26.50 | [+23.03, +30.31] | [+23.59, +29.63] | 1.250 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11813 | 11452 | -3.06 | [-4.75, -1.38] | [-4.50, -1.64] | 0.966 | 0.0032 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20492 | 20495 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8956 | 2.0745 | +0.1898 | [+0.1665, +0.2131] |
| multi_s | 2.2278 | 2.2278 | +0.0042 | [-0.0192, +0.0277] |
| client_wall_s | 4.1728 | 4.3527 | +0.1940 | [+0.1556, +0.2324] |
| client_cpu_s | 4.0367 | 4.1369 | +0.1342 | [+0.1043, +0.1641] |
| client_vcsw | 3360.0 | 3189.5 | +17.6 | [-497.2, +532.4] |
| multi_client_cpu_s | 2.1600 | 2.1650 | +0.0093 | [-0.0105, +0.0290] |
| multi_broker_cpu_s | 1.9600 | 1.8800 | -0.0838 | [-0.1189, -0.0486] |
| broker_user_s | 1.6677 | 1.6394 | -0.0157 | [-0.0378, +0.0064] |
| broker_sys_s | 1.7600 | 1.7849 | +0.0258 | [-0.0083, +0.0599] |
| broker_cpu_s | 3.4416 | 3.4513 | +0.0101 | [-0.0328, +0.0530] |
| broker_vcsw | 12088.5 | 15003.5 | +3131.4 | [+2756.0, +3506.8] |
| broker_maxrss_kib | 11722 | 11520 | -361 | [-576, -146] |
| broker_ru_maxrss_kib | 20540 | 20540 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
