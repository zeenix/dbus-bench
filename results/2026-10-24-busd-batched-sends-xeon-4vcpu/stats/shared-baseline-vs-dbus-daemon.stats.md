candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 4.4977 | 3.8893 | -13.53 | [-16.01, -11.17] | [-15.61, -11.51] | 0.873 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7821 | 4.7799 | -17.33 | [-19.86, -14.72] | [-19.45, -15.13] | 0.825 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 10.2871 | 8.6766 | -15.66 | [-17.46, -13.88] | [-17.18, -14.14] | 0.849 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.3415 | 7.9002 | -5.29 | [-7.30, -3.38] | [-6.97, -3.66] | 0.950 | <0.0001 | inconclusive; repeatable change (-) |
| client_vcsw | 40 | 55872.3 | 13245.7 | -76.29 | [-78.61, -73.74] | [-78.24, -74.18] | 0.234 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.4473 | 4.2910 | -3.51 | [-6.05, -0.81] | [-5.70, -1.22] | 0.958 | 0.0152 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 40 | 5.4778 | 3.6010 | -34.26 | [-36.53, -31.94] | [-36.18, -32.29] | 0.658 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 5.8512 | 3.2945 | -43.70 | [-44.96, -42.45] | [-44.77, -42.65] | 0.570 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 3.7520 | 2.7198 | -27.51 | [-30.03, -24.83] | [-29.63, -25.26] | 0.720 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 9.6032 | 6.0143 | -37.37 | [-38.85, -35.87] | [-38.61, -36.10] | 0.626 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 4799.3 | 18122.1 | +277.60 | [+253.89, +303.57] | [+257.65, +299.36] | 3.836 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7249 | 7089 | -2.22 | [-3.36, -1.04] | [-3.16, -1.24] | 0.968 | 0.0021 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18746 | 18746 | +0.00 | [-0.05, +0.05] | [-0.03, +0.03] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 4.4467 | 3.8441 | -0.6084 | [-0.7354, -0.4814] |
| multi_s | 5.7551 | 4.7416 | -1.0022 | [-1.1728, -0.8316] |
| client_wall_s | 10.2649 | 8.5486 | -1.6106 | [-1.8268, -1.3943] |
| client_cpu_s | 8.2712 | 7.7152 | -0.4414 | [-0.6182, -0.2646] |
| client_vcsw | 55100.5 | 13249.0 | -42626.7 | [-45218.0, -40035.4] |
| multi_client_cpu_s | 4.3950 | 4.2150 | -0.1563 | [-0.2820, -0.0305] |
| multi_broker_cpu_s | 5.4800 | 3.6100 | -1.8768 | [-2.0393, -1.7142] |
| broker_user_s | 5.8184 | 3.2543 | -2.5567 | [-2.6710, -2.4425] |
| broker_sys_s | 3.7481 | 2.6961 | -1.0322 | [-1.1505, -0.9138] |
| broker_cpu_s | 9.6182 | 5.9590 | -3.5889 | [-3.7903, -3.3875] |
| broker_vcsw | 4805.5 | 18168.0 | +13322.8 | [+12820.3, +13825.3] |
| broker_maxrss_kib | 7236 | 7032 | -161 | [-249, -73] |
| broker_ru_maxrss_kib | 18784 | 18784 | +0 | [-9, +9] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
