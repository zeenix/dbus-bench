candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2635 | 0.3795 | +44.02 | [+38.36, +49.79] | [+39.29, +48.82] | 1.459 | <0.0001 | slower/larger |
| multi_s | 60 | 0.3202 | 0.9592 | +199.56 | [+183.12, +216.60] | [+185.79, +213.86] | 2.965 | <0.0001 | slower/larger |
| client_wall_s | 60 | 0.6148 | 1.3698 | +122.79 | [+113.48, +132.22] | [+114.98, +130.74] | 2.267 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 1.3631 | 2.3845 | +74.93 | [+68.95, +80.94] | [+69.93, +79.95] | 1.732 | <0.0001 | slower/larger |
| client_vcsw | 60 | 4718.3 | 79625.1 | +1587.59 | [+1316.34, +1934.03] | [+1352.66, +1878.93] | 22.694 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.9118 | 1.9102 | +109.49 | [+100.93, +118.26] | [+102.38, +116.84] | 2.061 | <0.0001 | slower/larger |
| multi_broker_cpu_s | 60 | 0.2643 | 0.9175 | +247.10 | [+225.55, +269.56] | [+229.36, +266.16] | 3.442 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1517 | 0.4436 | +192.42 | [+181.48, +204.03] | [+183.31, +202.29] | 2.915 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3600 | 0.8560 | +137.75 | [+124.13, +152.09] | [+126.47, +149.73] | 2.383 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.5118 | 1.2996 | +153.95 | [+143.16, +165.09] | [+144.96, +163.29] | 2.591 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 2194.9 | 112.5 | -94.88 | [-95.66, -93.94] | [-95.55, -94.10] | 0.048 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 21250 | 4734 | -77.72 | [-79.48, -75.85] | [-79.19, -76.13] | 0.239 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20766 | 18836 | -9.29 | [-14.26, -4.73] | [-13.37, -5.44] | 1.000 | <0.0001 | inconclusive; repeatable change (-) |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2548 | 0.3704 | +0.1160 | [+0.1033, +0.1287] |
| multi_s | 0.3178 | 0.9671 | +0.6390 | [+0.5903, +0.6878] |
| client_wall_s | 0.6113 | 1.3721 | +0.7549 | [+0.7037, +0.8062] |
| client_cpu_s | 1.3487 | 2.4021 | +1.0213 | [+0.9505, +1.0922] |
| client_vcsw | 3502.5 | 81379.5 | +74906.9 | [+70453.5, +79360.2] |
| multi_client_cpu_s | 0.9000 | 1.9050 | +0.9983 | [+0.9300, +1.0667] |
| multi_broker_cpu_s | 0.2600 | 0.9250 | +0.6532 | [+0.6021, +0.7042] |
| broker_user_s | 0.1524 | 0.4415 | +0.2919 | [+0.2810, +0.3029] |
| broker_sys_s | 0.3590 | 0.8542 | +0.4959 | [+0.4490, +0.5429] |
| broker_cpu_s | 0.5054 | 1.3092 | +0.7879 | [+0.7367, +0.8390] |
| broker_vcsw | 2070.0 | 96.0 | -2082.4 | [-2312.1, -1852.7] |
| broker_maxrss_kib | 19696 | 4732 | -16516 | [-18288, -14744] |
| broker_ru_maxrss_kib | 18910 | 18840 | -1930 | [-3047, -813] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
