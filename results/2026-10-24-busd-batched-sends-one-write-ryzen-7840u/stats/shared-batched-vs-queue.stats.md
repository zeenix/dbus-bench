candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8245 | 1.9677 | +7.85 | [+6.64, +9.03] | [+6.84, +8.83] | 1.083 | <0.0001 | slower/larger |
| multi_s | 40 | 2.1860 | 2.1975 | +0.53 | [-0.66, +1.72] | [-0.46, +1.53] | 1.003 | 0.3399 | no material change |
| client_wall_s | 40 | 4.0412 | 4.1959 | +3.83 | [+2.91, +4.67] | [+3.07, +4.55] | 1.043 | <0.0001 | no material change; repeatable change (+) |
| client_cpu_s | 40 | 3.9310 | 4.0286 | +2.48 | [+1.70, +3.24] | [+1.83, +3.12] | 1.032 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 1865.2 | 2273.0 | +21.86 | [+4.64, +43.23] | [+7.41, +39.47] | 1.291 | 0.0054 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 40 | 2.1317 | 2.1440 | +0.57 | [-0.60, +1.73] | [-0.39, +1.55] | 1.005 | 0.2269 | no material change |
| multi_broker_cpu_s | 40 | 1.8958 | 1.8798 | -0.84 | [-2.59, +0.95] | [-2.30, +0.66] | 0.992 | 0.2396 | no material change |
| broker_user_s | 40 | 1.5974 | 1.5617 | -2.23 | [-3.34, -1.09] | [-3.18, -1.26] | 0.976 | 0.0012 | no material change; repeatable change (-) |
| broker_sys_s | 40 | 1.7049 | 1.7187 | +0.81 | [-0.92, +2.58] | [-0.64, +2.30] | 1.008 | 0.3897 | no material change |
| broker_cpu_s | 40 | 3.3022 | 3.2804 | -0.66 | [-1.69, +0.41] | [-1.53, +0.24] | 0.991 | 0.1789 | no material change |
| broker_vcsw | 40 | 12066.6 | 15269.0 | +26.54 | [+23.16, +30.04] | [+23.78, +29.45] | 1.267 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11755 | 11322 | -3.69 | [-5.51, -1.75] | [-5.23, -2.08] | 0.962 | 0.0004 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20590 | 20590 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8090 | 1.9499 | +0.1432 | [+0.1213, +0.1650] |
| multi_s | 2.1817 | 2.1820 | +0.0115 | [-0.0151, +0.0382] |
| client_wall_s | 4.0256 | 4.1769 | +0.1548 | [+0.1188, +0.1907] |
| client_cpu_s | 3.9218 | 4.0128 | +0.0976 | [+0.0669, +0.1283] |
| client_vcsw | 1612.0 | 2061.0 | +407.8 | [+89.0, +726.7] |
| multi_client_cpu_s | 2.1250 | 2.1300 | +0.0123 | [-0.0130, +0.0375] |
| multi_broker_cpu_s | 1.8700 | 1.8500 | -0.0160 | [-0.0513, +0.0193] |
| broker_user_s | 1.5715 | 1.5539 | -0.0357 | [-0.0551, -0.0162] |
| broker_sys_s | 1.7045 | 1.7139 | +0.0139 | [-0.0173, +0.0451] |
| broker_cpu_s | 3.2913 | 3.2547 | -0.0218 | [-0.0584, +0.0147] |
| broker_vcsw | 12262.0 | 15467.5 | +3202.3 | [+2825.2, +3579.5] |
| broker_maxrss_kib | 11706 | 11236 | -434 | [-666, -201] |
| broker_ru_maxrss_kib | 20628 | 20628 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
