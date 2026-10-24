candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1388 | 0.0715 | -48.48 | [-49.18, -47.76] | [-49.06, -47.89] | 0.518 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1815 | 0.4647 | -60.67 | [-61.03, -60.31] | [-60.97, -60.36] | 0.394 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3483 | 0.5639 | -58.18 | [-58.53, -57.83] | [-58.47, -57.88] | 0.418 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9574 | 0.4929 | -48.52 | [-48.87, -48.15] | [-48.82, -48.21] | 0.514 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 28696.7 | 2554.7 | -91.10 | [-91.38, -90.80] | [-91.33, -90.85] | 0.088 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8880 | 0.4450 | -49.89 | [-50.35, -49.42] | [-50.27, -49.49] | 0.503 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1553 | 0.3647 | -68.44 | [-68.78, -68.08] | [-68.72, -68.14] | 0.315 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5179 | 0.2105 | -59.35 | [-60.02, -58.66] | [-59.92, -58.78] | 0.404 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7601 | 0.2161 | -71.57 | [-72.02, -71.10] | [-71.95, -71.18] | 0.283 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2780 | 0.4266 | -66.62 | [-66.91, -66.32] | [-66.86, -66.37] | 0.335 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2045.5 | 5534.9 | +170.59 | [+166.60, +174.45] | [+167.28, +173.75] | 2.738 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6246 | 6694 | +7.18 | [+6.49, +7.86] | [+6.60, +7.75] | 1.074 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20530 | 20527 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1386 | 0.0711 | -0.0673 | [-0.0688, -0.0657] |
| multi_s | 1.1809 | 0.4645 | -0.7168 | [-0.7232, -0.7105] |
| client_wall_s | 1.3451 | 0.5651 | -0.7844 | [-0.7913, -0.7774] |
| client_cpu_s | 0.9572 | 0.4921 | -0.4645 | [-0.4690, -0.4600] |
| client_vcsw | 28591.5 | 2492.0 | -26142.0 | [-26427.6, -25856.4] |
| multi_client_cpu_s | 0.8900 | 0.4450 | -0.4430 | [-0.4482, -0.4378] |
| multi_broker_cpu_s | 1.1500 | 0.3600 | -0.7907 | [-0.7971, -0.7843] |
| broker_user_s | 0.5208 | 0.2083 | -0.3074 | [-0.3133, -0.3014] |
| broker_sys_s | 0.7573 | 0.2158 | -0.5440 | [-0.5505, -0.5375] |
| broker_cpu_s | 1.2761 | 0.4256 | -0.8514 | [-0.8576, -0.8451] |
| broker_vcsw | 2040.0 | 5572.0 | +3489.4 | [+3413.3, +3565.6] |
| broker_maxrss_kib | 6220 | 6682 | +448 | [+406, +490] |
| broker_ru_maxrss_kib | 20504 | 20504 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
