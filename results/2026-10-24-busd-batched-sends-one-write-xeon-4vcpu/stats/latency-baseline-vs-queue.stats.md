candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9436 | 0.9409 | -0.29 | [-1.65, +1.08] | [-1.44, +0.87] | 0.993 | 0.6587 | no material change |
| single_rtt_mean_us | 60 | 188.6 | 188.1 | -0.29 | [-1.65, +1.08] | [-1.44, +0.86] | 0.993 | 0.6587 | no material change |
| single_rtt_p50_us | 60 | 177.9 | 177.4 | -0.28 | [-1.65, +1.09] | [-1.44, +0.88] | 0.999 | 0.6910 | no material change |
| single_rtt_p90_us | 60 | 224.5 | 224.8 | +0.12 | [-1.52, +1.84] | [-1.27, +1.54] | 0.991 | 0.9238 | no material change |
| single_rtt_p99_us | 60 | 324.6 | 324.6 | +0.03 | [-3.14, +3.26] | [-2.63, +2.73] | 1.002 | 0.9941 | no material change |
| single_rtt_p999_us | 60 | 945.3 | 865.9 | -8.40 | [-21.12, +5.80] | [-19.07, +3.65] | 1.021 | 0.3931 | inconclusive |
| single_rtt_max_us | 60 | 2820.1 | 3025.0 | +7.26 | [-22.49, +52.49] | [-19.16, +43.94] | 1.032 | 0.9413 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.8029 | 0.7869 | -2.00 | [-4.70, +0.84] | [-4.27, +0.38] | 0.969 | 0.1732 | no material change |
| multi_rtt_mean_us | 60 | 780.4 | 762.5 | -2.29 | [-5.01, +0.59] | [-4.58, +0.10] | 0.965 | 0.1204 | no material change |
| multi_rtt_p50_us | 60 | 729.8 | 716.3 | -1.85 | [-4.62, +0.99] | [-4.18, +0.54] | 0.985 | 0.3062 | no material change |
| multi_rtt_p90_us | 60 | 1059.2 | 1039.9 | -1.83 | [-5.43, +2.03] | [-4.85, +1.39] | 0.959 | 0.3386 | no material change |
| multi_rtt_p99_us | 60 | 1590.2 | 1548.8 | -2.60 | [-8.76, +3.97] | [-7.84, +2.84] | 0.982 | 0.3810 | inconclusive |
| multi_rtt_p999_us | 60 | 3035.1 | 2994.8 | -1.33 | [-15.05, +14.62] | [-12.92, +12.02] | 0.985 | 0.8829 | inconclusive |
| multi_rtt_max_us | 60 | 4447.2 | 4277.7 | -3.81 | [-21.95, +18.85] | [-19.39, +14.72] | 0.935 | 0.6063 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3138 | 0.3047 | -2.91 | [-7.08, +1.45] | [-6.36, +0.77] | 0.948 | 0.1221 | inconclusive |
| fanout_delivery_mean_us | 60 | 68425.1 | 27093.4 | -60.40 | [-62.28, -58.47] | [-61.96, -58.80] | 0.388 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 68686.6 | 26823.6 | -60.95 | [-62.86, -58.86] | [-62.55, -59.25] | 0.385 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 107431.5 | 34879.1 | -67.53 | [-69.40, -65.62] | [-69.09, -65.92] | 0.315 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 118196.8 | 39544.9 | -66.54 | [-68.57, -64.44] | [-68.25, -64.81] | 0.332 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 121977.5 | 40732.9 | -66.61 | [-68.65, -64.48] | [-68.31, -64.85] | 0.333 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 123315.8 | 41930.0 | -66.00 | [-68.06, -63.89] | [-67.73, -64.20] | 0.338 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.0795 | 2.0535 | -1.25 | [-2.67, +0.24] | [-2.45, +0.01] | 0.985 | 0.1450 | no material change |
| client_cpu_s | 60 | 1.5642 | 1.5500 | -0.91 | [-2.64, +0.88] | [-2.37, +0.59] | 0.995 | 0.3891 | no material change |
| broker_user_s | 60 | 0.5585 | 0.5449 | -2.43 | [-5.21, +0.32] | [-4.76, -0.14] | 0.982 | 0.2330 | no material change |
| broker_sys_s | 60 | 0.6470 | 0.6359 | -1.71 | [-4.96, +1.62] | [-4.40, +1.06] | 0.982 | 0.3575 | no material change |
| broker_cpu_s | 60 | 1.2055 | 1.1808 | -2.05 | [-3.92, -0.16] | [-3.62, -0.47] | 0.996 | 0.0836 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 13482.2 | 13285.0 | -1.46 | [-3.00, +0.16] | [-2.78, -0.12] | 0.985 | 0.0668 | no material change |
| broker_maxrss_kib | 60 | 6309 | 5079 | -19.50 | [-20.14, -18.85] | [-20.03, -18.95] | 0.802 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9446 | 0.9380 | -0.0027 | [-0.0162, +0.0107] |
| single_rtt_mean_us | 188.8 | 187.5 | -0.6 | [-3.2, +2.1] |
| single_rtt_p50_us | 177.6 | 176.4 | -0.5 | [-3.1, +2.1] |
| single_rtt_p90_us | 225.1 | 224.7 | +0.3 | [-3.6, +4.2] |
| single_rtt_p99_us | 318.4 | 318.6 | +0.1 | [-10.6, +10.8] |
| single_rtt_p999_us | 838.8 | 819.9 | -79.4 | [-216.1, +57.2] |
| single_rtt_max_us | 2201.3 | 2312.8 | +204.9 | [-874.4, +1284.2] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.8022 | 0.7867 | -0.0161 | [-0.0393, +0.0071] |
| multi_rtt_mean_us | 780.3 | 765.1 | -17.9 | [-40.6, +4.8] |
| multi_rtt_p50_us | 729.6 | 717.1 | -13.5 | [-34.7, +7.7] |
| multi_rtt_p90_us | 1078.6 | 1043.5 | -19.4 | [-60.6, +21.8] |
| multi_rtt_p99_us | 1554.9 | 1539.2 | -41.4 | [-146.8, +64.1] |
| multi_rtt_p999_us | 2799.0 | 2567.7 | -40.3 | [-505.6, +425.1] |
| multi_rtt_max_us | 3928.7 | 3509.3 | -169.5 | [-1109.1, +770.1] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3074 | 0.2971 | -0.0091 | [-0.0230, +0.0048] |
| fanout_delivery_mean_us | 65926.6 | 26448.1 | -41331.7 | [-43873.7, -38789.7] |
| fanout_delivery_p50_us | 66697.5 | 26643.3 | -41863.0 | [-44455.8, -39270.3] |
| fanout_delivery_p90_us | 102991.1 | 33267.7 | -72552.5 | [-77034.7, -68070.3] |
| fanout_delivery_p99_us | 112528.8 | 37934.3 | -78651.9 | [-83590.7, -73713.1] |
| fanout_delivery_p999_us | 117300.5 | 40606.9 | -81244.6 | [-86370.8, -76118.3] |
| fanout_delivery_max_us | 117450.3 | 40699.3 | -81385.7 | [-86631.4, -76140.1] |
| client_wall_s | 2.0746 | 2.0530 | -0.0259 | [-0.0577, +0.0058] |
| client_cpu_s | 1.5565 | 1.5451 | -0.0142 | [-0.0428, +0.0145] |
| broker_user_s | 0.5491 | 0.5460 | -0.0136 | [-0.0299, +0.0027] |
| broker_sys_s | 0.6454 | 0.6370 | -0.0111 | [-0.0328, +0.0107] |
| broker_cpu_s | 1.1991 | 1.1842 | -0.0247 | [-0.0478, -0.0015] |
| broker_vcsw | 13499.0 | 13340.5 | -197.2 | [-417.9, +23.4] |
| broker_maxrss_kib | 6338 | 5084 | -1230 | [-1278, -1183] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
