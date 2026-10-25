candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3746 | 2.0654 | -67.60 | [-67.93, -67.27] | [-67.88, -67.33] | 0.323 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7786 | 2.2259 | -61.48 | [-61.75, -61.21] | [-61.71, -61.25] | 0.384 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.1840 | 4.3220 | -64.53 | [-64.77, -64.28] | [-64.73, -64.32] | 0.354 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.2009 | 4.1221 | -49.74 | [-49.96, -49.51] | [-49.92, -49.55] | 0.502 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 218937.9 | 3233.9 | -98.52 | [-98.70, -98.35] | [-98.67, -98.38] | 0.014 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3865 | 2.1655 | -50.63 | [-51.01, -50.27] | [-50.95, -50.32] | 0.492 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.7483 | 1.8725 | -67.42 | [-67.81, -67.03] | [-67.75, -67.10] | 0.324 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.7230 | 1.6324 | -65.44 | [-65.83, -65.04] | [-65.77, -65.11] | 0.347 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.4345 | 1.7880 | -75.95 | [-76.25, -75.64] | [-76.21, -75.70] | 0.240 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.1575 | 3.4205 | -71.87 | [-72.16, -71.57] | [-72.12, -71.61] | 0.283 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 26.350 | 14949.375 | +56633.87 | [+51015.66, +63425.14] | [+51888.64, +62390.17] | 549.483 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8475 | 11452 | +35.12 | [+33.21, +36.98] | [+33.52, +36.71] | 1.357 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20492 | 20495 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3827 | 2.0745 | -4.3093 | [-4.3288, -4.2897] |
| multi_s | 5.8352 | 2.2278 | -3.5527 | [-3.5791, -3.5264] |
| client_wall_s | 12.2475 | 4.3527 | -7.8620 | [-7.8938, -7.8302] |
| client_cpu_s | 8.2844 | 4.1369 | -4.0788 | [-4.1124, -4.0452] |
| client_vcsw | 218576.5 | 3189.5 | -215704.0 | [-217512.6, -213895.3] |
| multi_client_cpu_s | 4.4300 | 2.1650 | -2.2210 | [-2.2436, -2.1984] |
| multi_broker_cpu_s | 5.8050 | 1.8800 | -3.8758 | [-3.9043, -3.8472] |
| broker_user_s | 4.7466 | 1.6394 | -3.0906 | [-3.1195, -3.0616] |
| broker_sys_s | 7.4537 | 1.7849 | -5.6465 | [-5.6738, -5.6191] |
| broker_cpu_s | 12.2194 | 3.4513 | -8.7370 | [-8.7721, -8.7019] |
| broker_vcsw | 26.500 | 15003.500 | +14923.025 | [+14687.328, +15158.722] |
| broker_maxrss_kib | 8474 | 11520 | +2977 | [+2824, +3129] |
| broker_ru_maxrss_kib | 20540 | 20540 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
