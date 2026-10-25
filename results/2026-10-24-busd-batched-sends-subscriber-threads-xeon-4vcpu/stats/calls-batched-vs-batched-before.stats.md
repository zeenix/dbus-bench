candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1981 | 0.2033 | +2.61 | [+0.34, +4.99] | [+0.66, +4.59] | 1.026 | 0.0502 | no material change; repeatable change (+) |
| multi_s | 60 | 0.7522 | 0.7842 | +4.25 | [+0.79, +7.73] | [+1.37, +7.15] | 1.039 | 0.0167 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 0.9565 | 0.9940 | +3.92 | [+1.17, +6.71] | [+1.61, +6.25] | 1.027 | 0.0096 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.8240 | 0.8478 | +2.88 | [+0.15, +5.70] | [+0.58, +5.19] | 1.020 | 0.0529 | inconclusive; repeatable change (+) |
| client_vcsw | 60 | 4586.9 | 4844.2 | +5.61 | [+1.26, +10.23] | [+2.03, +9.46] | 1.066 | 0.0181 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.7182 | 0.7402 | +3.06 | [-0.07, +6.17] | [+0.50, +5.68] | 1.034 | 0.0388 | inconclusive |
| multi_broker_cpu_s | 60 | 0.5333 | 0.5663 | +6.19 | [+2.50, +10.00] | [+3.05, +9.43] | 1.059 | 0.0035 | inconclusive; repeatable change (+) |
| broker_user_s | 60 | 0.3383 | 0.3459 | +2.25 | [-0.71, +5.41] | [-0.26, +4.85] | 1.015 | 0.1619 | no material change |
| broker_sys_s | 60 | 0.3008 | 0.3298 | +9.64 | [+3.40, +16.14] | [+4.46, +15.08] | 1.136 | 0.0032 | inconclusive; repeatable change (+) |
| broker_cpu_s | 60 | 0.6390 | 0.6757 | +5.73 | [+2.60, +8.93] | [+3.08, +8.42] | 1.069 | 0.0012 | inconclusive; repeatable change (+) |
| broker_vcsw | 60 | 5424.7 | 5292.4 | -2.44 | [-5.06, +0.20] | [-4.66, -0.25] | 0.978 | 0.0610 | no material change |
| broker_maxrss_kib | 60 | 4937 | 4923 | -0.28 | [-0.92, +0.38] | [-0.81, +0.27] | 0.998 | 0.4106 | no material change |
| broker_ru_maxrss_kib | 60 | 18835 | 18833 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1975 | 0.1980 | +0.0052 | [+0.0004, +0.0099] |
| multi_s | 0.7475 | 0.7785 | +0.0320 | [+0.0055, +0.0584] |
| client_wall_s | 0.9574 | 0.9894 | +0.0375 | [+0.0105, +0.0645] |
| client_cpu_s | 0.8316 | 0.8434 | +0.0238 | [+0.0004, +0.0471] |
| client_vcsw | 4505.5 | 4788.0 | +257.4 | [+50.1, +464.7] |
| multi_client_cpu_s | 0.7100 | 0.7300 | +0.0220 | [-0.0007, +0.0447] |
| multi_broker_cpu_s | 0.5200 | 0.5650 | +0.0330 | [+0.0126, +0.0534] |
| broker_user_s | 0.3371 | 0.3492 | +0.0076 | [-0.0029, +0.0182] |
| broker_sys_s | 0.2948 | 0.3229 | +0.0290 | [+0.0103, +0.0477] |
| broker_cpu_s | 0.6316 | 0.6719 | +0.0366 | [+0.0162, +0.0570] |
| broker_vcsw | 5454.0 | 5283.0 | -132.2 | [-281.4, +16.9] |
| broker_maxrss_kib | 4936 | 4910 | -14 | [-47, +19] |
| broker_ru_maxrss_kib | 18756 | 18756 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
