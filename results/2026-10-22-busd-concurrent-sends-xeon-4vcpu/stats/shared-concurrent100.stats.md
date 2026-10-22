candidate concurrent100 against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 2.9322 | 3.2888 | +12.16 | [+9.41, +15.05] | [+9.82, +14.52] | 1.129 | <0.0001 | slower/larger |
| multi_s | 40 | 3.8875 | 3.7542 | -3.43 | [-6.08, -0.72] | [-5.63, -1.13] | 0.977 | 0.0385 | inconclusive; repeatable change (-) |
| client_wall_s | 40 | 6.8256 | 7.0492 | +3.28 | [+1.27, +5.22] | [+1.62, +4.94] | 1.039 | 0.0023 | no material change; repeatable change (+) |
| client_cpu_s | 40 | 6.0799 | 6.4743 | +6.49 | [+4.88, +8.02] | [+5.15, +7.79] | 1.072 | <0.0001 | inconclusive; repeatable change (+) |
| client_vcsw | 40 | 19939.2 | 10262.7 | -48.53 | [-53.75, -42.90] | [-52.85, -43.89] | 0.524 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.3952 | 3.4300 | +1.02 | [-0.86, +2.93] | [-0.55, +2.64] | 1.018 | 0.2367 | no material change |
| multi_broker_cpu_s | 40 | 3.2268 | 2.9447 | -8.74 | [-11.27, -6.12] | [-10.89, -6.52] | 0.910 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 2.6297 | 2.5218 | -4.10 | [-6.36, -1.88] | [-6.02, -2.23] | 0.971 | 0.0046 | inconclusive; repeatable change (-) |
| broker_sys_s | 40 | 2.6092 | 2.3555 | -9.72 | [-12.00, -7.43] | [-11.64, -7.80] | 0.907 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 5.2389 | 4.8773 | -6.90 | [-8.81, -5.01] | [-8.49, -5.33] | 0.939 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 13737.7 | 18648.4 | +35.75 | [+32.06, +39.54] | [+32.63, +38.98] | 1.344 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7484 | 7054 | -5.74 | [-6.96, -4.54] | [-6.78, -4.73] | 0.941 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 18703 | 18700 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 2.9326 | 3.2751 | +0.3566 | [+0.2753, +0.4380] |
| multi_s | 3.7945 | 3.7277 | -0.1333 | [-0.2447, -0.0220] |
| client_wall_s | 6.7691 | 7.0257 | +0.2236 | [+0.0843, +0.3629] |
| client_cpu_s | 6.0792 | 6.4436 | +0.3944 | [+0.2976, +0.4912] |
| client_vcsw | 19192.5 | 10515.0 | -9676.4 | [-11218.0, -8134.9] |
| multi_client_cpu_s | 3.4000 | 3.4350 | +0.0347 | [-0.0323, +0.1018] |
| multi_broker_cpu_s | 3.2100 | 2.9350 | -0.2820 | [-0.3728, -0.1912] |
| broker_user_s | 2.6319 | 2.5116 | -0.1079 | [-0.1703, -0.0455] |
| broker_sys_s | 2.5778 | 2.3655 | -0.2537 | [-0.3190, -0.1883] |
| broker_cpu_s | 5.1955 | 4.8919 | -0.3616 | [-0.4689, -0.2542] |
| broker_vcsw | 13725.5 | 18653.0 | +4910.7 | [+4463.1, +5358.3] |
| broker_maxrss_kib | 7446 | 7024 | -430 | [-528, -332] |
| broker_ru_maxrss_kib | 18700 | 18700 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
