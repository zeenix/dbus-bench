candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3795 | 0.3278 | -13.63 | [-17.00, -9.81] | [-16.49, -10.47] | 0.856 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.9592 | 0.2830 | -70.50 | [-72.21, -68.62] | [-71.95, -68.93] | 0.293 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3698 | 0.6430 | -53.06 | [-55.03, -50.89] | [-54.73, -51.23] | 0.455 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.3845 | 1.2327 | -48.30 | [-50.04, -46.45] | [-49.76, -46.78] | 0.506 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 79625.1 | 5040.4 | -93.67 | [-94.15, -93.15] | [-94.09, -93.23] | 0.060 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 1.9102 | 0.7828 | -59.02 | [-60.65, -57.25] | [-60.41, -57.52] | 0.405 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.9175 | 0.1910 | -79.18 | [-80.59, -77.67] | [-80.38, -77.91] | 0.201 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.4436 | 0.3462 | -21.96 | [-24.94, -18.75] | [-24.50, -19.28] | 0.787 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.8560 | 0.1757 | -79.48 | [-80.84, -77.99] | [-80.64, -78.27] | 0.188 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2996 | 0.5219 | -59.84 | [-61.63, -57.91] | [-61.37, -58.20] | 0.399 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 112.5 | 579.6 | +415.28 | [+318.40, +522.32] | [+334.15, +503.57] | 4.714 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 4734 | 4787 | +1.12 | [+0.75, +1.51] | [+0.81, +1.44] | 1.008 | <0.0001 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 18836 | 18836 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3704 | 0.3187 | -0.0517 | [-0.0668, -0.0366] |
| multi_s | 0.9671 | 0.2807 | -0.6762 | [-0.7268, -0.6257] |
| client_wall_s | 1.3721 | 0.6342 | -0.7267 | [-0.7794, -0.6741] |
| client_cpu_s | 2.4021 | 1.2223 | -1.1517 | [-1.2216, -1.0819] |
| client_vcsw | 81379.5 | 4831.5 | -74584.8 | [-78966.0, -70203.5] |
| multi_client_cpu_s | 1.9050 | 0.7700 | -1.1273 | [-1.1950, -1.0597] |
| multi_broker_cpu_s | 0.9250 | 0.1800 | -0.7265 | [-0.7791, -0.6739] |
| broker_user_s | 0.4415 | 0.3436 | -0.0974 | [-0.1133, -0.0816] |
| broker_sys_s | 0.8542 | 0.1739 | -0.6803 | [-0.7278, -0.6329] |
| broker_cpu_s | 1.3092 | 0.5152 | -0.7778 | [-0.8309, -0.7246] |
| broker_vcsw | 96.0 | 498.5 | +467.1 | [+372.3, +562.0] |
| broker_maxrss_kib | 4732 | 4786 | +53 | [+35, +71] |
| broker_ru_maxrss_kib | 18840 | 18840 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
