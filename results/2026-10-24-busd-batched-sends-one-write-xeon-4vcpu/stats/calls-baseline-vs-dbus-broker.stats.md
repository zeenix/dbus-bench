candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2079 | 0.1997 | -3.95 | [-6.21, -1.39] | [-5.85, -1.84] | 0.955 | 0.0010 | inconclusive; repeatable change (-) |
| multi_s | 60 | 1.2480 | 0.7999 | -35.91 | [-38.51, -33.05] | [-38.12, -33.53] | 0.638 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.4624 | 1.0061 | -31.20 | [-33.59, -28.62] | [-33.20, -29.05] | 0.687 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.3581 | 0.8608 | -36.62 | [-38.96, -34.10] | [-38.58, -34.51] | 0.624 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 3346.9 | 4937.2 | +47.51 | [+42.59, +52.86] | [+43.30, +51.99] | 1.494 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 1.2267 | 0.7528 | -38.63 | [-41.11, -35.87] | [-40.74, -36.37] | 0.607 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.4950 | 0.5752 | +16.20 | [+12.55, +20.08] | [+13.05, +19.47] | 1.160 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1811 | 0.3619 | +99.82 | [+91.42, +108.68] | [+92.77, +107.17] | 2.021 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.4158 | 0.3215 | -22.68 | [-26.76, -18.37] | [-26.13, -19.03] | 0.777 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5969 | 0.6834 | +14.48 | [+11.27, +17.86] | [+11.73, +17.29] | 1.131 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 32622.3 | 5101.7 | -84.36 | [-85.02, -83.66] | [-84.91, -83.77] | 0.160 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7310 | 4880 | -33.24 | [-33.65, -32.86] | [-33.58, -32.92] | 0.670 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 19033 | 19033 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2065 | 0.1988 | -0.0082 | [-0.0134, -0.0030] |
| multi_s | 1.2454 | 0.7874 | -0.4481 | [-0.4900, -0.4063] |
| client_wall_s | 1.4563 | 0.9811 | -0.4563 | [-0.4993, -0.4134] |
| client_cpu_s | 1.3560 | 0.8417 | -0.4973 | [-0.5378, -0.4568] |
| client_vcsw | 3361.5 | 4847.0 | +1590.3 | [+1432.7, +1747.9] |
| multi_client_cpu_s | 1.2300 | 0.7300 | -0.4738 | [-0.5138, -0.4338] |
| multi_broker_cpu_s | 0.4900 | 0.5700 | +0.0802 | [+0.0617, +0.0986] |
| broker_user_s | 0.1810 | 0.3569 | +0.1808 | [+0.1699, +0.1916] |
| broker_sys_s | 0.4085 | 0.3179 | -0.0943 | [-0.1144, -0.0742] |
| broker_cpu_s | 0.5951 | 0.6789 | +0.0864 | [+0.0671, +0.1058] |
| broker_vcsw | 32967.5 | 5178.0 | -27520.6 | [-28624.0, -26417.2] |
| broker_maxrss_kib | 7314 | 4884 | -2430 | [-2467, -2394] |
| broker_ru_maxrss_kib | 19016 | 19016 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
