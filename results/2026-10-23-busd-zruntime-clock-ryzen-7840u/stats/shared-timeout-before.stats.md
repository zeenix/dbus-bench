candidate timeout-before against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8654 | 2.1689 | +16.27 | [+14.90, +17.63] | [+15.11, +17.41] | 1.164 | <0.0001 | slower/larger |
| multi_s | 40 | 2.2467 | 2.5120 | +11.81 | [+10.16, +13.57] | [+10.42, +13.27] | 1.118 | <0.0001 | slower/larger |
| client_wall_s | 40 | 4.1444 | 4.7128 | +13.71 | [+12.59, +14.93] | [+12.77, +14.74] | 1.130 | <0.0001 | slower/larger |
| client_cpu_s | 40 | 4.0170 | 4.3877 | +9.23 | [+8.23, +10.31] | [+8.38, +10.13] | 1.089 | <0.0001 | slower/larger |
| client_vcsw | 40 | 2736.8 | 13813.5 | +404.73 | [+319.07, +505.28] | [+332.89, +489.99] | 5.667 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.1867 | 2.3775 | +8.72 | [+7.25, +10.27] | [+7.46, +10.01] | 1.090 | <0.0001 | slower/larger |
| multi_broker_cpu_s | 40 | 1.9558 | 2.4915 | +27.39 | [+24.92, +29.89] | [+25.35, +29.45] | 1.272 | <0.0001 | slower/larger |
| broker_user_s | 40 | 1.6386 | 1.8118 | +10.57 | [+9.02, +12.01] | [+9.27, +11.78] | 1.115 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.7594 | 2.4725 | +40.53 | [+37.85, +43.29] | [+38.27, +42.85] | 1.416 | <0.0001 | slower/larger |
| broker_cpu_s | 40 | 3.3980 | 4.2842 | +26.08 | [+24.36, +27.86] | [+24.62, +27.56] | 1.269 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 12100.0 | 6818.6 | -43.65 | [-45.57, -41.56] | [-45.27, -41.93] | 0.561 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 11766 | 11275 | -4.17 | [-5.99, -2.32] | [-5.70, -2.62] | 0.966 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20651 | 20651 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8500 | 2.1675 | +0.3035 | [+0.2779, +0.3291] |
| multi_s | 2.2372 | 2.5138 | +0.2653 | [+0.2275, +0.3031] |
| client_wall_s | 4.1243 | 4.6885 | +0.5684 | [+0.5200, +0.6168] |
| client_cpu_s | 3.9978 | 4.3746 | +0.3707 | [+0.3283, +0.4131] |
| client_vcsw | 2252.0 | 14168.0 | +11076.7 | [+9875.2, +12278.2] |
| multi_client_cpu_s | 2.1700 | 2.3700 | +0.1908 | [+0.1577, +0.2238] |
| multi_broker_cpu_s | 1.9400 | 2.5000 | +0.5357 | [+0.4916, +0.5799] |
| broker_user_s | 1.6319 | 1.7989 | +0.1732 | [+0.1487, +0.1977] |
| broker_sys_s | 1.7359 | 2.4727 | +0.7130 | [+0.6713, +0.7548] |
| broker_cpu_s | 3.3648 | 4.2704 | +0.8862 | [+0.8303, +0.9422] |
| broker_vcsw | 12400.0 | 6748.5 | -5281.4 | [-5672.4, -4890.5] |
| broker_maxrss_kib | 11688 | 11220 | -491 | [-724, -259] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
