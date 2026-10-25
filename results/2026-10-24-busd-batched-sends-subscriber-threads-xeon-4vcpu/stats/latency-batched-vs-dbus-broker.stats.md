candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9048 | 0.9126 | +0.87 | [-0.46, +2.18] | [-0.24, +1.99] | 1.006 | 0.1756 | no material change |
| single_rtt_mean_us | 60 | 180.9 | 182.4 | +0.87 | [-0.46, +2.19] | [-0.24, +1.99] | 1.006 | 0.1732 | no material change |
| single_rtt_p50_us | 60 | 171.0 | 171.8 | +0.47 | [-1.00, +1.98] | [-0.78, +1.76] | 1.005 | 0.3931 | no material change |
| single_rtt_p90_us | 60 | 217.4 | 214.5 | -1.34 | [-3.26, +0.60] | [-2.94, +0.28] | 0.991 | 0.2081 | no material change |
| single_rtt_p99_us | 60 | 307.8 | 299.5 | -2.71 | [-6.09, +0.94] | [-5.66, +0.36] | 0.973 | 0.1619 | inconclusive |
| single_rtt_p999_us | 60 | 975.2 | 803.2 | -17.64 | [-30.63, -2.40] | [-28.67, -5.02] | 0.864 | 0.0748 | inconclusive; repeatable change (-) |
| single_rtt_max_us | 60 | 3747.5 | 2750.4 | -26.61 | [-54.10, +12.32] | [-50.33, +7.62] | 0.911 | 0.6219 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.2845 | 0.7514 | -41.50 | [-43.06, -39.91] | [-42.80, -40.19] | 0.586 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1243.1 | 726.8 | -41.53 | [-43.12, -39.93] | [-42.85, -40.20] | 0.585 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1206.2 | 694.4 | -42.43 | [-43.72, -41.09] | [-43.52, -41.30] | 0.574 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1714.9 | 950.9 | -44.55 | [-46.84, -42.20] | [-46.48, -42.59] | 0.564 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2508.6 | 1465.1 | -41.60 | [-45.35, -37.41] | [-44.78, -38.11] | 0.570 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3890.1 | 2656.7 | -31.71 | [-40.24, -21.50] | [-39.01, -23.34] | 0.616 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 5226.9 | 4334.6 | -17.07 | [-36.83, +12.00] | [-34.81, +6.83] | 0.619 | 0.0002 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.1174 | 0.1013 | -13.71 | [-17.35, -10.03] | [-16.79, -10.64] | 0.878 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 9778.5 | 4902.9 | -49.86 | [-56.03, -42.83] | [-55.02, -44.01] | 0.569 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 6535.3 | 4615.3 | -29.38 | [-40.13, -17.98] | [-38.29, -19.71] | 0.822 | 0.0002 | faster/smaller |
| fanout_delivery_p90_us | 60 | 22537.4 | 8350.0 | -62.95 | [-67.69, -57.13] | [-66.99, -58.18] | 0.428 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 37151.2 | 12141.5 | -67.32 | [-70.77, -63.28] | [-70.25, -63.98] | 0.357 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 42499.1 | 14723.4 | -65.36 | [-68.61, -61.78] | [-68.10, -62.37] | 0.385 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 44149.0 | 17202.4 | -61.04 | [-64.33, -57.36] | [-63.85, -58.02] | 0.427 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.3404 | 1.7983 | -23.16 | [-24.21, -22.09] | [-24.05, -22.26] | 0.768 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.2046 | 1.4977 | -32.07 | [-33.06, -31.08] | [-32.89, -31.24] | 0.682 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2483 | 0.4960 | +99.76 | [+94.20, +105.77] | [+95.00, +104.71] | 1.973 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.6959 | 0.5798 | -16.67 | [-18.94, -14.42] | [-18.53, -14.78] | 0.831 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.9442 | 1.0759 | +13.95 | [+12.21, +15.66] | [+12.51, +15.40] | 1.133 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 52594.1 | 13705.0 | -73.94 | [-74.38, -73.48] | [-74.31, -73.56] | 0.260 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 10079 | 5101 | -49.39 | [-51.38, -47.38] | [-51.03, -47.69] | 0.524 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9010 | 0.9159 | +0.0078 | [-0.0046, +0.0202] |
| single_rtt_mean_us | 180.1 | 183.1 | +1.6 | [-0.9, +4.0] |
| single_rtt_p50_us | 170.1 | 173.2 | +0.8 | [-1.8, +3.4] |
| single_rtt_p90_us | 216.0 | 213.1 | -2.9 | [-7.3, +1.5] |
| single_rtt_p99_us | 303.7 | 298.9 | -8.4 | [-19.9, +3.2] |
| single_rtt_p999_us | 852.8 | 743.4 | -172.0 | [-331.8, -12.2] |
| single_rtt_max_us | 2472.8 | 2416.4 | -997.1 | [-2851.3, +857.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.2734 | 0.7465 | -0.5331 | [-0.5608, -0.5054] |
| multi_rtt_mean_us | 1230.6 | 721.8 | -516.3 | [-543.4, -489.2] |
| multi_rtt_p50_us | 1194.1 | 669.6 | -511.8 | [-534.3, -489.2] |
| multi_rtt_p90_us | 1675.2 | 949.5 | -764.0 | [-816.3, -711.7] |
| multi_rtt_p99_us | 2495.8 | 1456.4 | -1043.5 | [-1170.3, -916.7] |
| multi_rtt_p999_us | 3694.9 | 2319.7 | -1233.5 | [-1649.9, -817.1] |
| multi_rtt_max_us | 4877.1 | 3186.6 | -892.2 | [-2269.0, +484.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.1135 | 0.1013 | -0.0161 | [-0.0209, -0.0112] |
| fanout_delivery_mean_us | 8954.0 | 4913.4 | -4875.6 | [-6151.7, -3599.5] |
| fanout_delivery_p50_us | 5437.6 | 4635.0 | -1920.0 | [-2950.4, -889.5] |
| fanout_delivery_p90_us | 20522.0 | 8202.9 | -14187.3 | [-17378.9, -10995.8] |
| fanout_delivery_p99_us | 34998.7 | 11833.2 | -25009.7 | [-29082.8, -20936.7] |
| fanout_delivery_p999_us | 41016.7 | 14251.2 | -27775.6 | [-31778.9, -23772.4] |
| fanout_delivery_max_us | 41624.3 | 16914.1 | -26946.6 | [-30800.9, -23092.3] |
| client_wall_s | 2.3349 | 1.8011 | -0.5421 | [-0.5726, -0.5117] |
| client_cpu_s | 2.1960 | 1.4963 | -0.7069 | [-0.7365, -0.6774] |
| broker_user_s | 0.2462 | 0.4945 | +0.2477 | [+0.2377, +0.2578] |
| broker_sys_s | 0.6985 | 0.5756 | -0.1160 | [-0.1330, -0.0990] |
| broker_cpu_s | 0.9387 | 1.0807 | +0.1317 | [+0.1162, +0.1472] |
| broker_vcsw | 52594.5 | 13749.5 | -38889.1 | [-39783.3, -37994.9] |
| broker_maxrss_kib | 9814 | 5106 | -4978 | [-5388, -4567] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
