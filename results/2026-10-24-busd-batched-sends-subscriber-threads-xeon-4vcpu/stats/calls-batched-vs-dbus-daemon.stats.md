candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2161 | 0.2033 | -5.93 | [-8.77, -2.98] | [-8.29, -3.47] | 0.947 | 0.0002 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.8975 | 0.7842 | -12.62 | [-15.05, -10.23] | [-14.67, -10.59] | 0.873 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1197 | 0.9940 | -11.23 | [-13.34, -9.11] | [-13.02, -9.44] | 0.885 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8601 | 0.8478 | -1.43 | [-3.86, +1.05] | [-3.48, +0.63] | 0.985 | 0.2663 | no material change |
| client_vcsw | 60 | 8332.0 | 4844.2 | -41.86 | [-44.86, -38.85] | [-44.34, -39.32] | 0.589 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7553 | 0.7402 | -2.01 | [-4.61, +0.60] | [-4.20, +0.22] | 0.986 | 0.1500 | no material change |
| multi_broker_cpu_s | 60 | 0.8460 | 0.5663 | -33.06 | [-35.15, -30.94] | [-34.81, -31.31] | 0.669 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5733 | 0.3459 | -39.66 | [-41.66, -37.69] | [-41.36, -37.97] | 0.618 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3989 | 0.3298 | -17.34 | [-21.45, -13.06] | [-20.81, -13.66] | 0.836 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.9722 | 0.6757 | -30.50 | [-32.39, -28.61] | [-32.08, -28.93] | 0.700 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2452.3 | 5292.4 | +115.81 | [+108.36, +123.12] | [+109.61, +121.94] | 2.201 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5015 | 4923 | -1.83 | [-2.28, -1.35] | [-2.22, -1.42] | 0.980 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18833 | 18833 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2115 | 0.1980 | -0.0128 | [-0.0194, -0.0062] |
| multi_s | 0.8880 | 0.7785 | -0.1133 | [-0.1374, -0.0891] |
| client_wall_s | 1.1190 | 0.9894 | -0.1257 | [-0.1520, -0.0995] |
| client_cpu_s | 0.8535 | 0.8434 | -0.0123 | [-0.0342, +0.0096] |
| client_vcsw | 7778.5 | 4788.0 | -3487.8 | [-3878.3, -3097.2] |
| multi_client_cpu_s | 0.7500 | 0.7300 | -0.0152 | [-0.0359, +0.0056] |
| multi_broker_cpu_s | 0.8400 | 0.5650 | -0.2797 | [-0.3024, -0.2569] |
| broker_user_s | 0.5604 | 0.3492 | -0.2274 | [-0.2439, -0.2109] |
| broker_sys_s | 0.4001 | 0.3229 | -0.0692 | [-0.0880, -0.0503] |
| broker_cpu_s | 0.9686 | 0.6719 | -0.2965 | [-0.3194, -0.2737] |
| broker_vcsw | 2401.5 | 5283.0 | +2840.1 | [+2718.4, +2961.8] |
| broker_maxrss_kib | 5016 | 4910 | -92 | [-116, -67] |
| broker_ru_maxrss_kib | 18756 | 18756 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
