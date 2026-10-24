candidate timeout-rq256 against baseline timeout, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out/shared-read-ahead.json
30 pairs (rounds 3 to 32); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 30 | 3.5101 | 3.2949 | -6.13 | [-8.31, -3.85] | [-7.99, -4.25] | 0.938 | 0.0001 | inconclusive; repeatable change (-) |
| multi_s | 30 | 4.1623 | 4.1813 | +0.46 | [-2.89, +3.92] | [-2.33, +3.42] | 1.014 | 0.8130 | no material change |
| client_wall_s | 30 | 7.6787 | 7.4823 | -2.56 | [-4.81, -0.27] | [-4.44, -0.63] | 0.983 | 0.0495 | no material change; repeatable change (-) |
| client_cpu_s | 30 | 6.9616 | 6.7305 | -3.32 | [-5.07, -1.56] | [-4.79, -1.81] | 0.968 | 0.0028 | no material change; repeatable change (-) |
| client_vcsw | 30 | 13095.4 | 15801.4 | +20.66 | [+8.53, +35.03] | [+10.43, +32.53] | 1.184 | 0.0022 | slower/larger |
| multi_client_cpu_s | 30 | 3.7207 | 3.7250 | +0.12 | [-2.34, +2.65] | [-1.92, +2.22] | 1.000 | 0.8936 | no material change |
| multi_broker_cpu_s | 30 | 3.2343 | 3.2777 | +1.34 | [-2.11, +4.95] | [-1.58, +4.39] | 1.023 | 0.3819 | no material change |
| broker_user_s | 30 | 2.7380 | 2.7496 | +0.43 | [-2.05, +2.89] | [-1.65, +2.53] | 1.008 | 0.5304 | no material change |
| broker_sys_s | 30 | 2.5872 | 2.7455 | +6.12 | [+2.84, +9.45] | [+3.36, +8.94] | 1.080 | 0.0021 | inconclusive; repeatable change (+) |
| broker_cpu_s | 30 | 5.3252 | 5.4952 | +3.19 | [+0.70, +5.71] | [+1.10, +5.33] | 1.039 | 0.0148 | inconclusive; repeatable change (+) |
| broker_vcsw | 30 | 18309.7 | 16710.7 | -8.73 | [-12.51, -4.35] | [-11.99, -5.08] | 0.887 | 0.0002 | inconclusive; repeatable change (-) |
| broker_maxrss_kib | 30 | 7030 | 7947 | +13.05 | [+11.14, +14.96] | [+11.48, +14.67] | 1.143 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 30 | 18596 | 18596 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.4858 | 3.2758 | -0.2152 | [-0.2997, -0.1307] |
| multi_s | 4.1207 | 4.1193 | +0.0190 | [-0.1330, +0.1711] |
| client_wall_s | 7.6327 | 7.4259 | -0.1965 | [-0.3854, -0.0076] |
| client_cpu_s | 6.8621 | 6.7282 | -0.2310 | [-0.3631, -0.0990] |
| client_vcsw | 12127.0 | 16049.0 | +2706.0 | [+1058.9, +4353.1] |
| multi_client_cpu_s | 3.6900 | 3.6350 | +0.0043 | [-0.0940, +0.1027] |
| multi_broker_cpu_s | 3.2200 | 3.3000 | +0.0433 | [-0.0792, +0.1659] |
| broker_user_s | 2.7202 | 2.7491 | +0.0116 | [-0.0604, +0.0837] |
| broker_sys_s | 2.5278 | 2.7414 | +0.1583 | [+0.0688, +0.2478] |
| broker_cpu_s | 5.2372 | 5.5279 | +0.1699 | [+0.0282, +0.3117] |
| broker_vcsw | 18333.5 | 16156.0 | -1599.0 | [-2401.3, -796.7] |
| broker_maxrss_kib | 7056 | 7898 | +917 | [+786, +1048] |
| broker_ru_maxrss_kib | 18596 | 18596 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
