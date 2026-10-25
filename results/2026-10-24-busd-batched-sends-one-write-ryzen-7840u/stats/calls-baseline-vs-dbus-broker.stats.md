candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0609 | 0.0705 | +15.79 | [+14.12, +17.41] | [+14.39, +17.15] | 1.166 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4443 | 0.4674 | +5.20 | [+4.12, +6.31] | [+4.29, +6.13] | 1.058 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 0.5330 | 0.5658 | +6.16 | [+5.14, +7.20] | [+5.29, +7.03] | 1.067 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.4866 | 0.4951 | +1.74 | [+0.82, +2.68] | [+0.97, +2.53] | 1.024 | 0.0008 | no material change; repeatable change (+) |
| client_vcsw | 60 | 2080.1 | 2624.1 | +26.15 | [+22.71, +29.80] | [+23.26, +29.19] | 1.253 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4293 | 0.4473 | +4.19 | [+3.09, +5.30] | [+3.28, +5.13] | 1.047 | <0.0001 | inconclusive; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2957 | 0.3660 | +23.79 | [+22.32, +25.28] | [+22.56, +25.04] | 1.241 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1235 | 0.2079 | +68.34 | [+63.94, +72.80] | [+64.71, +72.02] | 1.712 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2310 | 0.2206 | -4.50 | [-6.14, -2.72] | [-5.90, -3.02] | 0.950 | <0.0001 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.3545 | 0.4285 | +20.88 | [+19.77, +22.02] | [+19.96, +21.82] | 1.209 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 21420.5 | 5480.3 | -74.42 | [-74.80, -74.05] | [-74.73, -74.11] | 0.259 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8264 | 6696 | -18.97 | [-19.57, -18.41] | [-19.48, -18.49] | 0.811 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20530 | 20523 | -0.03 | [-0.07, +0.00] | [-0.06, -0.01] | 1.000 | 0.0833 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0605 | 0.0705 | +0.0096 | [+0.0087, +0.0106] |
| multi_s | 0.4399 | 0.4667 | +0.0231 | [+0.0182, +0.0280] |
| client_wall_s | 0.5292 | 0.5648 | +0.0328 | [+0.0273, +0.0384] |
| client_cpu_s | 0.4829 | 0.4942 | +0.0085 | [+0.0038, +0.0132] |
| client_vcsw | 2081.0 | 2646.0 | +544.0 | [+468.9, +619.0] |
| multi_client_cpu_s | 0.4300 | 0.4500 | +0.0180 | [+0.0132, +0.0228] |
| multi_broker_cpu_s | 0.3000 | 0.3700 | +0.0703 | [+0.0661, +0.0746] |
| broker_user_s | 0.1225 | 0.2089 | +0.0844 | [+0.0800, +0.0888] |
| broker_sys_s | 0.2307 | 0.2204 | -0.0104 | [-0.0145, -0.0062] |
| broker_cpu_s | 0.3533 | 0.4278 | +0.0740 | [+0.0702, +0.0778] |
| broker_vcsw | 21270.5 | 5468.5 | -15940.2 | [-16176.9, -15703.6] |
| broker_maxrss_kib | 8262 | 6696 | -1568 | [-1625, -1511] |
| broker_ru_maxrss_kib | 20504 | 20504 | -6 | [-14, +1] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
