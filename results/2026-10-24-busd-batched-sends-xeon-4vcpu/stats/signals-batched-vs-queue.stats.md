candidate batched against baseline queue, from $WORK/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5681 | 0.4207 | -25.94 | [-27.80, -24.08] | [-27.49, -24.36] | 0.740 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.5566 | 0.4862 | -12.66 | [-14.52, -10.80] | [-14.25, -11.07] | 0.864 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1507 | 0.9200 | -20.05 | [-21.43, -18.69] | [-21.20, -18.91] | 0.798 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.0013 | 0.8888 | -11.24 | [-12.92, -9.57] | [-12.65, -9.85] | 0.880 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 237.6 | 106.8 | -55.04 | [-58.86, -50.81] | [-58.29, -51.54] | 0.430 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5507 | 0.4810 | -12.65 | [-14.49, -10.83] | [-14.20, -11.13] | 0.873 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2383 | 0.1318 | -44.69 | [-46.42, -42.84] | [-46.16, -43.15] | 0.542 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.3850 | 0.3271 | -15.04 | [-17.60, -12.34] | [-17.20, -12.79] | 0.859 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2852 | 0.1464 | -48.69 | [-51.04, -46.25] | [-50.66, -46.68] | 0.516 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6702 | 0.4735 | -29.36 | [-30.82, -27.85] | [-30.57, -28.09] | 0.712 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1172.3 | 342.4 | -70.79 | [-72.40, -69.15] | [-72.14, -69.41] | 0.295 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 54464 | 4976 | -90.86 | [-91.01, -90.71] | [-90.99, -90.74] | 0.090 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54429 | 18914 | -65.25 | [-65.77, -64.70] | [-65.69, -64.79] | 0.345 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5599 | 0.4179 | -0.1474 | [-0.1605, -0.1343] |
| multi_s | 0.5522 | 0.4857 | -0.0705 | [-0.0818, -0.0591] |
| client_wall_s | 1.1424 | 0.9255 | -0.2307 | [-0.2487, -0.2127] |
| client_cpu_s | 0.9948 | 0.8911 | -0.1126 | [-0.1308, -0.0943] |
| client_vcsw | 240.0 | 103.5 | -130.8 | [-143.9, -117.6] |
| multi_client_cpu_s | 0.5400 | 0.4800 | -0.0697 | [-0.0807, -0.0587] |
| multi_broker_cpu_s | 0.2400 | 0.1300 | -0.1065 | [-0.1125, -0.1005] |
| broker_user_s | 0.3825 | 0.3245 | -0.0579 | [-0.0695, -0.0464] |
| broker_sys_s | 0.2837 | 0.1435 | -0.1389 | [-0.1487, -0.1290] |
| broker_cpu_s | 0.6650 | 0.4710 | -0.1968 | [-0.2091, -0.1844] |
| broker_vcsw | 1178.0 | 326.0 | -829.9 | [-860.6, -799.3] |
| broker_maxrss_kib | 54840 | 4980 | -49489 | [-50357, -48621] |
| broker_ru_maxrss_kib | 54840 | 19012 | -35515 | [-36383, -34647] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
