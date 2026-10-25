candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.5575 | 0.3386 | -39.27 | [-39.78, -38.77] | [-39.70, -38.85] | 0.609 | <0.0001 | faster/smaller |
| single_rtt_mean_us | 60 | 110.1 | 66.3 | -39.78 | [-40.29, -39.28] | [-40.21, -39.36] | 0.604 | <0.0001 | faster/smaller |
| single_rtt_p50_us | 60 | 101.6 | 62.4 | -38.61 | [-39.11, -38.10] | [-39.03, -38.19] | 0.612 | <0.0001 | faster/smaller |
| single_rtt_p90_us | 60 | 130.1 | 78.7 | -39.52 | [-40.89, -38.11] | [-40.68, -38.34] | 0.604 | <0.0001 | faster/smaller |
| single_rtt_p99_us | 60 | 218.6 | 124.9 | -42.86 | [-44.62, -41.00] | [-44.34, -41.32] | 0.577 | <0.0001 | faster/smaller |
| single_rtt_p999_us | 60 | 369.8 | 224.4 | -39.33 | [-44.29, -33.92] | [-43.51, -34.78] | 0.590 | <0.0001 | faster/smaller |
| single_rtt_max_us | 60 | 801.7 | 553.9 | -30.91 | [-42.82, -16.91] | [-41.02, -19.14] | 0.575 | 0.0006 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 1.1764 | 0.5056 | -57.02 | [-57.32, -56.73] | [-57.27, -56.78] | 0.430 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 1162.8 | 500.7 | -56.94 | [-57.23, -56.64] | [-57.18, -56.69] | 0.430 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 1094.6 | 486.1 | -55.59 | [-55.79, -55.40] | [-55.75, -55.43] | 0.445 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1424.0 | 537.7 | -62.24 | [-62.80, -61.62] | [-62.72, -61.73] | 0.373 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1788.1 | 895.7 | -49.91 | [-51.50, -48.29] | [-51.25, -48.56] | 0.516 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 2399.6 | 1295.2 | -46.03 | [-49.72, -41.67] | [-49.19, -42.50] | 0.514 | <0.0001 | faster/smaller |
| multi_rtt_max_us | 60 | 2937.7 | 1642.1 | -44.10 | [-48.01, -39.89] | [-47.41, -40.62] | 0.543 | <0.0001 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.6205 | 0.2460 | -60.35 | [-60.63, -60.07] | [-60.58, -60.12] | 0.397 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 18754.1 | 27376.6 | +45.98 | [+44.38, +47.51] | [+44.62, +47.29] | 1.465 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 18765.6 | 27871.2 | +48.52 | [+46.78, +50.32] | [+47.07, +50.01] | 1.468 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 27699.6 | 32880.5 | +18.70 | [+17.50, +19.93] | [+17.69, +19.74] | 1.181 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 29981.6 | 36553.1 | +21.92 | [+19.96, +23.74] | [+20.32, +23.47] | 1.235 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 31073.0 | 38349.3 | +23.42 | [+21.52, +25.29] | [+21.81, +25.00] | 1.239 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 31464.7 | 38965.9 | +23.84 | [+22.00, +25.68] | [+22.28, +25.40] | 1.241 | <0.0001 | slower/larger |
| client_wall_s | 60 | 2.3665 | 1.1273 | -52.36 | [-52.57, -52.16] | [-52.54, -52.19] | 0.476 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.5488 | 0.9689 | -37.44 | [-37.73, -37.16] | [-37.68, -37.20] | 0.628 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7861 | 0.3027 | -61.49 | [-62.05, -60.94] | [-61.96, -61.03] | 0.385 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3566 | 0.3019 | -77.75 | [-78.00, -77.49] | [-77.96, -77.53] | 0.222 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.1427 | 0.6046 | -71.78 | [-71.96, -71.60] | [-71.93, -71.63] | 0.282 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10035.4 | 14002.9 | +39.54 | [+39.16, +39.90] | [+39.22, +39.84] | 1.397 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6329 | 7094 | +12.08 | [+11.37, +12.79] | [+11.48, +12.68] | 1.123 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.5565 | 0.3382 | -0.2189 | [-0.2229, -0.2149] |
| single_rtt_mean_us | 109.8 | 66.2 | -43.8 | [-44.6, -43.0] |
| single_rtt_p50_us | 100.9 | 61.7 | -39.2 | [-39.9, -38.6] |
| single_rtt_p90_us | 129.4 | 77.2 | -51.4 | [-54.0, -48.8] |
| single_rtt_p99_us | 218.5 | 127.0 | -93.7 | [-99.6, -87.8] |
| single_rtt_p999_us | 354.4 | 210.2 | -145.5 | [-171.8, -119.1] |
| single_rtt_max_us | 740.9 | 503.4 | -247.8 | [-377.7, -118.0] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 1.1724 | 0.5067 | -0.6708 | [-0.6767, -0.6649] |
| multi_rtt_mean_us | 1160.1 | 502.0 | -662.1 | [-668.0, -656.2] |
| multi_rtt_p50_us | 1093.5 | 488.6 | -608.5 | [-612.0, -605.0] |
| multi_rtt_p90_us | 1413.5 | 528.9 | -886.2 | [-898.7, -873.8] |
| multi_rtt_p99_us | 1715.7 | 916.6 | -892.4 | [-939.0, -845.9] |
| multi_rtt_p999_us | 2470.8 | 1202.2 | -1104.4 | [-1240.0, -968.9] |
| multi_rtt_max_us | 3062.1 | 1491.9 | -1295.6 | [-1464.6, -1126.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.6203 | 0.2456 | -0.3745 | [-0.3771, -0.3719] |
| fanout_delivery_mean_us | 18728.9 | 27491.0 | +8622.5 | [+8324.9, +8920.2] |
| fanout_delivery_p50_us | 18732.3 | 27595.0 | +9105.6 | [+8775.8, +9435.3] |
| fanout_delivery_p90_us | 27671.0 | 32546.7 | +5180.9 | [+4838.7, +5523.1] |
| fanout_delivery_p99_us | 29817.7 | 36987.3 | +6571.4 | [+5995.0, +7147.9] |
| fanout_delivery_p999_us | 30663.6 | 38085.6 | +7276.3 | [+6710.6, +7842.1] |
| fanout_delivery_max_us | 31159.9 | 38605.0 | +7501.1 | [+6948.9, +8053.4] |
| client_wall_s | 2.3662 | 1.1296 | -1.2392 | [-1.2467, -1.2317] |
| client_cpu_s | 1.5519 | 0.9717 | -0.5799 | [-0.5857, -0.5741] |
| broker_user_s | 0.7814 | 0.3015 | -0.4834 | [-0.4906, -0.4762] |
| broker_sys_s | 1.3574 | 0.3028 | -1.0547 | [-1.0611, -1.0483] |
| broker_cpu_s | 2.1411 | 0.6029 | -1.5381 | [-1.5452, -1.5310] |
| broker_vcsw | 10031.0 | 14025.0 | +3967.5 | [+3930.3, +4004.8] |
| broker_maxrss_kib | 6328 | 7084 | +765 | [+721, +808] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
