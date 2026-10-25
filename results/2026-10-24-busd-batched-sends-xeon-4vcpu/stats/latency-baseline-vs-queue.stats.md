candidate baseline against baseline queue, from $WORK/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9751 | 0.9503 | -2.54 | [-4.03, -1.08] | [-3.79, -1.32] | 0.975 | 0.0017 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 194.9 | 190.0 | -2.54 | [-4.03, -1.08] | [-3.79, -1.32] | 0.975 | 0.0017 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 183.2 | 179.1 | -2.25 | [-3.82, -0.71] | [-3.58, -0.96] | 0.980 | 0.0100 | no material change; repeatable change (-) |
| single_rtt_p90_us | 60 | 234.1 | 227.2 | -2.93 | [-4.61, -1.30] | [-4.33, -1.55] | 0.975 | 0.0021 | no material change; repeatable change (-) |
| single_rtt_p99_us | 60 | 346.4 | 332.4 | -4.02 | [-7.62, -0.23] | [-7.09, -0.80] | 0.978 | 0.0890 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 1056.3 | 961.6 | -8.97 | [-21.00, +4.43] | [-18.95, +2.15] | 0.930 | 0.3386 | inconclusive |
| single_rtt_max_us | 60 | 3819.9 | 2763.8 | -27.65 | [-52.77, +7.33] | [-48.96, +2.71] | 0.924 | 0.3349 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.8151 | 0.8090 | -0.75 | [-4.17, +2.70] | [-3.61, +2.14] | 1.003 | 0.6748 | no material change |
| multi_rtt_mean_us | 60 | 793.1 | 783.1 | -1.26 | [-4.64, +2.16] | [-4.08, +1.60] | 0.995 | 0.4797 | no material change |
| multi_rtt_p50_us | 60 | 746.4 | 743.0 | -0.46 | [-4.11, +3.32] | [-3.52, +2.67] | 0.986 | 0.5267 | no material change |
| multi_rtt_p90_us | 60 | 1072.9 | 1051.3 | -2.01 | [-6.76, +2.85] | [-6.07, +2.09] | 0.981 | 0.3349 | inconclusive |
| multi_rtt_p99_us | 60 | 1582.1 | 1593.1 | +0.70 | [-5.17, +6.63] | [-4.20, +5.62] | 1.014 | 0.7684 | inconclusive |
| multi_rtt_p999_us | 60 | 3409.5 | 3034.9 | -10.99 | [-28.71, +10.00] | [-25.95, +6.63] | 0.941 | 0.4055 | inconclusive |
| multi_rtt_max_us | 60 | 4582.0 | 4092.9 | -10.67 | [-27.59, +10.40] | [-24.98, +6.82] | 0.833 | 0.2273 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3224 | 0.3132 | -2.83 | [-7.33, +2.00] | [-6.63, +1.18] | 0.983 | 0.1876 | inconclusive |
| fanout_delivery_mean_us | 60 | 71072.7 | 27804.6 | -60.88 | [-62.76, -58.84] | [-62.46, -59.18] | 0.395 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 72582.7 | 27482.5 | -62.14 | [-64.52, -59.59] | [-64.14, -59.96] | 0.390 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 112880.0 | 36111.3 | -68.01 | [-70.04, -65.95] | [-69.71, -66.27] | 0.318 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 122476.3 | 41635.0 | -66.01 | [-68.45, -63.38] | [-68.09, -63.79] | 0.335 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 126145.7 | 43214.3 | -65.74 | [-68.32, -63.02] | [-67.89, -63.43] | 0.332 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 127414.5 | 44706.3 | -64.91 | [-67.50, -62.15] | [-67.10, -62.57] | 0.334 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1322 | 2.0939 | -1.79 | [-3.65, +0.10] | [-3.35, -0.20] | 0.978 | 0.0646 | no material change |
| client_cpu_s | 60 | 1.5983 | 1.5862 | -0.76 | [-2.92, +1.40] | [-2.57, +1.06] | 0.988 | 0.4661 | no material change |
| broker_user_s | 60 | 0.5706 | 0.5477 | -4.02 | [-7.46, -0.52] | [-6.89, -1.06] | 0.961 | 0.0353 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.6533 | 0.6476 | -0.86 | [-3.82, +2.18] | [-3.38, +1.70] | 0.994 | 0.5315 | no material change |
| broker_cpu_s | 60 | 1.2239 | 1.1953 | -2.33 | [-4.44, -0.26] | [-4.09, -0.58] | 0.971 | 0.0407 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 13550.8 | 13415.5 | -1.00 | [-2.38, +0.41] | [-2.15, +0.16] | 0.984 | 0.1038 | no material change |
| broker_maxrss_kib | 60 | 6317 | 5083 | -19.54 | [-20.20, -18.83] | [-20.09, -18.95] | 0.800 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9632 | 0.9489 | -0.0248 | [-0.0396, -0.0100] |
| single_rtt_mean_us | 192.5 | 189.7 | -5.0 | [-7.9, -2.0] |
| single_rtt_p50_us | 181.1 | 177.9 | -4.1 | [-7.1, -1.2] |
| single_rtt_p90_us | 231.9 | 227.0 | -6.9 | [-10.9, -2.8] |
| single_rtt_p99_us | 334.5 | 331.3 | -13.9 | [-27.5, -0.3] |
| single_rtt_p999_us | 925.9 | 948.2 | -94.8 | [-239.8, +50.3] |
| single_rtt_max_us | 2498.9 | 2343.7 | -1056.2 | [-2677.1, +564.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.8072 | 0.7962 | -0.0061 | [-0.0351, +0.0229] |
| multi_rtt_mean_us | 783.4 | 769.6 | -10.0 | [-37.9, +18.0] |
| multi_rtt_p50_us | 730.5 | 729.9 | -3.5 | [-32.2, +25.3] |
| multi_rtt_p90_us | 1078.3 | 1085.0 | -21.6 | [-75.7, +32.6] |
| multi_rtt_p99_us | 1549.0 | 1557.7 | +11.0 | [-84.1, +106.1] |
| multi_rtt_p999_us | 2920.9 | 2694.6 | -374.6 | [-1135.1, +386.0] |
| multi_rtt_max_us | 3859.1 | 3472.8 | -489.1 | [-1464.2, +486.1] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3179 | 0.2975 | -0.0091 | [-0.0250, +0.0067] |
| fanout_delivery_mean_us | 67628.8 | 26330.7 | -43268.0 | [-46080.9, -40455.2] |
| fanout_delivery_p50_us | 65902.3 | 25965.5 | -45100.3 | [-48965.1, -41235.4] |
| fanout_delivery_p90_us | 104889.2 | 33593.7 | -76768.7 | [-82315.6, -71221.7] |
| fanout_delivery_p99_us | 113716.1 | 39047.7 | -80841.3 | [-87179.2, -74503.4] |
| fanout_delivery_p999_us | 116820.9 | 40398.0 | -82931.4 | [-89394.9, -76467.9] |
| fanout_delivery_max_us | 119610.2 | 40483.2 | -82708.2 | [-89175.6, -76240.7] |
| client_wall_s | 2.1094 | 2.0715 | -0.0382 | [-0.0800, +0.0035] |
| client_cpu_s | 1.5759 | 1.5598 | -0.0122 | [-0.0482, +0.0239] |
| broker_user_s | 0.5604 | 0.5372 | -0.0229 | [-0.0437, -0.0022] |
| broker_sys_s | 0.6510 | 0.6468 | -0.0056 | [-0.0259, +0.0146] |
| broker_cpu_s | 1.2125 | 1.1810 | -0.0286 | [-0.0552, -0.0020] |
| broker_vcsw | 13647.0 | 13516.5 | -135.4 | [-327.0, +56.2] |
| broker_maxrss_kib | 6376 | 5084 | -1234 | [-1287, -1182] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
