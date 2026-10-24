candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4871 | 0.4805 | -1.35 | [-4.68, +2.14] | [-4.19, +1.58] | 0.976 | 0.3167 | no material change |
| multi_s | 60 | 0.6670 | 0.5686 | -14.75 | [-17.43, -11.94] | [-17.01, -12.40] | 0.845 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1648 | 1.0620 | -8.82 | [-11.23, -6.41] | [-10.84, -6.84] | 0.905 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.1449 | 1.0156 | -11.30 | [-13.62, -8.99] | [-13.24, -9.37] | 0.882 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 13.983 | 167.483 | +1097.74 | [+991.93, +1207.76] | [+1008.34, +1188.92] | 11.225 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.6607 | 0.5645 | -14.56 | [-17.23, -11.76] | [-16.83, -12.21] | 0.854 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2063 | 0.2483 | +20.36 | [+15.45, +25.46] | [+16.18, +24.65] | 1.200 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1753 | 0.4159 | +137.24 | [+126.16, +148.87] | [+127.94, +147.07] | 2.358 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3488 | 0.2425 | -30.50 | [-33.53, -27.52] | [-33.05, -28.02] | 0.697 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5242 | 0.6584 | +25.61 | [+22.31, +29.08] | [+22.80, +28.46] | 1.245 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 8353.1 | 341.9 | -95.91 | [-96.13, -95.67] | [-96.10, -95.71] | 0.040 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41750 | 4864 | -88.35 | [-88.42, -88.28] | [-88.41, -88.29] | 0.116 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 37624 | 18946 | -49.64 | [-49.87, -49.39] | [-49.84, -49.44] | 0.503 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4872 | 0.4730 | -0.0066 | [-0.0239, +0.0107] |
| multi_s | 0.6613 | 0.5618 | -0.0984 | [-0.1187, -0.0780] |
| client_wall_s | 1.1547 | 1.0418 | -0.1027 | [-0.1325, -0.0730] |
| client_cpu_s | 1.1344 | 0.9866 | -0.1294 | [-0.1579, -0.1009] |
| client_vcsw | 14.000 | 160.000 | +153.500 | [+139.673, +167.327] |
| multi_client_cpu_s | 0.6550 | 0.5550 | -0.0962 | [-0.1164, -0.0759] |
| multi_broker_cpu_s | 0.2000 | 0.2400 | +0.0420 | [+0.0324, +0.0516] |
| broker_user_s | 0.1701 | 0.4188 | +0.2406 | [+0.2257, +0.2555] |
| broker_sys_s | 0.3532 | 0.2460 | -0.1064 | [-0.1191, -0.0937] |
| broker_cpu_s | 0.5236 | 0.6543 | +0.1342 | [+0.1176, +0.1509] |
| broker_vcsw | 8039.0 | 335.5 | -8011.2 | [-8324.9, -7697.5] |
| broker_maxrss_kib | 41774 | 4872 | -36886 | [-37057, -36714] |
| broker_ru_maxrss_kib | 37662 | 19040 | -18678 | [-18853, -18502] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
