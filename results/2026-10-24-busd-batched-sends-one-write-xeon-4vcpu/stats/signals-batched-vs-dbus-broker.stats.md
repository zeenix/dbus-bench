candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4871 | 0.4382 | -10.04 | [-13.29, -6.62] | [-12.77, -7.14] | 0.897 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.6670 | 0.5040 | -24.43 | [-26.88, -21.83] | [-26.50, -22.23] | 0.743 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1648 | 0.9557 | -17.95 | [-20.02, -15.61] | [-19.73, -16.01] | 0.809 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.1449 | 0.9187 | -19.76 | [-21.81, -17.39] | [-21.50, -17.83] | 0.792 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 13.983 | 112.917 | +707.51 | [+524.94, +943.37] | [+547.94, +901.29] | 6.477 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.6607 | 0.4953 | -25.03 | [-27.40, -22.43] | [-27.03, -22.89] | 0.740 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2063 | 0.1403 | -31.99 | [-36.67, -26.02] | [-36.04, -27.15] | 0.650 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.1753 | 0.3520 | +100.77 | [+92.35, +109.58] | [+93.72, +108.12] | 2.009 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3488 | 0.1474 | -57.74 | [-60.71, -53.88] | [-60.32, -54.57] | 0.404 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5242 | 0.4994 | -4.72 | [-7.69, -1.64] | [-7.18, -2.15] | 0.950 | 0.0009 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 8353.1 | 352.4 | -95.78 | [-96.09, -95.44] | [-96.04, -95.50] | 0.042 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41750 | 4910 | -88.24 | [-88.31, -88.16] | [-88.30, -88.18] | 0.117 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 37624 | 18946 | -49.64 | [-49.87, -49.39] | [-49.84, -49.44] | 0.503 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4872 | 0.4342 | -0.0489 | [-0.0663, -0.0314] |
| multi_s | 0.6613 | 0.4878 | -0.1630 | [-0.1827, -0.1432] |
| client_wall_s | 1.1547 | 0.9364 | -0.2091 | [-0.2374, -0.1808] |
| client_cpu_s | 1.1344 | 0.8978 | -0.2262 | [-0.2539, -0.1984] |
| client_vcsw | 14.000 | 92.500 | +98.933 | [+68.921, +128.946] |
| multi_client_cpu_s | 0.6550 | 0.4800 | -0.1653 | [-0.1847, -0.1460] |
| multi_broker_cpu_s | 0.2000 | 0.1300 | -0.0660 | [-0.0785, -0.0535] |
| broker_user_s | 0.1701 | 0.3501 | +0.1767 | [+0.1649, +0.1885] |
| broker_sys_s | 0.3532 | 0.1385 | -0.2014 | [-0.2170, -0.1858] |
| broker_cpu_s | 0.5236 | 0.4865 | -0.0247 | [-0.0412, -0.0083] |
| broker_vcsw | 8039.0 | 338.0 | -8000.7 | [-8309.3, -7692.1] |
| broker_maxrss_kib | 41774 | 4908 | -36840 | [-37011, -36669] |
| broker_ru_maxrss_kib | 37662 | 19040 | -18678 | [-18853, -18502] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
