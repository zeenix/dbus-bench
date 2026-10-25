candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3746 | 2.0257 | -68.22 | [-68.54, -67.89] | [-68.50, -67.95] | 0.318 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7786 | 2.2359 | -61.31 | [-61.61, -61.00] | [-61.56, -61.05] | 0.386 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.1840 | 4.2924 | -64.77 | [-65.05, -64.48] | [-65.01, -64.53] | 0.352 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.2009 | 4.0967 | -50.05 | [-50.38, -49.68] | [-50.33, -49.75] | 0.498 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 218937.9 | 3195.0 | -98.54 | [-98.70, -98.37] | [-98.68, -98.40] | 0.015 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3865 | 2.1778 | -50.35 | [-50.75, -49.96] | [-50.68, -50.03] | 0.496 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.7483 | 1.9433 | -66.19 | [-66.69, -65.67] | [-66.62, -65.76] | 0.333 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.7230 | 1.6333 | -65.42 | [-65.87, -65.00] | [-65.80, -65.05] | 0.349 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.4345 | 1.7700 | -76.19 | [-76.55, -75.80] | [-76.50, -75.87] | 0.236 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.1575 | 3.4033 | -72.01 | [-72.32, -71.68] | [-72.27, -71.74] | 0.278 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 26.350 | 14743.350 | +55851.99 | [+50411.07, +62529.04] | [+51211.43, +61352.24] | 583.296 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8475 | 11316 | +33.53 | [+31.24, +35.86] | [+31.62, +35.48] | 1.326 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20492 | 20492 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3827 | 2.0330 | -4.3490 | [-4.3726, -4.3253] |
| multi_s | 5.8352 | 2.2457 | -3.5427 | [-3.5714, -3.5140] |
| client_wall_s | 12.2475 | 4.3335 | -7.8916 | [-7.9343, -7.8489] |
| client_cpu_s | 8.2844 | 4.1208 | -4.1042 | [-4.1465, -4.0619] |
| client_vcsw | 218576.5 | 3288.0 | -215742.8 | [-217626.7, -213859.0] |
| multi_client_cpu_s | 4.4300 | 2.1900 | -2.2087 | [-2.2323, -2.1852] |
| multi_broker_cpu_s | 5.8050 | 1.9250 | -3.8050 | [-3.8368, -3.7732] |
| broker_user_s | 4.7466 | 1.6410 | -3.0897 | [-3.1226, -3.0568] |
| broker_sys_s | 7.4537 | 1.7638 | -5.6645 | [-5.6993, -5.6297] |
| broker_cpu_s | 12.2194 | 3.4101 | -8.7542 | [-8.7947, -8.7138] |
| broker_vcsw | 26.500 | 15205.500 | +14717.000 | [+14335.484, +15098.516] |
| broker_maxrss_kib | 8474 | 11302 | +2841 | [+2662, +3021] |
| broker_ru_maxrss_kib | 20540 | 20540 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
