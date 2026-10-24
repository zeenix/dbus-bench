candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9409 | 0.9484 | +0.79 | [-0.69, +2.31] | [-0.45, +2.04] | 1.006 | 0.2993 | no material change |
| single_rtt_mean_us | 60 | 188.1 | 189.6 | +0.80 | [-0.69, +2.31] | [-0.45, +2.04] | 1.006 | 0.2959 | no material change |
| single_rtt_p50_us | 60 | 177.4 | 178.4 | +0.56 | [-1.02, +2.21] | [-0.76, +1.91] | 1.002 | 0.5809 | no material change |
| single_rtt_p90_us | 60 | 224.8 | 224.9 | +0.06 | [-1.69, +1.85] | [-1.40, +1.55] | 1.001 | 0.9765 | no material change |
| single_rtt_p99_us | 60 | 324.6 | 324.7 | +0.03 | [-3.59, +3.87] | [-3.00, +3.15] | 0.985 | 0.7128 | no material change |
| single_rtt_p999_us | 60 | 865.9 | 908.5 | +4.92 | [-10.64, +24.08] | [-8.25, +19.96] | 1.021 | 0.9004 | inconclusive |
| single_rtt_max_us | 60 | 3025.0 | 3334.7 | +10.24 | [-27.83, +62.43] | [-22.67, +53.93] | 1.048 | 0.3652 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7869 | 0.8068 | +2.53 | [-0.52, +5.58] | [-0.01, +5.08] | 1.035 | 0.0701 | inconclusive |
| multi_rtt_mean_us | 60 | 762.5 | 781.7 | +2.51 | [-0.59, +5.63] | [-0.07, +5.10] | 1.038 | 0.0798 | inconclusive |
| multi_rtt_p50_us | 60 | 716.3 | 737.4 | +2.95 | [+0.21, +5.76] | [+0.65, +5.32] | 1.033 | 0.0293 | inconclusive; repeatable change (+) |
| multi_rtt_p90_us | 60 | 1039.9 | 1057.3 | +1.68 | [-2.87, +6.23] | [-2.09, +5.51] | 1.040 | 0.3386 | inconclusive |
| multi_rtt_p99_us | 60 | 1548.8 | 1616.6 | +4.37 | [-2.70, +12.02] | [-1.62, +10.65] | 0.989 | 0.4013 | inconclusive |
| multi_rtt_p999_us | 60 | 2994.8 | 3253.7 | +8.64 | [-9.17, +29.74] | [-6.50, +25.95] | 1.121 | 0.4572 | inconclusive |
| multi_rtt_max_us | 60 | 4277.7 | 4776.0 | +11.65 | [-14.52, +45.67] | [-10.69, +40.05] | 1.063 | 0.5219 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3047 | 0.2682 | -11.98 | [-15.90, -7.92] | [-15.30, -8.65] | 0.886 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 27093.4 | 28546.3 | +5.36 | [+0.22, +10.66] | [+0.99, +9.82] | 1.046 | 0.0346 | inconclusive; repeatable change (+) |
| fanout_delivery_p50_us | 60 | 26823.6 | 28476.5 | +6.16 | [+1.05, +11.39] | [+1.89, +10.47] | 1.072 | 0.0084 | inconclusive; repeatable change (+) |
| fanout_delivery_p90_us | 60 | 34879.1 | 37533.5 | +7.61 | [-0.01, +15.77] | [+1.17, +14.35] | 1.059 | 0.0947 | inconclusive |
| fanout_delivery_p99_us | 60 | 39544.9 | 43456.2 | +9.89 | [+1.57, +18.65] | [+2.94, +17.32] | 1.121 | 0.0502 | inconclusive; repeatable change (+) |
| fanout_delivery_p999_us | 60 | 40732.9 | 45464.0 | +11.61 | [+3.07, +20.66] | [+4.57, +19.15] | 1.131 | 0.0229 | inconclusive; repeatable change (+) |
| fanout_delivery_max_us | 60 | 41930.0 | 46216.3 | +10.22 | [+2.08, +18.73] | [+3.41, +17.37] | 1.140 | 0.0299 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 2.0535 | 2.0424 | -0.54 | [-2.08, +0.99] | [-1.83, +0.74] | 0.991 | 0.5859 | no material change |
| client_cpu_s | 60 | 1.5500 | 1.5295 | -1.32 | [-3.04, +0.46] | [-2.79, +0.15] | 0.981 | 0.1186 | no material change |
| broker_user_s | 60 | 0.5449 | 0.5295 | -2.84 | [-5.55, -0.05] | [-5.15, -0.50] | 0.975 | 0.1135 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.6359 | 0.6192 | -2.64 | [-5.33, +0.17] | [-4.92, -0.30] | 0.963 | 0.0566 | no material change |
| broker_cpu_s | 60 | 1.1808 | 1.1486 | -2.73 | [-4.61, -0.84] | [-4.29, -1.16] | 0.978 | 0.0151 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 13285.0 | 13209.1 | -0.57 | [-2.03, +0.90] | [-1.80, +0.67] | 0.993 | 0.4395 | no material change |
| broker_maxrss_kib | 60 | 5079 | 5112 | +0.67 | [+0.10, +1.25] | [+0.19, +1.16] | 1.005 | 0.0425 | no material change; repeatable change (+) |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9380 | 0.9543 | +0.0075 | [-0.0068, +0.0217] |
| single_rtt_mean_us | 187.5 | 190.8 | +1.5 | [-1.4, +4.3] |
| single_rtt_p50_us | 176.4 | 178.6 | +1.0 | [-1.9, +3.9] |
| single_rtt_p90_us | 224.7 | 225.4 | +0.1 | [-3.9, +4.2] |
| single_rtt_p99_us | 318.6 | 325.1 | +0.1 | [-12.0, +12.2] |
| single_rtt_p999_us | 819.9 | 813.4 | +42.6 | [-105.6, +190.8] |
| single_rtt_max_us | 2312.8 | 2426.7 | +309.7 | [-1058.4, +1677.8] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7867 | 0.8025 | +0.0199 | [-0.0043, +0.0441] |
| multi_rtt_mean_us | 765.1 | 782.8 | +19.2 | [-4.6, +42.9] |
| multi_rtt_p50_us | 717.1 | 735.9 | +21.2 | [+0.9, +41.4] |
| multi_rtt_p90_us | 1043.5 | 1072.4 | +17.4 | [-30.1, +64.9] |
| multi_rtt_p99_us | 1539.2 | 1578.5 | +67.8 | [-44.8, +180.3] |
| multi_rtt_p999_us | 2567.7 | 2874.4 | +258.9 | [-312.4, +830.2] |
| multi_rtt_max_us | 3509.3 | 3645.1 | +498.3 | [-762.9, +1759.4] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2971 | 0.2579 | -0.0365 | [-0.0499, -0.0231] |
| fanout_delivery_mean_us | 26448.1 | 27668.2 | +1452.9 | [+18.1, +2887.7] |
| fanout_delivery_p50_us | 26643.3 | 27557.7 | +1652.9 | [+273.1, +3032.8] |
| fanout_delivery_p90_us | 33267.7 | 34582.1 | +2654.5 | [-100.2, +5409.2] |
| fanout_delivery_p99_us | 37934.3 | 38993.9 | +3911.3 | [+555.1, +7267.5] |
| fanout_delivery_p999_us | 40606.9 | 41790.7 | +4731.1 | [+1214.5, +8247.7] |
| fanout_delivery_max_us | 40699.3 | 42810.6 | +4286.2 | [+843.6, +7728.9] |
| client_wall_s | 2.0530 | 2.0475 | -0.0112 | [-0.0434, +0.0211] |
| client_cpu_s | 1.5451 | 1.5171 | -0.0205 | [-0.0487, +0.0076] |
| broker_user_s | 0.5460 | 0.5302 | -0.0155 | [-0.0313, +0.0004] |
| broker_sys_s | 0.6370 | 0.6194 | -0.0168 | [-0.0352, +0.0017] |
| broker_cpu_s | 1.1842 | 1.1402 | -0.0322 | [-0.0552, -0.0092] |
| broker_vcsw | 13340.5 | 13251.5 | -75.9 | [-278.1, +126.4] |
| broker_maxrss_kib | 5084 | 5128 | +34 | [+4, +64] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
