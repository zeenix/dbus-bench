candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1983 | 0.1990 | +0.32 | [-2.29, +2.91] | [-1.86, +2.50] | 1.012 | 0.6063 | no material change |
| multi_s | 60 | 1.2675 | 0.7563 | -40.33 | [-41.74, -38.85] | [-41.53, -39.09] | 0.584 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.4721 | 0.9614 | -34.69 | [-36.04, -33.29] | [-35.82, -33.53] | 0.643 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.3764 | 0.8267 | -39.94 | [-41.24, -38.61] | [-41.04, -38.83] | 0.597 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 3211.5 | 4603.6 | +43.35 | [+38.57, +48.56] | [+39.32, +47.67] | 1.418 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 1.2457 | 0.7210 | -42.12 | [-43.47, -40.73] | [-43.28, -40.94] | 0.567 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.4917 | 0.5335 | +8.51 | [+5.56, +11.43] | [+6.02, +10.98] | 1.085 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1733 | 0.3352 | +93.46 | [+85.22, +101.70] | [+86.66, +100.48] | 1.943 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.4132 | 0.3071 | -25.67 | [-28.72, -22.55] | [-28.25, -23.06] | 0.740 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5865 | 0.6423 | +9.52 | [+6.84, +12.18] | [+7.27, +11.75] | 1.100 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 34194.0 | 5412.0 | -84.17 | [-84.65, -83.69] | [-84.57, -83.77] | 0.161 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7291 | 4857 | -33.38 | [-33.73, -33.04] | [-33.67, -33.10] | 0.668 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18835 | 18835 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1936 | 0.1991 | +0.0006 | [-0.0047, +0.0060] |
| multi_s | 1.2691 | 0.7575 | -0.5111 | [-0.5362, -0.4860] |
| client_wall_s | 1.4638 | 0.9611 | -0.5107 | [-0.5375, -0.4838] |
| client_cpu_s | 1.3622 | 0.8257 | -0.5497 | [-0.5752, -0.5242] |
| client_vcsw | 3223.0 | 4526.5 | +1392.0 | [+1245.9, +1538.2] |
| multi_client_cpu_s | 1.2400 | 0.7250 | -0.5247 | [-0.5491, -0.5002] |
| multi_broker_cpu_s | 0.5000 | 0.5300 | +0.0418 | [+0.0274, +0.0563] |
| broker_user_s | 0.1724 | 0.3344 | +0.1619 | [+0.1512, +0.1726] |
| broker_sys_s | 0.4137 | 0.3098 | -0.1061 | [-0.1208, -0.0914] |
| broker_cpu_s | 0.5877 | 0.6441 | +0.0558 | [+0.0403, +0.0714] |
| broker_vcsw | 34254.0 | 5379.5 | -28782.0 | [-29573.1, -27991.0] |
| broker_maxrss_kib | 7290 | 4850 | -2434 | [-2465, -2402] |
| broker_ru_maxrss_kib | 18756 | 18756 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
