candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 2.0654 | 2.0257 | -1.92 | [-2.88, -0.85] | [-2.74, -1.03] | 0.974 | 0.0005 | no material change; repeatable change (-) |
| multi_s | 40 | 2.2259 | 2.2359 | +0.45 | [-0.51, +1.39] | [-0.36, +1.24] | 1.004 | 0.3537 | no material change |
| client_wall_s | 40 | 4.3220 | 4.2924 | -0.69 | [-1.46, +0.14] | [-1.35, -0.01] | 0.989 | 0.0326 | no material change |
| client_cpu_s | 40 | 4.1221 | 4.0967 | -0.62 | [-1.34, +0.14] | [-1.23, +0.01] | 0.989 | 0.0360 | no material change |
| client_vcsw | 40 | 3233.9 | 3195.0 | -1.20 | [-10.58, +10.01] | [-9.25, +8.08] | 0.998 | 0.5453 | inconclusive |
| multi_client_cpu_s | 40 | 2.1655 | 2.1778 | +0.57 | [-0.32, +1.45] | [-0.18, +1.31] | 1.005 | 0.2316 | no material change |
| multi_broker_cpu_s | 40 | 1.8725 | 1.9433 | +3.78 | [+2.02, +5.51] | [+2.31, +5.24] | 1.035 | 0.0002 | inconclusive; repeatable change (+) |
| broker_user_s | 40 | 1.6324 | 1.6333 | +0.05 | [-1.30, +1.39] | [-1.08, +1.17] | 0.998 | 0.8088 | no material change |
| broker_sys_s | 40 | 1.7880 | 1.7700 | -1.01 | [-2.64, +0.70] | [-2.40, +0.44] | 0.983 | 0.1097 | no material change |
| broker_cpu_s | 40 | 3.4205 | 3.4033 | -0.50 | [-1.69, +0.69] | [-1.49, +0.51] | 0.989 | 0.3468 | no material change |
| broker_vcsw | 40 | 14949.4 | 14743.4 | -1.38 | [-4.20, +1.44] | [-3.75, +0.99] | 0.991 | 0.4278 | no material change |
| broker_maxrss_kib | 40 | 11452 | 11316 | -1.18 | [-2.72, +0.39] | [-2.49, +0.14] | 0.988 | 0.1271 | no material change |
| broker_ru_maxrss_kib | 40 | 20495 | 20492 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 2.0745 | 2.0330 | -0.0397 | [-0.0619, -0.0175] |
| multi_s | 2.2278 | 2.2457 | +0.0100 | [-0.0119, +0.0320] |
| client_wall_s | 4.3527 | 4.3335 | -0.0296 | [-0.0660, +0.0068] |
| client_cpu_s | 4.1369 | 4.1208 | -0.0254 | [-0.0571, +0.0062] |
| client_vcsw | 3189.5 | 3288.0 | -38.9 | [-389.4, +311.7] |
| multi_client_cpu_s | 2.1650 | 2.1900 | +0.0123 | [-0.0077, +0.0322] |
| multi_broker_cpu_s | 1.8800 | 1.9250 | +0.0708 | [+0.0365, +0.1050] |
| broker_user_s | 1.6394 | 1.6410 | +0.0008 | [-0.0219, +0.0236] |
| broker_sys_s | 1.7849 | 1.7638 | -0.0180 | [-0.0500, +0.0139] |
| broker_cpu_s | 3.4513 | 3.4101 | -0.0172 | [-0.0602, +0.0258] |
| broker_vcsw | 15003.5 | 15205.5 | -206.0 | [-651.9, +239.8] |
| broker_maxrss_kib | 11520 | 11302 | -135 | [-327, +56] |
| broker_ru_maxrss_kib | 20540 | 20540 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
