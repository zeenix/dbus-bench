candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2191 | 0.1994 | -8.98 | [-11.03, -6.93] | [-10.69, -7.27] | 0.918 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.9034 | 0.7902 | -12.54 | [-14.80, -10.21] | [-14.48, -10.56] | 0.858 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1289 | 0.9961 | -11.76 | [-13.71, -9.81] | [-13.40, -10.12] | 0.882 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8687 | 0.8557 | -1.50 | [-3.50, +0.54] | [-3.20, +0.21] | 0.976 | 0.1619 | no material change |
| client_vcsw | 60 | 8265.7 | 4710.2 | -43.01 | [-45.28, -40.66] | [-44.90, -41.07] | 0.570 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7620 | 0.7500 | -1.57 | [-3.83, +0.74] | [-3.49, +0.37] | 0.975 | 0.1679 | no material change |
| multi_broker_cpu_s | 60 | 0.8545 | 0.5547 | -35.09 | [-36.83, -33.37] | [-36.56, -33.61] | 0.645 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5750 | 0.3472 | -39.63 | [-41.25, -37.95] | [-40.99, -38.25] | 0.598 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.4071 | 0.3158 | -22.43 | [-25.96, -18.82] | [-25.42, -19.41] | 0.793 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.9821 | 0.6629 | -32.50 | [-34.09, -30.94] | [-33.84, -31.17] | 0.677 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2404.3 | 5389.4 | +124.16 | [+116.95, +131.42] | [+118.13, +130.32] | 2.303 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5041 | 4916 | -2.48 | [-2.95, -2.00] | [-2.87, -2.08] | 0.975 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18933 | 18928 | -0.02 | [-0.06, +0.00] | [-0.05, +0.00] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2169 | 0.1970 | -0.0197 | [-0.0245, -0.0149] |
| multi_s | 0.9051 | 0.7901 | -0.1133 | [-0.1368, -0.0898] |
| client_wall_s | 1.1358 | 0.9985 | -0.1328 | [-0.1574, -0.1082] |
| client_cpu_s | 0.8733 | 0.8575 | -0.0131 | [-0.0313, +0.0052] |
| client_vcsw | 8077.0 | 4744.5 | -3555.5 | [-3863.4, -3247.6] |
| multi_client_cpu_s | 0.7700 | 0.7600 | -0.0120 | [-0.0301, +0.0061] |
| multi_broker_cpu_s | 0.8550 | 0.5500 | -0.2998 | [-0.3201, -0.2796] |
| broker_user_s | 0.5725 | 0.3430 | -0.2279 | [-0.2408, -0.2149] |
| broker_sys_s | 0.4104 | 0.3152 | -0.0913 | [-0.1085, -0.0741] |
| broker_cpu_s | 0.9805 | 0.6606 | -0.3192 | [-0.3399, -0.2985] |
| broker_vcsw | 2392.0 | 5362.5 | +2985.1 | [+2865.9, +3104.4] |
| broker_maxrss_kib | 5038 | 4914 | -125 | [-149, -100] |
| broker_ru_maxrss_kib | 18956 | 18956 | -4 | [-10, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
