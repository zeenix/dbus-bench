candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2635 | 0.3278 | +24.40 | [+19.99, +29.33] | [+20.66, +28.45] | 1.241 | <0.0001 | slower/larger |
| multi_s | 60 | 0.3202 | 0.2830 | -11.63 | [-15.41, -7.74] | [-14.83, -8.33] | 0.881 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.6148 | 0.6430 | +4.59 | [+1.40, +7.89] | [+1.92, +7.35] | 1.043 | 0.0074 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 1.3631 | 1.2327 | -9.57 | [-12.04, -7.07] | [-11.62, -7.46] | 0.898 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 4718.3 | 5040.4 | +6.83 | [-10.92, +29.02] | [-8.21, +25.37] | 1.432 | 0.1294 | inconclusive |
| multi_client_cpu_s | 60 | 0.9118 | 0.7828 | -14.15 | [-17.02, -11.10] | [-16.55, -11.62] | 0.863 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2643 | 0.1910 | -27.74 | [-31.96, -23.51] | [-31.28, -24.18] | 0.727 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.1517 | 0.3462 | +128.21 | [+119.31, +137.54] | [+120.80, +135.95] | 2.299 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3600 | 0.1757 | -51.21 | [-53.56, -48.79] | [-53.21, -49.19] | 0.484 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5118 | 0.5219 | +1.98 | [-1.31, +5.27] | [-0.76, +4.74] | 1.025 | 0.1221 | no material change |
| broker_vcsw | 60 | 2194.9 | 579.6 | -73.59 | [-77.78, -69.04] | [-77.14, -69.87] | 0.230 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 21250 | 4787 | -77.47 | [-79.24, -75.58] | [-78.96, -75.88] | 0.245 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20766 | 18836 | -9.29 | [-14.26, -4.73] | [-13.37, -5.44] | 1.000 | <0.0001 | inconclusive; repeatable change (-) |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2548 | 0.3187 | +0.0643 | [+0.0528, +0.0758] |
| multi_s | 0.3178 | 0.2807 | -0.0372 | [-0.0510, -0.0235] |
| client_wall_s | 0.6113 | 0.6342 | +0.0282 | [+0.0082, +0.0482] |
| client_cpu_s | 1.3487 | 1.2223 | -0.1304 | [-0.1675, -0.0934] |
| client_vcsw | 3502.5 | 4831.5 | +322.1 | [-581.1, +1225.3] |
| multi_client_cpu_s | 0.9000 | 0.7700 | -0.1290 | [-0.1593, -0.0987] |
| multi_broker_cpu_s | 0.2600 | 0.1800 | -0.0733 | [-0.0872, -0.0595] |
| broker_user_s | 0.1524 | 0.3436 | +0.1945 | [+0.1843, +0.2047] |
| broker_sys_s | 0.3590 | 0.1739 | -0.1844 | [-0.1976, -0.1712] |
| broker_cpu_s | 0.5054 | 0.5152 | +0.0101 | [-0.0070, +0.0273] |
| broker_vcsw | 2070.0 | 498.5 | -1615.3 | [-1837.1, -1393.5] |
| broker_maxrss_kib | 19696 | 4786 | -16463 | [-18233, -14693] |
| broker_ru_maxrss_kib | 18910 | 18840 | -1930 | [-3047, -813] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
