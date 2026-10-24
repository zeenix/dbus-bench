candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4879 | 0.4531 | -7.14 | [-10.50, -3.61] | [-10.00, -4.18] | 0.930 | 0.0005 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.6556 | 0.5489 | -16.27 | [-18.19, -14.25] | [-17.92, -14.57] | 0.837 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1541 | 1.0150 | -12.05 | [-14.01, -10.03] | [-13.68, -10.37] | 0.870 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.1368 | 0.9702 | -14.65 | [-16.39, -12.84] | [-16.11, -13.17] | 0.851 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 15.250 | 162.467 | +965.36 | [+857.37, +1086.42] | [+873.59, +1065.52] | 9.670 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.6510 | 0.5452 | -16.26 | [-18.12, -14.24] | [-17.85, -14.59] | 0.839 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.1952 | 0.2323 | +19.04 | [+15.40, +22.87] | [+15.98, +22.33] | 1.195 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1679 | 0.3898 | +132.11 | [+123.89, +141.13] | [+125.18, +139.62] | 2.310 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3431 | 0.2312 | -32.63 | [-35.83, -29.40] | [-35.31, -29.87] | 0.685 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5110 | 0.6210 | +21.51 | [+18.83, +24.40] | [+19.24, +23.93] | 1.195 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 8467.4 | 323.1 | -96.18 | [-96.38, -95.98] | [-96.35, -96.01] | 0.038 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41362 | 4868 | -88.23 | [-88.37, -88.07] | [-88.35, -88.10] | 0.117 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 37198 | 18912 | -49.16 | [-49.74, -48.43] | [-49.66, -48.55] | 0.502 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4814 | 0.4460 | -0.0348 | [-0.0527, -0.0169] |
| multi_s | 0.6501 | 0.5407 | -0.1067 | [-0.1212, -0.0922] |
| client_wall_s | 1.1434 | 1.0034 | -0.1391 | [-0.1636, -0.1146] |
| client_cpu_s | 1.1296 | 0.9565 | -0.1666 | [-0.1885, -0.1446] |
| client_vcsw | 14.000 | 146.500 | +147.217 | [+133.161, +161.272] |
| multi_client_cpu_s | 0.6400 | 0.5400 | -0.1058 | [-0.1199, -0.0917] |
| multi_broker_cpu_s | 0.1900 | 0.2300 | +0.0372 | [+0.0305, +0.0438] |
| broker_user_s | 0.1665 | 0.3894 | +0.2219 | [+0.2114, +0.2323] |
| broker_sys_s | 0.3426 | 0.2349 | -0.1119 | [-0.1256, -0.0982] |
| broker_cpu_s | 0.5064 | 0.6133 | +0.1099 | [+0.0965, +0.1233] |
| broker_vcsw | 8211.0 | 304.5 | -8144.4 | [-8423.4, -7865.3] |
| broker_maxrss_kib | 41910 | 4850 | -36494 | [-36987, -36001] |
| broker_ru_maxrss_kib | 37756 | 19012 | -18287 | [-18782, -17791] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
