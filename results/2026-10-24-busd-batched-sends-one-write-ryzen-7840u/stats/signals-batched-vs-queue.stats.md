candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3961 | 0.3015 | -23.90 | [-24.51, -23.26] | [-24.42, -23.38] | 0.759 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3963 | 0.3647 | -7.98 | [-8.81, -7.11] | [-8.68, -7.26] | 0.917 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.8513 | 0.7228 | -15.09 | [-15.71, -14.47] | [-15.60, -14.57] | 0.847 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.7218 | 0.6687 | -7.35 | [-7.99, -6.67] | [-7.89, -6.78] | 0.927 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 217.3 | 45.1 | -79.25 | [-80.20, -78.29] | [-80.04, -78.45] | 0.207 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3828 | 0.3525 | -7.92 | [-8.93, -6.89] | [-8.79, -7.06] | 0.921 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.1980 | 0.0912 | -53.96 | [-54.92, -52.97] | [-54.77, -53.13] | 0.450 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2747 | 0.2329 | -15.25 | [-16.74, -13.69] | [-16.50, -13.95] | 0.857 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.2712 | 0.1306 | -51.83 | [-52.98, -50.73] | [-52.78, -50.90] | 0.487 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5460 | 0.3635 | -33.42 | [-33.98, -32.84] | [-33.90, -32.94] | 0.665 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 820.2 | 672.3 | -18.03 | [-21.45, -14.51] | [-20.91, -15.06] | 0.866 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 55214 | 6598 | -88.05 | [-88.13, -87.97] | [-88.12, -87.98] | 0.119 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54875 | 20527 | -62.59 | [-62.82, -62.36] | [-62.78, -62.39] | 0.375 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3948 | 0.2999 | -0.0947 | [-0.0976, -0.0917] |
| multi_s | 0.3948 | 0.3633 | -0.0316 | [-0.0352, -0.0281] |
| client_wall_s | 0.8493 | 0.7227 | -0.1285 | [-0.1344, -0.1225] |
| client_cpu_s | 0.7226 | 0.6668 | -0.0530 | [-0.0581, -0.0480] |
| client_vcsw | 217.0 | 45.5 | -172.2 | [-176.1, -168.3] |
| multi_client_cpu_s | 0.3800 | 0.3500 | -0.0303 | [-0.0345, -0.0262] |
| multi_broker_cpu_s | 0.2000 | 0.0900 | -0.1068 | [-0.1097, -0.1040] |
| broker_user_s | 0.2740 | 0.2306 | -0.0419 | [-0.0466, -0.0372] |
| broker_sys_s | 0.2714 | 0.1317 | -0.1406 | [-0.1450, -0.1362] |
| broker_cpu_s | 0.5450 | 0.3623 | -0.1825 | [-0.1865, -0.1785] |
| broker_vcsw | 777.0 | 681.0 | -147.9 | [-181.7, -114.1] |
| broker_maxrss_kib | 55330 | 6614 | -48617 | [-48943, -48290] |
| broker_ru_maxrss_kib | 54782 | 20572 | -34348 | [-34688, -34007] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
