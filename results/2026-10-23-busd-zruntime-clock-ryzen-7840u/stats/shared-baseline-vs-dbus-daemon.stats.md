candidate baseline against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3712 | 1.8654 | -70.72 | [-70.93, -70.50] | [-70.90, -70.53] | 0.291 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7375 | 2.2467 | -60.84 | [-61.34, -60.31] | [-61.26, -60.40] | 0.391 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.1408 | 4.1444 | -65.86 | [-66.12, -65.60] | [-66.08, -65.65] | 0.340 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.1722 | 4.0170 | -50.85 | [-51.19, -50.49] | [-51.14, -50.55] | 0.490 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 211263.3 | 2736.8 | -98.70 | [-98.91, -98.46] | [-98.88, -98.50] | 0.011 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3755 | 2.1867 | -50.02 | [-50.63, -49.39] | [-50.53, -49.50] | 0.501 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.7067 | 1.9558 | -65.73 | [-66.32, -65.10] | [-66.23, -65.21] | 0.343 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.6910 | 1.6386 | -65.07 | [-65.40, -64.72] | [-65.35, -64.78] | 0.348 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.4221 | 1.7594 | -76.29 | [-76.67, -75.89] | [-76.61, -75.96] | 0.235 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.1131 | 3.3980 | -71.95 | [-72.25, -71.63] | [-72.20, -71.68] | 0.279 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 26.500 | 12100.025 | +45560.47 | [+40220.35, +51826.16] | [+40981.06, +50781.58] | 497.904 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8546 | 11766 | +37.68 | [+35.54, +39.82] | [+35.85, +39.47] | 1.382 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20651 | 20651 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3696 | 1.8500 | -4.5058 | [-4.5206, -4.4911] |
| multi_s | 5.7119 | 2.2372 | -3.4908 | [-3.5413, -3.4403] |
| client_wall_s | 12.1217 | 4.1243 | -7.9964 | [-8.0467, -7.9460] |
| client_cpu_s | 8.1609 | 3.9978 | -4.1552 | [-4.1966, -4.1139] |
| client_vcsw | 211821.5 | 2252.0 | -208526.5 | [-210647.4, -206405.5] |
| multi_client_cpu_s | 4.3600 | 2.1700 | -2.1887 | [-2.2284, -2.1491] |
| multi_broker_cpu_s | 5.6800 | 1.9400 | -3.7510 | [-3.8070, -3.6950] |
| broker_user_s | 4.6912 | 1.6319 | -3.0524 | [-3.0803, -3.0245] |
| broker_sys_s | 7.4170 | 1.7359 | -5.6626 | [-5.7118, -5.6134] |
| broker_cpu_s | 12.0948 | 3.3648 | -8.7150 | [-8.7722, -8.6579] |
| broker_vcsw | 25.000 | 12400.000 | +12073.525 | [+11729.577, +12417.473] |
| broker_maxrss_kib | 8506 | 11688 | +3220 | [+3045, +3395] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
