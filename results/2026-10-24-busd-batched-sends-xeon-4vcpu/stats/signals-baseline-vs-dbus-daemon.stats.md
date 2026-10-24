candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5205 | 0.4531 | -12.96 | [-15.88, -9.85] | [-15.44, -10.36] | 0.875 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.7385 | 0.5489 | -25.67 | [-27.29, -23.92] | [-27.06, -24.21] | 0.732 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.2708 | 1.0150 | -20.13 | [-21.60, -18.55] | [-21.39, -18.80] | 0.790 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.1914 | 0.9702 | -18.57 | [-19.91, -17.12] | [-19.72, -17.34] | 0.816 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 2088.8 | 162.5 | -92.22 | [-93.22, -91.01] | [-93.09, -91.21] | 0.085 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7315 | 0.5452 | -25.47 | [-27.02, -23.77] | [-26.80, -24.05] | 0.736 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.3792 | 0.2323 | -38.73 | [-40.57, -36.93] | [-40.27, -37.22] | 0.632 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5832 | 0.3898 | -33.16 | [-35.05, -31.27] | [-34.74, -31.59] | 0.672 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3090 | 0.2312 | -25.20 | [-28.48, -21.82] | [-27.97, -22.37] | 0.753 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.8922 | 0.6210 | -30.40 | [-31.88, -28.88] | [-31.66, -29.12] | 0.702 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 9568.7 | 323.1 | -96.62 | [-96.83, -96.38] | [-96.80, -96.42] | 0.032 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7903 | 4868 | -38.41 | [-40.38, -36.70] | [-40.00, -36.93] | 0.630 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18914 | 18912 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5103 | 0.4460 | -0.0675 | [-0.0850, -0.0499] |
| multi_s | 0.7331 | 0.5407 | -0.1896 | [-0.2041, -0.1751] |
| client_wall_s | 1.2665 | 1.0034 | -0.2558 | [-0.2779, -0.2338] |
| client_cpu_s | 1.1817 | 0.9565 | -0.2212 | [-0.2397, -0.2027] |
| client_vcsw | 1984.0 | 146.5 | -1926.3 | [-2197.4, -1655.2] |
| multi_client_cpu_s | 0.7250 | 0.5400 | -0.1863 | [-0.2003, -0.1724] |
| multi_broker_cpu_s | 0.3750 | 0.2300 | -0.1468 | [-0.1562, -0.1374] |
| broker_user_s | 0.5800 | 0.3894 | -0.1934 | [-0.2067, -0.1802] |
| broker_sys_s | 0.3086 | 0.2349 | -0.0779 | [-0.0906, -0.0651] |
| broker_cpu_s | 0.8874 | 0.6133 | -0.2713 | [-0.2882, -0.2543] |
| broker_vcsw | 9764.0 | 304.5 | -9245.6 | [-9597.4, -8893.8] |
| broker_maxrss_kib | 7684 | 4850 | -3035 | [-3280, -2791] |
| broker_ru_maxrss_kib | 19012 | 19012 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
