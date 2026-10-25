candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8245 | 2.0129 | +10.32 | [+9.16, +11.43] | [+9.35, +11.27] | 1.111 | <0.0001 | slower/larger |
| multi_s | 40 | 2.1860 | 2.1860 | -0.00 | [-1.01, +1.08] | [-0.86, +0.90] | 0.996 | 0.8193 | no material change |
| client_wall_s | 40 | 4.0412 | 4.2293 | +4.65 | [+3.95, +5.37] | [+4.06, +5.26] | 1.048 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 3.9310 | 4.0564 | +3.19 | [+2.53, +3.87] | [+2.64, +3.76] | 1.031 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 1865.2 | 2366.2 | +26.86 | [+12.02, +45.60] | [+14.38, +42.35] | 1.401 | 0.0006 | slower/larger |
| multi_client_cpu_s | 40 | 2.1317 | 2.1365 | +0.22 | [-0.78, +1.31] | [-0.62, +1.12] | 0.993 | 0.7518 | no material change |
| multi_broker_cpu_s | 40 | 1.8958 | 1.8313 | -3.40 | [-5.03, -1.76] | [-4.76, -2.01] | 0.965 | 0.0001 | no material change; repeatable change (-) |
| broker_user_s | 40 | 1.5974 | 1.5953 | -0.13 | [-1.09, +0.76] | [-0.93, +0.64] | 1.001 | 1.0000 | no material change |
| broker_sys_s | 40 | 1.7049 | 1.7433 | +2.26 | [+0.45, +4.31] | [+0.68, +3.97] | 1.015 | 0.0397 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 3.3022 | 3.3386 | +1.10 | [+0.05, +2.19] | [+0.20, +2.01] | 1.018 | 0.0397 | no material change; repeatable change (+) |
| broker_vcsw | 40 | 12066.6 | 15130.2 | +25.39 | [+21.77, +29.37] | [+22.32, +28.70] | 1.230 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11755 | 11525 | -1.96 | [-3.47, -0.45] | [-3.23, -0.70] | 0.984 | 0.0152 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20590 | 20586 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8090 | 2.0061 | +0.1884 | [+0.1678, +0.2089] |
| multi_s | 2.1817 | 2.1674 | -0.0000 | [-0.0237, +0.0237] |
| client_wall_s | 4.0256 | 4.1962 | +0.1881 | [+0.1589, +0.2172] |
| client_cpu_s | 3.9218 | 4.0353 | +0.1255 | [+0.0985, +0.1524] |
| client_vcsw | 1612.0 | 2164.5 | +501.0 | [+249.4, +752.5] |
| multi_client_cpu_s | 2.1250 | 2.1200 | +0.0048 | [-0.0184, +0.0279] |
| multi_broker_cpu_s | 1.8700 | 1.8050 | -0.0645 | [-0.0974, -0.0316] |
| broker_user_s | 1.5715 | 1.5921 | -0.0021 | [-0.0174, +0.0133] |
| broker_sys_s | 1.7045 | 1.7126 | +0.0385 | [+0.0040, +0.0729] |
| broker_cpu_s | 3.2913 | 3.3114 | +0.0364 | [-0.0007, +0.0735] |
| broker_vcsw | 12262.0 | 15143.5 | +3063.5 | [+2650.3, +3476.7] |
| broker_maxrss_kib | 11706 | 11490 | -231 | [-418, -43] |
| broker_ru_maxrss_kib | 20628 | 20628 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
