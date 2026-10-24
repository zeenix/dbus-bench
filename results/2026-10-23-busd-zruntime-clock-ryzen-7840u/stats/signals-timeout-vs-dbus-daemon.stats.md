candidate timeout against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8598 | 0.3131 | -63.59 | [-63.80, -63.36] | [-63.77, -63.40] | 0.364 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2063 | 0.3786 | -68.62 | [-68.87, -68.34] | [-68.83, -68.38] | 0.310 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1011 | 0.7513 | -64.24 | [-64.45, -64.01] | [-64.42, -64.05] | 0.356 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2433 | 0.6909 | -44.43 | [-44.78, -44.08] | [-44.72, -44.14] | 0.553 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 18179.8 | 126.4 | -99.30 | [-99.33, -99.28] | [-99.33, -99.28] | 0.007 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5457 | 0.3620 | -33.66 | [-34.42, -32.89] | [-34.30, -33.03] | 0.660 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1788 | 0.2018 | -82.88 | [-83.06, -82.70] | [-83.03, -82.72] | 0.171 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6993 | 0.2720 | -61.10 | [-61.62, -60.56] | [-61.54, -60.65] | 0.390 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3778 | 0.2502 | -81.84 | [-82.06, -81.62] | [-82.03, -81.66] | 0.181 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0771 | 0.5222 | -74.86 | [-74.97, -74.74] | [-74.96, -74.76] | 0.250 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 15.300 | 367.417 | +2301.42 | [+2211.33, +2379.46] | [+2227.85, +2368.66] | 24.724 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5578 | 6562 | +17.66 | [+16.74, +18.53] | [+16.89, +18.39] | 1.180 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20529 | 20529 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8581 | 0.3122 | -0.5467 | [-0.5501, -0.5434] |
| multi_s | 1.2025 | 0.3736 | -0.8277 | [-0.8320, -0.8235] |
| client_wall_s | 2.0959 | 0.7461 | -1.3498 | [-1.3562, -1.3433] |
| client_cpu_s | 1.2401 | 0.6844 | -0.5524 | [-0.5582, -0.5467] |
| client_vcsw | 18116.0 | 131.5 | -18053.4 | [-18133.8, -17973.0] |
| multi_client_cpu_s | 0.5400 | 0.3600 | -0.1837 | [-0.1888, -0.1785] |
| multi_broker_cpu_s | 1.1800 | 0.2000 | -0.9770 | [-0.9806, -0.9734] |
| broker_user_s | 0.7031 | 0.2727 | -0.4272 | [-0.4344, -0.4201] |
| broker_sys_s | 1.3798 | 0.2482 | -1.1277 | [-1.1350, -1.1203] |
| broker_cpu_s | 2.0721 | 0.5194 | -1.5549 | [-1.5603, -1.5495] |
| broker_vcsw | 15.000 | 364.000 | +352.117 | [+345.012, +359.222] |
| broker_maxrss_kib | 5562 | 6574 | +985 | [+938, +1031] |
| broker_ru_maxrss_kib | 20576 | 20576 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
