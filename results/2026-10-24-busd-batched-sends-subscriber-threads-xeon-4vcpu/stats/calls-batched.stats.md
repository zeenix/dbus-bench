candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1990 | 0.2033 | +2.17 | [-0.30, +4.89] | [+0.07, +4.42] | 1.005 | 0.1951 | no material change |
| multi_s | 60 | 0.7563 | 0.7842 | +3.68 | [+0.40, +7.12] | [+0.92, +6.63] | 1.024 | 0.0736 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 0.9614 | 0.9940 | +3.39 | [+0.64, +6.33] | [+1.11, +5.80] | 1.017 | 0.0334 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.8267 | 0.8478 | +2.55 | [-0.08, +5.32] | [+0.34, +4.89] | 1.015 | 0.0991 | no material change |
| client_vcsw | 60 | 4603.6 | 4844.2 | +5.23 | [+1.13, +9.72] | [+1.76, +8.94] | 1.044 | 0.0167 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.7210 | 0.7402 | +2.66 | [-0.29, +5.74] | [+0.20, +5.23] | 1.021 | 0.1057 | inconclusive |
| multi_broker_cpu_s | 60 | 0.5335 | 0.5663 | +6.15 | [+2.44, +10.25] | [+2.99, +9.58] | 1.034 | 0.0070 | inconclusive; repeatable change (+) |
| broker_user_s | 60 | 0.3352 | 0.3459 | +3.20 | [-0.07, +6.67] | [+0.43, +6.08] | 1.021 | 0.1204 | inconclusive |
| broker_sys_s | 60 | 0.3071 | 0.3298 | +7.37 | [+1.56, +13.82] | [+2.50, +12.82] | 1.042 | 0.0372 | inconclusive; repeatable change (+) |
| broker_cpu_s | 60 | 0.6423 | 0.6757 | +5.19 | [+2.00, +8.68] | [+2.48, +8.09] | 1.039 | 0.0098 | inconclusive; repeatable change (+) |
| broker_vcsw | 60 | 5412.0 | 5292.4 | -2.21 | [-4.53, +0.11] | [-4.15, -0.28] | 0.983 | 0.0779 | no material change |
| broker_maxrss_kib | 60 | 4857 | 4923 | +1.36 | [+0.76, +1.98] | [+0.86, +1.88] | 1.017 | 0.0001 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 18835 | 18833 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1991 | 0.1980 | +0.0043 | [-0.0010, +0.0096] |
| multi_s | 0.7575 | 0.7785 | +0.0279 | [+0.0022, +0.0535] |
| client_wall_s | 0.9611 | 0.9894 | +0.0326 | [+0.0052, +0.0599] |
| client_cpu_s | 0.8257 | 0.8434 | +0.0211 | [-0.0016, +0.0437] |
| client_vcsw | 4526.5 | 4788.0 | +240.7 | [+42.9, +438.4] |
| multi_client_cpu_s | 0.7250 | 0.7300 | +0.0192 | [-0.0027, +0.0411] |
| multi_broker_cpu_s | 0.5300 | 0.5650 | +0.0328 | [+0.0122, +0.0535] |
| broker_user_s | 0.3344 | 0.3492 | +0.0107 | [-0.0007, +0.0221] |
| broker_sys_s | 0.3098 | 0.3229 | +0.0226 | [+0.0039, +0.0414] |
| broker_cpu_s | 0.6441 | 0.6719 | +0.0334 | [+0.0119, +0.0548] |
| broker_vcsw | 5379.5 | 5283.0 | -119.5 | [-248.2, +9.1] |
| broker_maxrss_kib | 4850 | 4910 | +66 | [+36, +96] |
| broker_ru_maxrss_kib | 18756 | 18756 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
