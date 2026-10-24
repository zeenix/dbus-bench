candidate timeout-before against baseline baseline, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3805 | 0.3301 | -13.24 | [-13.75, -12.76] | [-13.67, -12.83] | 0.870 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3827 | 0.3713 | -3.00 | [-4.09, -1.95] | [-3.90, -2.11] | 0.977 | <0.0001 | no material change; repeatable change (-) |
| client_wall_s | 60 | 0.8251 | 0.7622 | -7.62 | [-8.32, -6.96] | [-8.21, -7.05] | 0.930 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.7000 | 0.6902 | -1.40 | [-2.16, -0.68] | [-2.05, -0.78] | 0.992 | 0.0017 | no material change; repeatable change (-) |
| client_vcsw | 60 | 209.2 | 328.0 | +56.78 | [+54.23, +59.39] | [+54.66, +58.96] | 1.590 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.3673 | 0.3568 | -2.86 | [-3.96, -1.78] | [-3.79, -1.95] | 0.973 | <0.0001 | no material change; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.1860 | 0.2805 | +50.81 | [+48.23, +53.44] | [+48.63, +53.03] | 1.500 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.2611 | 0.2825 | +8.18 | [+6.34, +10.06] | [+6.63, +9.75] | 1.091 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2617 | 0.3814 | +45.73 | [+43.41, +47.96] | [+43.80, +47.63] | 1.470 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.5228 | 0.6639 | +26.98 | [+26.06, +27.89] | [+26.22, +27.75] | 1.276 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 813.8 | 230.1 | -71.73 | [-73.29, -70.16] | [-73.03, -70.39] | 0.292 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 54207 | 6542 | -87.93 | [-88.02, -87.84] | [-88.00, -87.86] | 0.121 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 53987 | 20527 | -61.98 | [-62.18, -61.77] | [-62.15, -61.81] | 0.380 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3785 | 0.3299 | -0.0504 | [-0.0525, -0.0483] |
| multi_s | 0.3767 | 0.3689 | -0.0115 | [-0.0158, -0.0072] |
| client_wall_s | 0.8195 | 0.7607 | -0.0629 | [-0.0690, -0.0567] |
| client_cpu_s | 0.6922 | 0.6864 | -0.0098 | [-0.0153, -0.0044] |
| client_vcsw | 210.5 | 327.0 | +118.8 | [+114.4, +123.1] |
| multi_client_cpu_s | 0.3600 | 0.3600 | -0.0105 | [-0.0148, -0.0062] |
| multi_broker_cpu_s | 0.1900 | 0.2800 | +0.0945 | [+0.0908, +0.0982] |
| broker_user_s | 0.2609 | 0.2821 | +0.0214 | [+0.0165, +0.0262] |
| broker_sys_s | 0.2604 | 0.3814 | +0.1197 | [+0.1148, +0.1245] |
| broker_cpu_s | 0.5206 | 0.6634 | +0.1410 | [+0.1369, +0.1452] |
| broker_vcsw | 782.5 | 228.0 | -583.8 | [-615.9, -551.7] |
| broker_maxrss_kib | 54236 | 6536 | -47664 | [-47985, -47344] |
| broker_ru_maxrss_kib | 54080 | 20576 | -33460 | [-33747, -33174] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
