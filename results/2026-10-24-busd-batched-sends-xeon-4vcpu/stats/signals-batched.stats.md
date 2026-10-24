candidate batched against baseline baseline, from $WORK/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4531 | 0.4207 | -7.14 | [-10.37, -3.74] | [-9.86, -4.29] | 0.925 | 0.0004 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.5489 | 0.4862 | -11.42 | [-13.60, -9.21] | [-13.26, -9.57] | 0.878 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0150 | 0.9200 | -9.36 | [-11.44, -7.20] | [-11.12, -7.56] | 0.904 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9702 | 0.8888 | -8.39 | [-10.20, -6.49] | [-9.94, -6.83] | 0.914 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 162.5 | 106.8 | -34.26 | [-40.53, -27.53] | [-39.58, -28.59] | 0.728 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5452 | 0.4810 | -11.77 | [-13.89, -9.60] | [-13.54, -9.98] | 0.880 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2323 | 0.1318 | -43.26 | [-45.11, -41.28] | [-44.82, -41.64] | 0.565 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.3898 | 0.3271 | -16.09 | [-19.04, -13.09] | [-18.53, -13.55] | 0.842 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2312 | 0.1464 | -36.68 | [-40.30, -32.88] | [-39.70, -33.53] | 0.616 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6210 | 0.4735 | -23.75 | [-25.68, -21.77] | [-25.37, -22.07] | 0.763 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 323.1 | 342.4 | +5.99 | [-0.88, +13.51] | [+0.24, +12.16] | 1.037 | 0.1294 | inconclusive |
| broker_maxrss_kib | 60 | 4868 | 4976 | +2.21 | [+1.61, +2.81] | [+1.72, +2.70] | 1.025 | <0.0001 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 18912 | 18914 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4460 | 0.4179 | -0.0324 | [-0.0487, -0.0161] |
| multi_s | 0.5407 | 0.4857 | -0.0627 | [-0.0763, -0.0491] |
| client_wall_s | 1.0034 | 0.9255 | -0.0950 | [-0.1188, -0.0711] |
| client_cpu_s | 0.9565 | 0.8911 | -0.0814 | [-0.1011, -0.0617] |
| client_vcsw | 146.5 | 103.5 | -55.7 | [-70.2, -41.1] |
| multi_client_cpu_s | 0.5400 | 0.4800 | -0.0642 | [-0.0772, -0.0511] |
| multi_broker_cpu_s | 0.2300 | 0.1300 | -0.1005 | [-0.1067, -0.0943] |
| broker_user_s | 0.3894 | 0.3245 | -0.0627 | [-0.0760, -0.0495] |
| broker_sys_s | 0.2349 | 0.1435 | -0.0848 | [-0.0960, -0.0736] |
| broker_cpu_s | 0.6133 | 0.4710 | -0.1475 | [-0.1624, -0.1326] |
| broker_vcsw | 304.5 | 326.0 | +19.4 | [-3.9, +42.6] |
| broker_maxrss_kib | 4850 | 4980 | +108 | [+78, +137] |
| broker_ru_maxrss_kib | 19012 | 19012 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
