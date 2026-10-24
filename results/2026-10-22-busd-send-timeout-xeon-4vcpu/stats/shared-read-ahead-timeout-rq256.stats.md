candidate timeout-rq256 against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out/shared-read-ahead.json
30 pairs (rounds 3 to 32); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 30 | 3.1152 | 3.2949 | +5.77 | [+2.00, +9.73] | [+2.58, +9.12] | 1.060 | 0.0077 | inconclusive; repeatable change (+) |
| multi_s | 30 | 4.2211 | 4.1813 | -0.94 | [-4.57, +2.96] | [-4.07, +2.31] | 0.976 | 0.3286 | no material change |
| client_wall_s | 30 | 7.3432 | 7.4823 | +1.89 | [-1.23, +5.26] | [-0.76, +4.73] | 0.990 | 0.4908 | no material change |
| client_cpu_s | 30 | 6.4935 | 6.7305 | +3.65 | [+1.18, +6.34] | [+1.55, +5.89] | 1.027 | 0.0104 | inconclusive; repeatable change (+) |
| client_vcsw | 30 | 22699.0 | 15801.4 | -30.39 | [-37.25, -22.59] | [-36.20, -24.02] | 0.682 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 30 | 3.6583 | 3.7250 | +1.82 | [-1.18, +5.09] | [-0.73, +4.53] | 1.004 | 0.3611 | no material change |
| multi_broker_cpu_s | 30 | 3.4783 | 3.2777 | -5.77 | [-8.96, -2.48] | [-8.45, -2.99] | 0.931 | 0.0031 | inconclusive; repeatable change (-) |
| broker_user_s | 30 | 2.8537 | 2.7496 | -3.65 | [-6.58, -0.51] | [-6.13, -1.06] | 0.945 | 0.0185 | inconclusive; repeatable change (-) |
| broker_sys_s | 30 | 2.7783 | 2.7455 | -1.18 | [-4.41, +2.20] | [-3.91, +1.67] | 0.965 | 0.5304 | no material change |
| broker_cpu_s | 30 | 5.6320 | 5.4952 | -2.43 | [-5.16, +0.50] | [-4.75, +0.01] | 0.961 | 0.0786 | no material change |
| broker_vcsw | 30 | 14035.3 | 16710.7 | +19.06 | [+13.50, +25.44] | [+14.35, +24.29] | 1.155 | <0.0001 | slower/larger |
| broker_maxrss_kib | 30 | 7491 | 7947 | +6.09 | [+4.13, +7.99] | [+4.46, +7.71] | 1.067 | <0.0001 | inconclusive; repeatable change (+) |
| broker_ru_maxrss_kib | 30 | 18596 | 18596 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.1109 | 3.2758 | +0.1797 | [+0.0547, +0.3048] |
| multi_s | 4.2386 | 4.1193 | -0.0398 | [-0.2102, +0.1307] |
| client_wall_s | 7.3085 | 7.4259 | +0.1391 | [-0.1148, +0.3930] |
| client_cpu_s | 6.4767 | 6.7282 | +0.2370 | [+0.0608, +0.4132] |
| client_vcsw | 22593.0 | 16049.0 | -6897.6 | [-9058.1, -4737.2] |
| multi_client_cpu_s | 3.6450 | 3.6350 | +0.0667 | [-0.0547, +0.1880] |
| multi_broker_cpu_s | 3.4450 | 3.3000 | -0.2007 | [-0.3259, -0.0754] |
| broker_user_s | 2.8673 | 2.7491 | -0.1041 | [-0.1961, -0.0120] |
| broker_sys_s | 2.7866 | 2.7414 | -0.0328 | [-0.1319, +0.0663] |
| broker_cpu_s | 5.5960 | 5.5279 | -0.1369 | [-0.3079, +0.0342] |
| broker_vcsw | 14003.5 | 16156.0 | +2675.4 | [+1831.9, +3518.9] |
| broker_maxrss_kib | 7474 | 7898 | +456 | [+308, +604] |
| broker_ru_maxrss_kib | 18596 | 18596 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
