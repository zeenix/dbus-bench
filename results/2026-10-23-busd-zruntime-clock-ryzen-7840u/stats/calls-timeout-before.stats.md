candidate timeout-before against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0713 | 0.0749 | +4.98 | [+3.70, +6.33] | [+3.89, +6.10] | 1.052 | <0.0001 | inconclusive; repeatable change (+) |
| multi_s | 60 | 0.4521 | 0.4548 | +0.60 | [-0.18, +1.42] | [-0.06, +1.29] | 1.007 | 0.2028 | no material change |
| client_wall_s | 60 | 0.5542 | 0.5606 | +1.16 | [+0.43, +1.92] | [+0.55, +1.79] | 1.010 | 0.0075 | no material change; repeatable change (+) |
| client_cpu_s | 60 | 0.4835 | 0.4892 | +1.18 | [+0.51, +1.85] | [+0.63, +1.75] | 1.008 | 0.0018 | no material change; repeatable change (+) |
| client_vcsw | 60 | 2234.9 | 2317.4 | +3.69 | [+1.48, +5.99] | [+1.81, +5.61] | 1.033 | 0.0028 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 60 | 0.4347 | 0.4357 | +0.23 | [-0.65, +1.08] | [-0.50, +0.96] | 1.000 | 0.5487 | no material change |
| multi_broker_cpu_s | 60 | 0.3512 | 0.3982 | +13.38 | [+12.22, +14.54] | [+12.41, +14.38] | 1.141 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1969 | 0.2043 | +3.76 | [+2.02, +5.55] | [+2.29, +5.28] | 1.038 | 0.0002 | inconclusive; repeatable change (+) |
| broker_sys_s | 60 | 0.2190 | 0.2647 | +20.84 | [+18.75, +22.90] | [+19.08, +22.59] | 1.216 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.4159 | 0.4689 | +12.75 | [+12.01, +13.48] | [+12.14, +13.36] | 1.126 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 5542.6 | 3557.6 | -35.81 | [-36.80, -34.84] | [-36.64, -34.99] | 0.635 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 6669 | 6660 | -0.14 | [-0.70, +0.40] | [-0.61, +0.31] | 0.996 | 0.6244 | no material change |
| broker_ru_maxrss_kib | 60 | 20660 | 20658 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0707 | 0.0746 | +0.0036 | [+0.0026, +0.0045] |
| multi_s | 0.4500 | 0.4524 | +0.0027 | [-0.0010, +0.0064] |
| client_wall_s | 0.5506 | 0.5595 | +0.0064 | [+0.0022, +0.0106] |
| client_cpu_s | 0.4804 | 0.4873 | +0.0057 | [+0.0024, +0.0090] |
| client_vcsw | 2203.0 | 2311.0 | +82.5 | [+31.0, +133.9] |
| multi_client_cpu_s | 0.4300 | 0.4400 | +0.0010 | [-0.0029, +0.0049] |
| multi_broker_cpu_s | 0.3500 | 0.4000 | +0.0470 | [+0.0431, +0.0509] |
| broker_user_s | 0.1968 | 0.2061 | +0.0074 | [+0.0039, +0.0109] |
| broker_sys_s | 0.2206 | 0.2640 | +0.0456 | [+0.0414, +0.0499] |
| broker_cpu_s | 0.4145 | 0.4660 | +0.0530 | [+0.0501, +0.0560] |
| broker_vcsw | 5559.0 | 3531.5 | -1985.0 | [-2055.9, -1914.0] |
| broker_maxrss_kib | 6688 | 6658 | -9 | [-47, +28] |
| broker_ru_maxrss_kib | 20696 | 20696 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
