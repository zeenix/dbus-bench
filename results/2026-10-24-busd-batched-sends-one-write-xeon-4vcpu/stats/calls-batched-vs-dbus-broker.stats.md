candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2079 | 0.2084 | +0.26 | [-2.25, +2.99] | [-1.88, +2.51] | 1.001 | 0.8138 | no material change |
| multi_s | 60 | 1.2480 | 0.8082 | -35.24 | [-37.23, -33.15] | [-36.92, -33.50] | 0.645 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.4624 | 1.0231 | -30.04 | [-31.90, -28.13] | [-31.58, -28.44] | 0.696 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.3581 | 0.8683 | -36.06 | [-37.73, -34.37] | [-37.46, -34.65] | 0.636 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 3346.9 | 5001.5 | +49.44 | [+42.92, +57.34] | [+43.83, +55.88] | 1.484 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 1.2267 | 0.7600 | -38.04 | [-39.85, -36.19] | [-39.57, -36.49] | 0.614 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.4950 | 0.5923 | +19.66 | [+15.86, +23.73] | [+16.41, +23.10] | 1.202 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1811 | 0.3634 | +100.69 | [+93.28, +108.67] | [+94.47, +107.33] | 2.020 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.4158 | 0.3435 | -17.40 | [-21.60, -12.56] | [-21.03, -13.50] | 0.824 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5969 | 0.7069 | +18.43 | [+15.04, +22.10] | [+15.52, +21.52] | 1.178 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 32622.3 | 5038.6 | -84.55 | [-85.11, -83.96] | [-85.02, -84.06] | 0.151 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7310 | 4930 | -32.56 | [-32.96, -32.16] | [-32.90, -32.22] | 0.673 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 19033 | 19029 | -0.02 | [-0.06, +0.00] | [-0.04, +0.00] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2065 | 0.2052 | +0.0005 | [-0.0051, +0.0062] |
| multi_s | 1.2454 | 0.7998 | -0.4398 | [-0.4726, -0.4070] |
| client_wall_s | 1.4563 | 1.0120 | -0.4393 | [-0.4729, -0.4057] |
| client_cpu_s | 1.3560 | 0.8635 | -0.4897 | [-0.5196, -0.4599] |
| client_vcsw | 3361.5 | 4916.5 | +1654.6 | [+1427.0, +1882.2] |
| multi_client_cpu_s | 1.2300 | 0.7600 | -0.4667 | [-0.4969, -0.4364] |
| multi_broker_cpu_s | 0.4900 | 0.5850 | +0.0973 | [+0.0777, +0.1169] |
| broker_user_s | 0.1810 | 0.3593 | +0.1823 | [+0.1727, +0.1920] |
| broker_sys_s | 0.4085 | 0.3336 | -0.0723 | [-0.0930, -0.0517] |
| broker_cpu_s | 0.5951 | 0.7002 | +0.1100 | [+0.0890, +0.1311] |
| broker_vcsw | 32967.5 | 5131.0 | -27583.7 | [-28657.4, -26510.0] |
| broker_maxrss_kib | 7314 | 4926 | -2380 | [-2417, -2344] |
| broker_ru_maxrss_kib | 19016 | 19016 | -4 | [-10, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
