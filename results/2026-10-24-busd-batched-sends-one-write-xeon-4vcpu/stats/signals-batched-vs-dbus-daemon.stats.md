candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5491 | 0.4382 | -20.21 | [-23.75, -16.31] | [-23.20, -16.96] | 0.801 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.7559 | 0.5040 | -33.32 | [-35.28, -31.13] | [-34.97, -31.47] | 0.658 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3168 | 0.9557 | -27.43 | [-29.49, -25.12] | [-29.15, -25.51] | 0.716 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2279 | 0.9187 | -25.18 | [-27.28, -22.75] | [-26.95, -23.16] | 0.746 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 2380.7 | 112.9 | -95.26 | [-96.58, -93.42] | [-96.39, -93.72] | 0.046 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7465 | 0.4953 | -33.65 | [-35.67, -31.38] | [-35.36, -31.75] | 0.655 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.3963 | 0.1403 | -64.59 | [-66.74, -61.79] | [-66.47, -62.32] | 0.341 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6157 | 0.3520 | -42.84 | [-45.04, -40.46] | [-44.71, -40.87] | 0.569 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3263 | 0.1474 | -54.81 | [-58.14, -50.56] | [-57.69, -51.25] | 0.437 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.9420 | 0.4994 | -46.98 | [-48.85, -44.90] | [-48.56, -45.23] | 0.521 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 9270.5 | 352.4 | -96.20 | [-96.51, -95.84] | [-96.46, -95.90] | 0.037 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7787 | 4910 | -36.95 | [-38.33, -35.65] | [-38.09, -35.85] | 0.641 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18946 | 18946 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5337 | 0.4342 | -0.1110 | [-0.1360, -0.0859] |
| multi_s | 0.7544 | 0.4878 | -0.2519 | [-0.2717, -0.2320] |
| client_wall_s | 1.2958 | 0.9364 | -0.3611 | [-0.3966, -0.3257] |
| client_cpu_s | 1.2184 | 0.8978 | -0.3091 | [-0.3419, -0.2764] |
| client_vcsw | 1994.5 | 92.5 | -2267.8 | [-2668.0, -1867.6] |
| multi_client_cpu_s | 0.7500 | 0.4800 | -0.2512 | [-0.2717, -0.2307] |
| multi_broker_cpu_s | 0.4000 | 0.1300 | -0.2560 | [-0.2682, -0.2438] |
| broker_user_s | 0.5988 | 0.3501 | -0.2638 | [-0.2853, -0.2422] |
| broker_sys_s | 0.3268 | 0.1385 | -0.1788 | [-0.1960, -0.1616] |
| broker_cpu_s | 0.9358 | 0.4865 | -0.4426 | [-0.4719, -0.4133] |
| broker_vcsw | 9388.0 | 338.0 | -8918.0 | [-9263.2, -8572.9] |
| broker_maxrss_kib | 7656 | 4908 | -2877 | [-3046, -2708] |
| broker_ru_maxrss_kib | 19040 | 19040 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
