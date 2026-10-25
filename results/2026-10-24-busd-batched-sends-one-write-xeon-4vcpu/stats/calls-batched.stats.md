candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1997 | 0.2084 | +4.38 | [+1.63, +7.36] | [+2.10, +6.85] | 1.038 | 0.0039 | inconclusive; repeatable change (+) |
| multi_s | 60 | 0.7999 | 0.8082 | +1.04 | [-2.63, +4.79] | [-2.06, +4.18] | 1.011 | 0.4439 | no material change |
| client_wall_s | 60 | 1.0061 | 1.0231 | +1.69 | [-1.46, +4.89] | [-0.96, +4.37] | 1.015 | 0.2418 | no material change |
| client_cpu_s | 60 | 0.8608 | 0.8683 | +0.88 | [-2.55, +4.26] | [-2.00, +3.72] | 1.016 | 0.3349 | no material change |
| client_vcsw | 60 | 4937.2 | 5001.5 | +1.30 | [-2.64, +5.70] | [-2.05, +4.99] | 1.015 | 0.6775 | no material change |
| multi_client_cpu_s | 60 | 0.7528 | 0.7600 | +0.95 | [-2.72, +4.61] | [-2.14, +4.06] | 1.021 | 0.2954 | no material change |
| multi_broker_cpu_s | 60 | 0.5752 | 0.5923 | +2.98 | [-0.34, +6.46] | [+0.17, +5.86] | 1.036 | 0.1107 | inconclusive |
| broker_user_s | 60 | 0.3619 | 0.3634 | +0.44 | [-2.82, +3.78] | [-2.33, +3.25] | 1.002 | 0.9121 | no material change |
| broker_sys_s | 60 | 0.3215 | 0.3435 | +6.84 | [+1.36, +12.66] | [+2.16, +11.63] | 1.050 | 0.0145 | inconclusive; repeatable change (+) |
| broker_cpu_s | 60 | 0.6834 | 0.7069 | +3.45 | [+0.54, +6.51] | [+1.00, +5.98] | 1.043 | 0.0225 | inconclusive; repeatable change (+) |
| broker_vcsw | 60 | 5101.7 | 5038.6 | -1.24 | [-4.84, +2.58] | [-4.26, +1.94] | 0.981 | 0.2942 | no material change |
| broker_maxrss_kib | 60 | 4880 | 4930 | +1.02 | [+0.44, +1.64] | [+0.52, +1.53] | 1.009 | 0.0019 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 19033 | 19029 | -0.02 | [-0.06, +0.00] | [-0.06, +0.00] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1988 | 0.2052 | +0.0088 | [+0.0030, +0.0145] |
| multi_s | 0.7874 | 0.7998 | +0.0083 | [-0.0220, +0.0387] |
| client_wall_s | 0.9811 | 1.0120 | +0.0170 | [-0.0156, +0.0497] |
| client_cpu_s | 0.8417 | 0.8635 | +0.0076 | [-0.0224, +0.0375] |
| client_vcsw | 4847.0 | 4916.5 | +64.3 | [-147.8, +276.5] |
| multi_client_cpu_s | 0.7300 | 0.7600 | +0.0072 | [-0.0213, +0.0357] |
| multi_broker_cpu_s | 0.5700 | 0.5850 | +0.0172 | [-0.0028, +0.0372] |
| broker_user_s | 0.3569 | 0.3593 | +0.0016 | [-0.0107, +0.0138] |
| broker_sys_s | 0.3179 | 0.3336 | +0.0220 | [+0.0036, +0.0403] |
| broker_cpu_s | 0.6789 | 0.7002 | +0.0236 | [+0.0027, +0.0444] |
| broker_vcsw | 5178.0 | 5131.0 | -63.1 | [-258.5, +132.4] |
| broker_maxrss_kib | 4884 | 4926 | +50 | [+20, +80] |
| broker_ru_maxrss_kib | 19016 | 19016 | -4 | [-10, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
