candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9436 | 0.9484 | +0.50 | [-1.07, +2.10] | [-0.84, +1.80] | 1.008 | 0.4439 | no material change |
| single_rtt_mean_us | 60 | 188.6 | 189.6 | +0.50 | [-1.07, +2.10] | [-0.84, +1.80] | 1.008 | 0.4483 | no material change |
| single_rtt_p50_us | 60 | 177.9 | 178.4 | +0.28 | [-1.54, +2.07] | [-1.23, +1.79] | 0.998 | 0.8713 | no material change |
| single_rtt_p90_us | 60 | 224.5 | 224.9 | +0.18 | [-1.73, +2.09] | [-1.42, +1.80] | 1.001 | 0.8424 | no material change |
| single_rtt_p99_us | 60 | 324.6 | 324.7 | +0.06 | [-3.48, +3.67] | [-2.94, +3.05] | 0.991 | 0.7853 | no material change |
| single_rtt_p999_us | 60 | 945.3 | 908.5 | -3.89 | [-17.80, +11.72] | [-15.85, +9.22] | 0.909 | 0.1619 | inconclusive |
| single_rtt_max_us | 60 | 2820.1 | 3334.7 | +18.25 | [-10.82, +60.53] | [-7.46, +52.40] | 1.031 | 0.5758 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.8029 | 0.8068 | +0.48 | [-2.57, +3.63] | [-2.11, +3.11] | 1.013 | 0.6534 | no material change |
| multi_rtt_mean_us | 60 | 780.4 | 781.7 | +0.17 | [-2.95, +3.35] | [-2.46, +2.83] | 1.009 | 0.8024 | no material change |
| multi_rtt_p50_us | 60 | 729.8 | 737.4 | +1.05 | [-2.15, +4.24] | [-1.64, +3.75] | 1.008 | 0.2759 | no material change |
| multi_rtt_p90_us | 60 | 1059.2 | 1057.3 | -0.18 | [-4.63, +4.48] | [-3.93, +3.74] | 1.013 | 0.7797 | no material change |
| multi_rtt_p99_us | 60 | 1590.2 | 1616.6 | +1.66 | [-3.72, +7.35] | [-2.96, +6.36] | 1.007 | 0.8655 | inconclusive |
| multi_rtt_p999_us | 60 | 3035.1 | 3253.7 | +7.20 | [-8.63, +25.79] | [-6.25, +22.87] | 0.974 | 0.6694 | inconclusive |
| multi_rtt_max_us | 60 | 4447.2 | 4776.0 | +7.39 | [-15.40, +39.35] | [-12.36, +33.22] | 0.986 | 0.9062 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3138 | 0.2682 | -14.54 | [-17.97, -11.04] | [-17.43, -11.60] | 0.870 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 68425.1 | 28546.3 | -58.28 | [-60.18, -56.36] | [-59.87, -56.70] | 0.416 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 68686.6 | 28476.5 | -58.54 | [-60.37, -56.70] | [-60.09, -56.98] | 0.424 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 107431.5 | 37533.5 | -65.06 | [-67.11, -62.96] | [-66.80, -63.30] | 0.335 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 118196.8 | 43456.2 | -63.23 | [-65.43, -60.99] | [-65.11, -61.35] | 0.357 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 121977.5 | 45464.0 | -62.73 | [-64.99, -60.43] | [-64.62, -60.79] | 0.357 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 123315.8 | 46216.3 | -62.52 | [-64.85, -60.16] | [-64.47, -60.54] | 0.365 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.0795 | 2.0424 | -1.78 | [-3.51, -0.05] | [-3.23, -0.33] | 0.973 | 0.0538 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 1.5642 | 1.5295 | -2.22 | [-4.02, -0.33] | [-3.74, -0.64] | 0.973 | 0.0225 | no material change; repeatable change (-) |
| broker_user_s | 60 | 0.5585 | 0.5295 | -5.20 | [-8.02, -2.41] | [-7.56, -2.86] | 0.971 | 0.0017 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.6470 | 0.6192 | -4.30 | [-7.05, -1.48] | [-6.60, -1.97] | 0.958 | 0.0071 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 1.2055 | 1.1486 | -4.72 | [-6.69, -2.73] | [-6.39, -3.04] | 0.955 | <0.0001 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 13482.2 | 13209.1 | -2.03 | [-3.37, -0.61] | [-3.15, -0.86] | 0.974 | 0.0058 | no material change; repeatable change (-) |
| broker_maxrss_kib | 60 | 6309 | 5112 | -18.97 | [-19.55, -18.37] | [-19.46, -18.47] | 0.809 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9446 | 0.9543 | +0.0047 | [-0.0103, +0.0198] |
| single_rtt_mean_us | 188.8 | 190.8 | +0.9 | [-2.1, +4.0] |
| single_rtt_p50_us | 177.6 | 178.6 | +0.5 | [-2.7, +3.7] |
| single_rtt_p90_us | 225.1 | 225.4 | +0.4 | [-4.0, +4.8] |
| single_rtt_p99_us | 318.4 | 325.1 | +0.2 | [-11.6, +12.0] |
| single_rtt_p999_us | 838.8 | 813.4 | -36.8 | [-183.4, +109.7] |
| single_rtt_max_us | 2201.3 | 2426.7 | +514.5 | [-491.2, +1520.3] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.8022 | 0.8025 | +0.0039 | [-0.0216, +0.0293] |
| multi_rtt_mean_us | 780.3 | 782.8 | +1.3 | [-23.7, +26.3] |
| multi_rtt_p50_us | 729.6 | 735.9 | +7.6 | [-16.2, +31.5] |
| multi_rtt_p90_us | 1078.6 | 1072.4 | -2.0 | [-51.4, +47.5] |
| multi_rtt_p99_us | 1554.9 | 1578.5 | +26.4 | [-63.6, +116.3] |
| multi_rtt_p999_us | 2799.0 | 2874.4 | +218.6 | [-297.9, +735.2] |
| multi_rtt_max_us | 3928.7 | 3645.1 | +328.7 | [-889.3, +1546.8] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3074 | 0.2579 | -0.0456 | [-0.0576, -0.0337] |
| fanout_delivery_mean_us | 65926.6 | 27668.2 | -39878.8 | [-42292.2, -37465.3] |
| fanout_delivery_p50_us | 66697.5 | 27557.7 | -40210.1 | [-42658.2, -37762.0] |
| fanout_delivery_p90_us | 102991.1 | 34582.1 | -69898.0 | [-74232.7, -65563.3] |
| fanout_delivery_p99_us | 112528.8 | 38993.9 | -74740.6 | [-79550.6, -69930.7] |
| fanout_delivery_p999_us | 117300.5 | 41790.7 | -76513.4 | [-81530.1, -71496.8] |
| fanout_delivery_max_us | 117450.3 | 42810.6 | -77099.5 | [-82299.5, -71899.5] |
| client_wall_s | 2.0746 | 2.0475 | -0.0371 | [-0.0738, -0.0004] |
| client_cpu_s | 1.5565 | 1.5171 | -0.0347 | [-0.0648, -0.0046] |
| broker_user_s | 0.5491 | 0.5302 | -0.0290 | [-0.0454, -0.0127] |
| broker_sys_s | 0.6454 | 0.6194 | -0.0278 | [-0.0466, -0.0090] |
| broker_cpu_s | 1.1991 | 1.1402 | -0.0569 | [-0.0818, -0.0319] |
| broker_vcsw | 13499.0 | 13251.5 | -273.1 | [-467.3, -79.0] |
| broker_maxrss_kib | 6338 | 5128 | -1197 | [-1241, -1152] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
