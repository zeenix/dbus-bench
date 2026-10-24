candidate batched against baseline queue, from $WORK/batched-sends-results-4f346a3/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1990 | 0.2015 | +1.25 | [-0.93, +3.50] | [-0.59, +3.12] | 1.003 | 0.4352 | no material change |
| multi_s | 60 | 0.7825 | 0.7795 | -0.38 | [-3.22, +2.66] | [-2.78, +2.11] | 0.991 | 0.4843 | no material change |
| client_wall_s | 60 | 0.9880 | 0.9873 | -0.07 | [-2.49, +2.51] | [-2.12, +2.05] | 0.992 | 0.6115 | no material change |
| client_cpu_s | 60 | 0.8498 | 0.8456 | -0.49 | [-2.84, +2.05] | [-2.48, +1.57] | 1.000 | 0.5658 | no material change |
| client_vcsw | 60 | 4534.8 | 4741.6 | +4.56 | [+0.85, +8.54] | [+1.37, +7.88] | 1.028 | 0.0668 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.7433 | 0.7392 | -0.56 | [-3.22, +2.33] | [-2.81, +1.81] | 1.000 | 0.5157 | no material change |
| multi_broker_cpu_s | 60 | 0.5592 | 0.5602 | +0.18 | [-3.12, +3.69] | [-2.68, +3.14] | 0.992 | 0.9683 | no material change |
| broker_user_s | 60 | 0.3431 | 0.3432 | +0.05 | [-2.97, +3.03] | [-2.44, +2.56] | 0.998 | 0.8367 | no material change |
| broker_sys_s | 60 | 0.3238 | 0.3269 | +0.95 | [-4.73, +6.96] | [-3.85, +6.00] | 1.023 | 0.6428 | inconclusive |
| broker_cpu_s | 60 | 0.6668 | 0.6701 | +0.49 | [-2.45, +3.61] | [-2.04, +3.11] | 0.992 | 0.8713 | no material change |
| broker_vcsw | 60 | 5278.6 | 5289.4 | +0.21 | [-2.59, +3.09] | [-2.18, +2.63] | 0.980 | 0.9267 | no material change |
| broker_maxrss_kib | 60 | 4961 | 4971 | +0.19 | [-0.52, +0.91] | [-0.41, +0.79] | 1.007 | 0.3652 | no material change |
| broker_ru_maxrss_kib | 60 | 18928 | 18930 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1993 | 0.2019 | +0.0025 | [-0.0020, +0.0070] |
| multi_s | 0.7803 | 0.7810 | -0.0030 | [-0.0269, +0.0209] |
| client_wall_s | 0.9864 | 0.9903 | -0.0006 | [-0.0260, +0.0247] |
| client_cpu_s | 0.8400 | 0.8464 | -0.0042 | [-0.0256, +0.0172] |
| client_vcsw | 4463.0 | 4577.5 | +206.7 | [+27.9, +385.6] |
| multi_client_cpu_s | 0.7350 | 0.7300 | -0.0042 | [-0.0256, +0.0172] |
| multi_broker_cpu_s | 0.5550 | 0.5600 | +0.0010 | [-0.0185, +0.0205] |
| broker_user_s | 0.3370 | 0.3418 | +0.0002 | [-0.0106, +0.0109] |
| broker_sys_s | 0.3255 | 0.3282 | +0.0031 | [-0.0160, +0.0222] |
| broker_cpu_s | 0.6677 | 0.6617 | +0.0033 | [-0.0174, +0.0240] |
| broker_vcsw | 5306.0 | 5343.0 | +10.8 | [-145.4, +167.1] |
| broker_maxrss_kib | 4954 | 4976 | +10 | [-27, +46] |
| broker_ru_maxrss_kib | 18956 | 18956 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
