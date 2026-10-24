candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8822 | 0.3237 | -63.30 | [-63.58, -63.02] | [-63.54, -63.07] | 0.366 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2457 | 0.3909 | -68.62 | [-68.86, -68.36] | [-68.82, -68.41] | 0.312 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1615 | 0.7725 | -64.26 | [-64.48, -64.04] | [-64.44, -64.08] | 0.357 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2892 | 0.7113 | -44.83 | [-45.16, -44.48] | [-45.10, -44.54] | 0.549 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 20165.1 | 125.6 | -99.38 | [-99.40, -99.35] | [-99.40, -99.36] | 0.006 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5883 | 0.3783 | -35.69 | [-36.31, -35.08] | [-36.20, -35.18] | 0.644 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.2195 | 0.2100 | -82.78 | [-82.94, -82.60] | [-82.92, -82.63] | 0.172 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7252 | 0.2792 | -61.50 | [-62.07, -60.89] | [-61.98, -61.00] | 0.383 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.4119 | 0.2529 | -82.09 | [-82.30, -81.88] | [-82.27, -81.91] | 0.178 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.1371 | 0.5321 | -75.10 | [-75.22, -74.98] | [-75.20, -75.00] | 0.248 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 16.317 | 376.733 | +2208.89 | [+2073.10, +2328.21] | [+2095.01, +2311.78] | 24.402 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5602 | 6578 | +17.42 | [+16.52, +18.25] | [+16.67, +18.13] | 1.187 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20527 | 20529 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8770 | 0.3231 | -0.5585 | [-0.5630, -0.5539] |
| multi_s | 1.2448 | 0.3875 | -0.8548 | [-0.8592, -0.8504] |
| client_wall_s | 2.1580 | 0.7705 | -1.3890 | [-1.3962, -1.3818] |
| client_cpu_s | 1.2905 | 0.7076 | -0.5779 | [-0.5837, -0.5721] |
| client_vcsw | 20136.0 | 129.5 | -20039.5 | [-20186.3, -19892.6] |
| multi_client_cpu_s | 0.5900 | 0.3800 | -0.2100 | [-0.2147, -0.2053] |
| multi_broker_cpu_s | 1.2200 | 0.2100 | -1.0095 | [-1.0136, -1.0054] |
| broker_user_s | 0.7227 | 0.2808 | -0.4460 | [-0.4538, -0.4381] |
| broker_sys_s | 1.4137 | 0.2519 | -1.1590 | [-1.1663, -1.1518] |
| broker_cpu_s | 2.1328 | 0.5310 | -1.6050 | [-1.6111, -1.5989] |
| broker_vcsw | 16.000 | 375.000 | +360.417 | [+351.939, +368.894] |
| broker_maxrss_kib | 5570 | 6588 | +976 | [+930, +1022] |
| broker_ru_maxrss_kib | 20572 | 20572 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
