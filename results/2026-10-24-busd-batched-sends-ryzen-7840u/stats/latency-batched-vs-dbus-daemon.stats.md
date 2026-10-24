candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5382 | 0.3315 | -38.39 | [-38.92, -37.86] | [-38.84, -37.94] | 0.614 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 106.2 | 64.9 | -38.91 | [-39.44, -38.37] | [-39.36, -38.46] | 0.610 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 99.7 | 61.5 | -38.28 | [-38.76, -37.74] | [-38.69, -37.83] | 0.614 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 115.9 | 72.5 | -37.45 | [-38.66, -36.17] | [-38.48, -36.38] | 0.618 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 203.8 | 116.9 | -42.64 | [-44.59, -40.52] | [-44.29, -40.88] | 0.579 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 319.9 | 207.4 | -35.16 | [-38.96, -31.06] | [-38.42, -31.75] | 0.627 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 651.1 | 417.6 | -35.86 | [-49.67, -18.39] | [-47.69, -21.46] | 0.548 | <0.0001 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1402 | 0.4953 | -56.56 | [-56.83, -56.28] | [-56.79, -56.33] | 0.433 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1126.0 | 491.8 | -56.32 | [-56.58, -56.04] | [-56.54, -56.09] | 0.435 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1064.8 | 480.4 | -54.88 | [-55.15, -54.61] | [-55.11, -54.65] | 0.449 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1367.8 | 517.4 | -62.18 | [-62.46, -61.86] | [-62.42, -61.91] | 0.375 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1675.7 | 822.5 | -50.91 | [-52.31, -49.58] | [-52.04, -49.77] | 0.496 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 2052.8 | 1137.4 | -44.59 | [-47.77, -41.37] | [-47.28, -41.87] | 0.558 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2588.9 | 1478.9 | -42.87 | [-47.58, -37.70] | [-46.89, -38.56] | 0.574 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6074 | 0.2481 | -59.15 | [-59.49, -58.79] | [-59.44, -58.85] | 0.406 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 18329.5 | 26189.7 | +42.88 | [+41.43, +44.46] | [+41.62, +44.19] | 1.427 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 18329.7 | 26947.4 | +47.01 | [+45.73, +48.43] | [+45.93, +48.18] | 1.462 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 27089.9 | 32242.2 | +19.02 | [+17.93, +20.22] | [+18.09, +20.02] | 1.185 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 29376.7 | 34372.5 | +17.01 | [+15.32, +18.77] | [+15.59, +18.47] | 1.153 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 30660.7 | 37400.5 | +21.98 | [+20.09, +23.86] | [+20.40, +23.55] | 1.220 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 31118.3 | 37995.4 | +22.10 | [+20.14, +24.14] | [+20.44, +23.80] | 1.216 | <0.0001 | slower/larger |
| client_wall_s | 60 | 2.2978 | 1.1137 | -51.53 | [-51.76, -51.31] | [-51.72, -51.34] | 0.485 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.5068 | 0.9568 | -36.50 | [-36.86, -36.12] | [-36.80, -36.18] | 0.635 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7575 | 0.2906 | -61.64 | [-62.27, -61.03] | [-62.16, -61.13] | 0.382 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3213 | 0.3016 | -77.17 | [-77.45, -76.89] | [-77.41, -76.94] | 0.229 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0788 | 0.5922 | -71.51 | [-71.68, -71.34] | [-71.65, -71.37] | 0.285 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10041.7 | 14118.2 | +40.60 | [+40.33, +40.86] | [+40.37, +40.82] | 1.406 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6349 | 7091 | +11.68 | [+10.97, +12.42] | [+11.09, +12.29] | 1.115 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5369 | 0.3297 | -0.2066 | [-0.2105, -0.2027] |
| single_rtt_mean_us | 106.0 | 64.5 | -41.3 | [-42.1, -40.5] |
| single_rtt_p50_us | 98.5 | 60.6 | -38.2 | [-38.7, -37.6] |
| single_rtt_p90_us | 117.0 | 70.1 | -43.4 | [-45.3, -41.6] |
| single_rtt_p99_us | 203.0 | 118.1 | -86.9 | [-92.6, -81.2] |
| single_rtt_p999_us | 303.4 | 197.1 | -112.5 | [-127.9, -97.0] |
| single_rtt_max_us | 542.6 | 333.6 | -233.5 | [-369.0, -97.9] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1359 | 0.4922 | -0.6450 | [-0.6495, -0.6404] |
| multi_rtt_mean_us | 1121.8 | 489.0 | -634.1 | [-638.8, -629.5] |
| multi_rtt_p50_us | 1059.7 | 476.1 | -584.4 | [-588.8, -580.0] |
| multi_rtt_p90_us | 1358.3 | 515.3 | -850.5 | [-857.4, -843.5] |
| multi_rtt_p99_us | 1668.8 | 839.4 | -853.1 | [-879.0, -827.3] |
| multi_rtt_p999_us | 1931.2 | 1093.5 | -915.4 | [-1019.6, -811.2] |
| multi_rtt_max_us | 2432.2 | 1352.9 | -1109.9 | [-1297.5, -922.4] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6071 | 0.2447 | -0.3593 | [-0.3622, -0.3564] |
| fanout_delivery_mean_us | 18314.3 | 26156.4 | +7860.2 | [+7577.3, +8143.1] |
| fanout_delivery_p50_us | 18309.0 | 26690.3 | +8617.7 | [+8368.1, +8867.2] |
| fanout_delivery_p90_us | 27060.7 | 31833.7 | +5152.3 | [+4836.1, +5468.6] |
| fanout_delivery_p99_us | 29351.1 | 34097.4 | +4995.8 | [+4483.1, +5508.5] |
| fanout_delivery_p999_us | 30793.1 | 37078.1 | +6739.8 | [+6199.0, +7280.6] |
| fanout_delivery_max_us | 31415.8 | 37515.6 | +6877.1 | [+6297.2, +7457.0] |
| client_wall_s | 2.2929 | 1.1080 | -1.1841 | [-1.1920, -1.1762] |
| client_cpu_s | 1.4999 | 0.9523 | -0.5499 | [-0.5569, -0.5430] |
| broker_user_s | 0.7571 | 0.2912 | -0.4669 | [-0.4749, -0.4589] |
| broker_sys_s | 1.3248 | 0.3043 | -1.0197 | [-1.0271, -1.0124] |
| broker_cpu_s | 2.0736 | 0.5899 | -1.4866 | [-1.4935, -1.4797] |
| broker_vcsw | 10040.5 | 14121.0 | +4076.5 | [+4049.4, +4103.5] |
| broker_maxrss_kib | 6358 | 7092 | +742 | [+699, +785] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
