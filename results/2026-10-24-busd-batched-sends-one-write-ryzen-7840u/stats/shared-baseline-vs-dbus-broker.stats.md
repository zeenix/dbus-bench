candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8517 | 2.0129 | +8.71 | [+7.94, +9.48] | [+8.06, +9.36] | 1.086 | <0.0001 | slower/larger |
| multi_s | 40 | 2.0985 | 2.1860 | +4.17 | [+3.11, +5.34] | [+3.26, +5.15] | 1.040 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 40 | 3.9801 | 4.2293 | +6.26 | [+5.69, +6.86] | [+5.78, +6.76] | 1.061 | <0.0001 | slower/larger |
| client_cpu_s | 40 | 3.9440 | 4.0564 | +2.85 | [+2.31, +3.42] | [+2.39, +3.32] | 1.029 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 252.1 | 2366.2 | +838.59 | [+720.90, +994.76] | [+737.30, +968.32] | 10.653 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.0830 | 2.1365 | +2.57 | [+1.48, +3.75] | [+1.64, +3.55] | 1.024 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.4745 | 1.8313 | +24.19 | [+22.57, +25.98] | [+22.83, +25.68] | 1.236 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9253 | 1.5953 | +72.40 | [+70.36, +74.54] | [+70.67, +74.22] | 1.727 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.6896 | 1.7433 | +3.18 | [+1.95, +4.51] | [+2.13, +4.29] | 1.021 | <0.0001 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 2.6149 | 3.3386 | +27.68 | [+26.70, +28.73] | [+26.84, +28.54] | 1.275 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 103067.4 | 15130.2 | -85.32 | [-85.67, -84.99] | [-85.60, -85.05] | 0.148 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9279 | 11525 | +24.20 | [+22.30, +26.30] | [+22.62, +25.90] | 1.239 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20586 | 20586 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8470 | 2.0061 | +0.1612 | [+0.1467, +0.1757] |
| multi_s | 2.0894 | 2.1674 | +0.0876 | [+0.0632, +0.1119] |
| client_wall_s | 3.9679 | 4.1962 | +0.2492 | [+0.2247, +0.2738] |
| client_cpu_s | 3.9299 | 4.0353 | +0.1124 | [+0.0895, +0.1352] |
| client_vcsw | 198.0 | 2164.5 | +2114.1 | [+1895.8, +2332.4] |
| multi_client_cpu_s | 2.0750 | 2.1200 | +0.0535 | [+0.0292, +0.0778] |
| multi_broker_cpu_s | 1.4650 | 1.8050 | +0.3568 | [+0.3306, +0.3829] |
| broker_user_s | 0.9226 | 1.5921 | +0.6699 | [+0.6526, +0.6873] |
| broker_sys_s | 1.6773 | 1.7126 | +0.0538 | [+0.0311, +0.0765] |
| broker_cpu_s | 2.5974 | 3.3114 | +0.7237 | [+0.6948, +0.7526] |
| broker_vcsw | 102494.5 | 15143.5 | -87937.2 | [-89796.6, -86077.8] |
| broker_maxrss_kib | 9294 | 11490 | +2246 | [+2071, +2421] |
| broker_ru_maxrss_kib | 20628 | 20628 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
