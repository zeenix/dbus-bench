candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8840 | 2.0257 | +7.52 | [+6.55, +8.63] | [+6.69, +8.44] | 1.063 | <0.0001 | slower/larger |
| multi_s | 40 | 2.1346 | 2.2359 | +4.75 | [+3.55, +5.98] | [+3.73, +5.77] | 1.048 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 40 | 4.0486 | 4.2924 | +6.02 | [+5.01, +7.10] | [+5.17, +6.92] | 1.056 | <0.0001 | slower/larger |
| client_cpu_s | 40 | 4.0063 | 4.0967 | +2.26 | [+1.38, +3.20] | [+1.51, +3.04] | 1.020 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 523.3 | 3195.0 | +510.55 | [+432.72, +614.82] | [+443.27, +597.48] | 6.103 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.1175 | 2.1778 | +2.85 | [+1.71, +4.00] | [+1.89, +3.82] | 1.028 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.5112 | 1.9433 | +28.59 | [+26.41, +30.84] | [+26.72, +30.46] | 1.267 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9522 | 1.6333 | +71.53 | [+69.12, +73.98] | [+69.50, +73.57] | 1.714 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.7413 | 1.7700 | +1.65 | [+0.03, +3.36] | [+0.27, +3.09] | 1.010 | 0.1923 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 2.6935 | 3.4033 | +26.35 | [+24.95, +27.84] | [+25.15, +27.61] | 1.259 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 104299.9 | 14743.4 | -85.86 | [-86.30, -85.43] | [-86.24, -85.49] | 0.142 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9333 | 11316 | +21.25 | [+19.46, +23.14] | [+19.73, +22.82] | 1.207 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20495 | 20492 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8979 | 2.0330 | +0.1416 | [+0.1210, +0.1622] |
| multi_s | 2.1378 | 2.2457 | +0.1013 | [+0.0745, +0.1281] |
| client_wall_s | 4.0648 | 4.3335 | +0.2437 | [+0.2000, +0.2875] |
| client_cpu_s | 4.0209 | 4.1208 | +0.0904 | [+0.0524, +0.1283] |
| client_vcsw | 529.0 | 3288.0 | +2671.7 | [+2339.1, +3004.4] |
| multi_client_cpu_s | 2.1200 | 2.1900 | +0.0603 | [+0.0351, +0.0854] |
| multi_broker_cpu_s | 1.5100 | 1.9250 | +0.4320 | [+0.3968, +0.4672] |
| broker_user_s | 0.9531 | 1.6410 | +0.6811 | [+0.6581, +0.7041] |
| broker_sys_s | 1.7550 | 1.7638 | +0.0287 | [-0.0021, +0.0594] |
| broker_cpu_s | 2.7239 | 3.4101 | +0.7098 | [+0.6687, +0.7509] |
| broker_vcsw | 105133.0 | 15205.5 | -89556.5 | [-91339.0, -87774.1] |
| broker_maxrss_kib | 9360 | 11302 | +1983 | [+1815, +2151] |
| broker_ru_maxrss_kib | 20540 | 20540 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
