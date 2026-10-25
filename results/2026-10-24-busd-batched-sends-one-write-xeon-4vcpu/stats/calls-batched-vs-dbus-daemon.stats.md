candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2239 | 0.2084 | -6.92 | [-9.60, -3.99] | [-9.22, -4.52] | 0.936 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.9626 | 0.8082 | -16.04 | [-18.78, -13.22] | [-18.34, -13.66] | 0.822 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1931 | 1.0231 | -14.25 | [-16.71, -11.73] | [-16.28, -12.11] | 0.850 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9094 | 0.8683 | -4.52 | [-7.14, -1.81] | [-6.69, -2.23] | 0.964 | 0.0019 | inconclusive; repeatable change (-) |
| client_vcsw | 60 | 8848.6 | 5001.5 | -43.48 | [-46.81, -39.81] | [-46.30, -40.47] | 0.596 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7985 | 0.7600 | -4.82 | [-7.62, -1.85] | [-7.17, -2.35] | 0.962 | 0.0026 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.9037 | 0.5923 | -34.45 | [-36.72, -32.09] | [-36.36, -32.49] | 0.651 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6027 | 0.3634 | -39.70 | [-41.75, -37.58] | [-41.40, -37.90] | 0.597 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.4318 | 0.3435 | -20.45 | [-24.28, -16.32] | [-23.70, -17.05] | 0.778 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.0345 | 0.7069 | -31.67 | [-33.84, -29.43] | [-33.49, -29.78] | 0.678 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2525.8 | 5038.6 | +99.49 | [+91.46, +107.53] | [+92.75, +106.36] | 2.089 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5024 | 4930 | -1.87 | [-2.38, -1.36] | [-2.29, -1.44] | 0.981 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 19033 | 19029 | -0.02 | [-0.06, +0.00] | [-0.04, +0.00] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2209 | 0.2052 | -0.0155 | [-0.0220, -0.0090] |
| multi_s | 0.9395 | 0.7998 | -0.1544 | [-0.1857, -0.1231] |
| client_wall_s | 1.1526 | 1.0120 | -0.1700 | [-0.2039, -0.1360] |
| client_cpu_s | 0.8897 | 0.8635 | -0.0411 | [-0.0668, -0.0154] |
| client_vcsw | 8384.5 | 4916.5 | -3847.1 | [-4332.9, -3361.2] |
| multi_client_cpu_s | 0.7800 | 0.7600 | -0.0385 | [-0.0629, -0.0141] |
| multi_broker_cpu_s | 0.8700 | 0.5850 | -0.3113 | [-0.3392, -0.2834] |
| broker_user_s | 0.5865 | 0.3593 | -0.2393 | [-0.2573, -0.2212] |
| broker_sys_s | 0.4258 | 0.3336 | -0.0883 | [-0.1078, -0.0688] |
| broker_cpu_s | 0.9935 | 0.7002 | -0.3276 | [-0.3572, -0.2980] |
| broker_vcsw | 2441.0 | 5131.0 | +2512.8 | [+2354.5, +2671.2] |
| broker_maxrss_kib | 5024 | 4926 | -94 | [-120, -68] |
| broker_ru_maxrss_kib | 19016 | 19016 | -4 | [-10, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
