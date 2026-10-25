candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5476 | 0.3293 | -39.86 | [-40.35, -39.37] | [-40.27, -39.45] | 0.603 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 108.1 | 64.4 | -40.38 | [-40.87, -39.89] | [-40.79, -39.96] | 0.598 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 101.8 | 62.2 | -38.90 | [-39.48, -38.36] | [-39.37, -38.44] | 0.612 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 121.8 | 72.1 | -40.85 | [-41.91, -39.72] | [-41.75, -39.92] | 0.591 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 200.9 | 110.8 | -44.84 | [-46.85, -42.70] | [-46.53, -43.07] | 0.539 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 319.3 | 193.3 | -39.47 | [-44.19, -34.19] | [-43.51, -35.18] | 0.574 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 671.7 | 335.8 | -50.00 | [-59.87, -37.62] | [-58.42, -39.69] | 0.535 | <0.0001 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1641 | 0.5021 | -56.87 | [-57.05, -56.68] | [-57.02, -56.71] | 0.430 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1150.2 | 497.1 | -56.78 | [-56.96, -56.60] | [-56.93, -56.63] | 0.432 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1086.8 | 484.3 | -55.44 | [-55.54, -55.33] | [-55.52, -55.35] | 0.446 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1402.7 | 532.9 | -62.01 | [-62.49, -61.48] | [-62.41, -61.57] | 0.374 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1704.5 | 881.7 | -48.27 | [-49.58, -46.99] | [-49.36, -47.18] | 0.532 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 2047.4 | 1155.0 | -43.59 | [-46.32, -40.48] | [-45.89, -41.05] | 0.555 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2517.3 | 1389.4 | -44.80 | [-48.05, -41.20] | [-47.58, -41.79] | 0.552 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6790 | 0.1265 | -81.37 | [-81.42, -81.31] | [-81.41, -81.32] | 0.186 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 20435.5 | 7451.2 | -63.54 | [-63.65, -63.42] | [-63.63, -63.44] | 0.364 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 20425.8 | 7541.8 | -63.08 | [-63.19, -62.96] | [-63.17, -62.98] | 0.369 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 30320.0 | 9320.5 | -69.26 | [-69.36, -69.16] | [-69.34, -69.18] | 0.307 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 32947.2 | 9891.7 | -69.98 | [-70.13, -69.82] | [-70.10, -69.85] | 0.299 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 34169.3 | 10188.4 | -70.18 | [-70.40, -69.96] | [-70.37, -69.99] | 0.297 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 34665.6 | 10273.1 | -70.37 | [-70.60, -70.12] | [-70.56, -70.16] | 0.296 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.4160 | 1.0052 | -58.39 | [-58.55, -58.24] | [-58.53, -58.26] | 0.415 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.1866 | 1.4990 | -31.45 | [-31.62, -31.27] | [-31.60, -31.30] | 0.685 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7965 | 0.3066 | -61.50 | [-62.02, -60.94] | [-61.95, -61.04] | 0.383 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3887 | 0.3618 | -73.95 | [-74.25, -73.64] | [-74.20, -73.69] | 0.258 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.1851 | 0.6684 | -69.41 | [-69.54, -69.28] | [-69.52, -69.30] | 0.306 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10041.7 | 13973.0 | +39.15 | [+38.80, +39.51] | [+38.85, +39.45] | 1.391 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6307 | 7005 | +11.06 | [+10.24, +11.90] | [+10.36, +11.76] | 1.112 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5484 | 0.3296 | -0.2183 | [-0.2225, -0.2141] |
| single_rtt_mean_us | 108.2 | 64.5 | -43.7 | [-44.5, -42.8] |
| single_rtt_p50_us | 100.9 | 61.7 | -39.6 | [-40.5, -38.8] |
| single_rtt_p90_us | 121.7 | 71.2 | -49.8 | [-51.7, -47.8] |
| single_rtt_p99_us | 205.4 | 109.2 | -90.1 | [-96.5, -83.6] |
| single_rtt_p999_us | 311.7 | 180.5 | -126.0 | [-146.4, -105.6] |
| single_rtt_max_us | 511.1 | 267.1 | -335.8 | [-456.3, -215.3] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1670 | 0.5025 | -0.6620 | [-0.6655, -0.6585] |
| multi_rtt_mean_us | 1152.6 | 497.7 | -653.1 | [-656.7, -649.4] |
| multi_rtt_p50_us | 1089.4 | 485.6 | -602.5 | [-605.2, -599.8] |
| multi_rtt_p90_us | 1405.2 | 525.4 | -869.8 | [-878.7, -861.0] |
| multi_rtt_p99_us | 1684.2 | 910.1 | -822.8 | [-849.8, -795.7] |
| multi_rtt_p999_us | 2006.6 | 1094.1 | -892.4 | [-970.5, -814.2] |
| multi_rtt_max_us | 2485.6 | 1339.9 | -1127.9 | [-1249.3, -1006.4] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6803 | 0.1264 | -0.5525 | [-0.5545, -0.5505] |
| fanout_delivery_mean_us | 20472.9 | 7441.5 | -12984.3 | [-13043.2, -12925.4] |
| fanout_delivery_p50_us | 20469.3 | 7525.8 | -12884.0 | [-12943.4, -12824.7] |
| fanout_delivery_p90_us | 30370.4 | 9311.5 | -20999.5 | [-21086.9, -20912.1] |
| fanout_delivery_p99_us | 32954.6 | 9869.0 | -23055.5 | [-23190.8, -22920.2] |
| fanout_delivery_p999_us | 34143.1 | 10134.9 | -23980.9 | [-24168.5, -23793.3] |
| fanout_delivery_max_us | 34621.0 | 10230.5 | -24392.5 | [-24598.8, -24186.1] |
| client_wall_s | 2.4211 | 1.0027 | -1.4108 | [-1.4185, -1.4031] |
| client_cpu_s | 2.1847 | 1.4998 | -0.6877 | [-0.6927, -0.6827] |
| broker_user_s | 0.7995 | 0.3058 | -0.4898 | [-0.4977, -0.4820] |
| broker_sys_s | 1.3929 | 0.3597 | -1.0269 | [-1.0348, -1.0190] |
| broker_cpu_s | 2.1884 | 0.6713 | -1.5167 | [-1.5229, -1.5105] |
| broker_vcsw | 10037.5 | 13968.0 | +3931.4 | [+3895.3, +3967.4] |
| broker_maxrss_kib | 6308 | 7014 | +698 | [+647, +749] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
