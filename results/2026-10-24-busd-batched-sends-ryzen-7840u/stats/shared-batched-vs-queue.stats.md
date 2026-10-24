candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8791 | 2.0382 | +8.47 | [+6.99, +9.79] | [+7.23, +9.61] | 1.089 | <0.0001 | slower/larger |
| multi_s | 40 | 2.2559 | 2.2409 | -0.66 | [-2.18, +0.84] | [-1.93, +0.58] | 0.997 | 0.4200 | no material change |
| client_wall_s | 40 | 4.1678 | 4.3121 | +3.46 | [+2.17, +4.65] | [+2.40, +4.46] | 1.040 | <0.0001 | no material change; repeatable change (+) |
| client_cpu_s | 40 | 4.0400 | 4.1228 | +2.05 | [+0.96, +3.06] | [+1.14, +2.91] | 1.023 | 0.0003 | no material change; repeatable change (+) |
| client_vcsw | 40 | 2668.2 | 2832.1 | +6.14 | [-7.93, +23.33] | [-5.98, +20.49] | 1.154 | 0.1542 | inconclusive |
| multi_client_cpu_s | 40 | 2.1970 | 2.1825 | -0.66 | [-2.11, +0.79] | [-1.88, +0.53] | 1.000 | 0.3531 | no material change |
| multi_broker_cpu_s | 40 | 1.9672 | 1.9395 | -1.41 | [-3.47, +0.68] | [-3.16, +0.34] | 0.990 | 0.2760 | no material change |
| broker_user_s | 40 | 1.6662 | 1.6382 | -1.68 | [-3.11, -0.25] | [-2.90, -0.48] | 0.985 | 0.0424 | no material change; repeatable change (-) |
| broker_sys_s | 40 | 1.7570 | 1.7629 | +0.34 | [-1.47, +2.23] | [-1.19, +1.90] | 0.993 | 0.9571 | no material change |
| broker_cpu_s | 40 | 3.4232 | 3.4011 | -0.64 | [-1.99, +0.71] | [-1.76, +0.50] | 0.997 | 0.3537 | no material change |
| broker_vcsw | 40 | 12132.6 | 14890.4 | +22.73 | [+16.68, +28.30] | [+17.79, +27.45] | 1.250 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11789 | 11238 | -4.68 | [-5.99, -3.33] | [-5.78, -3.54] | 0.954 | <0.0001 | inconclusive; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20510 | 20510 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8636 | 2.0329 | +0.1591 | [+0.1331, +0.1851] |
| multi_s | 2.2476 | 2.2364 | -0.0150 | [-0.0506, +0.0206] |
| client_wall_s | 4.1592 | 4.2919 | +0.1443 | [+0.0919, +0.1967] |
| client_cpu_s | 4.0359 | 4.1102 | +0.0828 | [+0.0392, +0.1264] |
| client_vcsw | 2388.5 | 2788.0 | +163.9 | [-250.6, +578.5] |
| multi_client_cpu_s | 2.1900 | 2.1700 | -0.0145 | [-0.0478, +0.0188] |
| multi_broker_cpu_s | 1.9450 | 1.9200 | -0.0277 | [-0.0714, +0.0159] |
| broker_user_s | 1.6629 | 1.6309 | -0.0280 | [-0.0534, -0.0026] |
| broker_sys_s | 1.7411 | 1.7500 | +0.0060 | [-0.0279, +0.0399] |
| broker_cpu_s | 3.3995 | 3.3710 | -0.0221 | [-0.0713, +0.0272] |
| broker_vcsw | 12314.0 | 14992.5 | +2757.8 | [+2127.9, +3387.6] |
| broker_maxrss_kib | 11788 | 11222 | -551 | [-720, -383] |
| broker_ru_maxrss_kib | 20564 | 20564 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
