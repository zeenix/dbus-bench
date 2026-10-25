candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2002 | 0.2033 | +1.54 | [-1.23, +4.47] | [-0.80, +3.99] | 1.011 | 0.4661 | no material change |
| multi_s | 60 | 0.7740 | 0.7842 | +1.32 | [-1.97, +4.62] | [-1.43, +4.08] | 1.003 | 0.4138 | no material change |
| client_wall_s | 60 | 0.9803 | 0.9940 | +1.39 | [-1.43, +4.19] | [-0.96, +3.72] | 1.013 | 0.3167 | no material change |
| client_cpu_s | 60 | 0.8387 | 0.8478 | +1.08 | [-1.68, +3.80] | [-1.23, +3.37] | 1.015 | 0.3691 | no material change |
| client_vcsw | 60 | 4638.3 | 4844.2 | +4.44 | [+0.45, +8.83] | [+1.04, +8.10] | 1.020 | 0.0615 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.7322 | 0.7402 | +1.09 | [-1.97, +4.09] | [-1.45, +3.62] | 1.014 | 0.3712 | no material change |
| multi_broker_cpu_s | 60 | 0.5567 | 0.5663 | +1.74 | [-2.11, +5.60] | [-1.51, +5.06] | 1.009 | 0.3752 | inconclusive |
| broker_user_s | 60 | 0.3529 | 0.3459 | -1.98 | [-5.10, +1.28] | [-4.60, +0.75] | 0.984 | 0.2925 | no material change |
| broker_sys_s | 60 | 0.3119 | 0.3298 | +5.72 | [-0.06, +11.87] | [+0.81, +10.88] | 1.040 | 0.0713 | inconclusive |
| broker_cpu_s | 60 | 0.6648 | 0.6757 | +1.63 | [-1.69, +4.99] | [-1.14, +4.46] | 1.008 | 0.3386 | no material change |
| broker_vcsw | 60 | 5253.3 | 5292.4 | +0.74 | [-1.91, +3.52] | [-1.47, +3.04] | 1.008 | 0.7238 | no material change |
| broker_maxrss_kib | 60 | 4922 | 4923 | +0.02 | [-0.67, +0.74] | [-0.56, +0.62] | 0.996 | 0.9560 | no material change |
| broker_ru_maxrss_kib | 60 | 18835 | 18833 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1979 | 0.1980 | +0.0031 | [-0.0029, +0.0091] |
| multi_s | 0.7708 | 0.7785 | +0.0102 | [-0.0156, +0.0360] |
| client_wall_s | 0.9823 | 0.9894 | +0.0137 | [-0.0142, +0.0415] |
| client_cpu_s | 0.8397 | 0.8434 | +0.0091 | [-0.0142, +0.0323] |
| client_vcsw | 4614.5 | 4788.0 | +205.9 | [+7.5, +404.4] |
| multi_client_cpu_s | 0.7300 | 0.7300 | +0.0080 | [-0.0144, +0.0304] |
| multi_broker_cpu_s | 0.5500 | 0.5650 | +0.0097 | [-0.0123, +0.0316] |
| broker_user_s | 0.3518 | 0.3492 | -0.0070 | [-0.0187, +0.0047] |
| broker_sys_s | 0.3175 | 0.3229 | +0.0178 | [-0.0008, +0.0365] |
| broker_cpu_s | 0.6626 | 0.6719 | +0.0108 | [-0.0118, +0.0335] |
| broker_vcsw | 5255.0 | 5283.0 | +39.1 | [-106.8, +185.1] |
| broker_maxrss_kib | 4930 | 4910 | +1 | [-35, +37] |
| broker_ru_maxrss_kib | 18756 | 18756 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
