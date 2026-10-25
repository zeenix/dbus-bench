candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3030 | 0.2985 | -1.47 | [-1.99, -0.93] | [-1.91, -1.02] | 0.982 | <0.0001 | no material change; repeatable change (-) |
| multi_s | 60 | 0.3750 | 0.3581 | -4.51 | [-5.23, -3.78] | [-5.13, -3.90] | 0.960 | <0.0001 | inconclusive; repeatable change (-) |
| client_wall_s | 60 | 0.7111 | 0.7164 | +0.75 | [+0.10, +1.38] | [+0.20, +1.28] | 1.008 | 0.0208 | no material change; repeatable change (+) |
| client_cpu_s | 60 | 0.6815 | 0.6608 | -3.04 | [-3.56, -2.53] | [-3.48, -2.61] | 0.972 | <0.0001 | no material change; repeatable change (-) |
| client_vcsw | 60 | 11.517 | 41.300 | +258.61 | [+220.32, +300.50] | [+226.29, +293.55] | 4.118 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.3598 | 0.3430 | -4.68 | [-5.53, -3.81] | [-5.39, -3.96] | 0.946 | <0.0001 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.1198 | 0.1042 | -13.07 | [-15.01, -10.92] | [-14.73, -11.32] | 0.873 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.1214 | 0.2287 | +88.31 | [+83.07, +93.68] | [+83.93, +92.81] | 1.874 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2446 | 0.1430 | -41.54 | [-42.74, -40.24] | [-42.56, -40.44] | 0.577 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.3661 | 0.3717 | +1.54 | [+0.48, +2.62] | [+0.66, +2.44] | 1.021 | 0.0060 | no material change; repeatable change (+) |
| broker_vcsw | 60 | 7258.6 | 628.1 | -91.35 | [-91.50, -91.19] | [-91.48, -91.22] | 0.087 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41014 | 6623 | -83.85 | [-84.00, -83.70] | [-83.97, -83.72] | 0.161 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 36428 | 20472 | -43.80 | [-44.35, -43.20] | [-44.27, -43.30] | 0.557 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3026 | 0.2973 | -0.0044 | [-0.0061, -0.0028] |
| multi_s | 0.3715 | 0.3560 | -0.0169 | [-0.0199, -0.0140] |
| client_wall_s | 0.7063 | 0.7159 | +0.0053 | [+0.0005, +0.0101] |
| client_cpu_s | 0.6772 | 0.6587 | -0.0207 | [-0.0245, -0.0170] |
| client_vcsw | 10.000 | 41.000 | +29.783 | [+27.296, +32.270] |
| multi_client_cpu_s | 0.3600 | 0.3400 | -0.0168 | [-0.0201, -0.0136] |
| multi_broker_cpu_s | 0.1200 | 0.1000 | -0.0157 | [-0.0185, -0.0128] |
| broker_user_s | 0.1212 | 0.2288 | +0.1073 | [+0.1030, +0.1115] |
| broker_sys_s | 0.2426 | 0.1416 | -0.1016 | [-0.1058, -0.0974] |
| broker_cpu_s | 0.3618 | 0.3706 | +0.0056 | [+0.0017, +0.0096] |
| broker_vcsw | 7296.5 | 622.5 | -6630.5 | [-6672.2, -6588.8] |
| broker_maxrss_kib | 41420 | 6628 | -34390 | [-34767, -34014] |
| broker_ru_maxrss_kib | 36756 | 20500 | -15956 | [-16339, -15573] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
