candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1381 | 0.0723 | -47.65 | [-48.36, -46.94] | [-48.25, -47.05] | 0.524 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1550 | 0.4528 | -60.80 | [-61.07, -60.52] | [-61.03, -60.56] | 0.392 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3233 | 0.5554 | -58.03 | [-58.31, -57.74] | [-58.27, -57.78] | 0.420 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9460 | 0.4832 | -48.92 | [-49.27, -48.56] | [-49.22, -48.62] | 0.511 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 26619.0 | 2315.5 | -91.30 | [-91.46, -91.13] | [-91.44, -91.16] | 0.086 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8762 | 0.4348 | -50.37 | [-50.73, -49.98] | [-50.68, -50.05] | 0.494 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1258 | 0.3555 | -68.42 | [-68.71, -68.13] | [-68.66, -68.18] | 0.315 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5086 | 0.2002 | -60.63 | [-61.28, -59.94] | [-61.18, -60.06] | 0.394 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7437 | 0.2209 | -70.30 | [-70.76, -69.85] | [-70.69, -69.92] | 0.296 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2523 | 0.4211 | -66.37 | [-66.61, -66.13] | [-66.57, -66.17] | 0.335 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2050.1 | 5538.7 | +170.17 | [+166.55, +173.62] | [+167.16, +173.11] | 2.721 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6254 | 6694 | +7.04 | [+6.35, +7.74] | [+6.46, +7.62] | 1.071 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20614 | 20612 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1377 | 0.0722 | -0.0658 | [-0.0674, -0.0642] |
| multi_s | 1.1539 | 0.4517 | -0.7022 | [-0.7076, -0.6968] |
| client_wall_s | 1.3192 | 0.5542 | -0.7679 | [-0.7742, -0.7615] |
| client_cpu_s | 0.9426 | 0.4798 | -0.4628 | [-0.4676, -0.4580] |
| client_vcsw | 26672.5 | 2274.5 | -24303.4 | [-24448.1, -24158.7] |
| multi_client_cpu_s | 0.8700 | 0.4300 | -0.4413 | [-0.4458, -0.4369] |
| multi_broker_cpu_s | 1.1200 | 0.3500 | -0.7703 | [-0.7764, -0.7643] |
| broker_user_s | 0.5095 | 0.2006 | -0.3084 | [-0.3140, -0.3027] |
| broker_sys_s | 0.7391 | 0.2196 | -0.5229 | [-0.5295, -0.5162] |
| broker_cpu_s | 1.2495 | 0.4204 | -0.8312 | [-0.8371, -0.8253] |
| broker_vcsw | 2039.5 | 5607.5 | +3488.7 | [+3417.6, +3559.7] |
| broker_maxrss_kib | 6252 | 6710 | +440 | [+397, +484] |
| broker_ru_maxrss_kib | 20704 | 20704 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
