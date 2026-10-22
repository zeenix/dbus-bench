candidate timeout against baseline baseline, from signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5187 | 0.4174 | -19.52 | [-22.02, -16.72] | [-21.65, -17.20] | 0.785 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.5005 | 0.4954 | -1.02 | [-4.26, +2.45] | [-3.80, +1.89] | 0.981 | 0.3275 | no material change |
| client_wall_s | 60 | 1.0454 | 0.9255 | -11.46 | [-13.49, -9.22] | [-13.20, -9.59] | 0.892 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8894 | 0.8616 | -3.13 | [-5.16, -0.95] | [-4.86, -1.32] | 0.961 | 0.0018 | no material change; repeatable change (-) |
| client_vcsw | 60 | 241.0 | 184.3 | -23.51 | [-32.02, -14.02] | [-30.74, -15.54] | 0.704 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.4860 | 0.4802 | -1.20 | [-4.41, +2.13] | [-3.91, +1.61] | 0.989 | 0.3857 | no material change |
| multi_broker_cpu_s | 60 | 0.2225 | 0.2110 | -5.17 | [-9.81, -0.62] | [-9.07, -1.37] | 0.952 | 0.0539 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.3314 | 0.3371 | +1.73 | [-1.95, +5.83] | [-1.44, +5.15] | 0.985 | 0.8888 | inconclusive |
| broker_sys_s | 60 | 0.2813 | 0.2271 | -19.25 | [-22.64, -15.83] | [-22.06, -16.36] | 0.828 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6126 | 0.5642 | -7.90 | [-10.18, -5.47] | [-9.79, -5.90] | 0.921 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1112.1 | 309.0 | -72.21 | [-74.04, -70.20] | [-73.77, -70.52] | 0.274 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 51375 | 4827 | -90.60 | [-90.84, -90.34] | [-90.80, -90.39] | 0.092 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 51297 | 18652 | -63.64 | [-64.53, -62.65] | [-64.39, -62.83] | 0.353 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5015 | 0.4086 | -0.1013 | [-0.1173, -0.0852] |
| multi_s | 0.4849 | 0.4870 | -0.0051 | [-0.0228, +0.0125] |
| client_wall_s | 1.0212 | 0.9015 | -0.1198 | [-0.1443, -0.0954] |
| client_cpu_s | 0.8843 | 0.8524 | -0.0279 | [-0.0474, -0.0083] |
| client_vcsw | 234.5 | 160.0 | -56.6 | [-81.5, -31.8] |
| multi_client_cpu_s | 0.4750 | 0.4700 | -0.0058 | [-0.0223, +0.0107] |
| multi_broker_cpu_s | 0.2100 | 0.2100 | -0.0115 | [-0.0224, -0.0006] |
| broker_user_s | 0.3285 | 0.3331 | +0.0057 | [-0.0076, +0.0191] |
| broker_sys_s | 0.2749 | 0.2268 | -0.0541 | [-0.0654, -0.0429] |
| broker_cpu_s | 0.5958 | 0.5604 | -0.0484 | [-0.0636, -0.0332] |
| broker_vcsw | 1125.5 | 309.0 | -803.1 | [-847.7, -758.5] |
| broker_maxrss_kib | 52876 | 4838 | -46548 | [-47893, -45203] |
| broker_ru_maxrss_kib | 52868 | 18652 | -32645 | [-33994, -31295] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
