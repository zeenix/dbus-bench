candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1388 | 0.0705 | -49.22 | [-49.86, -48.57] | [-49.76, -48.68] | 0.511 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1815 | 0.4674 | -60.44 | [-60.76, -60.11] | [-60.71, -60.17] | 0.397 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3483 | 0.5658 | -58.03 | [-58.35, -57.71] | [-58.30, -57.77] | 0.422 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9574 | 0.4951 | -48.29 | [-48.65, -47.91] | [-48.59, -47.97] | 0.518 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 28696.7 | 2624.1 | -90.86 | [-91.10, -90.59] | [-91.06, -90.64] | 0.092 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8880 | 0.4473 | -49.62 | [-50.04, -49.18] | [-49.98, -49.26] | 0.500 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1553 | 0.3660 | -68.32 | [-68.66, -67.98] | [-68.61, -68.04] | 0.319 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5179 | 0.2079 | -59.86 | [-60.68, -59.02] | [-60.56, -59.16] | 0.403 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7601 | 0.2206 | -70.98 | [-71.43, -70.51] | [-71.36, -70.58] | 0.292 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2780 | 0.4285 | -66.47 | [-66.74, -66.20] | [-66.70, -66.25] | 0.335 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2045.5 | 5480.3 | +167.92 | [+164.29, +171.59] | [+164.87, +171.00] | 2.672 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6246 | 6696 | +7.21 | [+6.36, +8.03] | [+6.50, +7.90] | 1.072 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20530 | 20523 | -0.03 | [-0.07, +0.00] | [-0.06, -0.01] | 1.000 | 0.0833 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1386 | 0.0705 | -0.0683 | [-0.0698, -0.0668] |
| multi_s | 1.1809 | 0.4667 | -0.7141 | [-0.7201, -0.7082] |
| client_wall_s | 1.3451 | 0.5648 | -0.7825 | [-0.7889, -0.7760] |
| client_cpu_s | 0.9572 | 0.4942 | -0.4623 | [-0.4668, -0.4577] |
| client_vcsw | 28591.5 | 2646.0 | -26072.6 | [-26338.0, -25807.2] |
| multi_client_cpu_s | 0.8900 | 0.4500 | -0.4407 | [-0.4457, -0.4357] |
| multi_broker_cpu_s | 1.1500 | 0.3700 | -0.7893 | [-0.7957, -0.7829] |
| broker_user_s | 0.5208 | 0.2089 | -0.3100 | [-0.3167, -0.3033] |
| broker_sys_s | 0.7573 | 0.2204 | -0.5395 | [-0.5456, -0.5335] |
| broker_cpu_s | 1.2761 | 0.4278 | -0.8495 | [-0.8555, -0.8436] |
| broker_vcsw | 2040.0 | 5468.5 | +3434.8 | [+3361.3, +3508.2] |
| broker_maxrss_kib | 6220 | 6696 | +450 | [+399, +501] |
| broker_ru_maxrss_kib | 20504 | 20504 | -6 | [-14, +1] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
