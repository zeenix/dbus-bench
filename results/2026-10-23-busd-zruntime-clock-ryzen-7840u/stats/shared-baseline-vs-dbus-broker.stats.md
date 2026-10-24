candidate baseline against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8977 | 1.8654 | -1.70 | [-2.63, -0.74] | [-2.49, -0.89] | 0.978 | 0.0008 | no material change; repeatable change (-) |
| multi_s | 40 | 2.1672 | 2.2467 | +3.67 | [+2.06, +5.18] | [+2.36, +4.95] | 1.047 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 40 | 4.0967 | 4.1444 | +1.16 | [+0.07, +2.22] | [+0.25, +2.05] | 1.012 | 0.0095 | no material change; repeatable change (+) |
| client_cpu_s | 40 | 4.0536 | 4.0170 | -0.90 | [-1.94, +0.08] | [-1.77, -0.07] | 0.990 | 0.2213 | no material change |
| client_vcsw | 40 | 455.9 | 2736.8 | +500.27 | [+398.29, +623.14] | [+413.67, +602.18] | 5.413 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.1515 | 2.1867 | +1.64 | [+0.06, +3.13] | [+0.34, +2.91] | 1.023 | 0.0078 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.5270 | 1.9558 | +28.08 | [+26.06, +30.26] | [+26.36, +29.92] | 1.267 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9547 | 1.6386 | +71.63 | [+69.65, +73.73] | [+69.97, +73.39] | 1.717 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.7571 | 1.7594 | +0.14 | [-1.48, +1.76] | [-1.24, +1.48] | 1.000 | 0.8931 | no material change |
| broker_cpu_s | 40 | 2.7118 | 3.3980 | +25.31 | [+23.87, +26.79] | [+24.08, +26.54] | 1.247 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 106739.6 | 12100.0 | -88.66 | [-89.06, -88.29] | [-88.99, -88.35] | 0.114 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9340 | 11766 | +25.98 | [+24.13, +27.98] | [+24.40, +27.62] | 1.248 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20651 | 20651 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8849 | 1.8500 | -0.0323 | [-0.0516, -0.0130] |
| multi_s | 2.1475 | 2.2372 | +0.0795 | [+0.0445, +0.1146] |
| client_wall_s | 4.0705 | 4.1243 | +0.0477 | [+0.0013, +0.0941] |
| client_cpu_s | 4.0275 | 3.9978 | -0.0366 | [-0.0802, +0.0069] |
| client_vcsw | 436.0 | 2252.0 | +2280.9 | [+1777.3, +2784.5] |
| multi_client_cpu_s | 2.1350 | 2.1700 | +0.0352 | [+0.0005, +0.0700] |
| multi_broker_cpu_s | 1.5150 | 1.9400 | +0.4287 | [+0.3958, +0.4617] |
| broker_user_s | 0.9481 | 1.6319 | +0.6838 | [+0.6664, +0.7013] |
| broker_sys_s | 1.7502 | 1.7359 | +0.0024 | [-0.0279, +0.0327] |
| broker_cpu_s | 2.7085 | 3.3648 | +0.6862 | [+0.6457, +0.7267] |
| broker_vcsw | 106893.0 | 12400.0 | -94639.6 | [-96996.2, -92282.9] |
| broker_maxrss_kib | 9370 | 11688 | +2427 | [+2249, +2604] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
