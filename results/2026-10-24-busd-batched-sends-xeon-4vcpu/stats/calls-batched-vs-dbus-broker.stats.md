candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2042 | 0.2015 | -1.34 | [-3.97, +1.30] | [-3.52, +0.88] | 0.995 | 0.4797 | no material change |
| multi_s | 60 | 1.2879 | 0.7795 | -39.48 | [-41.14, -37.67] | [-40.90, -37.98] | 0.594 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.4984 | 0.9873 | -34.11 | [-35.69, -32.45] | [-35.44, -32.70] | 0.654 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.3982 | 0.8456 | -39.52 | [-41.06, -37.89] | [-40.82, -38.18] | 0.596 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 3293.6 | 4741.6 | +43.96 | [+38.80, +49.76] | [+39.62, +48.78] | 1.407 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 1.2650 | 0.7392 | -41.57 | [-43.20, -39.80] | [-42.96, -40.12] | 0.573 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.5012 | 0.5602 | +11.77 | [+8.84, +14.85] | [+9.32, +14.35] | 1.116 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1780 | 0.3432 | +92.84 | [+85.76, +100.34] | [+86.97, +99.02] | 1.902 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.4231 | 0.3269 | -22.75 | [-26.10, -19.39] | [-25.58, -19.86] | 0.766 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6011 | 0.6701 | +11.48 | [+8.92, +14.15] | [+9.33, +13.69] | 1.109 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 34169.6 | 5289.4 | -84.52 | [-84.98, -84.06] | [-84.91, -84.13] | 0.155 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7378 | 4971 | -32.63 | [-33.04, -32.22] | [-32.97, -32.29] | 0.674 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18930 | 18930 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2004 | 0.2019 | -0.0027 | [-0.0083, +0.0028] |
| multi_s | 1.2940 | 0.7810 | -0.5085 | [-0.5383, -0.4786] |
| client_wall_s | 1.5009 | 0.9903 | -0.5111 | [-0.5425, -0.4798] |
| client_cpu_s | 1.3981 | 0.8464 | -0.5526 | [-0.5829, -0.5223] |
| client_vcsw | 3294.0 | 4577.5 | +1447.9 | [+1275.0, +1620.8] |
| multi_client_cpu_s | 1.2700 | 0.7300 | -0.5258 | [-0.5556, -0.4960] |
| multi_broker_cpu_s | 0.5000 | 0.5600 | +0.0590 | [+0.0439, +0.0741] |
| broker_user_s | 0.1778 | 0.3418 | +0.1652 | [+0.1556, +0.1749] |
| broker_sys_s | 0.4251 | 0.3282 | -0.0963 | [-0.1119, -0.0807] |
| broker_cpu_s | 0.6000 | 0.6617 | +0.0690 | [+0.0533, +0.0847] |
| broker_vcsw | 34203.5 | 5343.0 | -28880.1 | [-29708.0, -28052.3] |
| broker_maxrss_kib | 7382 | 4976 | -2407 | [-2443, -2371] |
| broker_ru_maxrss_kib | 18956 | 18956 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
