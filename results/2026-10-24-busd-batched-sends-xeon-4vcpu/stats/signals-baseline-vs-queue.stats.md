candidate baseline against baseline queue, from $WORK/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5681 | 0.4531 | -20.25 | [-22.54, -17.82] | [-22.20, -18.23] | 0.787 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.5566 | 0.5489 | -1.39 | [-4.05, +1.43] | [-3.65, +0.94] | 0.973 | 0.2538 | no material change |
| client_wall_s | 60 | 1.1507 | 1.0150 | -11.80 | [-13.77, -9.72] | [-13.46, -10.06] | 0.878 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.0013 | 0.9702 | -3.11 | [-5.16, -0.94] | [-4.85, -1.28] | 0.954 | 0.0096 | no material change; repeatable change (-) |
| client_vcsw | 60 | 237.6 | 162.5 | -31.61 | [-38.42, -23.83] | [-37.38, -25.28] | 0.597 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5507 | 0.5452 | -1.00 | [-3.50, +1.66] | [-3.14, +1.21] | 1.000 | 0.3584 | no material change |
| multi_broker_cpu_s | 60 | 0.2383 | 0.2323 | -2.52 | [-5.51, +0.49] | [-5.00, +0.00] | 1.000 | 0.1412 | inconclusive |
| broker_user_s | 60 | 0.3850 | 0.3898 | +1.25 | [-1.97, +4.57] | [-1.46, +4.02] | 1.016 | 0.4097 | no material change |
| broker_sys_s | 60 | 0.2852 | 0.2312 | -18.95 | [-22.11, -15.69] | [-21.59, -16.19] | 0.833 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6702 | 0.6210 | -7.35 | [-9.47, -5.14] | [-9.13, -5.47] | 0.930 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1172.3 | 323.1 | -72.44 | [-73.88, -70.86] | [-73.66, -71.13] | 0.276 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 54464 | 4868 | -91.06 | [-91.21, -90.91] | [-91.18, -90.93] | 0.089 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54429 | 18912 | -65.25 | [-65.77, -64.70] | [-65.69, -64.79] | 0.345 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5599 | 0.4460 | -0.1150 | [-0.1298, -0.1002] |
| multi_s | 0.5522 | 0.5407 | -0.0078 | [-0.0235, +0.0080] |
| client_wall_s | 1.1424 | 1.0034 | -0.1357 | [-0.1604, -0.1110] |
| client_cpu_s | 0.9948 | 0.9565 | -0.0311 | [-0.0532, -0.0090] |
| client_vcsw | 240.0 | 146.5 | -75.1 | [-94.6, -55.6] |
| multi_client_cpu_s | 0.5400 | 0.5400 | -0.0055 | [-0.0202, +0.0092] |
| multi_broker_cpu_s | 0.2400 | 0.2300 | -0.0060 | [-0.0135, +0.0015] |
| broker_user_s | 0.3825 | 0.3894 | +0.0048 | [-0.0080, +0.0176] |
| broker_sys_s | 0.2837 | 0.2349 | -0.0541 | [-0.0645, -0.0437] |
| broker_cpu_s | 0.6650 | 0.6133 | -0.0493 | [-0.0646, -0.0339] |
| broker_vcsw | 1178.0 | 304.5 | -849.3 | [-881.2, -817.3] |
| broker_maxrss_kib | 54840 | 4850 | -49596 | [-50465, -48728] |
| broker_ru_maxrss_kib | 54840 | 19012 | -35517 | [-36386, -34649] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
