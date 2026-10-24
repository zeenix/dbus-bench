candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2042 | 0.1994 | -2.35 | [-4.73, +0.01] | [-4.33, -0.35] | 0.973 | 0.0615 | no material change |
| multi_s | 60 | 1.2879 | 0.7902 | -38.65 | [-40.05, -37.22] | [-39.84, -37.45] | 0.615 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.4984 | 0.9961 | -33.53 | [-34.91, -32.12] | [-34.70, -32.36] | 0.663 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.3982 | 0.8557 | -38.80 | [-40.09, -37.51] | [-39.87, -37.74] | 0.613 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 3293.6 | 4710.2 | +43.01 | [+39.39, +46.80] | [+39.97, +46.19] | 1.434 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 1.2650 | 0.7500 | -40.71 | [-42.03, -39.38] | [-41.82, -39.59] | 0.596 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.5012 | 0.5547 | +10.68 | [+7.68, +13.67] | [+8.14, +13.21] | 1.087 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1780 | 0.3472 | +95.04 | [+87.70, +103.10] | [+88.78, +101.74] | 1.893 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.4231 | 0.3158 | -25.37 | [-28.25, -22.47] | [-27.80, -22.92] | 0.743 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6011 | 0.6629 | +10.28 | [+7.75, +12.82] | [+8.14, +12.43] | 1.086 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 34169.6 | 5389.4 | -84.23 | [-84.61, -83.81] | [-84.56, -83.88] | 0.155 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7378 | 4916 | -33.37 | [-33.80, -32.94] | [-33.73, -33.01] | 0.669 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18930 | 18928 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2004 | 0.1970 | -0.0048 | [-0.0098, +0.0002] |
| multi_s | 1.2940 | 0.7901 | -0.4978 | [-0.5233, -0.4723] |
| client_wall_s | 1.5009 | 0.9985 | -0.5024 | [-0.5301, -0.4746] |
| client_cpu_s | 1.3981 | 0.8575 | -0.5425 | [-0.5682, -0.5169] |
| client_vcsw | 3294.0 | 4744.5 | +1416.6 | [+1303.2, +1530.0] |
| multi_client_cpu_s | 1.2700 | 0.7600 | -0.5150 | [-0.5393, -0.4907] |
| multi_broker_cpu_s | 0.5000 | 0.5500 | +0.0535 | [+0.0385, +0.0685] |
| broker_user_s | 0.1778 | 0.3430 | +0.1692 | [+0.1592, +0.1791] |
| broker_sys_s | 0.4251 | 0.3152 | -0.1074 | [-0.1219, -0.0929] |
| broker_cpu_s | 0.6000 | 0.6606 | +0.0618 | [+0.0465, +0.0771] |
| broker_vcsw | 34203.5 | 5362.5 | -28780.1 | [-29584.5, -27975.7] |
| broker_maxrss_kib | 7382 | 4914 | -2462 | [-2502, -2422] |
| broker_ru_maxrss_kib | 18956 | 18956 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
