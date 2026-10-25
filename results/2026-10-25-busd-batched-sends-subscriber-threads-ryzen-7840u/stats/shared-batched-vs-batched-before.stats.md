candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 2.0085 | 2.0257 | +0.85 | [-0.23, +2.01] | [-0.05, +1.79] | 1.006 | 0.1466 | no material change |
| multi_s | 40 | 2.2309 | 2.2359 | +0.23 | [-0.88, +1.32] | [-0.71, +1.14] | 1.001 | 0.6095 | no material change |
| client_wall_s | 40 | 4.2700 | 4.2924 | +0.52 | [-0.41, +1.52] | [-0.26, +1.35] | 1.004 | 0.3678 | no material change |
| client_cpu_s | 40 | 4.0822 | 4.0967 | +0.36 | [-0.54, +1.29] | [-0.40, +1.14] | 1.002 | 0.4846 | no material change |
| client_vcsw | 40 | 3212.2 | 3195.0 | -0.53 | [-12.83, +13.18] | [-10.83, +10.95] | 1.017 | 0.4679 | inconclusive |
| multi_client_cpu_s | 40 | 2.1690 | 2.1778 | +0.40 | [-0.66, +1.45] | [-0.49, +1.29] | 1.005 | 0.4295 | no material change |
| multi_broker_cpu_s | 40 | 1.9118 | 1.9433 | +1.65 | [-0.31, +3.57] | [-0.00, +3.27] | 1.022 | 0.0979 | no material change |
| broker_user_s | 40 | 1.6199 | 1.6333 | +0.82 | [-0.54, +2.18] | [-0.32, +1.98] | 1.010 | 0.2477 | no material change |
| broker_sys_s | 40 | 1.7316 | 1.7700 | +2.21 | [+0.35, +4.19] | [+0.65, +3.85] | 1.022 | 0.0546 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 3.3516 | 3.4033 | +1.54 | [+0.25, +2.87] | [+0.45, +2.65] | 1.011 | 0.0482 | no material change; repeatable change (+) |
| broker_vcsw | 40 | 15269.8 | 14743.4 | -3.45 | [-6.25, -0.79] | [-5.76, -1.22] | 0.972 | 0.0348 | inconclusive; repeatable change (-) |
| broker_maxrss_kib | 40 | 11409 | 11316 | -0.81 | [-2.53, +0.92] | [-2.27, +0.63] | 0.988 | 0.3467 | no material change |
| broker_ru_maxrss_kib | 40 | 20492 | 20492 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 2.0020 | 2.0330 | +0.0171 | [-0.0061, +0.0404] |
| multi_s | 2.2223 | 2.2457 | +0.0051 | [-0.0205, +0.0306] |
| client_wall_s | 4.3083 | 4.3335 | +0.0224 | [-0.0203, +0.0651] |
| client_cpu_s | 4.1051 | 4.1208 | +0.0145 | [-0.0245, +0.0535] |
| client_vcsw | 3077.0 | 3288.0 | -17.1 | [-448.3, +414.1] |
| multi_client_cpu_s | 2.1650 | 2.1900 | +0.0088 | [-0.0149, +0.0324] |
| multi_broker_cpu_s | 1.9050 | 1.9250 | +0.0315 | [-0.0075, +0.0705] |
| broker_user_s | 1.6388 | 1.6410 | +0.0134 | [-0.0097, +0.0364] |
| broker_sys_s | 1.7262 | 1.7638 | +0.0383 | [+0.0039, +0.0727] |
| broker_cpu_s | 3.3596 | 3.4101 | +0.0517 | [+0.0061, +0.0972] |
| broker_vcsw | 15368.5 | 15205.5 | -526.5 | [-965.8, -87.2] |
| broker_maxrss_kib | 11334 | 11302 | -93 | [-300, +114] |
| broker_ru_maxrss_kib | 20540 | 20540 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
