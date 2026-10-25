candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.8667 | 3.4153 | -11.67 | [-14.19, -9.16] | [-13.80, -9.56] | 0.884 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.1988 | 3.8547 | -25.85 | [-27.98, -23.73] | [-27.62, -24.08] | 0.745 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 9.0720 | 7.2765 | -19.79 | [-21.62, -17.99] | [-21.32, -18.26] | 0.809 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 7.2476 | 6.7359 | -7.06 | [-8.87, -5.27] | [-8.58, -5.56] | 0.931 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 59181.4 | 9338.4 | -84.22 | [-85.90, -82.42] | [-85.66, -82.73] | 0.153 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.8498 | 3.5410 | -8.02 | [-10.15, -5.86] | [-9.80, -6.22] | 0.938 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 4.9820 | 2.8725 | -42.34 | [-44.24, -40.43] | [-43.95, -40.76] | 0.571 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 5.1778 | 2.6937 | -47.98 | [-49.05, -46.90] | [-48.90, -47.07] | 0.515 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 3.4369 | 2.3127 | -32.71 | [-35.25, -30.22] | [-34.84, -30.63] | 0.680 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 8.6146 | 5.0063 | -41.89 | [-43.25, -40.53] | [-43.05, -40.75] | 0.581 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 3209.3 | 19247.6 | +499.73 | [+451.29, +557.03] | [+458.86, +546.69] | 6.401 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7283 | 7086 | -2.71 | [-3.83, -1.59] | [-3.65, -1.75] | 0.973 | 0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18750 | 18754 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.8390 | 3.4187 | -0.4514 | [-0.5616, -0.3412] |
| multi_s | 5.1624 | 3.8322 | -1.3441 | [-1.4663, -1.2219] |
| client_wall_s | 9.0027 | 7.2479 | -1.7955 | [-1.9838, -1.6072] |
| client_cpu_s | 7.1882 | 6.7028 | -0.5117 | [-0.6528, -0.3707] |
| client_vcsw | 59638.0 | 9331.0 | -49843.1 | [-52373.1, -47313.0] |
| multi_client_cpu_s | 3.8100 | 3.5050 | -0.3087 | [-0.3977, -0.2198] |
| multi_broker_cpu_s | 4.9550 | 2.8600 | -2.1095 | [-2.2196, -1.9994] |
| broker_user_s | 5.1349 | 2.6713 | -2.4841 | [-2.5650, -2.4031] |
| broker_sys_s | 3.4381 | 2.3395 | -1.1242 | [-1.2275, -1.0210] |
| broker_cpu_s | 8.5537 | 5.0193 | -3.6083 | [-3.7617, -3.4549] |
| broker_vcsw | 3073.0 | 19455.5 | +16038.2 | [+15608.8, +16467.6] |
| broker_maxrss_kib | 7240 | 7112 | -198 | [-284, -111] |
| broker_ru_maxrss_kib | 18744 | 18744 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
