candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8583 | 0.3135 | -63.47 | [-63.68, -63.26] | [-63.64, -63.29] | 0.366 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2069 | 0.3772 | -68.75 | [-68.99, -68.49] | [-68.95, -68.54] | 0.310 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1003 | 0.7519 | -64.20 | [-64.41, -63.99] | [-64.38, -64.02] | 0.358 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2460 | 0.6901 | -44.62 | [-44.91, -44.31] | [-44.86, -44.36] | 0.552 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 18039.8 | 131.4 | -99.27 | [-99.30, -99.25] | [-99.29, -99.25] | 0.007 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5478 | 0.3633 | -33.68 | [-34.37, -32.98] | [-34.25, -33.09] | 0.661 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1800 | 0.2053 | -82.60 | [-82.77, -82.42] | [-82.74, -82.45] | 0.173 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6895 | 0.2738 | -60.29 | [-60.88, -59.69] | [-60.79, -59.77] | 0.396 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3862 | 0.2513 | -81.87 | [-82.11, -81.63] | [-82.07, -81.67] | 0.180 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0757 | 0.5251 | -74.70 | [-74.81, -74.59] | [-74.79, -74.61] | 0.253 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 16.233 | 377.950 | +2228.23 | [+2071.47, +2374.62] | [+2097.77, +2353.97] | 24.167 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5658 | 6605 | +16.74 | [+15.88, +17.61] | [+16.02, +17.47] | 1.167 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20468 | 20468 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8559 | 0.3137 | -0.5447 | [-0.5481, -0.5414] |
| multi_s | 1.2023 | 0.3726 | -0.8297 | [-0.8332, -0.8262] |
| client_wall_s | 2.0952 | 0.7487 | -1.3485 | [-1.3546, -1.3423] |
| client_cpu_s | 1.2430 | 0.6855 | -0.5559 | [-0.5606, -0.5513] |
| client_vcsw | 18049.5 | 135.0 | -17908.4 | [-18021.4, -17795.4] |
| multi_client_cpu_s | 0.5500 | 0.3600 | -0.1845 | [-0.1889, -0.1801] |
| multi_broker_cpu_s | 1.1800 | 0.2100 | -0.9747 | [-0.9786, -0.9707] |
| broker_user_s | 0.6911 | 0.2729 | -0.4157 | [-0.4232, -0.4082] |
| broker_sys_s | 1.3864 | 0.2510 | -1.1349 | [-1.1421, -1.1278] |
| broker_cpu_s | 2.0719 | 0.5236 | -1.5506 | [-1.5563, -1.5449] |
| broker_vcsw | 15.000 | 377.500 | +361.717 | [+353.316, +370.117] |
| broker_maxrss_kib | 5664 | 6610 | +947 | [+901, +993] |
| broker_ru_maxrss_kib | 20500 | 20500 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
