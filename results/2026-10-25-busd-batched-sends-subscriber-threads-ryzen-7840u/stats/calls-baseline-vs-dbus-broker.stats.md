candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0609 | 0.0696 | +14.39 | [+12.54, +16.23] | [+12.85, +15.94] | 1.143 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4328 | 0.4494 | +3.83 | [+2.19, +5.11] | [+2.50, +4.94] | 1.044 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.5226 | 0.5482 | +4.91 | [+3.45, +6.10] | [+3.71, +5.93] | 1.055 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.4761 | 0.4774 | +0.29 | [-1.15, +1.37] | [-0.89, +1.24] | 1.005 | 0.0343 | no material change |
| client_vcsw | 60 | 2045.7 | 2227.2 | +8.88 | [+7.17, +10.65] | [+7.43, +10.36] | 1.082 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4180 | 0.4317 | +3.27 | [+1.45, +4.73] | [+1.78, +4.55] | 1.048 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2848 | 0.3507 | +23.11 | [+21.61, +24.62] | [+21.87, +24.38] | 1.241 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1192 | 0.1948 | +63.46 | [+59.71, +67.26] | [+60.28, +66.61] | 1.650 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2245 | 0.2189 | -2.52 | [-4.33, -0.63] | [-4.04, -0.93] | 0.977 | 0.0086 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.3437 | 0.4136 | +20.36 | [+19.43, +21.24] | [+19.60, +21.10] | 1.207 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 20483.1 | 5735.5 | -72.00 | [-72.61, -71.45] | [-72.50, -71.53] | 0.286 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8214 | 6682 | -18.66 | [-19.18, -18.12] | [-19.11, -18.20] | 0.813 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20395 | 20393 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0600 | 0.0687 | +0.0088 | [+0.0077, +0.0098] |
| multi_s | 0.4266 | 0.4461 | +0.0166 | [+0.0102, +0.0229] |
| client_wall_s | 0.5153 | 0.5427 | +0.0256 | [+0.0187, +0.0325] |
| client_cpu_s | 0.4690 | 0.4714 | +0.0014 | [-0.0049, +0.0076] |
| client_vcsw | 2039.0 | 2222.0 | +181.6 | [+145.1, +218.0] |
| multi_client_cpu_s | 0.4100 | 0.4300 | +0.0137 | [+0.0067, +0.0206] |
| multi_broker_cpu_s | 0.2800 | 0.3500 | +0.0658 | [+0.0617, +0.0700] |
| broker_user_s | 0.1194 | 0.1965 | +0.0756 | [+0.0717, +0.0795] |
| broker_sys_s | 0.2238 | 0.2185 | -0.0057 | [-0.0099, -0.0014] |
| broker_cpu_s | 0.3409 | 0.4091 | +0.0700 | [+0.0670, +0.0729] |
| broker_vcsw | 20068.0 | 5717.0 | -14747.6 | [-15146.6, -14348.5] |
| broker_maxrss_kib | 8228 | 6658 | -1533 | [-1586, -1480] |
| broker_ru_maxrss_kib | 20444 | 20444 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
