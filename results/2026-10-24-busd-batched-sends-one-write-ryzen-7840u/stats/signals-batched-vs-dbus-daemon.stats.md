candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8822 | 0.3015 | -65.83 | [-66.08, -65.58] | [-66.03, -65.62] | 0.342 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2457 | 0.3647 | -70.72 | [-70.92, -70.49] | [-70.89, -70.53] | 0.291 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1615 | 0.7228 | -66.56 | [-66.74, -66.38] | [-66.71, -66.41] | 0.334 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2892 | 0.6687 | -48.13 | [-48.41, -47.83] | [-48.37, -47.88] | 0.518 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 20165.1 | 45.1 | -99.78 | [-99.79, -99.77] | [-99.78, -99.77] | 0.002 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5883 | 0.3525 | -40.08 | [-40.73, -39.44] | [-40.64, -39.54] | 0.603 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.2195 | 0.0912 | -92.52 | [-92.66, -92.39] | [-92.64, -92.41] | 0.074 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7252 | 0.2329 | -67.89 | [-68.44, -67.31] | [-68.35, -67.41] | 0.320 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.4119 | 0.1306 | -90.75 | [-90.94, -90.55] | [-90.91, -90.59] | 0.093 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.1371 | 0.3635 | -82.99 | [-83.10, -82.89] | [-83.08, -82.90] | 0.169 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 16.317 | 672.333 | +4020.53 | [+3785.26, +4230.05] | [+3823.44, +4198.96] | 42.720 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5602 | 6598 | +17.77 | [+16.81, +18.71] | [+16.95, +18.56] | 1.183 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20527 | 20527 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8770 | 0.2999 | -0.5807 | [-0.5853, -0.5761] |
| multi_s | 1.2448 | 0.3633 | -0.8810 | [-0.8851, -0.8768] |
| client_wall_s | 2.1580 | 0.7227 | -1.4387 | [-1.4454, -1.4320] |
| client_cpu_s | 1.2905 | 0.6668 | -0.6205 | [-0.6259, -0.6151] |
| client_vcsw | 20136.0 | 45.5 | -20120.0 | [-20267.1, -19972.8] |
| multi_client_cpu_s | 0.5900 | 0.3500 | -0.2358 | [-0.2410, -0.2306] |
| multi_broker_cpu_s | 1.2200 | 0.0900 | -1.1283 | [-1.1321, -1.1245] |
| broker_user_s | 0.7227 | 0.2306 | -0.4923 | [-0.5005, -0.4842] |
| broker_sys_s | 1.4137 | 0.1317 | -1.2813 | [-1.2893, -1.2733] |
| broker_cpu_s | 2.1328 | 0.3623 | -1.7736 | [-1.7796, -1.7677] |
| broker_vcsw | 16.000 | 681.000 | +656.017 | [+641.437, +670.597] |
| broker_maxrss_kib | 5570 | 6614 | +996 | [+944, +1047] |
| broker_ru_maxrss_kib | 20572 | 20572 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
