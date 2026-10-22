candidate concurrent100 against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5009 | 0.3852 | -23.09 | [-26.44, -19.86] | [-25.87, -20.37] | 0.772 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.4733 | 0.4699 | -0.73 | [-3.43, +2.00] | [-3.01, +1.57] | 0.981 | 0.4395 | no material change |
| client_wall_s | 60 | 0.9974 | 0.8668 | -13.09 | [-15.59, -10.64] | [-15.16, -11.04] | 0.869 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8478 | 0.8160 | -3.75 | [-5.78, -1.65] | [-5.44, -2.05] | 0.965 | 0.0004 | inconclusive; repeatable change (-) |
| client_vcsw | 60 | 242.9 | 168.3 | -30.68 | [-37.07, -23.82] | [-36.09, -25.03] | 0.709 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.4625 | 0.4538 | -1.87 | [-4.44, +0.75] | [-4.02, +0.32] | 0.978 | 0.0976 | no material change |
| multi_broker_cpu_s | 60 | 0.2100 | 0.2018 | -3.89 | [-7.02, -0.49] | [-6.51, -1.06] | 0.952 | 0.0096 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.3075 | 0.3106 | +1.00 | [-2.54, +4.69] | [-2.02, +4.07] | 1.020 | 0.6964 | no material change |
| broker_sys_s | 60 | 0.2913 | 0.2217 | -23.89 | [-28.65, -19.31] | [-27.83, -19.97] | 0.805 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5988 | 0.5323 | -11.11 | [-14.37, -8.09] | [-13.78, -8.52] | 0.894 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1094.4 | 310.2 | -71.66 | [-73.09, -70.16] | [-72.86, -70.40] | 0.283 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 52759 | 4761 | -90.98 | [-91.14, -90.80] | [-91.11, -90.83] | 0.089 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 52732 | 18616 | -64.70 | [-65.35, -63.98] | [-65.25, -64.10] | 0.345 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4813 | 0.3787 | -0.1156 | [-0.1367, -0.0946] |
| multi_s | 0.4668 | 0.4591 | -0.0034 | [-0.0168, +0.0099] |
| client_wall_s | 0.9838 | 0.8637 | -0.1306 | [-0.1580, -0.1032] |
| client_cpu_s | 0.8364 | 0.8067 | -0.0318 | [-0.0497, -0.0139] |
| client_vcsw | 228.0 | 160.5 | -74.5 | [-94.3, -54.7] |
| multi_client_cpu_s | 0.4600 | 0.4500 | -0.0087 | [-0.0210, +0.0037] |
| multi_broker_cpu_s | 0.2100 | 0.2000 | -0.0082 | [-0.0152, -0.0011] |
| broker_user_s | 0.3023 | 0.3048 | +0.0031 | [-0.0082, +0.0144] |
| broker_sys_s | 0.2807 | 0.2169 | -0.0696 | [-0.0877, -0.0515] |
| broker_cpu_s | 0.5715 | 0.5298 | -0.0665 | [-0.0875, -0.0455] |
| broker_vcsw | 1105.5 | 306.5 | -784.2 | [-821.0, -747.5] |
| broker_maxrss_kib | 53966 | 4744 | -47998 | [-49036, -46961] |
| broker_ru_maxrss_kib | 53932 | 18616 | -34116 | [-35161, -33071] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
