candidate timeout against baseline timeout-before, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0749 | 0.0700 | -6.47 | [-7.57, -5.38] | [-7.39, -5.55] | 0.936 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.4548 | 0.4523 | -0.54 | [-1.42, +0.36] | [-1.28, +0.21] | 0.992 | 0.1803 | no material change |
| client_wall_s | 60 | 0.5606 | 0.5532 | -1.33 | [-2.07, -0.57] | [-1.95, -0.69] | 0.986 | 0.0011 | no material change; repeatable change (-) |
| client_cpu_s | 60 | 0.4892 | 0.4828 | -1.31 | [-2.03, -0.56] | [-1.91, -0.68] | 0.983 | 0.0004 | no material change; repeatable change (-) |
| client_vcsw | 60 | 2317.4 | 2280.4 | -1.60 | [-4.09, +0.92] | [-3.68, +0.50] | 0.963 | 0.1630 | no material change |
| multi_client_cpu_s | 60 | 0.4357 | 0.4342 | -0.34 | [-1.22, +0.54] | [-1.07, +0.38] | 1.000 | 0.4726 | no material change |
| multi_broker_cpu_s | 60 | 0.3982 | 0.3527 | -11.43 | [-12.23, -10.65] | [-12.09, -10.77] | 0.886 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2043 | 0.1963 | -3.89 | [-5.52, -2.25] | [-5.27, -2.53] | 0.953 | <0.0001 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.2647 | 0.2219 | -16.16 | [-17.53, -14.74] | [-17.32, -14.98] | 0.834 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.4689 | 0.4182 | -10.82 | [-11.39, -10.24] | [-11.31, -10.34] | 0.890 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 3557.6 | 5744.4 | +61.47 | [+58.72, +64.25] | [+59.18, +63.78] | 1.628 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6660 | 6664 | +0.06 | [-0.53, +0.66] | [-0.45, +0.56] | 1.000 | 0.9589 | no material change |
| broker_ru_maxrss_kib | 60 | 20658 | 20658 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0746 | 0.0696 | -0.0048 | [-0.0057, -0.0040] |
| multi_s | 0.4524 | 0.4506 | -0.0025 | [-0.0066, +0.0017] |
| client_wall_s | 0.5595 | 0.5505 | -0.0074 | [-0.0118, -0.0031] |
| client_cpu_s | 0.4873 | 0.4798 | -0.0064 | [-0.0101, -0.0027] |
| client_vcsw | 2311.0 | 2278.0 | -37.0 | [-96.7, +22.7] |
| multi_client_cpu_s | 0.4400 | 0.4300 | -0.0015 | [-0.0054, +0.0024] |
| multi_broker_cpu_s | 0.4000 | 0.3500 | -0.0455 | [-0.0489, -0.0421] |
| broker_user_s | 0.2061 | 0.1957 | -0.0079 | [-0.0114, -0.0045] |
| broker_sys_s | 0.2640 | 0.2224 | -0.0428 | [-0.0469, -0.0387] |
| broker_cpu_s | 0.4660 | 0.4182 | -0.0507 | [-0.0537, -0.0478] |
| broker_vcsw | 3531.5 | 5719.5 | +2186.8 | [+2105.2, +2268.4] |
| broker_maxrss_kib | 6658 | 6676 | +4 | [-37, +44] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
