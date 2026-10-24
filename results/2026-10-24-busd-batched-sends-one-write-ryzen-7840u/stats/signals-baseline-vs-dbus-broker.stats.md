candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3093 | 0.3237 | +4.68 | [+3.92, +5.42] | [+4.05, +5.29] | 1.045 | <0.0001 | inconclusive; repeatable change (+) |
| multi_s | 60 | 0.3871 | 0.3909 | +0.97 | [+0.16, +1.83] | [+0.29, +1.68] | 1.010 | 0.0196 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.7277 | 0.7725 | +6.16 | [+5.55, +6.79] | [+5.64, +6.67] | 1.064 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.6999 | 0.7113 | +1.64 | [+1.07, +2.23] | [+1.15, +2.12] | 1.014 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 60 | 10.283 | 125.583 | +1121.23 | [+1005.63, +1230.22] | [+1026.71, +1213.97] | 13.361 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.3737 | 0.3783 | +1.25 | [+0.31, +2.18] | [+0.49, +2.05] | 1.000 | 0.0130 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.1335 | 0.2100 | +57.30 | [+54.65, +59.97] | [+55.06, +59.54] | 1.615 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1278 | 0.2792 | +118.45 | [+113.47, +123.72] | [+114.21, +122.93] | 2.168 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2620 | 0.2529 | -3.47 | [-4.92, -2.01] | [-4.70, -2.25] | 0.972 | 0.0001 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.3898 | 0.5321 | +36.51 | [+35.60, +37.43] | [+35.75, +37.28] | 1.363 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 7183.3 | 376.7 | -94.76 | [-94.88, -94.64] | [-94.86, -94.66] | 0.053 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 40029 | 6578 | -83.57 | [-83.77, -83.35] | [-83.74, -83.39] | 0.164 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 35437 | 20529 | -42.07 | [-42.84, -41.24] | [-42.73, -41.39] | 0.571 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3085 | 0.3231 | +0.0145 | [+0.0121, +0.0168] |
| multi_s | 0.3850 | 0.3875 | +0.0038 | [+0.0004, +0.0071] |
| client_wall_s | 0.7263 | 0.7705 | +0.0448 | [+0.0403, +0.0494] |
| client_cpu_s | 0.6988 | 0.7076 | +0.0115 | [+0.0073, +0.0156] |
| client_vcsw | 10.000 | 129.500 | +115.300 | [+110.017, +120.583] |
| multi_client_cpu_s | 0.3700 | 0.3800 | +0.0047 | [+0.0011, +0.0082] |
| multi_broker_cpu_s | 0.1300 | 0.2100 | +0.0765 | [+0.0737, +0.0793] |
| broker_user_s | 0.1292 | 0.2808 | +0.1514 | [+0.1473, +0.1555] |
| broker_sys_s | 0.2608 | 0.2519 | -0.0091 | [-0.0131, -0.0050] |
| broker_cpu_s | 0.3915 | 0.5310 | +0.1423 | [+0.1392, +0.1454] |
| broker_vcsw | 7208.5 | 375.0 | -6806.5 | [-6849.5, -6763.5] |
| broker_maxrss_kib | 40422 | 6588 | -33451 | [-33955, -32947] |
| broker_ru_maxrss_kib | 35992 | 20572 | -14907 | [-15408, -14406] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
