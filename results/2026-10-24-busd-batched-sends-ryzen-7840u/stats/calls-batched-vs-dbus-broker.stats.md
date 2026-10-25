candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0608 | 0.0723 | +18.98 | [+17.50, +20.46] | [+17.74, +20.23] | 1.183 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4348 | 0.4528 | +4.14 | [+3.10, +5.16] | [+3.27, +5.00] | 1.048 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 0.5257 | 0.5554 | +5.65 | [+4.66, +6.61] | [+4.82, +6.47] | 1.061 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.4777 | 0.4832 | +1.15 | [+0.21, +2.06] | [+0.38, +1.93] | 1.012 | 0.0077 | no material change; repeatable change (+) |
| client_vcsw | 60 | 2060.2 | 2315.5 | +12.39 | [+10.39, +14.54] | [+10.71, +14.20] | 1.108 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4183 | 0.4348 | +3.94 | [+2.81, +5.06] | [+2.99, +4.89] | 1.048 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2842 | 0.3555 | +25.10 | [+23.64, +26.56] | [+23.88, +26.34] | 1.250 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1197 | 0.2002 | +67.32 | [+63.95, +70.81] | [+64.52, +70.25] | 1.682 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2256 | 0.2209 | -2.10 | [-3.59, -0.56] | [-3.36, -0.81] | 0.973 | 0.0071 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.3453 | 0.4211 | +21.96 | [+20.94, +22.98] | [+21.11, +22.82] | 1.223 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 20386.5 | 5538.7 | -72.83 | [-73.23, -72.43] | [-73.16, -72.49] | 0.270 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8244 | 6694 | -18.80 | [-19.42, -18.19] | [-19.32, -18.29] | 0.812 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20612 | 20612 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0604 | 0.0722 | +0.0115 | [+0.0107, +0.0124] |
| multi_s | 0.4314 | 0.4517 | +0.0180 | [+0.0135, +0.0225] |
| client_wall_s | 0.5210 | 0.5542 | +0.0297 | [+0.0246, +0.0348] |
| client_cpu_s | 0.4740 | 0.4798 | +0.0055 | [+0.0010, +0.0100] |
| client_vcsw | 2060.0 | 2274.5 | +255.3 | [+211.0, +299.6] |
| multi_client_cpu_s | 0.4200 | 0.4300 | +0.0165 | [+0.0117, +0.0213] |
| multi_broker_cpu_s | 0.2800 | 0.3500 | +0.0713 | [+0.0675, +0.0752] |
| broker_user_s | 0.1216 | 0.2006 | +0.0806 | [+0.0773, +0.0838] |
| broker_sys_s | 0.2251 | 0.2196 | -0.0047 | [-0.0083, -0.0012] |
| broker_cpu_s | 0.3441 | 0.4204 | +0.0758 | [+0.0725, +0.0791] |
| broker_vcsw | 20101.0 | 5607.5 | -14847.8 | [-15064.4, -14631.2] |
| broker_maxrss_kib | 8264 | 6710 | -1550 | [-1610, -1491] |
| broker_ru_maxrss_kib | 20704 | 20704 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
