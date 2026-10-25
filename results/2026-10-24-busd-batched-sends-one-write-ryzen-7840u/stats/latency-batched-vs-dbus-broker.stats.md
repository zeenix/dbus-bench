candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2867 | 0.3386 | +18.08 | [+17.15, +19.00] | [+17.30, +18.86] | 1.183 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.9 | 66.3 | +18.61 | [+17.66, +19.55] | [+17.81, +19.40] | 1.189 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 54.1 | 62.4 | +15.41 | [+14.38, +16.45] | [+14.55, +16.28] | 1.156 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 62.3 | 78.7 | +26.34 | [+23.91, +28.73] | [+24.32, +28.36] | 1.267 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 91.0 | 124.9 | +37.28 | [+32.72, +41.94] | [+33.40, +41.18] | 1.387 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 174.1 | 224.4 | +28.88 | [+20.36, +38.12] | [+21.63, +36.46] | 1.257 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 535.7 | 553.9 | +3.40 | [-15.11, +25.98] | [-12.32, +22.10] | 1.064 | 0.6964 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5092 | 0.5056 | -0.72 | [-1.48, +0.05] | [-1.36, -0.07] | 1.002 | 0.2792 | no material change |
| multi_rtt_mean_us | 60 | 481.9 | 500.7 | +3.91 | [+3.11, +4.74] | [+3.23, +4.60] | 1.046 | <0.0001 | no material change; repeatable change (+) |
| multi_rtt_p50_us | 60 | 519.0 | 486.1 | -6.34 | [-6.82, -5.83] | [-6.75, -5.92] | 0.939 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 571.6 | 537.7 | -5.92 | [-7.41, -4.29] | [-7.18, -4.56] | 0.934 | <0.0001 | inconclusive; repeatable change (-) |
| multi_rtt_p99_us | 60 | 775.0 | 895.7 | +15.56 | [+10.55, +20.85] | [+11.36, +19.95] | 1.203 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 1201.2 | 1295.2 | +7.82 | [-2.10, +19.33] | [-0.74, +17.54] | 1.039 | 0.2858 | inconclusive |
| multi_rtt_max_us | 60 | 1647.5 | 1642.1 | -0.33 | [-10.48, +10.92] | [-8.97, +8.96] | 0.962 | 0.9589 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2603 | 0.2460 | -5.49 | [-6.32, -4.66] | [-6.18, -4.79] | 0.950 | <0.0001 | inconclusive; repeatable change (-) |
| fanout_delivery_mean_us | 60 | 53821.3 | 27376.6 | -49.13 | [-49.78, -48.49] | [-49.68, -48.59] | 0.509 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 56317.8 | 27871.2 | -50.51 | [-51.25, -49.73] | [-51.13, -49.86] | 0.491 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 86485.9 | 32880.5 | -61.98 | [-62.43, -61.52] | [-62.36, -61.60] | 0.379 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 92329.9 | 36553.1 | -60.41 | [-60.99, -59.85] | [-60.89, -59.94] | 0.401 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 96758.6 | 38349.3 | -60.37 | [-60.86, -59.87] | [-60.78, -59.95] | 0.397 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 97336.3 | 38965.9 | -59.97 | [-60.45, -59.46] | [-60.37, -59.54] | 0.399 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0631 | 1.1273 | +6.04 | [+5.39, +6.69] | [+5.50, +6.60] | 1.066 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.9856 | 0.9689 | -1.69 | [-2.30, -1.08] | [-2.21, -1.18] | 0.986 | <0.0001 | no material change; repeatable change (-) |
| broker_user_s | 60 | 0.1807 | 0.3027 | +67.55 | [+63.85, +71.24] | [+64.45, +70.62] | 1.689 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3725 | 0.3019 | -18.96 | [-20.15, -17.72] | [-19.96, -17.94] | 0.805 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5532 | 0.6046 | +9.29 | [+8.48, +10.13] | [+8.61, +9.99] | 1.091 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 48544.4 | 14002.9 | -71.15 | [-71.35, -70.96] | [-71.32, -70.99] | 0.288 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11756 | 7094 | -39.65 | [-39.97, -39.35] | [-39.92, -39.40] | 0.604 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2854 | 0.3382 | +0.0518 | [+0.0493, +0.0544] |
| single_rtt_mean_us | 55.6 | 66.2 | +10.4 | [+9.9, +10.9] |
| single_rtt_p50_us | 53.4 | 61.7 | +8.3 | [+7.8, +8.9] |
| single_rtt_p90_us | 62.9 | 77.2 | +16.4 | [+14.9, +17.9] |
| single_rtt_p99_us | 90.2 | 127.0 | +33.9 | [+30.2, +37.7] |
| single_rtt_p999_us | 166.8 | 210.2 | +50.3 | [+36.0, +64.6] |
| single_rtt_max_us | 412.0 | 503.4 | +18.2 | [-91.8, +128.2] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5082 | 0.5067 | -0.0037 | [-0.0077, +0.0004] |
| multi_rtt_mean_us | 480.9 | 502.0 | +18.9 | [+14.9, +22.8] |
| multi_rtt_p50_us | 517.7 | 488.6 | -32.9 | [-35.7, -30.1] |
| multi_rtt_p90_us | 566.4 | 528.9 | -33.8 | [-43.4, -24.3] |
| multi_rtt_p99_us | 747.4 | 916.6 | +120.6 | [+83.3, +158.0] |
| multi_rtt_p999_us | 1146.9 | 1202.2 | +94.0 | [-35.4, +223.4] |
| multi_rtt_max_us | 1534.6 | 1491.9 | -5.4 | [-190.2, +179.4] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2586 | 0.2456 | -0.0143 | [-0.0166, -0.0120] |
| fanout_delivery_mean_us | 53566.6 | 27491.0 | -26444.7 | [-26963.8, -25925.5] |
| fanout_delivery_p50_us | 55824.1 | 27595.0 | -28446.7 | [-29103.0, -27790.3] |
| fanout_delivery_p90_us | 85865.0 | 32546.7 | -53605.4 | [-54395.7, -52815.0] |
| fanout_delivery_p99_us | 91694.1 | 36987.3 | -55776.9 | [-56592.2, -54961.6] |
| fanout_delivery_p999_us | 95883.0 | 38085.6 | -58409.3 | [-59230.6, -57588.0] |
| fanout_delivery_max_us | 96571.0 | 38605.0 | -58370.4 | [-59234.3, -57506.6] |
| client_wall_s | 1.0605 | 1.1296 | +0.0642 | [+0.0573, +0.0712] |
| client_cpu_s | 0.9824 | 0.9717 | -0.0167 | [-0.0231, -0.0103] |
| broker_user_s | 0.1807 | 0.3015 | +0.1221 | [+0.1167, +0.1274] |
| broker_sys_s | 0.3720 | 0.3028 | -0.0706 | [-0.0758, -0.0655] |
| broker_cpu_s | 0.5530 | 0.6029 | +0.0514 | [+0.0468, +0.0560] |
| broker_vcsw | 48586.0 | 14025.0 | -34541.5 | [-34839.2, -34243.9] |
| broker_maxrss_kib | 11758 | 7084 | -4662 | [-4716, -4607] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
