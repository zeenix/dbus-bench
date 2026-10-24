candidate baseline against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0608 | 0.0713 | +17.31 | [+15.79, +18.77] | [+16.04, +18.54] | 1.172 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4390 | 0.4521 | +2.98 | [+2.09, +3.89] | [+2.22, +3.72] | 1.029 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.5306 | 0.5542 | +4.44 | [+3.64, +5.25] | [+3.78, +5.11] | 1.045 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.4820 | 0.4835 | +0.31 | [-0.46, +1.07] | [-0.34, +0.95] | 1.002 | 0.3850 | no material change |
| client_vcsw | 60 | 2052.8 | 2234.9 | +8.87 | [+7.37, +10.51] | [+7.57, +10.23] | 1.079 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4232 | 0.4347 | +2.72 | [+1.72, +3.74] | [+1.88, +3.56] | 1.024 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2873 | 0.3512 | +22.22 | [+20.89, +23.57] | [+21.10, +23.36] | 1.214 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1213 | 0.1969 | +62.25 | [+58.10, +66.50] | [+58.74, +65.90] | 1.639 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2264 | 0.2190 | -3.24 | [-4.95, -1.49] | [-4.66, -1.77] | 0.969 | 0.0004 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.3477 | 0.4159 | +19.61 | [+18.70, +20.53] | [+18.85, +20.38] | 1.194 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 20974.3 | 5542.6 | -73.57 | [-73.99, -73.13] | [-73.92, -73.20] | 0.262 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8228 | 6669 | -18.95 | [-19.42, -18.46] | [-19.35, -18.54] | 0.811 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20658 | 20660 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0605 | 0.0707 | +0.0105 | [+0.0096, +0.0114] |
| multi_s | 0.4356 | 0.4500 | +0.0131 | [+0.0091, +0.0170] |
| client_wall_s | 0.5271 | 0.5506 | +0.0236 | [+0.0193, +0.0279] |
| client_cpu_s | 0.4794 | 0.4804 | +0.0015 | [-0.0023, +0.0053] |
| client_vcsw | 2053.5 | 2203.0 | +182.1 | [+148.5, +215.7] |
| multi_client_cpu_s | 0.4200 | 0.4300 | +0.0115 | [+0.0072, +0.0158] |
| multi_broker_cpu_s | 0.2900 | 0.3500 | +0.0638 | [+0.0602, +0.0675] |
| broker_user_s | 0.1202 | 0.1968 | +0.0755 | [+0.0717, +0.0794] |
| broker_sys_s | 0.2278 | 0.2206 | -0.0073 | [-0.0114, -0.0032] |
| broker_cpu_s | 0.3463 | 0.4145 | +0.0682 | [+0.0652, +0.0712] |
| broker_vcsw | 20772.0 | 5559.0 | -15431.7 | [-15753.4, -15110.1] |
| broker_maxrss_kib | 8230 | 6688 | -1559 | [-1605, -1513] |
| broker_ru_maxrss_kib | 20696 | 20696 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
