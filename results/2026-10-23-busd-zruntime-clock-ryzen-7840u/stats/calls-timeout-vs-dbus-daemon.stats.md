candidate timeout against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1358 | 0.0700 | -48.42 | [-49.07, -47.76] | [-48.96, -47.87] | 0.519 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1594 | 0.4523 | -60.98 | [-61.27, -60.69] | [-61.22, -60.74] | 0.388 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3263 | 0.5532 | -58.29 | [-58.56, -58.02] | [-58.52, -58.06] | 0.416 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9476 | 0.4828 | -49.05 | [-49.37, -48.71] | [-49.31, -48.77] | 0.508 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 27044.0 | 2280.4 | -91.57 | [-91.72, -91.41] | [-91.70, -91.44] | 0.085 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8793 | 0.4342 | -50.63 | [-50.98, -50.27] | [-50.92, -50.32] | 0.492 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1312 | 0.3527 | -68.82 | [-69.07, -68.58] | [-69.03, -68.62] | 0.312 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5059 | 0.1963 | -61.20 | [-61.89, -60.48] | [-61.79, -60.61] | 0.390 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7492 | 0.2219 | -70.38 | [-70.82, -69.93] | [-70.75, -70.00] | 0.294 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2551 | 0.4182 | -66.68 | [-66.89, -66.48] | [-66.86, -66.51] | 0.333 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2048.2 | 5744.4 | +180.46 | [+177.44, +183.67] | [+177.87, +183.10] | 2.807 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6201 | 6664 | +7.46 | [+6.71, +8.22] | [+6.83, +8.08] | 1.075 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20658 | 20658 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1347 | 0.0696 | -0.0657 | [-0.0672, -0.0642] |
| multi_s | 1.1531 | 0.4506 | -0.7070 | [-0.7122, -0.7019] |
| client_wall_s | 1.3185 | 0.5505 | -0.7731 | [-0.7788, -0.7675] |
| client_cpu_s | 0.9452 | 0.4798 | -0.4648 | [-0.4688, -0.4608] |
| client_vcsw | 26769.5 | 2278.0 | -24763.6 | [-25058.0, -24469.3] |
| multi_client_cpu_s | 0.8800 | 0.4300 | -0.4452 | [-0.4492, -0.4412] |
| multi_broker_cpu_s | 1.1300 | 0.3500 | -0.7785 | [-0.7836, -0.7734] |
| broker_user_s | 0.5050 | 0.1957 | -0.3096 | [-0.3153, -0.3039] |
| broker_sys_s | 0.7493 | 0.2224 | -0.5273 | [-0.5329, -0.5217] |
| broker_cpu_s | 1.2479 | 0.4182 | -0.8369 | [-0.8421, -0.8317] |
| broker_vcsw | 2035.5 | 5719.5 | +3696.2 | [+3631.5, +3760.9] |
| broker_maxrss_kib | 6176 | 6676 | +463 | [+418, +508] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
