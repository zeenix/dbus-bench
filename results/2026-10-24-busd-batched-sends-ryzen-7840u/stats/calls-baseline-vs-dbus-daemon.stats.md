candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1381 | 0.0708 | -48.74 | [-49.52, -47.96] | [-49.39, -48.08] | 0.510 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1550 | 0.4506 | -60.98 | [-61.28, -60.69] | [-61.23, -60.73] | 0.389 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3233 | 0.5514 | -58.33 | [-58.64, -58.04] | [-58.59, -58.08] | 0.415 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9460 | 0.4802 | -49.24 | [-49.57, -48.88] | [-49.53, -48.94] | 0.507 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 26619.0 | 2293.9 | -91.38 | [-91.52, -91.24] | [-91.50, -91.26] | 0.086 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8762 | 0.4313 | -50.77 | [-51.14, -50.40] | [-51.08, -50.46] | 0.494 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1258 | 0.3485 | -69.05 | [-69.35, -68.75] | [-69.30, -68.80] | 0.309 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5086 | 0.1951 | -61.64 | [-62.17, -61.10] | [-62.08, -61.20] | 0.383 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7437 | 0.2185 | -70.62 | [-71.11, -70.13] | [-71.03, -70.21] | 0.294 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2523 | 0.4136 | -66.98 | [-67.21, -66.74] | [-67.17, -66.78] | 0.330 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2050.1 | 5646.1 | +175.41 | [+172.49, +178.38] | [+172.95, +177.91] | 2.738 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6254 | 6695 | +7.05 | [+6.36, +7.75] | [+6.48, +7.63] | 1.072 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20614 | 20612 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1377 | 0.0704 | -0.0673 | [-0.0690, -0.0656] |
| multi_s | 1.1539 | 0.4486 | -0.7044 | [-0.7101, -0.6986] |
| client_wall_s | 1.3192 | 0.5488 | -0.7719 | [-0.7785, -0.7654] |
| client_cpu_s | 0.9426 | 0.4781 | -0.4658 | [-0.4705, -0.4611] |
| client_vcsw | 26672.5 | 2287.0 | -24325.0 | [-24466.8, -24183.3] |
| multi_client_cpu_s | 0.8700 | 0.4300 | -0.4448 | [-0.4493, -0.4404] |
| multi_broker_cpu_s | 1.1200 | 0.3500 | -0.7773 | [-0.7835, -0.7712] |
| broker_user_s | 0.5095 | 0.1942 | -0.3135 | [-0.3185, -0.3085] |
| broker_sys_s | 0.7391 | 0.2189 | -0.5253 | [-0.5317, -0.5188] |
| broker_cpu_s | 1.2495 | 0.4133 | -0.8388 | [-0.8445, -0.8330] |
| broker_vcsw | 2039.5 | 5642.0 | +3596.0 | [+3536.7, +3655.3] |
| broker_maxrss_kib | 6252 | 6698 | +441 | [+399, +484] |
| broker_ru_maxrss_kib | 20704 | 20704 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
