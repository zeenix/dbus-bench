candidate timeout against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out/shared-read-ahead.json
30 pairs (rounds 3 to 32); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 30 | 3.1152 | 3.5101 | +12.68 | [+9.22, +16.40] | [+9.78, +15.71] | 1.110 | <0.0001 | slower/larger |
| multi_s | 30 | 4.2211 | 4.1623 | -1.39 | [-4.57, +1.69] | [-4.02, +1.16] | 0.995 | 0.4528 | no material change |
| client_wall_s | 30 | 7.3432 | 7.6787 | +4.57 | [+1.93, +7.21] | [+2.37, +6.74] | 1.036 | 0.0026 | inconclusive; repeatable change (+) |
| client_cpu_s | 30 | 6.4935 | 6.9616 | +7.21 | [+5.17, +9.29] | [+5.47, +8.96] | 1.075 | <0.0001 | slower/larger |
| client_vcsw | 30 | 22699.0 | 13095.4 | -42.31 | [-48.89, -35.10] | [-47.93, -36.46] | 0.522 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 30 | 3.6583 | 3.7207 | +1.70 | [-0.80, +4.14] | [-0.39, +3.76] | 1.022 | 0.0896 | no material change |
| multi_broker_cpu_s | 30 | 3.4783 | 3.2343 | -7.01 | [-10.22, -3.81] | [-9.71, -4.35] | 0.929 | 0.0009 | inconclusive; repeatable change (-) |
| broker_user_s | 30 | 2.8537 | 2.7380 | -4.06 | [-6.71, -1.30] | [-6.30, -1.78] | 0.955 | 0.0104 | inconclusive; repeatable change (-) |
| broker_sys_s | 30 | 2.7783 | 2.5872 | -6.88 | [-9.88, -3.80] | [-9.42, -4.27] | 0.924 | 0.0005 | inconclusive; repeatable change (-) |
| broker_cpu_s | 30 | 5.6320 | 5.3252 | -5.45 | [-8.02, -2.82] | [-7.60, -3.25] | 0.932 | 0.0016 | inconclusive; repeatable change (-) |
| broker_vcsw | 30 | 14035.3 | 18309.7 | +30.45 | [+26.64, +34.61] | [+27.21, +33.85] | 1.305 | <0.0001 | slower/larger |
| broker_maxrss_kib | 30 | 7491 | 7030 | -6.16 | [-7.83, -4.51] | [-7.55, -4.79] | 0.930 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 30 | 18596 | 18596 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.1109 | 3.4858 | +0.3949 | [+0.2851, +0.5048] |
| multi_s | 4.2386 | 4.1207 | -0.0588 | [-0.1991, +0.0815] |
| client_wall_s | 7.3085 | 7.6327 | +0.3356 | [+0.1350, +0.5361] |
| client_cpu_s | 6.4767 | 6.8621 | +0.4680 | [+0.3305, +0.6056] |
| client_vcsw | 22593.0 | 12127.0 | -9603.7 | [-11764.0, -7443.4] |
| multi_client_cpu_s | 3.6450 | 3.6900 | +0.0623 | [-0.0332, +0.1579] |
| multi_broker_cpu_s | 3.4450 | 3.2200 | -0.2440 | [-0.3667, -0.1213] |
| broker_user_s | 2.8673 | 2.7202 | -0.1157 | [-0.1988, -0.0326] |
| broker_sys_s | 2.7866 | 2.5278 | -0.1911 | [-0.2847, -0.0975] |
| broker_cpu_s | 5.5960 | 5.2372 | -0.3068 | [-0.4662, -0.1474] |
| broker_vcsw | 14003.5 | 18333.5 | +4274.4 | [+3791.8, +4757.0] |
| broker_maxrss_kib | 7474 | 7056 | -461 | [-596, -327] |
| broker_ru_maxrss_kib | 18596 | 18596 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
