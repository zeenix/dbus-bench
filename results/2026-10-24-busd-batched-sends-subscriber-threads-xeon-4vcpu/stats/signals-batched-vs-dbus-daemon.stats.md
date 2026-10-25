candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.6892 | 0.3278 | -52.44 | [-54.50, -50.24] | [-54.16, -50.64] | 0.466 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2216 | 0.2830 | -76.84 | [-78.02, -75.56] | [-77.83, -75.77] | 0.233 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.9403 | 0.6430 | -66.86 | [-68.03, -65.62] | [-67.86, -65.82] | 0.323 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.8376 | 1.2327 | -56.56 | [-57.84, -55.21] | [-57.65, -55.44] | 0.427 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 106855.0 | 5040.4 | -95.28 | [-95.61, -94.92] | [-95.56, -94.99] | 0.043 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 2.2138 | 0.7828 | -64.64 | [-65.90, -63.31] | [-65.71, -63.54] | 0.345 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1982 | 0.1910 | -84.06 | [-84.99, -83.02] | [-84.84, -83.21] | 0.152 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7283 | 0.3462 | -52.46 | [-54.04, -50.79] | [-53.78, -51.08] | 0.473 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.1614 | 0.1757 | -84.88 | [-85.68, -84.00] | [-85.57, -84.15] | 0.150 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.8897 | 0.5219 | -72.38 | [-73.35, -71.34] | [-73.20, -71.51] | 0.272 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 62.183 | 579.600 | +832.08 | [+564.49, +1237.90] | [+602.33, +1159.70] | 13.399 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 4806 | 4787 | -0.41 | [-1.63, +0.81] | [-1.44, +0.61] | 1.008 | 0.5412 | no material change |
| broker_ru_maxrss_kib | 60 | 18834 | 18836 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.6758 | 0.3187 | -0.3615 | [-0.3856, -0.3373] |
| multi_s | 1.2591 | 0.2807 | -0.9386 | [-0.9919, -0.8853] |
| client_wall_s | 1.9584 | 0.6342 | -1.2973 | [-1.3525, -1.2421] |
| client_cpu_s | 2.9043 | 1.2223 | -1.6049 | [-1.6727, -1.5371] |
| client_vcsw | 112115.0 | 4831.5 | -101814.6 | [-105577.0, -98052.3] |
| multi_client_cpu_s | 2.2700 | 0.7700 | -1.4310 | [-1.4945, -1.3675] |
| multi_broker_cpu_s | 1.2350 | 0.1800 | -1.0072 | [-1.0613, -0.9530] |
| broker_user_s | 0.7225 | 0.3436 | -0.3821 | [-0.3986, -0.3656] |
| broker_sys_s | 1.1950 | 0.1739 | -0.9857 | [-1.0347, -0.9368] |
| broker_cpu_s | 1.9192 | 0.5152 | -1.3678 | [-1.4222, -1.3135] |
| broker_vcsw | 30.000 | 498.500 | +517.417 | [+421.441, +613.393] |
| broker_maxrss_kib | 4740 | 4786 | -20 | [-80, +41] |
| broker_ru_maxrss_kib | 18840 | 18840 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
