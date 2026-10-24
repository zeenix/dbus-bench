candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3135 | 0.2985 | -4.79 | [-5.42, -4.18] | [-5.32, -4.28] | 0.947 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.3772 | 0.3581 | -5.07 | [-6.08, -4.11] | [-5.90, -4.26] | 0.957 | <0.0001 | inconclusive; repeatable change (-) |
| client_wall_s | 60 | 0.7519 | 0.7164 | -4.73 | [-5.53, -3.93] | [-5.39, -4.06] | 0.955 | <0.0001 | inconclusive; repeatable change (-) |
| client_cpu_s | 60 | 0.6901 | 0.6608 | -4.25 | [-4.94, -3.59] | [-4.82, -3.69] | 0.961 | <0.0001 | no material change; repeatable change (-) |
| client_vcsw | 60 | 131.4 | 41.3 | -68.56 | [-70.46, -66.54] | [-70.15, -66.90] | 0.302 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3633 | 0.3430 | -5.60 | [-6.80, -4.45] | [-6.61, -4.62] | 0.946 | <0.0001 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.2053 | 0.1042 | -49.27 | [-50.20, -48.33] | [-50.04, -48.49] | 0.500 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2738 | 0.2287 | -16.48 | [-17.84, -15.11] | [-17.64, -15.34] | 0.829 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2513 | 0.1430 | -43.08 | [-44.34, -41.86] | [-44.12, -42.07] | 0.577 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5251 | 0.3717 | -29.21 | [-29.67, -28.76] | [-29.60, -28.83] | 0.708 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 377.9 | 628.1 | +66.19 | [+61.37, +71.16] | [+62.12, +70.34] | 1.659 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6605 | 6623 | +0.27 | [-0.35, +0.92] | [-0.25, +0.81] | 0.998 | 0.7995 | no material change |
| broker_ru_maxrss_kib | 60 | 20468 | 20472 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3137 | 0.2973 | -0.0150 | [-0.0171, -0.0130] |
| multi_s | 0.3726 | 0.3560 | -0.0191 | [-0.0230, -0.0152] |
| client_wall_s | 0.7487 | 0.7159 | -0.0355 | [-0.0419, -0.0292] |
| client_cpu_s | 0.6855 | 0.6587 | -0.0293 | [-0.0342, -0.0244] |
| client_vcsw | 135.0 | 41.0 | -90.1 | [-94.8, -85.3] |
| multi_client_cpu_s | 0.3600 | 0.3400 | -0.0203 | [-0.0249, -0.0157] |
| multi_broker_cpu_s | 0.2100 | 0.1000 | -0.1012 | [-0.1039, -0.0984] |
| broker_user_s | 0.2729 | 0.2288 | -0.0451 | [-0.0494, -0.0409] |
| broker_sys_s | 0.2510 | 0.1416 | -0.1083 | [-0.1124, -0.1041] |
| broker_cpu_s | 0.5236 | 0.3706 | -0.1534 | [-0.1563, -0.1505] |
| broker_vcsw | 377.5 | 622.5 | +250.2 | [+235.2, +265.2] |
| broker_maxrss_kib | 6610 | 6628 | +18 | [-25, +61] |
| broker_ru_maxrss_kib | 20500 | 20500 | +4 | [-2, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
