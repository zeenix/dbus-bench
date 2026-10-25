candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2002 | 0.1990 | -0.62 | [-3.39, +2.20] | [-2.96, +1.68] | 0.992 | 0.6802 | no material change |
| multi_s | 60 | 0.7740 | 0.7563 | -2.28 | [-4.68, +0.13] | [-4.33, -0.25] | 0.986 | 0.1275 | no material change |
| client_wall_s | 60 | 0.9803 | 0.9614 | -1.93 | [-3.91, +0.04] | [-3.60, -0.28] | 0.992 | 0.0904 | no material change |
| client_cpu_s | 60 | 0.8387 | 0.8267 | -1.43 | [-3.65, +0.72] | [-3.29, +0.40] | 1.009 | 0.2925 | no material change |
| client_vcsw | 60 | 4638.3 | 4603.6 | -0.75 | [-3.94, +2.66] | [-3.48, +2.09] | 0.974 | 0.4729 | no material change |
| multi_client_cpu_s | 60 | 0.7322 | 0.7210 | -1.53 | [-4.03, +0.92] | [-3.59, +0.52] | 1.007 | 0.3104 | no material change |
| multi_broker_cpu_s | 60 | 0.5567 | 0.5335 | -4.16 | [-6.82, -1.58] | [-6.39, -1.97] | 0.960 | 0.0083 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.3529 | 0.3352 | -5.02 | [-7.69, -2.33] | [-7.24, -2.72] | 0.953 | 0.0019 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.3119 | 0.3071 | -1.54 | [-6.47, +3.46] | [-5.69, +2.70] | 0.980 | 0.6910 | inconclusive |
| broker_cpu_s | 60 | 0.6648 | 0.6423 | -3.39 | [-5.64, -1.18] | [-5.29, -1.50] | 0.973 | 0.0128 | inconclusive; repeatable change (-) |
| broker_vcsw | 60 | 5253.3 | 5412.0 | +3.02 | [+0.32, +5.76] | [+0.76, +5.30] | 1.036 | 0.0328 | inconclusive; repeatable change (+) |
| broker_maxrss_kib | 60 | 4922 | 4857 | -1.32 | [-1.96, -0.67] | [-1.86, -0.77] | 0.988 | 0.0002 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18835 | 18835 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1979 | 0.1991 | -0.0012 | [-0.0070, +0.0045] |
| multi_s | 0.7708 | 0.7575 | -0.0177 | [-0.0372, +0.0019] |
| client_wall_s | 0.9823 | 0.9611 | -0.0189 | [-0.0391, +0.0013] |
| client_cpu_s | 0.8397 | 0.8257 | -0.0120 | [-0.0310, +0.0070] |
| client_vcsw | 4614.5 | 4526.5 | -34.7 | [-191.3, +121.9] |
| multi_client_cpu_s | 0.7300 | 0.7250 | -0.0112 | [-0.0298, +0.0075] |
| multi_broker_cpu_s | 0.5500 | 0.5300 | -0.0232 | [-0.0386, -0.0077] |
| broker_user_s | 0.3518 | 0.3344 | -0.0177 | [-0.0277, -0.0077] |
| broker_sys_s | 0.3175 | 0.3098 | -0.0048 | [-0.0209, +0.0113] |
| broker_cpu_s | 0.6626 | 0.6441 | -0.0225 | [-0.0382, -0.0068] |
| broker_vcsw | 5255.0 | 5379.5 | +158.7 | [+13.7, +303.6] |
| broker_maxrss_kib | 4930 | 4850 | -65 | [-98, -32] |
| broker_ru_maxrss_kib | 18756 | 18756 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
