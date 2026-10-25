candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4458 | 0.4382 | -1.71 | [-5.37, +2.34] | [-4.78, +1.67] | 0.979 | 0.1511 | no material change |
| multi_s | 60 | 0.4977 | 0.5040 | +1.26 | [-2.17, +4.64] | [-1.58, +4.08] | 1.043 | 0.2858 | no material change |
| client_wall_s | 60 | 0.9569 | 0.9557 | -0.12 | [-2.67, +2.52] | [-2.29, +2.08] | 0.995 | 0.9121 | no material change |
| client_cpu_s | 60 | 0.9189 | 0.9187 | -0.02 | [-2.58, +2.62] | [-2.18, +2.16] | 0.992 | 0.9530 | no material change |
| client_vcsw | 60 | 129.7 | 112.9 | -12.95 | [-34.76, +15.17] | [-31.76, +9.76] | 0.721 | 0.0085 | inconclusive |
| multi_client_cpu_s | 60 | 0.4932 | 0.4953 | +0.44 | [-2.75, +3.64] | [-2.21, +3.14] | 1.040 | 0.5774 | no material change |
| multi_broker_cpu_s | 60 | 0.1470 | 0.1403 | -4.54 | [-11.69, +3.53] | [-10.57, +2.14] | 0.929 | 0.0372 | inconclusive |
| broker_user_s | 60 | 0.3492 | 0.3520 | +0.80 | [-3.46, +5.37] | [-2.76, +4.72] | 1.003 | 0.8081 | no material change |
| broker_sys_s | 60 | 0.1614 | 0.1474 | -8.65 | [-17.05, +0.75] | [-15.78, -0.85] | 0.897 | 0.0047 | inconclusive |
| broker_cpu_s | 60 | 0.5106 | 0.4994 | -2.19 | [-5.88, +1.60] | [-5.28, +0.96] | 0.971 | 0.1641 | inconclusive |
| broker_vcsw | 60 | 333.3 | 352.4 | +5.76 | [-3.93, +16.26] | [-2.34, +14.47] | 1.003 | 0.3751 | inconclusive |
| broker_maxrss_kib | 60 | 4940 | 4910 | -0.62 | [-1.23, +0.02] | [-1.13, -0.08] | 0.989 | 0.0448 | no material change |
| broker_ru_maxrss_kib | 60 | 18946 | 18946 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4393 | 0.4342 | -0.0076 | [-0.0258, +0.0105] |
| multi_s | 0.4843 | 0.4878 | +0.0063 | [-0.0110, +0.0236] |
| client_wall_s | 0.9423 | 0.9364 | -0.0012 | [-0.0268, +0.0245] |
| client_cpu_s | 0.9021 | 0.8978 | -0.0002 | [-0.0248, +0.0245] |
| client_vcsw | 120.5 | 92.5 | -16.8 | [-51.0, +17.4] |
| multi_client_cpu_s | 0.4800 | 0.4800 | +0.0022 | [-0.0140, +0.0184] |
| multi_broker_cpu_s | 0.1400 | 0.1300 | -0.0067 | [-0.0185, +0.0051] |
| broker_user_s | 0.3446 | 0.3501 | +0.0028 | [-0.0131, +0.0187] |
| broker_sys_s | 0.1525 | 0.1385 | -0.0140 | [-0.0296, +0.0017] |
| broker_cpu_s | 0.4987 | 0.4865 | -0.0112 | [-0.0311, +0.0088] |
| broker_vcsw | 323.0 | 338.0 | +19.2 | [-15.0, +53.3] |
| broker_maxrss_kib | 4932 | 4908 | -31 | [-62, +1] |
| broker_ru_maxrss_kib | 19040 | 19040 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
