candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.2320 | 3.4153 | +5.67 | [+2.39, +9.05] | [+2.94, +8.47] | 1.080 | 0.0022 | inconclusive; repeatable change (+) |
| multi_s | 40 | 3.9286 | 3.8547 | -1.88 | [-5.33, +1.74] | [-4.76, +1.16] | 0.983 | 0.2704 | no material change |
| client_wall_s | 40 | 7.1675 | 7.2765 | +1.52 | [-1.12, +4.19] | [-0.68, +3.74] | 1.022 | 0.2064 | no material change |
| client_cpu_s | 40 | 6.5765 | 6.7359 | +2.42 | [+0.02, +4.76] | [+0.42, +4.39] | 1.031 | 0.0257 | no material change; repeatable change (+) |
| client_vcsw | 40 | 13968.7 | 9338.4 | -33.15 | [-40.59, -24.14] | [-39.53, -25.83] | 0.657 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.5688 | 3.5410 | -0.78 | [-3.73, +2.21] | [-3.28, +1.76] | 1.003 | 0.7497 | no material change |
| multi_broker_cpu_s | 40 | 3.0255 | 2.8725 | -5.06 | [-8.62, -1.07] | [-8.13, -1.76] | 0.960 | 0.0065 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 2.7534 | 2.6937 | -2.17 | [-4.36, +0.14] | [-4.02, -0.26] | 0.976 | 0.0563 | no material change |
| broker_sys_s | 40 | 2.5354 | 2.3127 | -8.78 | [-12.36, -5.02] | [-11.80, -5.66] | 0.912 | 0.0002 | faster/smaller |
| broker_cpu_s | 40 | 5.2888 | 5.0063 | -5.34 | [-7.71, -2.82] | [-7.34, -3.23] | 0.942 | 0.0003 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 16508.1 | 19247.6 | +16.59 | [+11.80, +21.10] | [+12.60, +20.50] | 1.187 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7558 | 7086 | -6.24 | [-7.57, -4.93] | [-7.37, -5.14] | 0.945 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18754 | 18754 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.1972 | 3.4187 | +0.1833 | [+0.0760, +0.2906] |
| multi_s | 3.9432 | 3.8322 | -0.0739 | [-0.2200, +0.0722] |
| client_wall_s | 7.0740 | 7.2479 | +0.1090 | [-0.0842, +0.3021] |
| client_cpu_s | 6.5257 | 6.7028 | +0.1594 | [+0.0012, +0.3176] |
| client_vcsw | 13301.0 | 9331.0 | -4630.3 | [-6072.8, -3187.8] |
| multi_client_cpu_s | 3.5450 | 3.5050 | -0.0278 | [-0.1385, +0.0830] |
| multi_broker_cpu_s | 3.0500 | 2.8600 | -0.1530 | [-0.2769, -0.0291] |
| broker_user_s | 2.7364 | 2.6713 | -0.0598 | [-0.1250, +0.0054] |
| broker_sys_s | 2.5540 | 2.3395 | -0.2227 | [-0.3237, -0.1218] |
| broker_cpu_s | 5.2764 | 5.0193 | -0.2825 | [-0.4215, -0.1435] |
| broker_vcsw | 16331.0 | 19455.5 | +2739.5 | [+2014.7, +3464.3] |
| broker_maxrss_kib | 7528 | 7112 | -472 | [-580, -364] |
| broker_ru_maxrss_kib | 18744 | 18744 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
