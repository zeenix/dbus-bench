candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2161 | 0.1990 | -7.93 | [-10.98, -4.96] | [-10.42, -5.44] | 0.952 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.8975 | 0.7563 | -15.72 | [-18.54, -12.97] | [-18.11, -13.40] | 0.842 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1197 | 0.9614 | -14.14 | [-16.56, -11.82] | [-16.18, -12.19] | 0.867 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8601 | 0.8267 | -3.88 | [-6.29, -1.52] | [-5.92, -1.92] | 0.961 | 0.0058 | inconclusive; repeatable change (-) |
| client_vcsw | 60 | 8332.0 | 4603.6 | -44.75 | [-47.71, -41.70] | [-47.25, -42.20] | 0.571 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7553 | 0.7210 | -4.55 | [-7.14, -1.98] | [-6.72, -2.44] | 0.948 | 0.0024 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.8460 | 0.5335 | -36.94 | [-39.06, -34.84] | [-38.75, -35.20] | 0.641 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5733 | 0.3352 | -41.53 | [-43.58, -39.55] | [-43.23, -39.87] | 0.591 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3989 | 0.3071 | -23.01 | [-26.68, -19.28] | [-26.14, -19.91] | 0.801 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.9722 | 0.6423 | -33.93 | [-35.94, -31.98] | [-35.62, -32.30] | 0.664 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2452.3 | 5412.0 | +120.69 | [+113.12, +127.83] | [+114.39, +126.74] | 2.239 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5015 | 4857 | -3.15 | [-3.61, -2.68] | [-3.54, -2.76] | 0.970 | <0.0001 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 60 | 18833 | 18835 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2115 | 0.1991 | -0.0171 | [-0.0241, -0.0102] |
| multi_s | 0.8880 | 0.7575 | -0.1411 | [-0.1699, -0.1124] |
| client_wall_s | 1.1190 | 0.9611 | -0.1583 | [-0.1886, -0.1280] |
| client_cpu_s | 0.8535 | 0.8257 | -0.0333 | [-0.0550, -0.0117] |
| client_vcsw | 7778.5 | 4526.5 | -3728.4 | [-4138.9, -3318.0] |
| multi_client_cpu_s | 0.7500 | 0.7250 | -0.0343 | [-0.0548, -0.0138] |
| multi_broker_cpu_s | 0.8400 | 0.5300 | -0.3125 | [-0.3369, -0.2881] |
| broker_user_s | 0.5604 | 0.3344 | -0.2381 | [-0.2548, -0.2214] |
| broker_sys_s | 0.4001 | 0.3098 | -0.0918 | [-0.1096, -0.0740] |
| broker_cpu_s | 0.9686 | 0.6441 | -0.3299 | [-0.3553, -0.3045] |
| broker_vcsw | 2401.5 | 5379.5 | +2959.7 | [+2835.9, +3083.5] |
| broker_maxrss_kib | 5016 | 4850 | -158 | [-182, -134] |
| broker_ru_maxrss_kib | 18756 | 18756 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
