candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.6125 | 3.4153 | -5.46 | [-7.55, -3.29] | [-7.24, -3.66] | 0.948 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 40 | 6.3354 | 3.8547 | -39.16 | [-40.64, -37.62] | [-40.42, -37.88] | 0.600 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 9.9543 | 7.2765 | -26.90 | [-28.05, -25.70] | [-27.89, -25.89] | 0.734 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 9.8355 | 6.7359 | -31.52 | [-32.50, -30.51] | [-32.35, -30.67] | 0.691 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 254.2 | 9338.4 | +3574.36 | [+2520.18, +5007.86] | [+2665.11, +4814.33] | 48.560 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 6.2700 | 3.5410 | -43.52 | [-44.71, -42.33] | [-44.51, -42.52] | 0.554 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 2.3925 | 2.8725 | +20.06 | [+16.37, +23.91] | [+16.91, +23.26] | 1.203 | <0.0001 | slower/larger |
| broker_user_s | 40 | 1.2642 | 2.6937 | +113.08 | [+107.19, +119.25] | [+108.17, +118.16] | 2.123 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 2.7138 | 2.3127 | -14.78 | [-17.54, -12.07] | [-17.10, -12.52] | 0.848 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 3.9780 | 5.0063 | +25.85 | [+23.21, +28.55] | [+23.61, +28.11] | 1.242 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 199154.4 | 19247.6 | -90.34 | [-90.53, -90.13] | [-90.50, -90.17] | 0.097 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 8651 | 7086 | -18.10 | [-18.97, -17.22] | [-18.83, -17.35] | 0.821 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18750 | 18754 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.6179 | 3.4187 | -0.1972 | [-0.2790, -0.1154] |
| multi_s | 6.3087 | 3.8322 | -2.4806 | [-2.5959, -2.3654] |
| client_wall_s | 9.9180 | 7.2479 | -2.6778 | [-2.8148, -2.5408] |
| client_cpu_s | 9.7732 | 6.7028 | -3.0997 | [-3.2252, -2.9742] |
| client_vcsw | 176.0 | 9331.0 | +9084.2 | [+8157.8, +10010.7] |
| multi_client_cpu_s | 6.2300 | 3.5050 | -2.7290 | [-2.8347, -2.6233] |
| multi_broker_cpu_s | 2.3650 | 2.8600 | +0.4800 | [+0.3890, +0.5710] |
| broker_user_s | 1.2704 | 2.6713 | +1.4295 | [+1.3707, +1.4882] |
| broker_sys_s | 2.6939 | 2.3395 | -0.4012 | [-0.4822, -0.3201] |
| broker_cpu_s | 3.9498 | 5.0193 | +1.0283 | [+0.9263, +1.1303] |
| broker_vcsw | 201200.0 | 19455.5 | -179906.8 | [-183304.3, -176509.3] |
| broker_maxrss_kib | 8658 | 7112 | -1566 | [-1649, -1482] |
| broker_ru_maxrss_kib | 18744 | 18744 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
