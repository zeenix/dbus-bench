candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 1.0078 | 0.9409 | -6.64 | [-8.17, -5.17] | [-7.90, -5.39] | 0.936 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 201.5 | 188.1 | -6.64 | [-8.17, -5.17] | [-7.90, -5.39] | 0.936 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 190.7 | 177.4 | -6.97 | [-8.36, -5.59] | [-8.15, -5.82] | 0.927 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 238.7 | 224.8 | -5.81 | [-7.71, -3.94] | [-7.41, -4.24] | 0.947 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p99_us | 60 | 350.3 | 324.6 | -7.33 | [-12.41, -2.42] | [-11.62, -3.16] | 0.948 | 0.0059 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 994.7 | 865.9 | -12.95 | [-24.39, +0.92] | [-22.65, -1.49] | 0.831 | 0.0262 | inconclusive |
| single_rtt_max_us | 60 | 3034.3 | 3025.0 | -0.31 | [-28.49, +39.85] | [-25.03, +32.34] | 1.088 | 0.7183 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.9504 | 0.7869 | -17.20 | [-20.32, -14.01] | [-19.83, -14.48] | 0.832 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 932.7 | 762.5 | -18.25 | [-21.33, -15.09] | [-20.83, -15.59] | 0.818 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 842.6 | 716.3 | -15.00 | [-17.86, -12.19] | [-17.39, -12.58] | 0.863 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1372.7 | 1039.9 | -24.25 | [-28.65, -19.66] | [-27.93, -20.38] | 0.772 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2053.4 | 1548.8 | -24.57 | [-29.03, -19.80] | [-28.41, -20.55] | 0.741 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3837.7 | 2994.8 | -21.96 | [-34.03, -7.57] | [-32.36, -9.88] | 0.738 | 0.0041 | faster/smaller |
| multi_rtt_max_us | 60 | 5591.2 | 4277.7 | -23.49 | [-40.71, -1.68] | [-38.16, -5.23] | 0.820 | 0.0154 | inconclusive; repeatable change (-) |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.4008 | 0.3047 | -23.98 | [-27.34, -20.39] | [-26.81, -21.03] | 0.752 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 75182.6 | 27093.4 | -63.96 | [-65.72, -62.08] | [-65.46, -62.42] | 0.366 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 60496.6 | 26823.6 | -55.66 | [-58.23, -52.97] | [-57.83, -53.41] | 0.451 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 165250.7 | 34879.1 | -78.89 | [-80.22, -77.48] | [-80.01, -77.71] | 0.208 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 196716.1 | 39544.9 | -79.90 | [-81.26, -78.45] | [-81.04, -78.70] | 0.197 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 200814.4 | 40732.9 | -79.72 | [-81.05, -78.28] | [-80.86, -78.53] | 0.196 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 202130.9 | 41930.0 | -79.26 | [-80.60, -77.84] | [-80.39, -78.07] | 0.209 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.3757 | 2.0535 | -13.56 | [-15.40, -11.81] | [-15.09, -12.05] | 0.866 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.6987 | 1.5500 | -8.75 | [-10.67, -6.88] | [-10.37, -7.17] | 0.912 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.8630 | 0.5449 | -36.86 | [-38.58, -35.09] | [-38.31, -35.36] | 0.630 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7761 | 0.6359 | -18.06 | [-20.50, -15.53] | [-20.11, -15.94] | 0.814 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.6391 | 1.1808 | -27.96 | [-29.60, -26.31] | [-29.32, -26.58] | 0.721 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 15172.7 | 13285.0 | -12.44 | [-13.86, -10.98] | [-13.65, -11.21] | 0.867 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 6124 | 5079 | -17.07 | [-17.62, -16.51] | [-17.53, -16.60] | 0.830 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9999 | 0.9380 | -0.0669 | [-0.0832, -0.0506] |
| single_rtt_mean_us | 199.9 | 187.5 | -13.4 | [-16.6, -10.1] |
| single_rtt_p50_us | 188.9 | 176.4 | -13.3 | [-16.1, -10.4] |
| single_rtt_p90_us | 237.9 | 224.7 | -13.9 | [-18.7, -9.1] |
| single_rtt_p99_us | 338.7 | 318.6 | -25.7 | [-45.0, -6.3] |
| single_rtt_p999_us | 980.6 | 819.9 | -128.8 | [-262.6, +4.9] |
| single_rtt_max_us | 2528.3 | 2312.8 | -9.3 | [-1093.8, +1075.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.9486 | 0.7867 | -0.1635 | [-0.1989, -0.1281] |
| multi_rtt_mean_us | 934.4 | 765.1 | -170.2 | [-204.7, -135.7] |
| multi_rtt_p50_us | 835.7 | 717.1 | -126.4 | [-154.5, -98.3] |
| multi_rtt_p90_us | 1386.3 | 1043.5 | -332.9 | [-409.8, -255.9] |
| multi_rtt_p99_us | 2065.6 | 1539.2 | -504.6 | [-616.5, -392.6] |
| multi_rtt_p999_us | 3238.7 | 2567.7 | -842.9 | [-1453.5, -232.4] |
| multi_rtt_max_us | 4444.5 | 3509.3 | -1313.4 | [-2653.8, +27.0] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3918 | 0.2971 | -0.0961 | [-0.1127, -0.0795] |
| fanout_delivery_mean_us | 72355.7 | 26448.1 | -48089.1 | [-51150.8, -45027.5] |
| fanout_delivery_p50_us | 57292.4 | 26643.3 | -33673.0 | [-36638.2, -30707.8] |
| fanout_delivery_p90_us | 159567.1 | 33267.7 | -130371.7 | [-138116.6, -122626.7] |
| fanout_delivery_p99_us | 190475.1 | 37934.3 | -157171.2 | [-165894.3, -148448.1] |
| fanout_delivery_p999_us | 195981.3 | 40606.9 | -160081.5 | [-168966.1, -151196.9] |
| fanout_delivery_max_us | 197573.8 | 40699.3 | -160200.9 | [-168950.9, -151450.9] |
| client_wall_s | 2.3759 | 2.0530 | -0.3222 | [-0.3711, -0.2732] |
| client_cpu_s | 1.6838 | 1.5451 | -0.1487 | [-0.1842, -0.1131] |
| broker_user_s | 0.8554 | 0.5460 | -0.3181 | [-0.3389, -0.2974] |
| broker_sys_s | 0.7698 | 0.6370 | -0.1401 | [-0.1626, -0.1176] |
| broker_cpu_s | 1.6346 | 1.1842 | -0.4583 | [-0.4931, -0.4234] |
| broker_vcsw | 15136.5 | 13340.5 | -1887.7 | [-2137.7, -1637.7] |
| broker_maxrss_kib | 6142 | 5084 | -1045 | [-1083, -1008] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
