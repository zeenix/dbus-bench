candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.9065 | 2.0774 | +8.96 | [+7.83, +10.03] | [+8.00, +9.87] | 1.095 | <0.0001 | slower/larger |
| multi_s | 40 | 2.1735 | 2.2495 | +3.50 | [+2.05, +4.96] | [+2.27, +4.74] | 1.042 | 0.0001 | no material change; repeatable change (+) |
| client_wall_s | 40 | 4.1125 | 4.3598 | +6.01 | [+4.89, +7.10] | [+5.07, +6.92] | 1.064 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 4.0694 | 4.1674 | +2.41 | [+1.33, +3.45] | [+1.50, +3.29] | 1.027 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 430.0 | 2871.6 | +567.80 | [+493.03, +648.38] | [+505.10, +634.40] | 7.108 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.1562 | 2.1957 | +1.83 | [+0.38, +3.32] | [+0.61, +3.08] | 1.018 | 0.0075 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.5257 | 1.8837 | +23.46 | [+21.77, +25.17] | [+22.05, +24.87] | 1.233 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9496 | 1.6426 | +72.98 | [+70.44, +75.53] | [+70.86, +75.09] | 1.727 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.7659 | 1.8073 | +2.35 | [+0.57, +3.91] | [+0.87, +3.64] | 1.028 | 0.0002 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 2.7155 | 3.4500 | +27.05 | [+25.40, +28.50] | [+25.68, +28.27] | 1.275 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 107221.9 | 14886.8 | -86.12 | [-86.46, -85.77] | [-86.40, -85.82] | 0.141 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9428 | 11361 | +20.50 | [+18.62, +22.38] | [+18.96, +22.08] | 1.212 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20510 | 20510 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8939 | 2.0683 | +0.1709 | [+0.1496, +0.1922] |
| multi_s | 2.1507 | 2.2407 | +0.0760 | [+0.0429, +0.1091] |
| client_wall_s | 4.0804 | 4.3412 | +0.2473 | [+0.2007, +0.2939] |
| client_cpu_s | 4.0365 | 4.1478 | +0.0980 | [+0.0527, +0.1432] |
| client_vcsw | 415.5 | 2812.0 | +2441.6 | [+2255.6, +2627.5] |
| multi_client_cpu_s | 2.1350 | 2.1900 | +0.0395 | [+0.0061, +0.0729] |
| multi_broker_cpu_s | 1.5200 | 1.8850 | +0.3580 | [+0.3325, +0.3835] |
| broker_user_s | 0.9439 | 1.6272 | +0.6930 | [+0.6726, +0.7134] |
| broker_sys_s | 1.7437 | 1.7948 | +0.0415 | [+0.0109, +0.0720] |
| broker_cpu_s | 2.6943 | 3.4485 | +0.7345 | [+0.6957, +0.7732] |
| broker_vcsw | 107284.0 | 14919.5 | -92335.1 | [-94361.3, -90309.0] |
| broker_maxrss_kib | 9458 | 11322 | +1933 | [+1755, +2110] |
| broker_ru_maxrss_kib | 20564 | 20564 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
