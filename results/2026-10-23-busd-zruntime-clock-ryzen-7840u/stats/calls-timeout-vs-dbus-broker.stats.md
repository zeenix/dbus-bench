candidate timeout against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0608 | 0.0700 | +15.19 | [+13.91, +16.45] | [+14.12, +16.23] | 1.154 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4390 | 0.4523 | +3.03 | [+1.99, +4.03] | [+2.16, +3.89] | 1.038 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.5306 | 0.5532 | +4.25 | [+3.38, +5.09] | [+3.52, +4.97] | 1.049 | <0.0001 | no material change; repeatable change (+) |
| client_cpu_s | 60 | 0.4820 | 0.4828 | +0.16 | [-0.70, +1.01] | [-0.57, +0.88] | 1.003 | 0.5315 | no material change |
| client_vcsw | 60 | 2052.8 | 2280.4 | +11.09 | [+9.16, +13.04] | [+9.45, +12.76] | 1.104 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4232 | 0.4342 | +2.60 | [+1.49, +3.70] | [+1.65, +3.53] | 1.024 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2873 | 0.3527 | +22.74 | [+21.37, +24.04] | [+21.61, +23.83] | 1.237 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1213 | 0.1963 | +61.80 | [+56.81, +66.79] | [+57.65, +65.98] | 1.627 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2264 | 0.2219 | -1.98 | [-3.92, +0.07] | [-3.65, -0.24] | 0.975 | 0.0437 | no material change |
| broker_cpu_s | 60 | 0.3477 | 0.4182 | +20.28 | [+19.24, +21.27] | [+19.41, +21.12] | 1.209 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 20974.3 | 5744.4 | -72.61 | [-73.08, -72.12] | [-73.01, -72.20] | 0.274 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8228 | 6664 | -19.01 | [-19.51, -18.52] | [-19.43, -18.60] | 0.812 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20658 | 20658 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0605 | 0.0696 | +0.0092 | [+0.0085, +0.0100] |
| multi_s | 0.4356 | 0.4506 | +0.0133 | [+0.0088, +0.0179] |
| client_wall_s | 0.5271 | 0.5505 | +0.0226 | [+0.0180, +0.0271] |
| client_cpu_s | 0.4794 | 0.4798 | +0.0008 | [-0.0035, +0.0050] |
| client_vcsw | 2053.5 | 2278.0 | +227.6 | [+187.0, +268.1] |
| multi_client_cpu_s | 0.4200 | 0.4300 | +0.0110 | [+0.0063, +0.0157] |
| multi_broker_cpu_s | 0.2900 | 0.3500 | +0.0653 | [+0.0619, +0.0688] |
| broker_user_s | 0.1202 | 0.1957 | +0.0750 | [+0.0703, +0.0797] |
| broker_sys_s | 0.2278 | 0.2224 | -0.0045 | [-0.0092, +0.0003] |
| broker_cpu_s | 0.3463 | 0.4182 | +0.0705 | [+0.0672, +0.0738] |
| broker_vcsw | 20772.0 | 5719.5 | -15229.9 | [-15556.8, -14902.9] |
| broker_maxrss_kib | 8230 | 6676 | -1564 | [-1612, -1516] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
