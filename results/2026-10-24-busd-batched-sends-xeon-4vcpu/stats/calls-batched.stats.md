candidate batched against baseline baseline, from $WORK/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1994 | 0.2015 | +1.03 | [-1.61, +3.69] | [-1.21, +3.27] | 1.007 | 0.4223 | no material change |
| multi_s | 60 | 0.7902 | 0.7795 | -1.35 | [-3.87, +1.33] | [-3.49, +0.89] | 0.971 | 0.2081 | no material change |
| client_wall_s | 60 | 0.9961 | 0.9873 | -0.88 | [-2.98, +1.35] | [-2.64, +0.99] | 0.974 | 0.2695 | no material change |
| client_cpu_s | 60 | 0.8557 | 0.8456 | -1.18 | [-3.28, +1.08] | [-2.97, +0.70] | 0.975 | 0.1901 | no material change |
| client_vcsw | 60 | 4710.2 | 4741.6 | +0.66 | [-3.27, +4.83] | [-2.62, +4.11] | 0.968 | 0.9765 | no material change |
| multi_client_cpu_s | 60 | 0.7500 | 0.7392 | -1.44 | [-3.93, +1.21] | [-3.55, +0.78] | 0.975 | 0.1907 | no material change |
| multi_broker_cpu_s | 60 | 0.5547 | 0.5602 | +0.99 | [-2.23, +4.35] | [-1.72, +3.81] | 0.982 | 0.7012 | no material change |
| broker_user_s | 60 | 0.3472 | 0.3432 | -1.13 | [-3.95, +1.82] | [-3.52, +1.32] | 0.995 | 0.4483 | no material change |
| broker_sys_s | 60 | 0.3158 | 0.3269 | +3.52 | [-1.63, +9.18] | [-0.92, +8.24] | 1.011 | 0.3498 | inconclusive |
| broker_cpu_s | 60 | 0.6629 | 0.6701 | +1.08 | [-1.77, +4.04] | [-1.32, +3.58] | 0.993 | 0.6534 | no material change |
| broker_vcsw | 60 | 5389.4 | 5289.4 | -1.86 | [-4.61, +0.99] | [-4.17, +0.54] | 0.972 | 0.1429 | no material change |
| broker_maxrss_kib | 60 | 4916 | 4971 | +1.12 | [+0.44, +1.81] | [+0.55, +1.70] | 1.008 | 0.0064 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 18928 | 18930 | +0.01 | [-0.02, +0.06] | [-0.02, +0.05] | 1.000 | 0.5637 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1970 | 0.2019 | +0.0021 | [-0.0034, +0.0075] |
| multi_s | 0.7901 | 0.7810 | -0.0107 | [-0.0322, +0.0109] |
| client_wall_s | 0.9985 | 0.9903 | -0.0087 | [-0.0313, +0.0138] |
| client_cpu_s | 0.8575 | 0.8464 | -0.0101 | [-0.0295, +0.0094] |
| client_vcsw | 4744.5 | 4577.5 | +31.3 | [-163.8, +226.5] |
| multi_client_cpu_s | 0.7600 | 0.7300 | -0.0108 | [-0.0311, +0.0094] |
| multi_broker_cpu_s | 0.5500 | 0.5600 | +0.0055 | [-0.0133, +0.0243] |
| broker_user_s | 0.3430 | 0.3418 | -0.0039 | [-0.0144, +0.0065] |
| broker_sys_s | 0.3152 | 0.3282 | +0.0111 | [-0.0065, +0.0287] |
| broker_cpu_s | 0.6606 | 0.6617 | +0.0072 | [-0.0126, +0.0270] |
| broker_vcsw | 5362.5 | 5343.0 | -100.0 | [-255.6, +55.6] |
| broker_maxrss_kib | 4914 | 4976 | +55 | [+20, +90] |
| broker_ru_maxrss_kib | 18956 | 18956 | +2 | [-5, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
