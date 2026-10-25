candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2191 | 0.2015 | -8.04 | [-9.94, -6.20] | [-9.66, -6.49] | 0.930 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.9034 | 0.7795 | -13.72 | [-15.97, -11.44] | [-15.62, -11.76] | 0.865 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1289 | 0.9873 | -12.54 | [-14.47, -10.58] | [-14.17, -10.88] | 0.874 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8687 | 0.8456 | -2.66 | [-4.55, -0.68] | [-4.26, -0.99] | 0.965 | 0.0077 | no material change; repeatable change (-) |
| client_vcsw | 60 | 8265.7 | 4741.6 | -42.64 | [-45.19, -39.94] | [-44.77, -40.39] | 0.570 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7620 | 0.7392 | -3.00 | [-5.11, -0.77] | [-4.81, -1.11] | 0.960 | 0.0068 | no material change; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.8545 | 0.5602 | -34.45 | [-36.36, -32.51] | [-36.05, -32.82] | 0.648 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5750 | 0.3432 | -40.31 | [-41.91, -38.71] | [-41.63, -38.95] | 0.594 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.4071 | 0.3269 | -19.70 | [-23.59, -15.69] | [-23.01, -16.35] | 0.785 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.9821 | 0.6701 | -31.77 | [-33.49, -30.01] | [-33.25, -30.29] | 0.681 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2404.3 | 5289.4 | +120.00 | [+112.50, +127.80] | [+113.63, +126.61] | 2.207 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5041 | 4971 | -1.39 | [-1.88, -0.88] | [-1.80, -0.96] | 0.983 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18933 | 18930 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2169 | 0.2019 | -0.0176 | [-0.0220, -0.0132] |
| multi_s | 0.9051 | 0.7810 | -0.1239 | [-0.1468, -0.1011] |
| client_wall_s | 1.1358 | 0.9903 | -0.1415 | [-0.1660, -0.1171] |
| client_cpu_s | 0.8733 | 0.8464 | -0.0231 | [-0.0406, -0.0057] |
| client_vcsw | 8077.0 | 4577.5 | -3524.2 | [-3846.0, -3202.3] |
| multi_client_cpu_s | 0.7700 | 0.7300 | -0.0228 | [-0.0402, -0.0055] |
| multi_broker_cpu_s | 0.8550 | 0.5600 | -0.2943 | [-0.3150, -0.2736] |
| broker_user_s | 0.5725 | 0.3418 | -0.2318 | [-0.2440, -0.2196] |
| broker_sys_s | 0.4104 | 0.3282 | -0.0802 | [-0.0984, -0.0620] |
| broker_cpu_s | 0.9805 | 0.6617 | -0.3120 | [-0.3332, -0.2908] |
| broker_vcsw | 2392.0 | 5343.0 | +2885.1 | [+2754.9, +3015.4] |
| broker_maxrss_kib | 5038 | 4976 | -70 | [-96, -44] |
| broker_ru_maxrss_kib | 18956 | 18956 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
