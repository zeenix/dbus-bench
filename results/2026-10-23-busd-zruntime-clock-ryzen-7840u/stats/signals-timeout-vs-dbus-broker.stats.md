candidate timeout against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3027 | 0.3131 | +3.44 | [+2.86, +4.06] | [+2.95, +3.95] | 1.036 | <0.0001 | no material change; repeatable change (+) |
| multi_s | 60 | 0.3740 | 0.3786 | +1.22 | [+0.31, +2.19] | [+0.45, +2.02] | 1.007 | 0.0123 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.7093 | 0.7513 | +5.93 | [+5.20, +6.67] | [+5.32, +6.55] | 1.055 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.6801 | 0.6909 | +1.58 | [+0.94, +2.26] | [+1.04, +2.14] | 1.013 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 60 | 12.083 | 126.400 | +946.07 | [+824.84, +1082.67] | [+846.30, +1063.35] | 12.359 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.3590 | 0.3620 | +0.84 | [-0.28, +2.00] | [-0.09, +1.81] | 1.000 | 0.1680 | no material change |
| multi_broker_cpu_s | 60 | 0.1152 | 0.2018 | +75.25 | [+71.19, +79.71] | [+71.77, +78.94] | 1.739 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1183 | 0.2720 | +130.00 | [+124.77, +135.22] | [+125.63, +134.39] | 2.319 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2426 | 0.2502 | +3.11 | [+1.47, +4.79] | [+1.72, +4.55] | 1.032 | 0.0009 | no material change; repeatable change (+) |
| broker_cpu_s | 60 | 0.3609 | 0.5222 | +44.70 | [+43.45, +45.93] | [+43.67, +45.75] | 1.449 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 7309.0 | 367.4 | -94.97 | [-95.07, -94.87] | [-95.06, -94.89] | 0.050 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41049 | 6562 | -84.01 | [-84.14, -83.88] | [-84.12, -83.90] | 0.159 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 36460 | 20529 | -43.69 | [-44.14, -43.22] | [-44.07, -43.30] | 0.558 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3021 | 0.3122 | +0.0104 | [+0.0086, +0.0122] |
| multi_s | 0.3699 | 0.3736 | +0.0046 | [+0.0010, +0.0081] |
| client_wall_s | 0.7056 | 0.7461 | +0.0421 | [+0.0368, +0.0473] |
| client_cpu_s | 0.6772 | 0.6844 | +0.0108 | [+0.0062, +0.0153] |
| client_vcsw | 10.000 | 131.500 | +114.317 | [+109.775, +118.858] |
| multi_client_cpu_s | 0.3600 | 0.3600 | +0.0030 | [-0.0011, +0.0071] |
| multi_broker_cpu_s | 0.1200 | 0.2000 | +0.0867 | [+0.0833, +0.0900] |
| broker_user_s | 0.1166 | 0.2727 | +0.1538 | [+0.1502, +0.1574] |
| broker_sys_s | 0.2422 | 0.2482 | +0.0075 | [+0.0034, +0.0117] |
| broker_cpu_s | 0.3570 | 0.5194 | +0.1613 | [+0.1579, +0.1647] |
| broker_vcsw | 7334.5 | 364.0 | -6941.6 | [-6972.6, -6910.6] |
| broker_maxrss_kib | 41440 | 6574 | -34486 | [-34779, -34193] |
| broker_ru_maxrss_kib | 36756 | 20576 | -15931 | [-16230, -15633] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
