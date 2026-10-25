candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3237 | 0.3015 | -6.87 | [-7.63, -6.08] | [-7.52, -6.21] | 0.929 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3909 | 0.3647 | -6.69 | [-7.64, -5.76] | [-7.48, -5.92] | 0.939 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.7725 | 0.7228 | -6.43 | [-7.10, -5.78] | [-6.99, -5.88] | 0.938 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.7113 | 0.6687 | -5.99 | [-6.69, -5.29] | [-6.57, -5.40] | 0.945 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 125.6 | 45.1 | -64.09 | [-66.27, -61.77] | [-65.95, -62.16] | 0.344 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3783 | 0.3525 | -6.83 | [-7.90, -5.80] | [-7.72, -5.96] | 0.946 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2100 | 0.0912 | -56.59 | [-57.44, -55.73] | [-57.32, -55.87] | 0.429 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2792 | 0.2329 | -16.60 | [-17.98, -15.15] | [-17.77, -15.38] | 0.831 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2529 | 0.1306 | -48.35 | [-49.51, -47.18] | [-49.33, -47.36] | 0.528 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5321 | 0.3635 | -31.69 | [-32.19, -31.20] | [-32.12, -31.27] | 0.684 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 376.7 | 672.3 | +78.46 | [+72.95, +84.44] | [+73.74, +83.37] | 1.793 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6578 | 6598 | +0.30 | [-0.29, +0.87] | [-0.19, +0.79] | 0.999 | 0.2889 | no material change |
| broker_ru_maxrss_kib | 60 | 20529 | 20527 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3231 | 0.2999 | -0.0222 | [-0.0250, -0.0195] |
| multi_s | 0.3875 | 0.3633 | -0.0262 | [-0.0301, -0.0222] |
| client_wall_s | 0.7705 | 0.7227 | -0.0497 | [-0.0552, -0.0442] |
| client_cpu_s | 0.7076 | 0.6668 | -0.0426 | [-0.0479, -0.0373] |
| client_vcsw | 129.5 | 45.5 | -80.5 | [-86.2, -74.8] |
| multi_client_cpu_s | 0.3800 | 0.3500 | -0.0258 | [-0.0300, -0.0217] |
| multi_broker_cpu_s | 0.2100 | 0.0900 | -0.1188 | [-0.1214, -0.1162] |
| broker_user_s | 0.2808 | 0.2306 | -0.0464 | [-0.0509, -0.0419] |
| broker_sys_s | 0.2519 | 0.1317 | -0.1223 | [-0.1262, -0.1183] |
| broker_cpu_s | 0.5310 | 0.3623 | -0.1686 | [-0.1718, -0.1654] |
| broker_vcsw | 375.0 | 681.0 | +295.6 | [+277.9, +313.3] |
| broker_maxrss_kib | 6588 | 6614 | +20 | [-19, +59] |
| broker_ru_maxrss_kib | 20572 | 20572 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
