candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8491 | 0.2635 | -68.97 | [-69.12, -68.82] | [-69.09, -68.85] | 0.310 | <0.0001 | faster/smaller |
| multi_s | 60 | 2.0105 | 0.3953 | -80.34 | [-80.42, -80.27] | [-80.40, -80.28] | 0.197 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.9055 | 0.7113 | -75.52 | [-75.61, -75.43] | [-75.59, -75.44] | 0.245 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 3.6696 | 2.6183 | -28.65 | [-28.86, -28.45] | [-28.83, -28.48] | 0.714 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 138099.5 | 121136.0 | -12.28 | [-12.33, -12.24] | [-12.32, -12.24] | 0.877 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 2.8212 | 2.1820 | -22.66 | [-22.92, -22.41] | [-22.88, -22.45] | 0.774 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.9808 | 0.3647 | -81.59 | [-81.69, -81.49] | [-81.68, -81.51] | 0.184 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.9247 | 0.3264 | -64.70 | [-65.19, -64.19] | [-65.12, -64.27] | 0.354 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.9460 | 0.3573 | -81.64 | [-81.83, -81.45] | [-81.80, -81.47] | 0.184 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.8707 | 0.6837 | -76.18 | [-76.25, -76.11] | [-76.24, -76.13] | 0.238 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 22.050 | 129.867 | +488.96 | [+463.63, +515.79] | [+467.30, +511.48] | 5.805 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5633 | 6299 | +11.82 | [+10.85, +12.78] | [+11.00, +12.63] | 1.112 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20259 | 20262 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8469 | 0.2632 | -0.5857 | [-0.5882, -0.5831] |
| multi_s | 2.0055 | 0.3955 | -1.6152 | [-1.6203, -1.6101] |
| client_wall_s | 2.9004 | 0.7093 | -2.1942 | [-2.2009, -2.1875] |
| client_cpu_s | 3.6609 | 2.6177 | -1.0513 | [-1.0604, -1.0423] |
| client_vcsw | 138058.0 | 121136.0 | -16963.5 | [-17040.4, -16886.5] |
| multi_client_cpu_s | 2.8200 | 2.1800 | -0.6392 | [-0.6473, -0.6311] |
| multi_broker_cpu_s | 1.9800 | 0.3600 | -1.6162 | [-1.6215, -1.6108] |
| broker_user_s | 0.9276 | 0.3263 | -0.5983 | [-0.6076, -0.5890] |
| broker_sys_s | 1.9453 | 0.3558 | -1.5887 | [-1.5973, -1.5801] |
| broker_cpu_s | 2.8663 | 0.6834 | -2.1870 | [-2.1932, -2.1808] |
| broker_vcsw | 22.000 | 125.500 | +107.817 | [+103.557, +112.076] |
| broker_maxrss_kib | 5638 | 6288 | +666 | [+612, +720] |
| broker_ru_maxrss_kib | 20268 | 20268 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
