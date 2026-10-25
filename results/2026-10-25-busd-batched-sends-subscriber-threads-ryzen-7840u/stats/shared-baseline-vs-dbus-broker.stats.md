candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8840 | 2.0654 | +9.62 | [+8.68, +10.55] | [+8.84, +10.39] | 1.091 | <0.0001 | slower/larger |
| multi_s | 40 | 2.1346 | 2.2259 | +4.28 | [+3.29, +5.25] | [+3.45, +5.11] | 1.037 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 40 | 4.0486 | 4.3220 | +6.75 | [+5.94, +7.54] | [+6.08, +7.42] | 1.067 | <0.0001 | slower/larger |
| client_cpu_s | 40 | 4.0063 | 4.1221 | +2.89 | [+2.25, +3.51] | [+2.36, +3.42] | 1.028 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 523.3 | 3233.9 | +517.98 | [+447.23, +613.10] | [+456.61, +596.21] | 6.043 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.1175 | 2.1655 | +2.27 | [+1.37, +3.17] | [+1.51, +3.03] | 1.019 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.5112 | 1.8725 | +23.90 | [+22.33, +25.59] | [+22.56, +25.31] | 1.231 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9522 | 1.6324 | +71.44 | [+69.23, +73.67] | [+69.59, +73.33] | 1.708 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.7413 | 1.7880 | +2.68 | [+1.45, +3.95] | [+1.63, +3.75] | 1.018 | 0.0011 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 2.6935 | 3.4205 | +26.99 | [+25.85, +28.19] | [+26.04, +27.99] | 1.267 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 104299.9 | 14949.4 | -85.67 | [-85.97, -85.35] | [-85.92, -85.40] | 0.144 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9333 | 11452 | +22.70 | [+20.69, +24.68] | [+21.02, +24.36] | 1.235 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20495 | 20495 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8979 | 2.0745 | +0.1813 | [+0.1628, +0.1998] |
| multi_s | 2.1378 | 2.2278 | +0.0913 | [+0.0698, +0.1127] |
| client_wall_s | 4.0648 | 4.3527 | +0.2733 | [+0.2397, +0.3070] |
| client_cpu_s | 4.0209 | 4.1369 | +0.1158 | [+0.0897, +0.1419] |
| client_vcsw | 529.0 | 3189.5 | +2710.6 | [+2359.7, +3061.5] |
| multi_client_cpu_s | 2.1200 | 2.1650 | +0.0480 | [+0.0284, +0.0676] |
| multi_broker_cpu_s | 1.5100 | 1.8800 | +0.3613 | [+0.3359, +0.3866] |
| broker_user_s | 0.9531 | 1.6394 | +0.6803 | [+0.6587, +0.7019] |
| broker_sys_s | 1.7550 | 1.7849 | +0.0467 | [+0.0240, +0.0694] |
| broker_cpu_s | 2.7239 | 3.4513 | +0.7270 | [+0.6937, +0.7603] |
| broker_vcsw | 105133.0 | 15003.5 | -89350.5 | [-91042.8, -87658.2] |
| broker_maxrss_kib | 9360 | 11520 | +2118 | [+1935, +2302] |
| broker_ru_maxrss_kib | 20540 | 20540 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
