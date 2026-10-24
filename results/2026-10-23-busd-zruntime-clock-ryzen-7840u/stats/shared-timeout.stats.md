candidate timeout against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8654 | 2.0755 | +11.26 | [+10.00, +12.53] | [+10.19, +12.33] | 1.112 | <0.0001 | slower/larger |
| multi_s | 40 | 2.2467 | 2.2574 | +0.48 | [-1.28, +2.35] | [-0.98, +2.01] | 1.002 | 0.9464 | no material change |
| client_wall_s | 40 | 4.1444 | 4.3648 | +5.32 | [+4.12, +6.64] | [+4.31, +6.39] | 1.052 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 4.0170 | 4.1745 | +3.92 | [+2.77, +5.19] | [+2.95, +4.95] | 1.037 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 2736.8 | 2934.1 | +7.21 | [-10.11, +27.40] | [-7.44, +24.22] | 1.218 | 0.0563 | inconclusive |
| multi_client_cpu_s | 40 | 2.1867 | 2.2018 | +0.69 | [-1.04, +2.53] | [-0.78, +2.24] | 1.002 | 0.6182 | no material change |
| multi_broker_cpu_s | 40 | 1.9558 | 1.9040 | -2.65 | [-4.61, -0.69] | [-4.25, -1.02] | 0.974 | 0.0237 | no material change; repeatable change (-) |
| broker_user_s | 40 | 1.6386 | 1.6467 | +0.50 | [-1.10, +2.20] | [-0.86, +1.91] | 0.998 | 0.8402 | no material change |
| broker_sys_s | 40 | 1.7594 | 1.8265 | +3.81 | [+2.08, +5.54] | [+2.35, +5.27] | 1.050 | 0.0002 | inconclusive; repeatable change (+) |
| broker_cpu_s | 40 | 3.3980 | 3.4732 | +2.21 | [+0.86, +3.56] | [+1.08, +3.35] | 1.019 | 0.0064 | no material change; repeatable change (+) |
| broker_vcsw | 40 | 12100.0 | 14708.8 | +21.56 | [+18.01, +25.34] | [+18.58, +24.72] | 1.210 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11766 | 11222 | -4.62 | [-6.39, -2.85] | [-6.10, -3.15] | 0.949 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20651 | 20651 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8500 | 2.0627 | +0.2101 | [+0.1864, +0.2338] |
| multi_s | 2.2372 | 2.2360 | +0.0107 | [-0.0318, +0.0532] |
| client_wall_s | 4.1243 | 4.3299 | +0.2204 | [+0.1669, +0.2739] |
| client_cpu_s | 3.9978 | 4.1404 | +0.1575 | [+0.1076, +0.2075] |
| client_vcsw | 2252.0 | 2969.5 | +197.3 | [-314.2, +708.8] |
| multi_client_cpu_s | 2.1700 | 2.1700 | +0.0150 | [-0.0263, +0.0563] |
| multi_broker_cpu_s | 1.9400 | 1.8800 | -0.0518 | [-0.0928, -0.0107] |
| broker_user_s | 1.6319 | 1.6313 | +0.0081 | [-0.0201, +0.0364] |
| broker_sys_s | 1.7359 | 1.8126 | +0.0671 | [+0.0359, +0.0983] |
| broker_cpu_s | 3.3648 | 3.4584 | +0.0752 | [+0.0270, +0.1235] |
| broker_vcsw | 12400.0 | 14927.5 | +2608.8 | [+2200.2, +3017.4] |
| broker_maxrss_kib | 11688 | 11196 | -544 | [-768, -320] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
