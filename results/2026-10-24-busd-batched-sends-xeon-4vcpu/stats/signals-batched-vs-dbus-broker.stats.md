candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4879 | 0.4207 | -13.77 | [-16.89, -10.72] | [-16.40, -11.15] | 0.896 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.6556 | 0.4862 | -25.84 | [-27.70, -23.96] | [-27.40, -24.26] | 0.739 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1541 | 0.9200 | -20.28 | [-22.15, -18.46] | [-21.86, -18.75] | 0.807 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.1368 | 0.8888 | -21.82 | [-23.57, -20.13] | [-23.29, -20.39] | 0.787 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 15.250 | 106.800 | +600.33 | [+530.80, +675.21] | [+542.70, +662.49] | 6.866 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.6510 | 0.4810 | -26.11 | [-27.83, -24.38] | [-27.58, -24.65] | 0.741 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.1952 | 0.1318 | -32.45 | [-35.13, -29.53] | [-34.69, -30.03] | 0.667 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.1679 | 0.3271 | +94.77 | [+86.85, +103.50] | [+88.09, +102.04] | 1.958 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3431 | 0.1464 | -57.34 | [-59.41, -55.21] | [-59.06, -55.58] | 0.441 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5110 | 0.4735 | -7.35 | [-9.48, -5.11] | [-9.15, -5.48] | 0.932 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 8467.4 | 342.4 | -95.96 | [-96.22, -95.68] | [-96.17, -95.73] | 0.040 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41362 | 4976 | -87.97 | [-88.11, -87.81] | [-88.09, -87.84] | 0.120 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 37198 | 18914 | -49.15 | [-49.73, -48.42] | [-49.66, -48.54] | 0.502 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4814 | 0.4179 | -0.0672 | [-0.0843, -0.0500] |
| multi_s | 0.6501 | 0.4857 | -0.1694 | [-0.1844, -0.1544] |
| client_wall_s | 1.1434 | 0.9255 | -0.2341 | [-0.2591, -0.2090] |
| client_cpu_s | 1.1296 | 0.8911 | -0.2480 | [-0.2716, -0.2245] |
| client_vcsw | 14.000 | 103.500 | +91.550 | [+82.774, +100.326] |
| multi_client_cpu_s | 0.6400 | 0.4800 | -0.1700 | [-0.1841, -0.1559] |
| multi_broker_cpu_s | 0.1900 | 0.1300 | -0.0633 | [-0.0706, -0.0561] |
| broker_user_s | 0.1665 | 0.3245 | +0.1592 | [+0.1493, +0.1690] |
| broker_sys_s | 0.3426 | 0.1435 | -0.1967 | [-0.2084, -0.1851] |
| broker_cpu_s | 0.5064 | 0.4710 | -0.0376 | [-0.0494, -0.0258] |
| broker_vcsw | 8211.0 | 326.0 | -8125.0 | [-8409.1, -7840.9] |
| broker_maxrss_kib | 41910 | 4980 | -36386 | [-36877, -35895] |
| broker_ru_maxrss_kib | 37756 | 19012 | -18285 | [-18780, -17789] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
