candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 1.0078 | 0.9484 | -5.90 | [-7.37, -4.43] | [-7.13, -4.66] | 0.945 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_mean_us | 60 | 201.5 | 189.6 | -5.90 | [-7.37, -4.43] | [-7.13, -4.66] | 0.945 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p50_us | 60 | 190.7 | 178.4 | -6.45 | [-7.96, -4.92] | [-7.73, -5.18] | 0.938 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p90_us | 60 | 238.7 | 224.9 | -5.75 | [-7.43, -4.08] | [-7.16, -4.34] | 0.946 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p99_us | 60 | 350.3 | 324.7 | -7.30 | [-11.42, -3.31] | [-10.77, -3.83] | 0.952 | 0.0014 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 994.7 | 908.5 | -8.67 | [-21.99, +6.46] | [-20.10, +3.82] | 0.860 | 0.0460 | inconclusive |
| single_rtt_max_us | 60 | 3034.3 | 3334.7 | +9.90 | [-21.58, +55.34] | [-17.42, +47.03] | 0.969 | 0.8829 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.9504 | 0.8068 | -15.11 | [-18.12, -12.03] | [-17.64, -12.49] | 0.872 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 932.7 | 781.7 | -16.19 | [-19.20, -13.13] | [-18.71, -13.57] | 0.861 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 842.6 | 737.4 | -12.49 | [-15.60, -9.28] | [-15.06, -9.81] | 0.882 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1372.7 | 1057.3 | -22.98 | [-27.26, -18.48] | [-26.60, -19.22] | 0.800 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2053.4 | 1616.6 | -21.27 | [-25.79, -16.57] | [-25.12, -17.34] | 0.800 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3837.7 | 3253.7 | -15.22 | [-28.86, +0.59] | [-26.66, -1.97] | 0.801 | 0.0460 | inconclusive |
| multi_rtt_max_us | 60 | 5591.2 | 4776.0 | -14.58 | [-35.05, +12.88] | [-32.00, +7.89] | 0.865 | 0.1756 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.4008 | 0.2682 | -33.09 | [-35.90, -30.04] | [-35.45, -30.60] | 0.654 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 75182.6 | 28546.3 | -62.03 | [-63.99, -59.85] | [-63.72, -60.22] | 0.375 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 60496.6 | 28476.5 | -52.93 | [-55.53, -50.10] | [-55.18, -50.56] | 0.480 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 165250.7 | 37533.5 | -77.29 | [-78.81, -75.62] | [-78.57, -75.90] | 0.214 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 196716.1 | 43456.2 | -77.91 | [-79.34, -76.37] | [-79.11, -76.64] | 0.206 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 200814.4 | 45464.0 | -77.36 | [-78.82, -75.79] | [-78.59, -76.06] | 0.211 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 202130.9 | 46216.3 | -77.14 | [-78.59, -75.55] | [-78.36, -75.83] | 0.211 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.3757 | 2.0424 | -14.03 | [-15.74, -12.35] | [-15.47, -12.60] | 0.866 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.6987 | 1.5295 | -9.96 | [-11.83, -8.13] | [-11.52, -8.41] | 0.908 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.8630 | 0.5295 | -38.65 | [-40.33, -36.99] | [-40.05, -37.24] | 0.619 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7761 | 0.6192 | -20.22 | [-22.84, -17.49] | [-22.42, -17.97] | 0.803 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.6391 | 1.1486 | -29.92 | [-31.51, -28.33] | [-31.26, -28.56] | 0.704 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 15172.7 | 13209.1 | -12.94 | [-14.46, -11.38] | [-14.23, -11.61] | 0.878 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 6124 | 5112 | -16.52 | [-17.03, -16.00] | [-16.95, -16.08] | 0.838 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9999 | 0.9543 | -0.0594 | [-0.0752, -0.0436] |
| single_rtt_mean_us | 199.9 | 190.8 | -11.9 | [-15.0, -8.7] |
| single_rtt_p50_us | 188.9 | 178.6 | -12.3 | [-15.4, -9.2] |
| single_rtt_p90_us | 237.9 | 225.4 | -13.7 | [-18.0, -9.5] |
| single_rtt_p99_us | 338.7 | 325.1 | -25.6 | [-41.3, -9.8] |
| single_rtt_p999_us | 980.6 | 813.4 | -86.2 | [-236.5, +64.1] |
| single_rtt_max_us | 2528.3 | 2426.7 | +300.3 | [-866.4, +1467.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.9486 | 0.8025 | -0.1436 | [-0.1773, -0.1098] |
| multi_rtt_mean_us | 934.4 | 782.8 | -151.0 | [-184.3, -117.8] |
| multi_rtt_p50_us | 835.7 | 735.9 | -105.2 | [-135.4, -75.0] |
| multi_rtt_p90_us | 1386.3 | 1072.4 | -315.4 | [-389.3, -241.6] |
| multi_rtt_p99_us | 2065.6 | 1578.5 | -436.8 | [-544.2, -329.4] |
| multi_rtt_p999_us | 3238.7 | 2874.4 | -584.1 | [-1223.3, +55.2] |
| multi_rtt_max_us | 4444.5 | 3645.1 | -815.2 | [-2311.3, +680.9] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3918 | 0.2579 | -0.1326 | [-0.1480, -0.1173] |
| fanout_delivery_mean_us | 72355.7 | 27668.2 | -46636.2 | [-49831.8, -43440.7] |
| fanout_delivery_p50_us | 57292.4 | 27557.7 | -32020.1 | [-34992.2, -29048.0] |
| fanout_delivery_p90_us | 159567.1 | 34582.1 | -127717.2 | [-135521.5, -119912.9] |
| fanout_delivery_p99_us | 190475.1 | 38993.9 | -153259.9 | [-161786.8, -144732.9] |
| fanout_delivery_p999_us | 195981.3 | 41790.7 | -155350.4 | [-164094.0, -146606.8] |
| fanout_delivery_max_us | 197573.8 | 42810.6 | -155914.7 | [-164574.6, -147254.7] |
| client_wall_s | 2.3759 | 2.0475 | -0.3333 | [-0.3802, -0.2865] |
| client_cpu_s | 1.6838 | 1.5171 | -0.1692 | [-0.2045, -0.1340] |
| broker_user_s | 0.8554 | 0.5302 | -0.3336 | [-0.3542, -0.3129] |
| broker_sys_s | 0.7698 | 0.6194 | -0.1569 | [-0.1811, -0.1327] |
| broker_cpu_s | 1.6346 | 1.1402 | -0.4905 | [-0.5253, -0.4556] |
| broker_vcsw | 15136.5 | 13251.5 | -1963.6 | [-2228.0, -1699.1] |
| broker_maxrss_kib | 6142 | 5128 | -1012 | [-1047, -976] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
