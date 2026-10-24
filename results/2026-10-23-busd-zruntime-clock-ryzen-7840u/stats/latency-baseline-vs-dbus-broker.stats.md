candidate baseline against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2841 | 0.3275 | +15.26 | [+14.26, +16.30] | [+14.41, +16.12] | 1.155 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.4 | 64.1 | +15.75 | [+14.73, +16.80] | [+14.89, +16.63] | 1.159 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 53.9 | 61.0 | +13.06 | [+12.07, +14.07] | [+12.23, +13.91] | 1.133 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 59.9 | 70.1 | +17.05 | [+14.84, +19.43] | [+15.16, +19.06] | 1.160 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 83.7 | 114.7 | +36.94 | [+32.78, +41.43] | [+33.37, +40.71] | 1.359 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 146.4 | 196.1 | +33.98 | [+26.20, +42.31] | [+27.28, +40.89] | 1.311 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 336.5 | 385.5 | +14.57 | [-11.37, +46.91] | [-7.68, +41.49] | 1.144 | 0.1061 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.4968 | 0.4926 | -0.85 | [-1.70, +0.06] | [-1.56, -0.10] | 0.990 | 0.0304 | no material change |
| multi_rtt_mean_us | 60 | 469.2 | 489.4 | +4.30 | [+3.37, +5.27] | [+3.52, +5.11] | 1.043 | <0.0001 | inconclusive; repeatable change (+) |
| multi_rtt_p50_us | 60 | 512.8 | 478.0 | -6.78 | [-7.53, -5.92] | [-7.41, -6.08] | 0.929 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 558.0 | 516.3 | -7.48 | [-8.69, -6.30] | [-8.50, -6.50] | 0.926 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 682.0 | 788.6 | +15.63 | [+10.28, +21.13] | [+11.19, +20.29] | 1.194 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 974.3 | 1137.6 | +16.76 | [+5.32, +28.75] | [+7.04, +26.71] | 1.231 | <0.0001 | slower/larger |
| multi_rtt_max_us | 60 | 1307.3 | 1405.1 | +7.48 | [-2.49, +18.32] | [-0.87, +16.47] | 1.149 | 0.0445 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2553 | 0.2553 | +0.01 | [-0.86, +0.92] | [-0.73, +0.77] | 1.001 | 0.7628 | no material change |
| fanout_delivery_mean_us | 60 | 52930.4 | 56443.2 | +6.64 | [+5.59, +7.72] | [+5.74, +7.55] | 1.068 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 55612.1 | 57505.1 | +3.40 | [+2.10, +4.78] | [+2.31, +4.53] | 1.023 | <0.0001 | no material change; repeatable change (+) |
| fanout_delivery_p90_us | 60 | 84710.1 | 88729.0 | +4.74 | [+3.66, +5.86] | [+3.84, +5.67] | 1.053 | <0.0001 | inconclusive; repeatable change (+) |
| fanout_delivery_p99_us | 60 | 90286.9 | 95828.8 | +6.14 | [+5.06, +7.22] | [+5.24, +7.05] | 1.064 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 94834.0 | 97620.5 | +2.94 | [+1.89, +4.02] | [+2.05, +3.85] | 1.026 | <0.0001 | no material change; repeatable change (+) |
| fanout_delivery_max_us | 60 | 95313.7 | 97897.5 | +2.71 | [+1.64, +3.81] | [+1.80, +3.65] | 1.023 | <0.0001 | no material change; repeatable change (+) |
| client_wall_s | 60 | 1.0429 | 1.1126 | +6.68 | [+6.00, +7.35] | [+6.12, +7.25] | 1.067 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.9653 | 0.9572 | -0.84 | [-1.51, -0.16] | [-1.39, -0.27] | 0.992 | 0.0272 | no material change; repeatable change (-) |
| broker_user_s | 60 | 0.1717 | 0.2980 | +73.57 | [+70.70, +76.58] | [+71.15, +76.09] | 1.733 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3566 | 0.3336 | -6.47 | [-7.81, -5.13] | [-7.61, -5.35] | 0.932 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.5283 | 0.6315 | +19.54 | [+18.45, +20.67] | [+18.62, +20.48] | 1.196 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 48093.9 | 14479.7 | -69.89 | [-70.13, -69.64] | [-70.09, -69.69] | 0.299 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11885 | 8150 | -31.42 | [-32.00, -30.86] | [-31.91, -30.95] | 0.688 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2821 | 0.3270 | +0.0434 | [+0.0406, +0.0462] |
| single_rtt_mean_us | 55.0 | 64.0 | +8.7 | [+8.2, +9.3] |
| single_rtt_p50_us | 53.4 | 60.6 | +7.0 | [+6.5, +7.6] |
| single_rtt_p90_us | 59.4 | 68.9 | +10.2 | [+8.8, +11.6] |
| single_rtt_p99_us | 85.5 | 115.2 | +30.9 | [+27.6, +34.3] |
| single_rtt_p999_us | 143.7 | 190.0 | +49.7 | [+39.2, +60.2] |
| single_rtt_max_us | 248.1 | 320.0 | +49.0 | [-44.2, +142.2] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.4959 | 0.4894 | -0.0042 | [-0.0086, +0.0002] |
| multi_rtt_mean_us | 468.1 | 486.4 | +20.2 | [+15.7, +24.6] |
| multi_rtt_p50_us | 513.5 | 474.3 | -34.8 | [-39.1, -30.4] |
| multi_rtt_p90_us | 553.9 | 513.5 | -41.7 | [-48.8, -34.7] |
| multi_rtt_p99_us | 659.6 | 802.0 | +106.6 | [+71.4, +141.8] |
| multi_rtt_p999_us | 901.8 | 1059.7 | +163.3 | [+56.5, +270.1] |
| multi_rtt_max_us | 1120.8 | 1331.0 | +97.8 | [-34.2, +229.7] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2520 | 0.2525 | +0.0000 | [-0.0023, +0.0024] |
| fanout_delivery_mean_us | 52220.5 | 55930.8 | +3512.9 | [+2939.1, +4086.7] |
| fanout_delivery_p50_us | 54758.5 | 56042.5 | +1892.9 | [+1131.6, +2654.3] |
| fanout_delivery_p90_us | 83604.3 | 88024.1 | +4018.8 | [+3080.6, +4957.1] |
| fanout_delivery_p99_us | 89010.8 | 94699.8 | +5541.9 | [+4574.2, +6509.7] |
| fanout_delivery_p999_us | 93474.5 | 96027.8 | +2786.5 | [+1749.2, +3823.9] |
| fanout_delivery_max_us | 93833.1 | 96164.4 | +2583.8 | [+1520.2, +3647.5] |
| client_wall_s | 1.0370 | 1.1114 | +0.0696 | [+0.0627, +0.0766] |
| client_cpu_s | 0.9621 | 0.9512 | -0.0081 | [-0.0147, -0.0015] |
| broker_user_s | 0.1709 | 0.2960 | +0.1263 | [+0.1221, +0.1305] |
| broker_sys_s | 0.3556 | 0.3330 | -0.0231 | [-0.0282, -0.0179] |
| broker_cpu_s | 0.5285 | 0.6280 | +0.1032 | [+0.0978, +0.1087] |
| broker_vcsw | 48523.5 | 14467.5 | -33614.2 | [-33985.9, -33242.5] |
| broker_maxrss_kib | 11912 | 8218 | -3735 | [-3817, -3652] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
