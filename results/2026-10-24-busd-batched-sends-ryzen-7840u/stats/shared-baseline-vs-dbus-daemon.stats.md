candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3939 | 2.0774 | -67.51 | [-67.77, -67.23] | [-67.73, -67.27] | 0.324 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7512 | 2.2495 | -60.89 | [-61.26, -60.48] | [-61.20, -60.55] | 0.390 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.1779 | 4.3598 | -64.20 | [-64.45, -63.92] | [-64.41, -63.97] | 0.357 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.2030 | 4.1674 | -49.20 | [-49.57, -48.77] | [-49.51, -48.85] | 0.507 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 212676.5 | 2871.6 | -98.65 | [-98.73, -98.56] | [-98.72, -98.58] | 0.013 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3803 | 2.1957 | -49.87 | [-50.37, -49.32] | [-50.29, -49.42] | 0.498 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.7190 | 1.8837 | -67.06 | [-67.49, -66.60] | [-67.43, -66.68] | 0.328 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.6936 | 1.6426 | -65.00 | [-65.44, -64.54] | [-65.37, -64.62] | 0.348 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.4553 | 1.8073 | -75.76 | [-75.99, -75.51] | [-75.95, -75.55] | 0.240 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.1489 | 3.4500 | -71.60 | [-71.83, -71.36] | [-71.79, -71.40] | 0.283 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 26.375 | 14886.800 | +56342.84 | [+50783.02, +62975.12] | [+51613.32, +61885.44] | 590.666 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8467 | 11361 | +34.18 | [+31.98, +36.37] | [+32.33, +36.02] | 1.335 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20510 | 20510 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3892 | 2.0683 | -4.3165 | [-4.3424, -4.2905] |
| multi_s | 5.7202 | 2.2407 | -3.5017 | [-3.5386, -3.4647] |
| client_wall_s | 12.1573 | 4.3412 | -7.8181 | [-7.8694, -7.7669] |
| client_cpu_s | 8.1968 | 4.1478 | -4.0357 | [-4.0810, -3.9904] |
| client_vcsw | 212622.0 | 2812.0 | -209805.0 | [-211367.9, -208242.0] |
| multi_client_cpu_s | 4.3700 | 2.1900 | -2.1845 | [-2.2173, -2.1517] |
| multi_broker_cpu_s | 5.6950 | 1.8850 | -3.8352 | [-3.8763, -3.7942] |
| broker_user_s | 4.6795 | 1.6272 | -3.0510 | [-3.0870, -3.0149] |
| broker_sys_s | 7.4540 | 1.7948 | -5.6480 | [-5.6769, -5.6190] |
| broker_cpu_s | 12.1261 | 3.4485 | -8.6989 | [-8.7454, -8.6525] |
| broker_vcsw | 25.500 | 14919.500 | +14860.425 | [+14627.433, +15093.417] |
| broker_maxrss_kib | 8468 | 11322 | +2894 | [+2714, +3074] |
| broker_ru_maxrss_kib | 20564 | 20564 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
