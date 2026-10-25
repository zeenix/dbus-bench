candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.3978 | 3.7058 | +9.06 | [+6.74, +11.51] | [+7.11, +11.09] | 1.103 | <0.0001 | slower/larger |
| multi_s | 40 | 4.3793 | 4.3901 | +0.25 | [-2.34, +3.06] | [-1.95, +2.63] | 0.989 | 1.0000 | no material change |
| client_wall_s | 40 | 7.7845 | 8.1037 | +4.10 | [+2.14, +6.16] | [+2.46, +5.83] | 1.047 | 0.0007 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 7.0706 | 7.4607 | +5.52 | [+3.91, +7.21] | [+4.17, +6.96] | 1.062 | <0.0001 | inconclusive; repeatable change (+) |
| client_vcsw | 40 | 16670.0 | 10858.4 | -34.86 | [-40.37, -28.77] | [-39.59, -29.74] | 0.672 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.9270 | 4.0178 | +2.31 | [-0.01, +4.79] | [+0.35, +4.43] | 1.026 | 0.0996 | no material change |
| multi_broker_cpu_s | 40 | 3.3712 | 3.2625 | -3.23 | [-6.47, +0.11] | [-5.93, -0.46] | 0.979 | 0.1038 | inconclusive |
| broker_user_s | 40 | 3.0343 | 3.0305 | -0.13 | [-2.55, +2.53] | [-2.15, +2.08] | 0.989 | 0.7675 | no material change |
| broker_sys_s | 40 | 2.7111 | 2.5272 | -6.79 | [-10.08, -3.54] | [-9.46, -4.05] | 0.951 | 0.0009 | inconclusive; repeatable change (-) |
| broker_cpu_s | 40 | 5.7454 | 5.5577 | -3.27 | [-5.68, -0.89] | [-5.25, -1.27] | 0.967 | 0.0257 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 16947.6 | 18781.2 | +10.82 | [+8.25, +13.57] | [+8.64, +13.10] | 1.100 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7460 | 7043 | -5.60 | [-6.82, -4.38] | [-6.62, -4.60] | 0.946 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18778 | 18772 | -0.03 | [-0.10, +0.00] | [-0.10, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.3754 | 3.7073 | +0.3080 | [+0.2265, +0.3895] |
| multi_s | 4.2960 | 4.3492 | +0.0108 | [-0.1131, +0.1348] |
| client_wall_s | 7.6561 | 8.0934 | +0.3192 | [+0.1589, +0.4794] |
| client_cpu_s | 6.9960 | 7.3674 | +0.3900 | [+0.2721, +0.5080] |
| client_vcsw | 15918.0 | 10653.0 | -5811.7 | [-7194.6, -4428.8] |
| multi_client_cpu_s | 3.9000 | 3.9700 | +0.0908 | [-0.0064, +0.1879] |
| multi_broker_cpu_s | 3.3050 | 3.2350 | -0.1088 | [-0.2272, +0.0097] |
| broker_user_s | 2.9558 | 2.9792 | -0.0038 | [-0.0850, +0.0774] |
| broker_sys_s | 2.6510 | 2.5386 | -0.1840 | [-0.2810, -0.0869] |
| broker_cpu_s | 5.6791 | 5.5213 | -0.1878 | [-0.3362, -0.0393] |
| broker_vcsw | 17047.5 | 18682.0 | +1833.6 | [+1399.9, +2267.3] |
| broker_maxrss_kib | 7458 | 7020 | -418 | [-515, -320] |
| broker_ru_maxrss_kib | 18708 | 18708 | -6 | [-19, +7] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
