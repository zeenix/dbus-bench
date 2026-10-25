candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4805 | 0.4382 | -8.80 | [-12.42, -4.94] | [-11.90, -5.62] | 0.903 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 60 | 0.5686 | 0.5040 | -11.36 | [-14.34, -8.28] | [-13.85, -8.73] | 0.886 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0620 | 0.9557 | -10.01 | [-12.68, -7.25] | [-12.23, -7.74] | 0.897 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.0156 | 0.9187 | -9.54 | [-12.30, -6.65] | [-11.87, -7.15] | 0.908 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 167.5 | 112.9 | -32.58 | [-47.56, -12.17] | [-45.77, -15.86] | 0.517 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5645 | 0.4953 | -12.25 | [-15.21, -9.22] | [-14.73, -9.65] | 0.880 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.2483 | 0.1403 | -43.49 | [-47.16, -38.82] | [-46.68, -39.61] | 0.545 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.4159 | 0.3520 | -15.37 | [-18.44, -12.29] | [-17.94, -12.80] | 0.862 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2425 | 0.1474 | -39.19 | [-43.70, -33.17] | [-43.13, -34.29] | 0.579 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6584 | 0.4994 | -24.15 | [-26.49, -21.56] | [-26.11, -22.01] | 0.753 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 341.9 | 352.4 | +3.08 | [-5.35, +12.79] | [-4.10, +11.15] | 0.992 | 0.9699 | inconclusive |
| broker_maxrss_kib | 60 | 4864 | 4910 | +0.95 | [+0.30, +1.61] | [+0.41, +1.49] | 1.011 | 0.0102 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 18946 | 18946 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4730 | 0.4342 | -0.0423 | [-0.0616, -0.0230] |
| multi_s | 0.5618 | 0.4878 | -0.0646 | [-0.0836, -0.0456] |
| client_wall_s | 1.0418 | 0.9364 | -0.1063 | [-0.1369, -0.0758] |
| client_cpu_s | 0.9866 | 0.8978 | -0.0968 | [-0.1274, -0.0663] |
| client_vcsw | 160.0 | 92.5 | -54.6 | [-86.6, -22.6] |
| multi_client_cpu_s | 0.5550 | 0.4800 | -0.0692 | [-0.0880, -0.0503] |
| multi_broker_cpu_s | 0.2400 | 0.1300 | -0.1080 | [-0.1203, -0.0957] |
| broker_user_s | 0.4188 | 0.3501 | -0.0639 | [-0.0786, -0.0493] |
| broker_sys_s | 0.2460 | 0.1385 | -0.0950 | [-0.1104, -0.0796] |
| broker_cpu_s | 0.6543 | 0.4865 | -0.1590 | [-0.1776, -0.1403] |
| broker_vcsw | 335.5 | 338.0 | +10.5 | [-21.1, +42.1] |
| broker_maxrss_kib | 4872 | 4908 | +46 | [+14, +78] |
| broker_ru_maxrss_kib | 19040 | 19040 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
