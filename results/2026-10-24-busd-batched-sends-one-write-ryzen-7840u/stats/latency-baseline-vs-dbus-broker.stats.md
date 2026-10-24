candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2867 | 0.3354 | +16.98 | [+16.09, +17.87] | [+16.23, +17.72] | 1.172 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.9 | 65.6 | +17.48 | [+16.57, +18.38] | [+16.71, +18.23] | 1.177 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 54.1 | 61.9 | +14.49 | [+13.68, +15.26] | [+13.80, +15.14] | 1.156 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 62.3 | 77.5 | +24.50 | [+21.93, +27.13] | [+22.36, +26.72] | 1.230 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 91.0 | 121.6 | +33.67 | [+29.38, +38.11] | [+30.07, +37.41] | 1.357 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 174.1 | 221.6 | +27.29 | [+16.61, +39.03] | [+18.31, +37.13] | 1.345 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 535.7 | 615.0 | +14.81 | [-10.70, +48.80] | [-7.27, +42.47] | 0.919 | 0.9033 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5092 | 0.5083 | -0.19 | [-1.04, +0.70] | [-0.90, +0.55] | 1.003 | 0.4889 | no material change |
| multi_rtt_mean_us | 60 | 481.9 | 502.9 | +4.36 | [+3.44, +5.30] | [+3.60, +5.14] | 1.050 | <0.0001 | inconclusive; repeatable change (+) |
| multi_rtt_p50_us | 60 | 519.0 | 486.2 | -6.30 | [-6.82, -5.79] | [-6.74, -5.87] | 0.940 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 571.6 | 546.7 | -4.34 | [-6.07, -2.43] | [-5.80, -2.75] | 0.949 | <0.0001 | inconclusive; repeatable change (-) |
| multi_rtt_p99_us | 60 | 775.0 | 917.7 | +18.40 | [+13.02, +23.82] | [+13.85, +23.04] | 1.242 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 1201.2 | 1388.0 | +15.54 | [+6.77, +25.24] | [+8.00, +23.72] | 1.184 | 0.0012 | slower/larger |
| multi_rtt_max_us | 60 | 1647.5 | 1761.2 | +6.90 | [-2.36, +17.56] | [-0.95, +15.62] | 1.064 | 0.0991 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2603 | 0.2642 | +1.47 | [+0.37, +2.69] | [+0.55, +2.50] | 1.012 | 0.0322 | no material change; repeatable change (+) |
| fanout_delivery_mean_us | 60 | 53821.3 | 23626.8 | -56.10 | [-56.68, -55.48] | [-56.59, -55.58] | 0.439 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 56317.8 | 23513.5 | -58.25 | [-58.85, -57.60] | [-58.76, -57.70] | 0.416 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 86485.9 | 29004.0 | -66.46 | [-66.93, -65.94] | [-66.86, -66.04] | 0.333 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 92329.9 | 30700.6 | -66.75 | [-67.32, -66.11] | [-67.24, -66.21] | 0.328 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 96758.6 | 32135.2 | -66.79 | [-67.53, -65.97] | [-67.41, -66.10] | 0.322 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 97336.3 | 33346.1 | -65.74 | [-66.54, -64.87] | [-66.42, -65.01] | 0.345 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.0631 | 1.1466 | +7.86 | [+7.11, +8.63] | [+7.23, +8.50] | 1.076 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.9856 | 0.9874 | +0.19 | [-0.53, +0.92] | [-0.41, +0.81] | 1.001 | 0.8081 | no material change |
| broker_user_s | 60 | 0.1807 | 0.3177 | +75.84 | [+72.07, +79.75] | [+72.67, +79.05] | 1.754 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3725 | 0.3477 | -6.66 | [-8.50, -4.80] | [-8.19, -5.10] | 0.927 | <0.0001 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.5532 | 0.6654 | +20.28 | [+19.33, +21.27] | [+19.48, +21.11] | 1.202 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 48544.4 | 14030.9 | -71.10 | [-71.26, -70.93] | [-71.23, -70.95] | 0.289 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 11756 | 7071 | -39.85 | [-40.17, -39.54] | [-40.12, -39.59] | 0.601 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2854 | 0.3357 | +0.0487 | [+0.0462, +0.0512] |
| single_rtt_mean_us | 55.6 | 65.7 | +9.8 | [+9.3, +10.3] |
| single_rtt_p50_us | 53.4 | 61.7 | +7.8 | [+7.4, +8.2] |
| single_rtt_p90_us | 62.9 | 77.2 | +15.3 | [+13.6, +16.9] |
| single_rtt_p99_us | 90.2 | 121.1 | +30.6 | [+26.9, +34.4] |
| single_rtt_p999_us | 166.8 | 211.9 | +47.5 | [+29.9, +65.2] |
| single_rtt_max_us | 412.0 | 467.2 | +79.3 | [-75.3, +233.9] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5082 | 0.5081 | -0.0009 | [-0.0054, +0.0035] |
| multi_rtt_mean_us | 480.9 | 502.4 | +21.0 | [+16.6, +25.4] |
| multi_rtt_p50_us | 517.7 | 488.0 | -32.7 | [-35.5, -29.9] |
| multi_rtt_p90_us | 566.4 | 536.7 | -24.8 | [-35.6, -14.1] |
| multi_rtt_p99_us | 747.4 | 922.5 | +142.6 | [+104.2, +181.0] |
| multi_rtt_p999_us | 1146.9 | 1301.9 | +186.7 | [+79.8, +293.6] |
| multi_rtt_max_us | 1534.6 | 1617.7 | +113.7 | [-47.7, +275.0] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2586 | 0.2617 | +0.0038 | [+0.0007, +0.0070] |
| fanout_delivery_mean_us | 53566.6 | 23527.8 | -30194.5 | [-30729.2, -29659.8] |
| fanout_delivery_p50_us | 55824.1 | 23236.4 | -32804.3 | [-33447.2, -32161.4] |
| fanout_delivery_p90_us | 85865.0 | 28603.7 | -57481.9 | [-58352.0, -56611.8] |
| fanout_delivery_p99_us | 91694.1 | 29918.0 | -61629.3 | [-62580.3, -60678.3] |
| fanout_delivery_p999_us | 95883.0 | 31465.7 | -64623.3 | [-65784.3, -63462.4] |
| fanout_delivery_max_us | 96571.0 | 33399.2 | -63990.2 | [-65233.2, -62747.3] |
| client_wall_s | 1.0605 | 1.1484 | +0.0835 | [+0.0756, +0.0915] |
| client_cpu_s | 0.9824 | 0.9892 | +0.0019 | [-0.0054, +0.0092] |
| broker_user_s | 0.1807 | 0.3166 | +0.1370 | [+0.1316, +0.1425] |
| broker_sys_s | 0.3720 | 0.3444 | -0.0248 | [-0.0319, -0.0177] |
| broker_cpu_s | 0.5530 | 0.6643 | +0.1122 | [+0.1071, +0.1173] |
| broker_vcsw | 48586.0 | 14023.0 | -34513.6 | [-34797.7, -34229.5] |
| broker_maxrss_kib | 11758 | 7060 | -4685 | [-4741, -4629] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
