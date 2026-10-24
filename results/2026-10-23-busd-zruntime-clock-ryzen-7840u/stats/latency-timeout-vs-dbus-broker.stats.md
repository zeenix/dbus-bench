candidate timeout against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2841 | 0.3283 | +15.56 | [+14.37, +16.79] | [+14.58, +16.60] | 1.149 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.4 | 64.3 | +16.05 | [+14.84, +17.31] | [+15.05, +17.12] | 1.154 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 53.9 | 61.6 | +14.27 | [+13.13, +15.44] | [+13.31, +15.25] | 1.133 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 59.9 | 70.4 | +17.58 | [+14.87, +20.55] | [+15.27, +20.11] | 1.147 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 83.7 | 109.1 | +30.35 | [+25.57, +35.26] | [+26.24, +34.52] | 1.322 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 146.4 | 188.5 | +28.80 | [+19.35, +38.90] | [+20.73, +37.30] | 1.245 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 336.5 | 377.0 | +12.03 | [-14.16, +46.60] | [-10.54, +40.50] | 0.891 | 0.9179 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4968 | 0.4953 | -0.30 | [-1.18, +0.60] | [-1.05, +0.46] | 0.999 | 0.4309 | no material change |
| multi_rtt_mean_us | 60 | 469.2 | 491.6 | +4.77 | [+3.81, +5.74] | [+3.96, +5.59] | 1.049 | <0.0001 | inconclusive; repeatable change (+) |
| multi_rtt_p50_us | 60 | 512.8 | 480.3 | -6.33 | [-7.06, -5.58] | [-6.95, -5.69] | 0.931 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 558.0 | 521.8 | -6.49 | [-8.00, -4.69] | [-7.78, -5.06] | 0.932 | <0.0001 | inconclusive; repeatable change (-) |
| multi_rtt_p99_us | 60 | 682.0 | 807.5 | +18.40 | [+12.67, +24.11] | [+13.61, +23.26] | 1.222 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 974.3 | 1194.5 | +22.60 | [+12.50, +33.97] | [+14.08, +32.12] | 1.253 | <0.0001 | slower/larger |
| multi_rtt_max_us | 60 | 1307.3 | 1502.9 | +14.96 | [+3.74, +27.38] | [+5.54, +25.49] | 1.202 | 0.0070 | inconclusive; repeatable change (+) |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2553 | 0.2570 | +0.68 | [-0.48, +1.83] | [-0.28, +1.65] | 1.011 | 0.1085 | no material change |
| fanout_delivery_mean_us | 60 | 52930.4 | 22711.9 | -57.09 | [-57.63, -56.55] | [-57.55, -56.64] | 0.431 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 55612.1 | 22765.9 | -59.06 | [-59.55, -58.56] | [-59.48, -58.64] | 0.411 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 84710.1 | 28026.7 | -66.91 | [-67.35, -66.49] | [-67.27, -66.55] | 0.331 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 90286.9 | 29121.6 | -67.75 | [-68.25, -67.24] | [-68.17, -67.32] | 0.322 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 94834.0 | 30036.2 | -68.33 | [-68.91, -67.73] | [-68.82, -67.83] | 0.314 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 95313.7 | 31217.9 | -67.25 | [-67.92, -66.55] | [-67.81, -66.67] | 0.325 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0429 | 1.1192 | +7.32 | [+6.58, +8.05] | [+6.71, +7.93] | 1.078 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.9653 | 0.9646 | -0.07 | [-0.86, +0.73] | [-0.73, +0.61] | 1.004 | 0.9589 | no material change |
| broker_user_s | 60 | 0.1717 | 0.2965 | +72.69 | [+69.01, +76.63] | [+69.55, +75.99] | 1.713 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3566 | 0.3435 | -3.69 | [-5.30, -2.06] | [-5.04, -2.32] | 0.964 | 0.0003 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.5283 | 0.6400 | +21.13 | [+19.98, +22.30] | [+20.18, +22.11] | 1.214 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 48093.9 | 14165.6 | -70.55 | [-70.77, -70.31] | [-70.73, -70.35] | 0.293 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11885 | 7072 | -40.50 | [-40.85, -40.14] | [-40.80, -40.20] | 0.595 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2821 | 0.3271 | +0.0442 | [+0.0408, +0.0476] |
| single_rtt_mean_us | 55.0 | 64.0 | +8.9 | [+8.2, +9.6] |
| single_rtt_p50_us | 53.4 | 60.6 | +7.7 | [+7.1, +8.3] |
| single_rtt_p90_us | 59.4 | 70.1 | +10.5 | [+8.8, +12.3] |
| single_rtt_p99_us | 85.5 | 107.5 | +25.4 | [+21.5, +29.3] |
| single_rtt_p999_us | 143.7 | 176.9 | +42.1 | [+28.0, +56.3] |
| single_rtt_max_us | 248.1 | 252.3 | +40.5 | [-61.6, +142.5] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4959 | 0.4927 | -0.0015 | [-0.0060, +0.0030] |
| multi_rtt_mean_us | 468.1 | 488.9 | +22.4 | [+17.9, +26.8] |
| multi_rtt_p50_us | 513.5 | 477.9 | -32.5 | [-36.6, -28.4] |
| multi_rtt_p90_us | 553.9 | 516.5 | -36.2 | [-45.7, -26.7] |
| multi_rtt_p99_us | 659.6 | 819.2 | +125.5 | [+88.6, +162.4] |
| multi_rtt_p999_us | 901.8 | 1086.4 | +220.2 | [+123.0, +317.4] |
| multi_rtt_max_us | 1120.8 | 1339.3 | +195.6 | [+48.9, +342.3] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2520 | 0.2538 | +0.0017 | [-0.0013, +0.0048] |
| fanout_delivery_mean_us | 52220.5 | 22507.6 | -30218.5 | [-30677.3, -29759.7] |
| fanout_delivery_p50_us | 54758.5 | 22493.7 | -32846.3 | [-33364.0, -32328.5] |
| fanout_delivery_p90_us | 83604.3 | 27570.1 | -56683.4 | [-57452.9, -55913.9] |
| fanout_delivery_p99_us | 89010.8 | 28553.2 | -61165.3 | [-62099.4, -60231.3] |
| fanout_delivery_p999_us | 93474.5 | 29441.3 | -64797.8 | [-65831.1, -63764.5] |
| fanout_delivery_max_us | 93833.1 | 31008.6 | -64095.7 | [-65189.7, -63001.8] |
| client_wall_s | 1.0370 | 1.1148 | +0.0763 | [+0.0688, +0.0838] |
| client_cpu_s | 0.9621 | 0.9565 | -0.0006 | [-0.0084, +0.0071] |
| broker_user_s | 0.1709 | 0.2969 | +0.1248 | [+0.1193, +0.1303] |
| broker_sys_s | 0.3556 | 0.3402 | -0.0131 | [-0.0192, -0.0071] |
| broker_cpu_s | 0.5285 | 0.6383 | +0.1117 | [+0.1060, +0.1173] |
| broker_vcsw | 48523.5 | 14189.5 | -33928.3 | [-34296.9, -33559.7] |
| broker_maxrss_kib | 11912 | 7078 | -4813 | [-4878, -4748] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
