candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9048 | 0.9078 | +0.33 | [-1.15, +1.89] | [-0.92, +1.64] | 0.998 | 0.9121 | no material change |
| single_rtt_mean_us | 60 | 180.9 | 181.5 | +0.33 | [-1.15, +1.89] | [-0.92, +1.64] | 0.998 | 0.9121 | no material change |
| single_rtt_p50_us | 60 | 171.0 | 170.6 | -0.23 | [-1.73, +1.37] | [-1.51, +1.09] | 0.998 | 0.5683 | no material change |
| single_rtt_p90_us | 60 | 217.4 | 214.2 | -1.47 | [-3.38, +0.63] | [-3.09, +0.28] | 0.981 | 0.0547 | no material change |
| single_rtt_p99_us | 60 | 307.8 | 301.9 | -1.94 | [-6.82, +4.32] | [-6.24, +3.12] | 0.952 | 0.0252 | inconclusive |
| single_rtt_p999_us | 60 | 975.2 | 797.1 | -18.26 | [-32.40, -1.53] | [-30.40, -4.31] | 0.863 | 0.0353 | inconclusive; repeatable change (-) |
| single_rtt_max_us | 60 | 3747.5 | 2224.5 | -40.64 | [-63.07, -10.31] | [-60.05, -13.76] | 0.718 | 0.0080 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.2845 | 0.7370 | -42.63 | [-44.29, -40.93] | [-44.05, -41.19] | 0.570 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1243.1 | 712.0 | -42.72 | [-44.42, -41.01] | [-44.16, -41.27] | 0.572 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1206.2 | 686.5 | -43.09 | [-44.43, -41.70] | [-44.21, -41.94] | 0.568 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1714.9 | 914.4 | -46.68 | [-49.18, -44.08] | [-48.80, -44.52] | 0.531 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2508.6 | 1379.8 | -45.00 | [-48.39, -41.28] | [-47.84, -41.87] | 0.567 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3890.1 | 2604.3 | -33.05 | [-41.73, -22.48] | [-40.45, -24.40] | 0.642 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 5226.9 | 3739.7 | -28.45 | [-42.19, -11.05] | [-40.25, -14.00] | 0.626 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.1174 | 0.2961 | +152.32 | [+134.47, +169.43] | [+137.47, +166.65] | 2.591 | <0.0001 | slower/larger |
| fanout_delivery_mean_us | 60 | 9778.5 | 17345.6 | +77.39 | [+55.37, +102.31] | [+58.87, +98.28] | 1.899 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 6535.3 | 16526.9 | +152.89 | [+115.48, +194.09] | [+121.20, +187.49] | 2.838 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 22537.4 | 28326.2 | +25.69 | [+9.57, +45.95] | [+11.69, +42.13] | 1.384 | 0.0020 | slower/larger |
| fanout_delivery_p99_us | 60 | 37151.2 | 37178.6 | +0.07 | [-11.82, +13.34] | [-10.04, +11.13] | 1.017 | 0.7628 | inconclusive |
| fanout_delivery_p999_us | 60 | 42499.1 | 39630.0 | -6.75 | [-16.90, +3.93] | [-15.39, +2.27] | 0.892 | 0.3731 | inconclusive |
| fanout_delivery_max_us | 60 | 44149.0 | 40444.8 | -8.39 | [-18.08, +1.84] | [-16.62, +0.23] | 0.880 | 0.2632 | inconclusive |
| client_wall_s | 60 | 2.3404 | 1.9775 | -15.51 | [-17.11, -13.94] | [-16.84, -14.18] | 0.849 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.2046 | 1.8239 | -17.27 | [-19.05, -15.54] | [-18.79, -15.83] | 0.830 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2483 | 0.5112 | +105.87 | [+99.03, +113.28] | [+100.03, +112.11] | 2.053 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.6959 | 0.7684 | +10.43 | [+6.16, +14.71] | [+6.76, +14.01] | 1.127 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.9442 | 1.2796 | +35.53 | [+32.10, +39.01] | [+32.60, +38.43] | 1.363 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 52594.1 | 13559.0 | -74.22 | [-74.72, -73.70] | [-74.64, -73.78] | 0.255 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 10079 | 5040 | -49.99 | [-52.00, -47.93] | [-51.68, -48.26] | 0.522 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9010 | 0.9092 | +0.0030 | [-0.0112, +0.0171] |
| single_rtt_mean_us | 180.1 | 181.8 | +0.6 | [-2.2, +3.4] |
| single_rtt_p50_us | 170.1 | 171.1 | -0.4 | [-3.2, +2.4] |
| single_rtt_p90_us | 216.0 | 213.4 | -3.2 | [-7.7, +1.4] |
| single_rtt_p99_us | 303.7 | 290.1 | -6.0 | [-23.7, +11.8] |
| single_rtt_p999_us | 852.8 | 687.9 | -178.1 | [-349.2, -7.1] |
| single_rtt_max_us | 2472.8 | 1870.1 | -1523.1 | [-3362.7, +316.6] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.2734 | 0.7390 | -0.5476 | [-0.5776, -0.5175] |
| multi_rtt_mean_us | 1230.6 | 714.5 | -531.1 | [-560.6, -501.6] |
| multi_rtt_p50_us | 1194.1 | 669.7 | -519.7 | [-543.2, -496.2] |
| multi_rtt_p90_us | 1675.2 | 914.1 | -800.4 | [-861.0, -739.9] |
| multi_rtt_p99_us | 2495.8 | 1327.0 | -1128.8 | [-1249.2, -1008.3] |
| multi_rtt_p999_us | 3694.9 | 2267.5 | -1285.9 | [-1718.6, -853.1] |
| multi_rtt_max_us | 4877.1 | 3010.6 | -1487.2 | [-2431.2, -543.2] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.1135 | 0.2994 | +0.1788 | [+0.1598, +0.1977] |
| fanout_delivery_mean_us | 8954.0 | 17718.0 | +7567.2 | [+5971.4, +9163.0] |
| fanout_delivery_p50_us | 5437.6 | 17370.6 | +9991.7 | [+8502.5, +11480.8] |
| fanout_delivery_p90_us | 20522.0 | 28449.7 | +5788.9 | [+2286.8, +9290.9] |
| fanout_delivery_p99_us | 34998.7 | 36713.8 | +27.4 | [-4867.5, +4922.3] |
| fanout_delivery_p999_us | 41016.7 | 38929.8 | -2869.0 | [-7758.2, +2020.1] |
| fanout_delivery_max_us | 41624.3 | 39365.5 | -3704.2 | [-8618.8, +1210.4] |
| client_wall_s | 2.3349 | 1.9682 | -0.3629 | [-0.4038, -0.3220] |
| client_cpu_s | 2.1960 | 1.8173 | -0.3807 | [-0.4238, -0.3376] |
| broker_user_s | 0.2462 | 0.5090 | +0.2629 | [+0.2506, +0.2752] |
| broker_sys_s | 0.6985 | 0.7664 | +0.0726 | [+0.0424, +0.1027] |
| broker_cpu_s | 0.9387 | 1.2662 | +0.3355 | [+0.3045, +0.3664] |
| broker_vcsw | 52594.5 | 13575.0 | -39035.1 | [-39962.1, -38108.1] |
| broker_maxrss_kib | 9814 | 5072 | -5039 | [-5454, -4623] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
