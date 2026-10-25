candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5476 | 0.3333 | -39.13 | [-39.72, -38.53] | [-39.63, -38.63] | 0.610 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 108.1 | 65.2 | -39.64 | [-40.24, -39.03] | [-40.14, -39.13] | 0.605 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 101.8 | 62.5 | -38.59 | [-39.25, -37.91] | [-39.14, -38.03] | 0.612 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 121.8 | 73.9 | -39.32 | [-40.64, -37.93] | [-40.43, -38.17] | 0.602 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 200.9 | 114.0 | -43.26 | [-45.59, -40.71] | [-45.22, -41.15] | 0.552 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 319.3 | 205.9 | -35.51 | [-40.74, -29.37] | [-39.91, -30.47] | 0.603 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 671.7 | 452.3 | -32.65 | [-50.27, -8.67] | [-47.71, -12.94] | 0.570 | 0.0004 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1641 | 0.5030 | -56.80 | [-56.99, -56.60] | [-56.96, -56.63] | 0.432 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1150.2 | 498.1 | -56.69 | [-56.88, -56.50] | [-56.85, -56.53] | 0.433 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1086.8 | 485.0 | -55.37 | [-55.48, -55.24] | [-55.47, -55.27] | 0.446 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1402.7 | 531.2 | -62.13 | [-62.52, -61.70] | [-62.47, -61.77] | 0.374 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1704.5 | 889.7 | -47.80 | [-49.37, -46.35] | [-49.12, -46.57] | 0.538 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 2047.4 | 1170.3 | -42.84 | [-45.26, -40.38] | [-44.86, -40.78] | 0.573 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2517.3 | 1414.3 | -43.82 | [-46.73, -40.78] | [-46.28, -41.26] | 0.578 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6790 | 0.0502 | -92.60 | [-92.65, -92.56] | [-92.64, -92.57] | 0.074 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 20435.5 | 2246.2 | -89.01 | [-89.07, -88.94] | [-89.06, -88.95] | 0.110 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 20425.8 | 2261.4 | -88.93 | [-88.99, -88.87] | [-88.98, -88.88] | 0.111 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 30320.0 | 3378.6 | -88.86 | [-88.92, -88.80] | [-88.91, -88.81] | 0.111 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 32947.2 | 3836.8 | -88.35 | [-88.58, -88.09] | [-88.55, -88.14] | 0.114 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 34169.3 | 4083.3 | -88.05 | [-88.30, -87.76] | [-88.26, -87.81] | 0.116 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 34665.6 | 4365.4 | -87.41 | [-87.67, -87.10] | [-87.63, -87.15] | 0.123 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.4160 | 0.9347 | -61.31 | [-61.50, -61.13] | [-61.47, -61.16] | 0.387 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.1866 | 1.0681 | -51.15 | [-51.33, -50.97] | [-51.30, -51.00] | 0.488 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7965 | 0.2970 | -62.72 | [-63.33, -62.09] | [-63.23, -62.19] | 0.372 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3887 | 0.2983 | -78.52 | [-78.78, -78.25] | [-78.74, -78.29] | 0.213 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.1851 | 0.5953 | -72.76 | [-72.91, -72.61] | [-72.88, -72.63] | 0.273 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10041.7 | 13979.9 | +39.22 | [+38.90, +39.54] | [+38.95, +39.49] | 1.392 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6307 | 7001 | +11.00 | [+10.16, +11.83] | [+10.29, +11.69] | 1.112 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5484 | 0.3327 | -0.2143 | [-0.2191, -0.2095] |
| single_rtt_mean_us | 108.2 | 65.1 | -42.9 | [-43.8, -41.9] |
| single_rtt_p50_us | 100.9 | 61.7 | -39.3 | [-40.2, -38.4] |
| single_rtt_p90_us | 121.7 | 73.0 | -47.9 | [-50.2, -45.6] |
| single_rtt_p99_us | 205.4 | 112.8 | -86.9 | [-94.1, -79.7] |
| single_rtt_p999_us | 311.7 | 190.0 | -113.4 | [-135.6, -91.2] |
| single_rtt_max_us | 511.1 | 316.4 | -219.3 | [-385.1, -53.6] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1670 | 0.5043 | -0.6612 | [-0.6650, -0.6574] |
| multi_rtt_mean_us | 1152.6 | 499.2 | -652.1 | [-656.0, -648.1] |
| multi_rtt_p50_us | 1089.4 | 485.6 | -601.8 | [-604.8, -598.8] |
| multi_rtt_p90_us | 1405.2 | 523.6 | -871.6 | [-879.3, -863.8] |
| multi_rtt_p99_us | 1684.2 | 913.6 | -814.8 | [-846.3, -783.3] |
| multi_rtt_p999_us | 2006.6 | 1144.0 | -877.1 | [-949.7, -804.5] |
| multi_rtt_max_us | 2485.6 | 1383.2 | -1103.0 | [-1213.4, -992.5] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6803 | 0.0501 | -0.6288 | [-0.6309, -0.6268] |
| fanout_delivery_mean_us | 20472.9 | 2243.7 | -18189.3 | [-18251.7, -18126.9] |
| fanout_delivery_p50_us | 20469.3 | 2260.1 | -18164.4 | [-18224.9, -18103.9] |
| fanout_delivery_p90_us | 30370.4 | 3380.9 | -26941.4 | [-27031.2, -26851.6] |
| fanout_delivery_p99_us | 32954.6 | 3751.3 | -29110.4 | [-29283.1, -28937.7] |
| fanout_delivery_p999_us | 34143.1 | 3986.4 | -30086.1 | [-30302.6, -29869.6] |
| fanout_delivery_max_us | 34621.0 | 4258.9 | -30300.1 | [-30535.5, -30064.8] |
| client_wall_s | 2.4211 | 0.9359 | -1.4813 | [-1.4898, -1.4729] |
| client_cpu_s | 2.1847 | 1.0655 | -1.1185 | [-1.1244, -1.1126] |
| broker_user_s | 0.7995 | 0.2947 | -0.4995 | [-0.5078, -0.4912] |
| broker_sys_s | 1.3929 | 0.2963 | -1.0903 | [-1.0981, -1.0825] |
| broker_cpu_s | 2.1884 | 0.5975 | -1.5898 | [-1.5968, -1.5828] |
| broker_vcsw | 10037.5 | 13980.5 | +3938.2 | [+3905.3, +3971.1] |
| broker_maxrss_kib | 6308 | 7024 | +694 | [+643, +745] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
