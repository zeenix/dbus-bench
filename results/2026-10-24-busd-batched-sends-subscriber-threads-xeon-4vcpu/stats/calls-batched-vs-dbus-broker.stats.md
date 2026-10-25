candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1983 | 0.2033 | +2.51 | [+0.06, +5.26] | [+0.43, +4.76] | 1.020 | 0.0760 | no material change; repeatable change (+) |
| multi_s | 60 | 1.2675 | 0.7842 | -38.13 | [-39.62, -36.59] | [-39.37, -36.83] | 0.619 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.4721 | 0.9940 | -32.48 | [-33.93, -30.97] | [-33.68, -31.21] | 0.677 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.3764 | 0.8478 | -38.41 | [-39.76, -36.99] | [-39.55, -37.21] | 0.609 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 3211.5 | 4844.2 | +50.84 | [+44.91, +57.48] | [+45.82, +56.33] | 1.480 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 1.2457 | 0.7402 | -40.58 | [-41.97, -39.16] | [-41.74, -39.38] | 0.590 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.4917 | 0.5663 | +15.19 | [+11.71, +19.04] | [+12.28, +18.38] | 1.136 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1733 | 0.3459 | +99.64 | [+91.73, +107.95] | [+92.90, +106.53] | 2.038 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.4132 | 0.3298 | -20.19 | [-23.81, -16.12] | [-23.24, -16.79] | 0.771 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5865 | 0.6757 | +15.21 | [+12.21, +18.55] | [+12.67, +17.99] | 1.134 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 34194.0 | 5292.4 | -84.52 | [-84.90, -84.14] | [-84.85, -84.20] | 0.154 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7291 | 4923 | -32.47 | [-32.90, -32.03] | [-32.83, -32.10] | 0.676 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18835 | 18833 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1936 | 0.1980 | +0.0050 | [-0.0003, +0.0102] |
| multi_s | 1.2691 | 0.7785 | -0.4833 | [-0.5083, -0.4582] |
| client_wall_s | 1.4638 | 0.9894 | -0.4781 | [-0.5055, -0.4507] |
| client_cpu_s | 1.3622 | 0.8434 | -0.5286 | [-0.5548, -0.5024] |
| client_vcsw | 3223.0 | 4788.0 | +1632.7 | [+1443.6, +1821.9] |
| multi_client_cpu_s | 1.2400 | 0.7300 | -0.5055 | [-0.5298, -0.4812] |
| multi_broker_cpu_s | 0.5000 | 0.5650 | +0.0747 | [+0.0570, +0.0923] |
| broker_user_s | 0.1724 | 0.3492 | +0.1726 | [+0.1621, +0.1831] |
| broker_sys_s | 0.4137 | 0.3229 | -0.0834 | [-0.1009, -0.0659] |
| broker_cpu_s | 0.5877 | 0.6719 | +0.0892 | [+0.0710, +0.1074] |
| broker_vcsw | 34254.0 | 5283.0 | -28901.6 | [-29663.1, -28140.1] |
| broker_maxrss_kib | 7290 | 4910 | -2368 | [-2407, -2328] |
| broker_ru_maxrss_kib | 18756 | 18756 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
