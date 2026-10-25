candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.2852 | 0.3293 | +15.48 | [+14.46, +16.44] | [+14.64, +16.30] | 1.155 | <0.0001 | slower/larger |
| single_rtt_mean_us | 60 | 55.6 | 64.4 | +15.97 | [+14.93, +16.95] | [+15.11, +16.80] | 1.160 | <0.0001 | slower/larger |
| single_rtt_p50_us | 60 | 54.4 | 62.2 | +14.45 | [+13.29, +15.54] | [+13.48, +15.38] | 1.156 | <0.0001 | slower/larger |
| single_rtt_p90_us | 60 | 60.6 | 72.1 | +18.90 | [+16.89, +21.01] | [+17.18, +20.67] | 1.189 | <0.0001 | slower/larger |
| single_rtt_p99_us | 60 | 84.8 | 110.8 | +30.63 | [+25.30, +36.01] | [+26.21, +35.12] | 1.299 | <0.0001 | slower/larger |
| single_rtt_p999_us | 60 | 147.0 | 193.3 | +31.45 | [+20.82, +42.69] | [+22.45, +40.76] | 1.311 | <0.0001 | slower/larger |
| single_rtt_max_us | 60 | 384.4 | 335.8 | -12.64 | [-31.87, +11.68] | [-28.97, +7.25] | 0.964 | 0.5315 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5017 | 0.5021 | +0.09 | [-0.55, +0.75] | [-0.45, +0.64] | 1.004 | 0.4889 | no material change |
| multi_rtt_mean_us | 60 | 474.4 | 497.1 | +4.79 | [+4.05, +5.51] | [+4.18, +5.38] | 1.051 | <0.0001 | inconclusive; repeatable change (+) |
| multi_rtt_p50_us | 60 | 514.2 | 484.3 | -5.80 | [-6.12, -5.48] | [-6.07, -5.54] | 0.943 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 562.1 | 532.9 | -5.19 | [-6.63, -3.69] | [-6.42, -3.94] | 0.939 | <0.0001 | inconclusive; repeatable change (-) |
| multi_rtt_p99_us | 60 | 725.4 | 881.7 | +21.55 | [+16.22, +26.86] | [+17.05, +25.94] | 1.266 | <0.0001 | slower/larger |
| multi_rtt_p999_us | 60 | 1008.2 | 1155.0 | +14.57 | [+7.24, +22.88] | [+8.28, +21.47] | 1.161 | 0.0004 | slower/larger |
| multi_rtt_max_us | 60 | 1356.8 | 1389.4 | +2.40 | [-6.41, +12.35] | [-5.08, +10.74] | 1.067 | 0.3613 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.0703 | 0.1265 | +80.06 | [+78.55, +81.63] | [+78.79, +81.33] | 1.796 | <0.0001 | slower/larger |
| fanout_delivery_mean_us | 60 | 2121.7 | 7451.2 | +251.20 | [+248.16, +254.37] | [+248.61, +253.80] | 3.494 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 2113.9 | 7541.8 | +256.77 | [+253.63, +260.03] | [+254.11, +259.49] | 3.556 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 3115.9 | 9320.5 | +199.12 | [+196.58, +201.78] | [+196.95, +201.29] | 2.980 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 3495.6 | 9891.7 | +182.98 | [+179.29, +186.23] | [+179.91, +185.82] | 2.817 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 3681.0 | 10188.4 | +176.78 | [+171.39, +181.50] | [+172.30, +180.82] | 2.788 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 3783.2 | 10273.1 | +171.55 | [+166.02, +176.40] | [+166.90, +175.67] | 2.736 | <0.0001 | slower/larger |
| client_wall_s | 60 | 0.8771 | 1.0052 | +14.60 | [+14.04, +15.16] | [+14.12, +15.06] | 1.150 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 1.1564 | 1.4990 | +29.63 | [+29.19, +30.07] | [+29.26, +30.00] | 1.299 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1804 | 0.3066 | +69.96 | [+66.41, +73.69] | [+66.98, +73.10] | 1.713 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3571 | 0.3618 | +1.30 | [-0.06, +2.62] | [+0.15, +2.42] | 1.016 | 0.0585 | no material change |
| broker_cpu_s | 60 | 0.5375 | 0.6684 | +24.34 | [+23.66, +25.02] | [+23.77, +24.91] | 1.245 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 45385.7 | 13973.0 | -69.21 | [-69.43, -68.99] | [-69.40, -69.02] | 0.308 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8247 | 7005 | -15.07 | [-15.75, -14.40] | [-15.63, -14.50] | 0.852 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.2826 | 0.3296 | +0.0442 | [+0.0415, +0.0469] |
| single_rtt_mean_us | 55.1 | 64.5 | +8.9 | [+8.3, +9.4] |
| single_rtt_p50_us | 53.4 | 61.7 | +7.9 | [+7.3, +8.4] |
| single_rtt_p90_us | 60.6 | 71.2 | +11.5 | [+10.2, +12.7] |
| single_rtt_p99_us | 85.5 | 109.2 | +26.0 | [+21.7, +30.2] |
| single_rtt_p999_us | 143.1 | 180.5 | +46.2 | [+30.8, +61.7] |
| single_rtt_max_us | 256.5 | 267.1 | -48.6 | [-143.1, +45.9] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5006 | 0.5025 | +0.0005 | [-0.0029, +0.0038] |
| multi_rtt_mean_us | 473.0 | 497.7 | +22.7 | [+19.3, +26.2] |
| multi_rtt_p50_us | 514.1 | 485.6 | -29.8 | [-31.6, -28.1] |
| multi_rtt_p90_us | 558.0 | 525.4 | -29.2 | [-38.0, -20.4] |
| multi_rtt_p99_us | 708.2 | 910.1 | +156.3 | [+121.4, +191.2] |
| multi_rtt_p999_us | 964.7 | 1094.1 | +146.9 | [+71.4, +222.3] |
| multi_rtt_max_us | 1227.7 | 1339.9 | +32.6 | [-96.5, +161.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.0703 | 0.1264 | +0.0563 | [+0.0556, +0.0569] |
| fanout_delivery_mean_us | 2122.7 | 7441.5 | +5329.6 | [+5303.9, +5355.2] |
| fanout_delivery_p50_us | 2114.6 | 7525.8 | +5427.8 | [+5401.6, +5454.1] |
| fanout_delivery_p90_us | 3115.5 | 9311.5 | +6204.6 | [+6170.2, +6238.9] |
| fanout_delivery_p99_us | 3510.9 | 9869.0 | +6396.2 | [+6340.2, +6452.1] |
| fanout_delivery_p999_us | 3646.3 | 10134.9 | +6507.4 | [+6417.8, +6597.1] |
| fanout_delivery_max_us | 3725.2 | 10230.5 | +6489.9 | [+6395.1, +6584.8] |
| client_wall_s | 0.8757 | 1.0027 | +0.1281 | [+0.1234, +0.1327] |
| client_cpu_s | 1.1553 | 1.4998 | +0.3426 | [+0.3381, +0.3471] |
| broker_user_s | 0.1813 | 0.3058 | +0.1262 | [+0.1210, +0.1315] |
| broker_sys_s | 0.3594 | 0.3597 | +0.0046 | [-0.0003, +0.0096] |
| broker_cpu_s | 0.5383 | 0.6713 | +0.1308 | [+0.1275, +0.1342] |
| broker_vcsw | 45491.0 | 13968.0 | -31412.6 | [-31732.6, -31092.6] |
| broker_maxrss_kib | 8258 | 7014 | -1243 | [-1306, -1179] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
