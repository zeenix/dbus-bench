candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3865 | 0.3135 | -18.88 | [-19.50, -18.31] | [-19.40, -18.39] | 0.811 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3799 | 0.3772 | -0.72 | [-1.85, +0.45] | [-1.67, +0.27] | 0.995 | 0.1803 | no material change |
| client_wall_s | 60 | 0.8257 | 0.7519 | -8.94 | [-9.69, -8.19] | [-9.56, -8.30] | 0.912 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.6998 | 0.6901 | -1.39 | [-2.13, -0.63] | [-2.00, -0.75] | 0.990 | 0.0007 | no material change; repeatable change (-) |
| client_vcsw | 60 | 212.0 | 131.4 | -38.03 | [-39.94, -36.17] | [-39.66, -36.47] | 0.625 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3658 | 0.3633 | -0.68 | [-2.03, +0.69] | [-1.80, +0.46] | 1.000 | 0.4240 | no material change |
| multi_broker_cpu_s | 60 | 0.1858 | 0.2053 | +10.49 | [+8.54, +12.56] | [+8.84, +12.21] | 1.105 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.2664 | 0.2738 | +2.77 | [+1.00, +4.55] | [+1.31, +4.27] | 1.035 | 0.0034 | no material change; repeatable change (+) |
| broker_sys_s | 60 | 0.2606 | 0.2513 | -3.59 | [-5.30, -1.80] | [-5.04, -2.09] | 0.946 | 0.0005 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.5271 | 0.5251 | -0.37 | [-1.11, +0.34] | [-1.00, +0.23] | 0.998 | 0.4843 | no material change |
| broker_vcsw | 60 | 811.0 | 377.9 | -53.40 | [-55.73, -50.90] | [-55.37, -51.32] | 0.499 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 55199 | 6605 | -88.03 | [-88.12, -87.95] | [-88.10, -87.96] | 0.120 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54843 | 20468 | -62.68 | [-62.87, -62.49] | [-62.84, -62.52] | 0.374 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3846 | 0.3137 | -0.0730 | [-0.0757, -0.0703] |
| multi_s | 0.3748 | 0.3726 | -0.0027 | [-0.0072, +0.0017] |
| client_wall_s | 0.8212 | 0.7487 | -0.0738 | [-0.0805, -0.0671] |
| client_cpu_s | 0.6952 | 0.6855 | -0.0097 | [-0.0151, -0.0043] |
| client_vcsw | 213.5 | 135.0 | -80.6 | [-85.1, -76.2] |
| multi_client_cpu_s | 0.3600 | 0.3600 | -0.0025 | [-0.0076, +0.0026] |
| multi_broker_cpu_s | 0.1900 | 0.2100 | +0.0195 | [+0.0159, +0.0231] |
| broker_user_s | 0.2649 | 0.2729 | +0.0074 | [+0.0026, +0.0122] |
| broker_sys_s | 0.2613 | 0.2510 | -0.0094 | [-0.0142, -0.0045] |
| broker_cpu_s | 0.5262 | 0.5236 | -0.0020 | [-0.0060, +0.0020] |
| broker_vcsw | 754.5 | 377.5 | -433.1 | [-473.0, -393.2] |
| broker_maxrss_kib | 55164 | 6610 | -48593 | [-48921, -48266] |
| broker_ru_maxrss_kib | 54722 | 20500 | -34375 | [-34659, -34091] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
