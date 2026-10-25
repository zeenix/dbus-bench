candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.6032 | 0.4382 | -27.36 | [-29.93, -24.66] | [-29.53, -25.12] | 0.735 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.5711 | 0.5040 | -11.75 | [-14.51, -8.83] | [-14.10, -9.31] | 0.882 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.1990 | 0.9557 | -20.29 | [-22.33, -18.21] | [-22.00, -18.55] | 0.806 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.0394 | 0.9187 | -11.61 | [-13.89, -9.30] | [-13.49, -9.70] | 0.889 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 250.1 | 112.9 | -54.86 | [-65.39, -40.94] | [-64.03, -43.49] | 0.415 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5648 | 0.4953 | -12.30 | [-15.00, -9.40] | [-14.59, -9.89] | 0.884 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2543 | 0.1403 | -44.82 | [-48.50, -40.16] | [-48.01, -40.96] | 0.521 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.4148 | 0.3520 | -15.15 | [-18.15, -12.01] | [-17.68, -12.52] | 0.846 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3011 | 0.1474 | -51.04 | [-54.35, -46.77] | [-53.90, -47.53] | 0.466 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.7159 | 0.4994 | -30.24 | [-32.38, -27.94] | [-32.03, -28.32] | 0.687 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1142.8 | 352.4 | -69.16 | [-71.37, -66.68] | [-71.05, -67.11] | 0.297 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 52435 | 4910 | -90.64 | [-90.82, -90.43] | [-90.79, -90.47] | 0.093 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 52406 | 18946 | -63.85 | [-64.55, -63.10] | [-64.43, -63.22] | 0.361 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5819 | 0.4342 | -0.1651 | [-0.1841, -0.1460] |
| multi_s | 0.5604 | 0.4878 | -0.0671 | [-0.0849, -0.0493] |
| client_wall_s | 1.1712 | 0.9364 | -0.2433 | [-0.2722, -0.2144] |
| client_cpu_s | 1.0199 | 0.8978 | -0.1207 | [-0.1465, -0.0949] |
| client_vcsw | 242.5 | 92.5 | -137.2 | [-175.9, -98.5] |
| multi_client_cpu_s | 0.5500 | 0.4800 | -0.0695 | [-0.0870, -0.0520] |
| multi_broker_cpu_s | 0.2500 | 0.1300 | -0.1140 | [-0.1268, -0.1012] |
| broker_user_s | 0.4101 | 0.3501 | -0.0628 | [-0.0772, -0.0485] |
| broker_sys_s | 0.3009 | 0.1385 | -0.1537 | [-0.1677, -0.1397] |
| broker_cpu_s | 0.7070 | 0.4865 | -0.2165 | [-0.2361, -0.1969] |
| broker_vcsw | 1142.0 | 338.0 | -790.4 | [-833.0, -747.7] |
| broker_maxrss_kib | 52264 | 4908 | -47525 | [-48576, -46474] |
| broker_ru_maxrss_kib | 52264 | 19040 | -33460 | [-34513, -32407] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
