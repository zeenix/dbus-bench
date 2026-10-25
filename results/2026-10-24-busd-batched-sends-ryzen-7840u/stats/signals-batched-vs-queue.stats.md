candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3865 | 0.2985 | -22.77 | [-23.30, -22.24] | [-23.22, -22.33] | 0.774 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3799 | 0.3581 | -5.75 | [-6.65, -4.85] | [-6.50, -5.00] | 0.945 | <0.0001 | inconclusive; repeatable change (-) |
| client_wall_s | 60 | 0.8257 | 0.7164 | -13.24 | [-13.92, -12.55] | [-13.82, -12.66] | 0.870 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.6998 | 0.6608 | -5.58 | [-6.23, -4.92] | [-6.12, -5.03] | 0.945 | <0.0001 | inconclusive; repeatable change (-) |
| client_vcsw | 60 | 212.0 | 41.3 | -80.52 | [-81.51, -79.53] | [-81.35, -79.69] | 0.193 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3658 | 0.3430 | -6.24 | [-7.38, -5.11] | [-7.20, -5.27] | 0.944 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.1858 | 0.1042 | -43.95 | [-45.02, -42.84] | [-44.84, -43.03] | 0.556 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2664 | 0.2287 | -14.17 | [-15.52, -12.77] | [-15.31, -13.00] | 0.857 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2606 | 0.1430 | -45.13 | [-46.17, -44.02] | [-46.01, -44.20] | 0.547 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5271 | 0.3717 | -29.48 | [-30.01, -28.94] | [-29.93, -29.02] | 0.703 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 811.0 | 628.1 | -22.56 | [-26.27, -18.67] | [-25.66, -19.28] | 0.818 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 55199 | 6623 | -88.00 | [-88.10, -87.91] | [-88.08, -87.92] | 0.120 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54843 | 20472 | -62.67 | [-62.86, -62.49] | [-62.83, -62.52] | 0.374 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3846 | 0.2973 | -0.0880 | [-0.0905, -0.0856] |
| multi_s | 0.3748 | 0.3560 | -0.0219 | [-0.0255, -0.0182] |
| client_wall_s | 0.8212 | 0.7159 | -0.1093 | [-0.1157, -0.1030] |
| client_cpu_s | 0.6952 | 0.6587 | -0.0390 | [-0.0439, -0.0341] |
| client_vcsw | 213.5 | 41.0 | -170.7 | [-174.0, -167.4] |
| multi_client_cpu_s | 0.3600 | 0.3400 | -0.0228 | [-0.0273, -0.0183] |
| multi_broker_cpu_s | 0.1900 | 0.1000 | -0.0817 | [-0.0847, -0.0787] |
| broker_user_s | 0.2649 | 0.2288 | -0.0377 | [-0.0418, -0.0337] |
| broker_sys_s | 0.2613 | 0.1416 | -0.1176 | [-0.1214, -0.1138] |
| broker_cpu_s | 0.5262 | 0.3706 | -0.1554 | [-0.1591, -0.1516] |
| broker_vcsw | 754.5 | 622.5 | -182.9 | [-222.9, -142.9] |
| broker_maxrss_kib | 55164 | 6628 | -48575 | [-48911, -48240] |
| broker_ru_maxrss_kib | 54722 | 20500 | -34371 | [-34656, -34086] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
