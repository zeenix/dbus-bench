candidate concurrent100 against baseline timeout, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3927 | 0.3852 | -1.92 | [-5.06, +1.45] | [-4.59, +0.89] | 0.970 | 0.1901 | no material change |
| multi_s | 60 | 0.4660 | 0.4699 | +0.82 | [-2.13, +3.94] | [-1.66, +3.40] | 0.995 | 0.8946 | no material change |
| client_wall_s | 60 | 0.8702 | 0.8668 | -0.38 | [-2.61, +1.97] | [-2.26, +1.58] | 0.983 | 0.3652 | no material change |
| client_cpu_s | 60 | 0.8213 | 0.8160 | -0.65 | [-2.62, +1.50] | [-2.34, +1.11] | 0.983 | 0.1976 | no material change |
| client_vcsw | 60 | 171.3 | 168.3 | -1.72 | [-16.91, +13.07] | [-14.46, +11.15] | 1.033 | 0.6452 | inconclusive |
| multi_client_cpu_s | 60 | 0.4553 | 0.4538 | -0.33 | [-2.95, +2.61] | [-2.58, +2.06] | 0.979 | 0.1514 | no material change |
| multi_broker_cpu_s | 60 | 0.2035 | 0.2018 | -0.82 | [-3.95, +2.11] | [-3.41, +1.66] | 1.000 | 0.8634 | no material change |
| broker_user_s | 60 | 0.3082 | 0.3106 | +0.78 | [-2.77, +4.40] | [-2.18, +3.80] | 0.997 | 0.7684 | no material change |
| broker_sys_s | 60 | 0.2272 | 0.2217 | -2.41 | [-5.83, +1.09] | [-5.32, +0.55] | 0.955 | 0.1169 | inconclusive |
| broker_cpu_s | 60 | 0.5354 | 0.5323 | -0.57 | [-2.82, +1.64] | [-2.47, +1.30] | 0.991 | 0.6012 | no material change |
| broker_vcsw | 60 | 312.6 | 310.2 | -0.76 | [-7.83, +6.93] | [-6.68, +5.71] | 0.997 | 0.7073 | inconclusive |
| broker_maxrss_kib | 60 | 4735 | 4761 | +0.55 | [-0.09, +1.20] | [+0.01, +1.09] | 1.008 | 0.1312 | no material change |
| broker_ru_maxrss_kib | 60 | 18616 | 18616 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3803 | 0.3787 | -0.0075 | [-0.0209, +0.0059] |
| multi_s | 0.4635 | 0.4591 | +0.0038 | [-0.0108, +0.0184] |
| client_wall_s | 0.8643 | 0.8637 | -0.0033 | [-0.0240, +0.0173] |
| client_cpu_s | 0.8168 | 0.8067 | -0.0053 | [-0.0229, +0.0122] |
| client_vcsw | 150.5 | 160.5 | -3.0 | [-30.8, +24.9] |
| multi_client_cpu_s | 0.4500 | 0.4500 | -0.0015 | [-0.0146, +0.0116] |
| multi_broker_cpu_s | 0.2000 | 0.2000 | -0.0017 | [-0.0080, +0.0047] |
| broker_user_s | 0.3030 | 0.3048 | +0.0024 | [-0.0089, +0.0138] |
| broker_sys_s | 0.2292 | 0.2169 | -0.0055 | [-0.0138, +0.0028] |
| broker_cpu_s | 0.5262 | 0.5298 | -0.0031 | [-0.0153, +0.0092] |
| broker_vcsw | 298.0 | 306.5 | -2.4 | [-26.4, +21.7] |
| broker_maxrss_kib | 4722 | 4744 | +26 | [-5, +58] |
| broker_ru_maxrss_kib | 18616 | 18616 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
