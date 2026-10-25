candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2239 | 0.1997 | -10.83 | [-12.92, -8.66] | [-12.60, -8.99] | 0.887 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.9626 | 0.7999 | -16.90 | [-19.73, -13.82] | [-19.28, -14.36] | 0.830 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1931 | 1.0061 | -15.67 | [-18.07, -13.06] | [-17.72, -13.50] | 0.842 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9094 | 0.8608 | -5.35 | [-8.30, -2.08] | [-7.85, -2.66] | 0.943 | 0.0004 | inconclusive; repeatable change (-) |
| client_vcsw | 60 | 8848.6 | 4937.2 | -44.20 | [-47.26, -41.09] | [-46.76, -41.60] | 0.574 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7985 | 0.7528 | -5.72 | [-9.01, -2.04] | [-8.51, -2.66] | 0.935 | 0.0008 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.9037 | 0.5752 | -36.35 | [-38.51, -34.09] | [-38.19, -34.47] | 0.644 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6027 | 0.3619 | -39.96 | [-41.93, -37.92] | [-41.61, -38.26] | 0.610 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.4318 | 0.3215 | -25.54 | [-29.55, -21.30] | [-28.92, -22.02] | 0.733 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.0345 | 0.6834 | -33.94 | [-35.95, -31.84] | [-35.65, -32.21] | 0.664 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2525.8 | 5101.7 | +101.98 | [+92.69, +111.46] | [+94.21, +110.01] | 2.041 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5024 | 4880 | -2.86 | [-3.37, -2.36] | [-3.29, -2.45] | 0.971 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 19033 | 19033 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2209 | 0.1988 | -0.0243 | [-0.0294, -0.0191] |
| multi_s | 0.9395 | 0.7874 | -0.1627 | [-0.1947, -0.1308] |
| client_wall_s | 1.1526 | 0.9811 | -0.1870 | [-0.2204, -0.1536] |
| client_cpu_s | 0.8897 | 0.8417 | -0.0487 | [-0.0780, -0.0194] |
| client_vcsw | 8384.5 | 4847.0 | -3911.4 | [-4373.7, -3449.0] |
| multi_client_cpu_s | 0.7800 | 0.7300 | -0.0457 | [-0.0748, -0.0166] |
| multi_broker_cpu_s | 0.8700 | 0.5700 | -0.3285 | [-0.3563, -0.3007] |
| broker_user_s | 0.5865 | 0.3569 | -0.2408 | [-0.2585, -0.2232] |
| broker_sys_s | 0.4258 | 0.3179 | -0.1103 | [-0.1317, -0.0889] |
| broker_cpu_s | 0.9935 | 0.6789 | -0.3512 | [-0.3800, -0.3223] |
| broker_vcsw | 2441.0 | 5178.0 | +2575.9 | [+2388.2, +2763.6] |
| broker_maxrss_kib | 5024 | 4884 | -144 | [-170, -118] |
| broker_ru_maxrss_kib | 19016 | 19016 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
