candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8491 | 0.2156 | -74.60 | [-74.70, -74.51] | [-74.68, -74.52] | 0.254 | <0.0001 | faster/smaller |
| multi_s | 60 | 2.0105 | 0.1381 | -93.13 | [-93.17, -93.09] | [-93.16, -93.10] | 0.069 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.9055 | 0.4077 | -85.97 | [-86.04, -85.90] | [-86.03, -85.91] | 0.140 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 3.6696 | 1.2006 | -67.28 | [-67.41, -67.15] | [-67.39, -67.17] | 0.327 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 138099.5 | 10121.2 | -92.67 | [-92.68, -92.66] | [-92.68, -92.66] | 0.073 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 2.8212 | 0.7743 | -72.55 | [-72.72, -72.38] | [-72.69, -72.41] | 0.273 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.9808 | 0.1068 | -94.61 | [-94.69, -94.52] | [-94.68, -94.53] | 0.055 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.9247 | 0.2372 | -74.35 | [-74.68, -74.03] | [-74.63, -74.08] | 0.257 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.9460 | 0.1402 | -92.79 | [-92.90, -92.68] | [-92.89, -92.70] | 0.072 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.8707 | 0.3774 | -86.85 | [-86.90, -86.81] | [-86.89, -86.82] | 0.131 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 22.050 | 142.700 | +547.17 | [+522.05, +572.79] | [+525.88, +568.75] | 6.544 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5633 | 6373 | +13.14 | [+12.21, +14.05] | [+12.37, +13.90] | 1.136 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20259 | 20259 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8469 | 0.2157 | -0.6335 | [-0.6357, -0.6312] |
| multi_s | 2.0055 | 0.1376 | -1.8724 | [-1.8777, -1.8670] |
| client_wall_s | 2.9004 | 0.4057 | -2.4978 | [-2.5044, -2.4912] |
| client_cpu_s | 3.6609 | 1.1986 | -2.4690 | [-2.4775, -2.4605] |
| client_vcsw | 138058.0 | 10121.5 | -127978.3 | [-128057.3, -127899.3] |
| multi_client_cpu_s | 2.8200 | 0.7700 | -2.0468 | [-2.0543, -2.0394] |
| multi_broker_cpu_s | 1.9800 | 0.1100 | -1.8740 | [-1.8799, -1.8681] |
| broker_user_s | 0.9276 | 0.2372 | -0.6875 | [-0.6960, -0.6791] |
| broker_sys_s | 1.9453 | 0.1393 | -1.8057 | [-1.8141, -1.7974] |
| broker_cpu_s | 2.8663 | 0.3768 | -2.4933 | [-2.4996, -2.4870] |
| broker_vcsw | 22.000 | 140.000 | +120.650 | [+115.979, +125.321] |
| broker_maxrss_kib | 5638 | 6394 | +740 | [+689, +791] |
| broker_ru_maxrss_kib | 20268 | 20268 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
