candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3773 | 0.2156 | -42.84 | [-43.57, -41.97] | [-43.47, -42.12] | 0.567 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.2424 | 0.1381 | -43.03 | [-43.52, -42.54] | [-43.44, -42.62] | 0.572 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.6709 | 0.4077 | -39.24 | [-39.79, -38.64] | [-39.71, -38.74] | 0.606 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.0523 | 1.2006 | +14.10 | [+13.44, +14.78] | [+13.55, +14.67] | 1.140 | <0.0001 | slower/larger |
| client_vcsw | 60 | 2452.1 | 10121.2 | +312.75 | [+308.43, +316.45] | [+309.21, +315.93] | 4.166 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.6637 | 0.7743 | +16.68 | [+15.60, +17.82] | [+15.76, +17.64] | 1.167 | <0.0001 | slower/larger |
| multi_broker_cpu_s | 60 | 0.2130 | 0.1068 | -49.84 | [-50.74, -48.98] | [-50.59, -49.10] | 0.500 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2783 | 0.2372 | -14.78 | [-15.90, -13.63] | [-15.74, -13.81] | 0.854 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2777 | 0.1402 | -49.52 | [-50.43, -48.59] | [-50.28, -48.74] | 0.503 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5561 | 0.3774 | -32.13 | [-32.47, -31.79] | [-32.42, -31.85] | 0.681 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 419.4 | 142.7 | -65.98 | [-67.32, -64.57] | [-67.11, -64.79] | 0.335 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 54769 | 6373 | -88.36 | [-88.78, -87.82] | [-88.72, -87.92] | 0.112 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54211 | 20259 | -62.63 | [-63.85, -61.07] | [-63.68, -61.37] | 0.360 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3816 | 0.2157 | -0.1616 | [-0.1672, -0.1560] |
| multi_s | 0.2412 | 0.1376 | -0.1043 | [-0.1061, -0.1025] |
| client_wall_s | 0.6737 | 0.4057 | -0.2632 | [-0.2693, -0.2571] |
| client_cpu_s | 1.0507 | 1.1986 | +0.1484 | [+0.1417, +0.1551] |
| client_vcsw | 2420.5 | 10121.5 | +7669.1 | [+7641.7, +7696.4] |
| multi_client_cpu_s | 0.6600 | 0.7700 | +0.1107 | [+0.1037, +0.1176] |
| multi_broker_cpu_s | 0.2100 | 0.1100 | -0.1062 | [-0.1088, -0.1036] |
| broker_user_s | 0.2779 | 0.2372 | -0.0412 | [-0.0448, -0.0375] |
| broker_sys_s | 0.2788 | 0.1393 | -0.1375 | [-0.1415, -0.1336] |
| broker_cpu_s | 0.5555 | 0.3768 | -0.1787 | [-0.1812, -0.1761] |
| broker_vcsw | 432.0 | 140.0 | -276.7 | [-290.6, -262.9] |
| broker_maxrss_kib | 56748 | 6394 | -48396 | [-50685, -46107] |
| broker_ru_maxrss_kib | 56074 | 20268 | -33952 | [-36026, -31877] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
