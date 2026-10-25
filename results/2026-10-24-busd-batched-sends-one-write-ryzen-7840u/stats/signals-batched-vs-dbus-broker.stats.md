candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3093 | 0.3015 | -2.52 | [-3.20, -1.82] | [-3.09, -1.93] | 0.972 | <0.0001 | no material change; repeatable change (-) |
| multi_s | 60 | 0.3871 | 0.3647 | -5.79 | [-6.59, -4.90] | [-6.47, -5.05] | 0.944 | <0.0001 | inconclusive; repeatable change (-) |
| client_wall_s | 60 | 0.7277 | 0.7228 | -0.67 | [-1.30, -0.01] | [-1.20, -0.11] | 0.995 | 0.0445 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 0.6999 | 0.6687 | -4.45 | [-5.07, -3.79] | [-4.97, -3.91] | 0.958 | <0.0001 | no material change; repeatable change (-) |
| client_vcsw | 60 | 10.283 | 45.100 | +338.57 | [+299.41, +374.14] | [+306.65, +369.51] | 4.528 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.3737 | 0.3525 | -5.66 | [-6.64, -4.68] | [-6.49, -4.85] | 0.946 | <0.0001 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.1335 | 0.0912 | -31.71 | [-33.33, -30.08] | [-33.05, -30.34] | 0.692 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.1278 | 0.2329 | +82.18 | [+77.47, +87.21] | [+78.13, +86.39] | 1.809 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2620 | 0.1306 | -50.14 | [-51.27, -49.02] | [-51.08, -49.20] | 0.499 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.3898 | 0.3635 | -6.75 | [-7.49, -5.98] | [-7.38, -6.11] | 0.930 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 7183.3 | 672.3 | -90.64 | [-90.84, -90.44] | [-90.81, -90.47] | 0.095 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 40029 | 6598 | -83.52 | [-83.76, -83.26] | [-83.72, -83.31] | 0.163 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 35437 | 20527 | -42.07 | [-42.85, -41.24] | [-42.73, -41.39] | 0.571 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3085 | 0.2999 | -0.0078 | [-0.0100, -0.0055] |
| multi_s | 0.3850 | 0.3633 | -0.0224 | [-0.0259, -0.0189] |
| client_wall_s | 0.7263 | 0.7227 | -0.0049 | [-0.0097, +0.0000] |
| client_cpu_s | 0.6988 | 0.6668 | -0.0311 | [-0.0358, -0.0264] |
| client_vcsw | 10.000 | 45.500 | +34.817 | [+32.617, +37.017] |
| multi_client_cpu_s | 0.3700 | 0.3500 | -0.0212 | [-0.0250, -0.0173] |
| multi_broker_cpu_s | 0.1300 | 0.0900 | -0.0423 | [-0.0451, -0.0396] |
| broker_user_s | 0.1292 | 0.2306 | +0.1050 | [+0.1005, +0.1095] |
| broker_sys_s | 0.2608 | 0.1317 | -0.1314 | [-0.1352, -0.1275] |
| broker_cpu_s | 0.3915 | 0.3623 | -0.0263 | [-0.0295, -0.0232] |
| broker_vcsw | 7208.5 | 681.0 | -6510.9 | [-6553.1, -6468.8] |
| broker_maxrss_kib | 40422 | 6614 | -33431 | [-33948, -32914] |
| broker_ru_maxrss_kib | 35992 | 20572 | -14909 | [-15411, -14408] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
