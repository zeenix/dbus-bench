candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0608 | 0.0708 | +16.51 | [+14.86, +18.15] | [+15.13, +17.90] | 1.175 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4348 | 0.4506 | +3.65 | [+2.69, +4.59] | [+2.84, +4.44] | 1.036 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.5257 | 0.5514 | +4.88 | [+4.01, +5.76] | [+4.14, +5.62] | 1.050 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.4777 | 0.4802 | +0.52 | [-0.25, +1.33] | [-0.13, +1.19] | 1.005 | 0.1619 | no material change |
| client_vcsw | 60 | 2060.2 | 2293.9 | +11.34 | [+9.65, +13.11] | [+9.90, +12.84] | 1.102 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4183 | 0.4313 | +3.11 | [+2.14, +4.05] | [+2.30, +3.90] | 1.024 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2842 | 0.3485 | +22.64 | [+21.28, +24.00] | [+21.50, +23.80] | 1.214 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1197 | 0.1951 | +63.02 | [+60.24, +65.92] | [+60.65, +65.48] | 1.619 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2256 | 0.2185 | -3.17 | [-4.76, -1.49] | [-4.50, -1.74] | 0.971 | 0.0008 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.3453 | 0.4136 | +19.77 | [+18.84, +20.77] | [+18.98, +20.61] | 1.197 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 20386.5 | 5646.1 | -72.30 | [-72.70, -71.92] | [-72.63, -71.98] | 0.278 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8244 | 6695 | -18.79 | [-19.37, -18.21] | [-19.28, -18.31] | 0.809 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20612 | 20612 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0604 | 0.0704 | +0.0100 | [+0.0091, +0.0110] |
| multi_s | 0.4314 | 0.4486 | +0.0159 | [+0.0117, +0.0200] |
| client_wall_s | 0.5210 | 0.5488 | +0.0256 | [+0.0210, +0.0303] |
| client_cpu_s | 0.4740 | 0.4781 | +0.0025 | [-0.0014, +0.0064] |
| client_vcsw | 2060.0 | 2287.0 | +233.7 | [+196.2, +271.1] |
| multi_client_cpu_s | 0.4200 | 0.4300 | +0.0130 | [+0.0090, +0.0170] |
| multi_broker_cpu_s | 0.2800 | 0.3500 | +0.0643 | [+0.0606, +0.0681] |
| broker_user_s | 0.1216 | 0.1942 | +0.0754 | [+0.0728, +0.0780] |
| broker_sys_s | 0.2251 | 0.2189 | -0.0071 | [-0.0110, -0.0033] |
| broker_cpu_s | 0.3441 | 0.4133 | +0.0683 | [+0.0651, +0.0715] |
| broker_vcsw | 20101.0 | 5642.0 | -14740.4 | [-14959.6, -14521.3] |
| broker_maxrss_kib | 8264 | 6698 | -1549 | [-1606, -1493] |
| broker_ru_maxrss_kib | 20704 | 20704 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
