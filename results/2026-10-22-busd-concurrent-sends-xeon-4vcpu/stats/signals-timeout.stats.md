candidate timeout against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5009 | 0.3927 | -21.59 | [-25.54, -17.80] | [-24.88, -18.36] | 0.801 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.4733 | 0.4660 | -1.54 | [-4.10, +1.13] | [-3.68, +0.69] | 0.994 | 0.2925 | no material change |
| client_wall_s | 60 | 0.9974 | 0.8702 | -12.76 | [-15.18, -10.34] | [-14.81, -10.71] | 0.877 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8478 | 0.8213 | -3.13 | [-4.99, -1.10] | [-4.72, -1.45] | 0.961 | 0.0020 | no material change; repeatable change (-) |
| client_vcsw | 60 | 242.9 | 171.3 | -29.47 | [-38.90, -16.88] | [-37.70, -19.02] | 0.662 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.4625 | 0.4553 | -1.55 | [-3.95, +0.91] | [-3.58, +0.51] | 0.990 | 0.3856 | no material change |
| multi_broker_cpu_s | 60 | 0.2100 | 0.2035 | -3.10 | [-5.80, -0.16] | [-5.39, -0.65] | 1.000 | 0.0181 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.3075 | 0.3082 | +0.22 | [-2.85, +3.43] | [-2.42, +2.92] | 1.007 | 0.8888 | no material change |
| broker_sys_s | 60 | 0.2913 | 0.2272 | -22.01 | [-27.14, -17.02] | [-26.27, -17.81] | 0.807 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5988 | 0.5354 | -10.60 | [-13.80, -7.58] | [-13.30, -7.98] | 0.921 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1094.4 | 312.6 | -71.44 | [-73.08, -69.67] | [-72.84, -70.02] | 0.271 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 52759 | 4735 | -91.03 | [-91.19, -90.84] | [-91.17, -90.88] | 0.088 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 52732 | 18616 | -64.70 | [-65.35, -63.98] | [-65.25, -64.10] | 0.345 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4813 | 0.3803 | -0.1081 | [-0.1319, -0.0844] |
| multi_s | 0.4668 | 0.4635 | -0.0073 | [-0.0199, +0.0054] |
| client_wall_s | 0.9838 | 0.8643 | -0.1273 | [-0.1542, -0.1004] |
| client_cpu_s | 0.8364 | 0.8168 | -0.0265 | [-0.0435, -0.0095] |
| client_vcsw | 228.0 | 150.5 | -71.6 | [-102.2, -41.0] |
| multi_client_cpu_s | 0.4600 | 0.4500 | -0.0072 | [-0.0187, +0.0043] |
| multi_broker_cpu_s | 0.2100 | 0.2000 | -0.0065 | [-0.0126, -0.0004] |
| broker_user_s | 0.3023 | 0.3030 | +0.0007 | [-0.0094, +0.0107] |
| broker_sys_s | 0.2807 | 0.2292 | -0.0641 | [-0.0829, -0.0454] |
| broker_cpu_s | 0.5715 | 0.5262 | -0.0635 | [-0.0842, -0.0427] |
| broker_vcsw | 1105.5 | 298.0 | -781.8 | [-817.1, -746.5] |
| broker_maxrss_kib | 53966 | 4722 | -48025 | [-49065, -46984] |
| broker_ru_maxrss_kib | 53932 | 18616 | -34116 | [-35161, -33071] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
