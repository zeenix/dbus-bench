candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1351 | 0.0696 | -48.44 | [-49.22, -47.62] | [-49.10, -47.76] | 0.514 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1543 | 0.4494 | -61.07 | [-61.47, -60.71] | [-61.41, -60.76] | 0.389 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3187 | 0.5482 | -58.43 | [-58.81, -58.08] | [-58.75, -58.13] | 0.415 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9427 | 0.4774 | -49.36 | [-49.79, -48.94] | [-49.71, -49.02] | 0.505 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 26987.5 | 2227.2 | -91.75 | [-91.87, -91.62] | [-91.85, -91.64] | 0.082 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8735 | 0.4317 | -50.58 | [-51.11, -50.10] | [-51.02, -50.16] | 0.494 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1263 | 0.3507 | -68.87 | [-69.25, -68.52] | [-69.18, -68.57] | 0.311 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.4978 | 0.1948 | -60.87 | [-61.65, -60.09] | [-61.53, -60.22] | 0.390 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7516 | 0.2189 | -70.88 | [-71.36, -70.41] | [-71.28, -70.48] | 0.289 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2495 | 0.4136 | -66.89 | [-67.19, -66.65] | [-67.13, -66.68] | 0.331 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2051.9 | 5735.5 | +179.52 | [+176.55, +182.45] | [+176.99, +182.00] | 2.791 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6230 | 6682 | +7.24 | [+6.66, +7.83] | [+6.75, +7.73] | 1.073 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20395 | 20393 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1336 | 0.0687 | -0.0654 | [-0.0672, -0.0637] |
| multi_s | 1.1426 | 0.4461 | -0.7049 | [-0.7133, -0.6965] |
| client_wall_s | 1.3074 | 0.5427 | -0.7704 | [-0.7793, -0.7616] |
| client_cpu_s | 0.9352 | 0.4714 | -0.4653 | [-0.4710, -0.4597] |
| client_vcsw | 26744.0 | 2222.0 | -24760.3 | [-25077.9, -24442.7] |
| multi_client_cpu_s | 0.8700 | 0.4300 | -0.4418 | [-0.4480, -0.4357] |
| multi_broker_cpu_s | 1.1200 | 0.3500 | -0.7757 | [-0.7845, -0.7668] |
| broker_user_s | 0.4922 | 0.1965 | -0.3030 | [-0.3093, -0.2967] |
| broker_sys_s | 0.7483 | 0.2185 | -0.5328 | [-0.5396, -0.5260] |
| broker_cpu_s | 1.2394 | 0.4091 | -0.8358 | [-0.8442, -0.8274] |
| broker_vcsw | 2044.0 | 5717.0 | +3683.6 | [+3625.5, +3741.7] |
| broker_maxrss_kib | 6228 | 6658 | +451 | [+415, +487] |
| broker_ru_maxrss_kib | 20444 | 20444 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
