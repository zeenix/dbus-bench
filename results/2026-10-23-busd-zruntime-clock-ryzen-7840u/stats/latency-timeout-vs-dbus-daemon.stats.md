candidate timeout against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5377 | 0.3283 | -38.94 | [-39.63, -38.25] | [-39.52, -38.35] | 0.609 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 106.1 | 64.3 | -39.46 | [-40.15, -38.76] | [-40.04, -38.86] | 0.604 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 100.1 | 61.6 | -38.40 | [-39.10, -37.73] | [-38.99, -37.83] | 0.614 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 116.3 | 70.4 | -39.46 | [-40.99, -37.92] | [-40.74, -38.14] | 0.608 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 194.1 | 109.1 | -43.78 | [-45.75, -41.71] | [-45.46, -42.04] | 0.552 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 304.7 | 188.5 | -38.13 | [-42.28, -33.23] | [-41.72, -34.09] | 0.590 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 606.7 | 377.0 | -37.87 | [-51.77, -19.44] | [-49.87, -22.84] | 0.515 | <0.0001 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1379 | 0.4953 | -56.47 | [-56.81, -56.13] | [-56.75, -56.19] | 0.435 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1123.6 | 491.6 | -56.25 | [-56.60, -55.91] | [-56.54, -55.97] | 0.437 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1062.7 | 480.3 | -54.80 | [-55.09, -54.53] | [-55.04, -54.57] | 0.451 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1364.8 | 521.8 | -61.76 | [-62.26, -61.12] | [-62.20, -61.25] | 0.379 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1669.1 | 807.5 | -51.62 | [-53.30, -49.99] | [-53.02, -50.24] | 0.484 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 1967.9 | 1194.5 | -39.30 | [-43.34, -34.73] | [-42.72, -35.53] | 0.570 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2484.1 | 1502.9 | -39.50 | [-44.28, -34.00] | [-43.56, -34.87] | 0.572 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6075 | 0.2570 | -57.69 | [-58.03, -57.31] | [-57.98, -57.38] | 0.420 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 18349.0 | 22711.9 | +23.78 | [+22.48, +25.20] | [+22.67, +24.95] | 1.225 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 18355.6 | 22765.9 | +24.03 | [+22.94, +25.24] | [+23.10, +25.03] | 1.226 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 27110.9 | 28026.7 | +3.38 | [+2.37, +4.51] | [+2.52, +4.32] | 1.020 | <0.0001 | no material change; repeatable change (+) |
| fanout_delivery_p99_us | 60 | 29351.7 | 29121.6 | -0.78 | [-2.02, +0.55] | [-1.84, +0.33] | 0.979 | 0.0556 | no material change |
| fanout_delivery_p999_us | 60 | 30529.0 | 30036.2 | -1.61 | [-3.38, +0.21] | [-3.10, -0.08] | 0.970 | 0.0668 | no material change |
| fanout_delivery_max_us | 60 | 30982.3 | 31217.9 | +0.76 | [-1.13, +2.74] | [-0.82, +2.39] | 0.996 | 0.5559 | no material change |
| client_wall_s | 60 | 2.2951 | 1.1192 | -51.24 | [-51.53, -50.95] | [-51.48, -50.99] | 0.488 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.5047 | 0.9646 | -35.89 | [-36.34, -35.44] | [-36.26, -35.51] | 0.639 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7608 | 0.2965 | -61.03 | [-61.69, -60.35] | [-61.59, -60.47] | 0.385 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3162 | 0.3435 | -73.90 | [-74.26, -73.56] | [-74.20, -73.61] | 0.262 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0770 | 0.6400 | -69.19 | [-69.42, -68.95] | [-69.38, -68.99] | 0.307 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10032.5 | 14165.6 | +41.20 | [+40.89, +41.48] | [+40.95, +41.44] | 1.415 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6314 | 7072 | +12.00 | [+11.26, +12.72] | [+11.39, +12.61] | 1.119 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5325 | 0.3271 | -0.2093 | [-0.2148, -0.2039] |
| single_rtt_mean_us | 105.1 | 64.0 | -41.9 | [-43.0, -40.8] |
| single_rtt_p50_us | 98.5 | 60.6 | -38.4 | [-39.4, -37.5] |
| single_rtt_p90_us | 116.4 | 70.1 | -45.9 | [-48.4, -43.4] |
| single_rtt_p99_us | 197.1 | 107.5 | -85.0 | [-90.8, -79.2] |
| single_rtt_p999_us | 302.2 | 176.9 | -116.2 | [-131.8, -100.5] |
| single_rtt_max_us | 457.1 | 252.3 | -229.8 | [-357.1, -102.5] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1323 | 0.4927 | -0.6426 | [-0.6484, -0.6368] |
| multi_rtt_mean_us | 1117.7 | 488.9 | -632.1 | [-637.9, -626.2] |
| multi_rtt_p50_us | 1058.5 | 477.9 | -582.4 | [-587.1, -577.7] |
| multi_rtt_p90_us | 1358.9 | 516.5 | -843.0 | [-853.5, -832.4] |
| multi_rtt_p99_us | 1665.2 | 819.2 | -861.6 | [-894.2, -829.1] |
| multi_rtt_p999_us | 1905.1 | 1086.4 | -773.4 | [-865.2, -681.6] |
| multi_rtt_max_us | 2434.6 | 1339.3 | -981.2 | [-1149.2, -813.2] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6060 | 0.2538 | -0.3505 | [-0.3534, -0.3475] |
| fanout_delivery_mean_us | 18300.5 | 22507.6 | +4362.9 | [+4110.6, +4615.1] |
| fanout_delivery_p50_us | 18304.9 | 22493.7 | +4410.3 | [+4195.1, +4625.5] |
| fanout_delivery_p90_us | 27050.6 | 27570.1 | +915.8 | [+613.7, +1218.0] |
| fanout_delivery_p99_us | 29294.7 | 28553.2 | -230.1 | [-627.2, +167.0] |
| fanout_delivery_p999_us | 30630.4 | 29441.3 | -492.9 | [-1063.8, +78.1] |
| fanout_delivery_max_us | 31288.8 | 31008.6 | +235.7 | [-375.6, +847.0] |
| client_wall_s | 2.2863 | 1.1148 | -1.1759 | [-1.1859, -1.1660] |
| client_cpu_s | 1.4977 | 0.9565 | -0.5401 | [-0.5482, -0.5320] |
| broker_user_s | 0.7592 | 0.2969 | -0.4643 | [-0.4721, -0.4565] |
| broker_sys_s | 1.3149 | 0.3402 | -0.9728 | [-0.9806, -0.9650] |
| broker_cpu_s | 2.0689 | 0.6383 | -1.4371 | [-1.4460, -1.4281] |
| broker_vcsw | 10026.5 | 14189.5 | +4133.1 | [+4103.7, +4162.6] |
| broker_maxrss_kib | 6302 | 7078 | +757 | [+713, +802] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
