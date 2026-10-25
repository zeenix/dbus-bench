candidate baseline against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5382 | 0.3289 | -38.88 | [-39.43, -38.34] | [-39.34, -38.43] | 0.610 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 106.2 | 64.4 | -39.40 | [-39.95, -38.87] | [-39.87, -38.95] | 0.604 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 99.7 | 61.1 | -38.73 | [-39.12, -38.32] | [-39.06, -38.39] | 0.614 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 115.9 | 72.0 | -37.90 | [-39.46, -36.27] | [-39.20, -36.55] | 0.610 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 203.8 | 114.1 | -44.01 | [-45.99, -41.82] | [-45.73, -42.20] | 0.555 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 319.9 | 196.7 | -38.50 | [-42.26, -34.39] | [-41.67, -35.05] | 0.598 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 651.1 | 343.2 | -47.28 | [-57.48, -35.24] | [-55.91, -37.08] | 0.590 | <0.0001 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1402 | 0.4942 | -56.66 | [-57.01, -56.27] | [-56.96, -56.34] | 0.432 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1126.0 | 490.5 | -56.43 | [-56.78, -56.05] | [-56.73, -56.11] | 0.434 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1064.8 | 479.6 | -54.96 | [-55.30, -54.59] | [-55.25, -54.65] | 0.450 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1367.8 | 519.3 | -62.03 | [-62.45, -61.58] | [-62.39, -61.66] | 0.377 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1675.7 | 799.7 | -52.28 | [-53.36, -51.17] | [-53.19, -51.35] | 0.480 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 2052.8 | 1105.4 | -46.15 | [-49.88, -41.86] | [-49.30, -42.62] | 0.529 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2588.9 | 1354.0 | -47.70 | [-52.44, -42.44] | [-51.73, -43.27] | 0.511 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6074 | 0.2559 | -57.87 | [-58.22, -57.50] | [-58.16, -57.57] | 0.418 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 18329.5 | 22866.5 | +24.75 | [+23.50, +26.06] | [+23.70, +25.85] | 1.241 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 18329.7 | 22766.3 | +24.20 | [+23.12, +25.40] | [+23.29, +25.21] | 1.229 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 27089.9 | 27963.1 | +3.22 | [+2.27, +4.28] | [+2.41, +4.09] | 1.021 | <0.0001 | no material change; repeatable change (+) |
| fanout_delivery_p99_us | 60 | 29376.7 | 29082.7 | -1.00 | [-2.33, +0.43] | [-2.13, +0.17] | 0.981 | 0.0280 | no material change |
| fanout_delivery_p999_us | 60 | 30660.7 | 30109.9 | -1.80 | [-3.75, +0.20] | [-3.44, -0.12] | 0.976 | 0.0773 | no material change |
| fanout_delivery_max_us | 60 | 31118.3 | 31506.0 | +1.25 | [-0.92, +3.43] | [-0.55, +3.10] | 1.013 | 0.2389 | no material change |
| client_wall_s | 60 | 2.2978 | 1.1170 | -51.39 | [-51.68, -51.09] | [-51.64, -51.14] | 0.485 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.5068 | 0.9622 | -36.14 | [-36.60, -35.66] | [-36.52, -35.74] | 0.637 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7575 | 0.2992 | -60.50 | [-61.10, -59.93] | [-61.00, -60.02] | 0.396 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3213 | 0.3376 | -74.45 | [-74.69, -74.21] | [-74.65, -74.25] | 0.255 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0788 | 0.6367 | -69.37 | [-69.58, -69.16] | [-69.54, -69.20] | 0.306 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10041.7 | 14155.9 | +40.97 | [+40.70, +41.23] | [+40.74, +41.19] | 1.409 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6349 | 7065 | +11.28 | [+10.55, +12.01] | [+10.67, +11.89] | 1.111 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5369 | 0.3292 | -0.2092 | [-0.2134, -0.2051] |
| single_rtt_mean_us | 106.0 | 64.4 | -41.9 | [-42.7, -41.0] |
| single_rtt_p50_us | 98.5 | 60.6 | -38.6 | [-39.1, -38.1] |
| single_rtt_p90_us | 117.0 | 70.1 | -43.9 | [-46.3, -41.6] |
| single_rtt_p99_us | 203.0 | 112.8 | -89.7 | [-95.6, -83.8] |
| single_rtt_p999_us | 303.4 | 185.8 | -123.2 | [-138.3, -108.0] |
| single_rtt_max_us | 542.6 | 303.4 | -307.8 | [-429.3, -186.4] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1359 | 0.4900 | -0.6461 | [-0.6520, -0.6401] |
| multi_rtt_mean_us | 1121.8 | 486.4 | -635.4 | [-641.4, -629.5] |
| multi_rtt_p50_us | 1059.7 | 474.9 | -585.2 | [-590.6, -579.8] |
| multi_rtt_p90_us | 1358.3 | 514.7 | -848.5 | [-857.5, -839.5] |
| multi_rtt_p99_us | 1668.8 | 812.7 | -876.0 | [-898.1, -853.8] |
| multi_rtt_p999_us | 1931.2 | 1044.2 | -947.4 | [-1066.7, -828.1] |
| multi_rtt_max_us | 2432.2 | 1283.5 | -1234.9 | [-1435.2, -1034.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6071 | 0.2527 | -0.3515 | [-0.3544, -0.3486] |
| fanout_delivery_mean_us | 18314.3 | 22760.5 | +4536.9 | [+4299.0, +4774.9] |
| fanout_delivery_p50_us | 18309.0 | 22482.4 | +4436.6 | [+4227.3, +4645.8] |
| fanout_delivery_p90_us | 27060.7 | 27579.6 | +873.2 | [+599.0, +1147.4] |
| fanout_delivery_p99_us | 29351.1 | 28316.3 | -293.9 | [-705.9, +118.0] |
| fanout_delivery_p999_us | 30793.1 | 29469.8 | -550.8 | [-1174.9, +73.3] |
| fanout_delivery_max_us | 31415.8 | 32061.7 | +387.8 | [-310.4, +1085.9] |
| client_wall_s | 2.2929 | 1.1125 | -1.1808 | [-1.1911, -1.1706] |
| client_cpu_s | 1.4999 | 0.9544 | -0.5446 | [-0.5532, -0.5359] |
| broker_user_s | 0.7571 | 0.2994 | -0.4583 | [-0.4664, -0.4503] |
| broker_sys_s | 1.3248 | 0.3372 | -0.9837 | [-0.9907, -0.9768] |
| broker_cpu_s | 2.0736 | 0.6361 | -1.4421 | [-1.4506, -1.4336] |
| broker_vcsw | 10040.5 | 14172.0 | +4114.1 | [+4087.2, +4141.0] |
| broker_maxrss_kib | 6358 | 7062 | +716 | [+672, +760] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
