candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.6892 | 0.3795 | -44.94 | [-47.24, -42.79] | [-46.88, -43.14] | 0.548 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2216 | 0.9592 | -21.48 | [-25.74, -17.00] | [-25.04, -17.73] | 0.786 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.9403 | 1.3698 | -29.41 | [-31.97, -26.83] | [-31.58, -27.20] | 0.705 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.8376 | 2.3845 | -15.97 | [-18.23, -13.75] | [-17.86, -14.11] | 0.842 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 106855.0 | 79625.1 | -25.48 | [-29.65, -21.18] | [-28.92, -21.85] | 0.747 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 2.2138 | 1.9102 | -13.72 | [-16.69, -10.77] | [-16.20, -11.25] | 0.865 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1982 | 0.9175 | -23.42 | [-27.91, -18.74] | [-27.15, -19.51] | 0.772 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7283 | 0.4436 | -39.09 | [-40.83, -37.29] | [-40.54, -37.57] | 0.596 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.1614 | 0.8560 | -26.30 | [-30.54, -21.84] | [-29.86, -22.54] | 0.725 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.8897 | 1.2996 | -31.23 | [-33.92, -28.47] | [-33.51, -28.93] | 0.694 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 62.183 | 112.483 | +80.89 | [+32.88, +157.95] | [+39.12, +142.52] | 2.935 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 4806 | 4734 | -1.51 | [-2.75, -0.29] | [-2.54, -0.47] | 1.000 | 0.1968 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18834 | 18836 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.6758 | 0.3704 | -0.3098 | [-0.3338, -0.2858] |
| multi_s | 1.2591 | 0.9671 | -0.2623 | [-0.3229, -0.2018] |
| client_wall_s | 1.9584 | 1.3721 | -0.5706 | [-0.6301, -0.5110] |
| client_cpu_s | 2.9043 | 2.4021 | -0.4532 | [-0.5228, -0.3835] |
| client_vcsw | 112115.0 | 81379.5 | -27229.9 | [-32388.6, -22071.2] |
| multi_client_cpu_s | 2.2700 | 1.9050 | -0.3037 | [-0.3742, -0.2331] |
| multi_broker_cpu_s | 1.2350 | 0.9250 | -0.2807 | [-0.3431, -0.2183] |
| broker_user_s | 0.7225 | 0.4415 | -0.2847 | [-0.3012, -0.2682] |
| broker_sys_s | 1.1950 | 0.8542 | -0.3054 | [-0.3644, -0.2464] |
| broker_cpu_s | 1.9192 | 1.3092 | -0.5901 | [-0.6513, -0.5289] |
| broker_vcsw | 30.000 | 96.000 | +50.300 | [+26.516, +74.084] |
| broker_maxrss_kib | 4740 | 4732 | -72 | [-135, -10] |
| broker_ru_maxrss_kib | 18840 | 18840 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
