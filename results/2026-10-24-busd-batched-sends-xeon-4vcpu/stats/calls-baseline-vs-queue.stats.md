candidate baseline against baseline queue, from $WORK/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1990 | 0.1994 | +0.21 | [-2.04, +2.54] | [-1.72, +2.15] | 1.004 | 0.6694 | no material change |
| multi_s | 60 | 0.7825 | 0.7902 | +0.98 | [-1.84, +3.81] | [-1.32, +3.33] | 1.008 | 0.4752 | no material change |
| client_wall_s | 60 | 0.9880 | 0.9961 | +0.82 | [-1.56, +3.18] | [-1.12, +2.81] | 0.997 | 0.4936 | no material change |
| client_cpu_s | 60 | 0.8498 | 0.8557 | +0.69 | [-1.71, +3.20] | [-1.33, +2.78] | 0.996 | 0.6964 | no material change |
| client_vcsw | 60 | 4534.8 | 4710.2 | +3.87 | [+0.78, +6.97] | [+1.25, +6.51] | 1.041 | 0.0198 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.7433 | 0.7500 | +0.90 | [-1.81, +3.70] | [-1.36, +3.23] | 1.000 | 0.5696 | no material change |
| multi_broker_cpu_s | 60 | 0.5592 | 0.5547 | -0.80 | [-3.37, +1.81] | [-2.93, +1.36] | 1.000 | 0.6709 | no material change |
| broker_user_s | 60 | 0.3431 | 0.3472 | +1.19 | [-1.71, +4.26] | [-1.25, +3.73] | 1.007 | 0.4395 | no material change |
| broker_sys_s | 60 | 0.3238 | 0.3158 | -2.48 | [-6.84, +2.11] | [-6.16, +1.35] | 0.966 | 0.2825 | inconclusive |
| broker_cpu_s | 60 | 0.6668 | 0.6629 | -0.59 | [-2.75, +1.63] | [-2.42, +1.28] | 0.995 | 0.6587 | no material change |
| broker_vcsw | 60 | 5278.6 | 5389.4 | +2.10 | [-0.38, +4.62] | [+0.04, +4.21] | 1.025 | 0.0641 | no material change |
| broker_maxrss_kib | 60 | 4961 | 4916 | -0.91 | [-1.53, -0.29] | [-1.43, -0.39] | 0.991 | 0.0070 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18928 | 18928 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1993 | 0.1970 | +0.0004 | [-0.0043, +0.0051] |
| multi_s | 0.7803 | 0.7901 | +0.0077 | [-0.0147, +0.0300] |
| client_wall_s | 0.9864 | 0.9985 | +0.0081 | [-0.0155, +0.0317] |
| client_cpu_s | 0.8400 | 0.8575 | +0.0059 | [-0.0154, +0.0272] |
| client_vcsw | 4463.0 | 4744.5 | +175.4 | [+30.3, +320.5] |
| multi_client_cpu_s | 0.7350 | 0.7600 | +0.0067 | [-0.0142, +0.0275] |
| multi_broker_cpu_s | 0.5550 | 0.5500 | -0.0045 | [-0.0193, +0.0103] |
| broker_user_s | 0.3370 | 0.3430 | +0.0041 | [-0.0064, +0.0146] |
| broker_sys_s | 0.3255 | 0.3152 | -0.0080 | [-0.0230, +0.0070] |
| broker_cpu_s | 0.6677 | 0.6606 | -0.0039 | [-0.0190, +0.0111] |
| broker_vcsw | 5306.0 | 5362.5 | +110.8 | [-24.6, +246.3] |
| broker_maxrss_kib | 4954 | 4914 | -45 | [-77, -14] |
| broker_ru_maxrss_kib | 18956 | 18956 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
