candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0609 | 0.0707 | +16.10 | [+14.24, +18.03] | [+14.53, +17.72] | 1.159 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4328 | 0.4470 | +3.27 | [+1.70, +4.47] | [+1.99, +4.33] | 1.043 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.5226 | 0.5467 | +4.61 | [+3.16, +5.76] | [+3.44, +5.60] | 1.052 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.4761 | 0.4784 | +0.50 | [-0.97, +1.66] | [-0.70, +1.50] | 1.013 | 0.0181 | no material change |
| client_vcsw | 60 | 2045.7 | 2276.2 | +11.27 | [+9.15, +13.54] | [+9.47, +13.16] | 1.094 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4180 | 0.4290 | +2.63 | [+1.02, +3.91] | [+1.30, +3.73] | 1.024 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2848 | 0.3487 | +22.41 | [+21.18, +23.68] | [+21.37, +23.48] | 1.214 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1192 | 0.1980 | +66.16 | [+62.84, +69.63] | [+63.35, +69.07] | 1.665 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2245 | 0.2167 | -3.50 | [-5.12, -1.88] | [-4.84, -2.14] | 0.967 | 0.0003 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.3437 | 0.4147 | +20.65 | [+19.65, +21.69] | [+19.81, +21.54] | 1.211 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 20483.1 | 5755.5 | -71.90 | [-72.56, -71.34] | [-72.43, -71.42] | 0.285 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8214 | 6708 | -18.33 | [-18.87, -17.80] | [-18.78, -17.89] | 0.817 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20395 | 20393 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0600 | 0.0707 | +0.0098 | [+0.0087, +0.0109] |
| multi_s | 0.4266 | 0.4431 | +0.0142 | [+0.0080, +0.0203] |
| client_wall_s | 0.5153 | 0.5424 | +0.0241 | [+0.0173, +0.0309] |
| client_cpu_s | 0.4690 | 0.4742 | +0.0024 | [-0.0041, +0.0088] |
| client_vcsw | 2039.0 | 2235.5 | +230.5 | [+184.1, +276.9] |
| multi_client_cpu_s | 0.4100 | 0.4300 | +0.0110 | [+0.0048, +0.0172] |
| multi_broker_cpu_s | 0.2800 | 0.3500 | +0.0638 | [+0.0605, +0.0672] |
| broker_user_s | 0.1194 | 0.1967 | +0.0788 | [+0.0757, +0.0820] |
| broker_sys_s | 0.2238 | 0.2171 | -0.0079 | [-0.0116, -0.0041] |
| broker_cpu_s | 0.3409 | 0.4122 | +0.0710 | [+0.0676, +0.0743] |
| broker_vcsw | 20068.0 | 5772.0 | -14727.6 | [-15130.1, -14325.1] |
| broker_maxrss_kib | 8228 | 6722 | -1506 | [-1558, -1454] |
| broker_ru_maxrss_kib | 20444 | 20444 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
