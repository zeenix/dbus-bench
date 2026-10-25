candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8755 | 2.0257 | +8.00 | [+6.92, +9.23] | [+7.07, +9.00] | 1.076 | <0.0001 | slower/larger |
| multi_s | 40 | 2.2216 | 2.2359 | +0.64 | [-0.47, +1.82] | [-0.30, +1.62] | 1.001 | 0.3897 | no material change |
| client_wall_s | 40 | 4.1280 | 4.2924 | +3.98 | [+3.03, +5.06] | [+3.17, +4.86] | 1.035 | <0.0001 | no material change; repeatable change (+) |
| client_cpu_s | 40 | 3.9879 | 4.0967 | +2.73 | [+1.93, +3.61] | [+2.05, +3.47] | 1.025 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 3216.3 | 3195.0 | -0.66 | [-15.28, +18.78] | [-13.19, +15.37] | 1.013 | 0.7984 | inconclusive |
| multi_client_cpu_s | 40 | 2.1562 | 2.1778 | +1.00 | [+0.02, +2.01] | [+0.17, +1.84] | 1.009 | 0.0791 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.9563 | 1.9433 | -0.66 | [-2.68, +1.32] | [-2.37, +1.04] | 1.010 | 0.6523 | no material change |
| broker_user_s | 40 | 1.6481 | 1.6333 | -0.90 | [-2.42, +0.67] | [-2.18, +0.43] | 0.988 | 0.2422 | no material change |
| broker_sys_s | 40 | 1.7622 | 1.7700 | +0.44 | [-1.69, +2.57] | [-1.34, +2.22] | 1.004 | 0.5453 | no material change |
| broker_cpu_s | 40 | 3.4104 | 3.4033 | -0.21 | [-1.64, +1.20] | [-1.40, +0.98] | 1.002 | 0.9893 | no material change |
| broker_vcsw | 40 | 11818.0 | 14743.4 | +24.75 | [+20.15, +29.68] | [+20.83, +28.93] | 1.238 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11813 | 11316 | -4.20 | [-5.68, -2.73] | [-5.44, -2.93] | 0.952 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20492 | 20492 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8956 | 2.0330 | +0.1501 | [+0.1281, +0.1721] |
| multi_s | 2.2278 | 2.2457 | +0.0143 | [-0.0119, +0.0404] |
| client_wall_s | 4.1728 | 4.3335 | +0.1644 | [+0.1218, +0.2070] |
| client_cpu_s | 4.0367 | 4.1208 | +0.1088 | [+0.0742, +0.1434] |
| client_vcsw | 3360.0 | 3288.0 | -21.2 | [-582.6, +540.1] |
| multi_client_cpu_s | 2.1600 | 2.1900 | +0.0215 | [-0.0007, +0.0437] |
| multi_broker_cpu_s | 1.9600 | 1.9250 | -0.0130 | [-0.0552, +0.0292] |
| broker_user_s | 1.6677 | 1.6410 | -0.0148 | [-0.0416, +0.0119] |
| broker_sys_s | 1.7600 | 1.7638 | +0.0077 | [-0.0317, +0.0472] |
| broker_cpu_s | 3.4416 | 3.4101 | -0.0071 | [-0.0586, +0.0444] |
| broker_vcsw | 12088.5 | 15205.5 | +2925.4 | [+2390.9, +3459.8] |
| broker_maxrss_kib | 11722 | 11302 | -496 | [-684, -309] |
| broker_ru_maxrss_kib | 20540 | 20540 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
