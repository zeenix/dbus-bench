candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9315 | 0.9078 | -2.55 | [-4.24, -0.92] | [-3.96, -1.18] | 0.977 | 0.0044 | no material change; repeatable change (-) |
| single_rtt_mean_us | 60 | 186.2 | 181.5 | -2.55 | [-4.24, -0.92] | [-3.96, -1.18] | 0.977 | 0.0044 | no material change; repeatable change (-) |
| single_rtt_p50_us | 60 | 174.5 | 170.6 | -2.25 | [-3.81, -0.75] | [-3.55, -0.97] | 0.976 | 0.0079 | no material change; repeatable change (-) |
| single_rtt_p90_us | 60 | 219.1 | 214.2 | -2.24 | [-4.35, -0.14] | [-4.02, -0.47] | 0.984 | 0.0299 | no material change; repeatable change (-) |
| single_rtt_p99_us | 60 | 318.6 | 301.9 | -5.26 | [-10.30, +0.26] | [-9.56, -0.69] | 0.953 | 0.0029 | inconclusive |
| single_rtt_p999_us | 60 | 949.2 | 797.1 | -16.03 | [-29.98, +1.15] | [-28.06, -1.71] | 0.739 | 0.0148 | inconclusive |
| single_rtt_max_us | 60 | 4399.0 | 2224.5 | -49.43 | [-71.56, -0.73] | [-69.03, -7.79] | 0.786 | 0.0947 | inconclusive; repeatable change (-) |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7507 | 0.7370 | -1.83 | [-4.61, +1.06] | [-4.20, +0.61] | 0.985 | 0.3062 | no material change |
| multi_rtt_mean_us | 60 | 726.8 | 712.0 | -2.04 | [-4.88, +0.91] | [-4.44, +0.43] | 0.988 | 0.2727 | no material change |
| multi_rtt_p50_us | 60 | 694.1 | 686.5 | -1.11 | [-3.59, +1.39] | [-3.19, +1.01] | 0.996 | 0.4395 | no material change |
| multi_rtt_p90_us | 60 | 948.7 | 914.4 | -3.61 | [-7.96, +0.98] | [-7.25, +0.22] | 0.968 | 0.1709 | inconclusive |
| multi_rtt_p99_us | 60 | 1439.1 | 1379.8 | -4.12 | [-11.69, +4.17] | [-10.54, +2.74] | 1.018 | 0.5758 | inconclusive |
| multi_rtt_p999_us | 60 | 2804.8 | 2604.3 | -7.15 | [-20.88, +10.22] | [-18.91, +6.97] | 0.868 | 0.1450 | inconclusive |
| multi_rtt_max_us | 60 | 4519.8 | 3739.7 | -17.26 | [-35.25, +7.17] | [-32.52, +2.74] | 0.897 | 0.1641 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.1170 | 0.2961 | +153.06 | [+136.35, +169.53] | [+139.03, +167.03] | 2.579 | <0.0001 | slower/larger |
| fanout_delivery_mean_us | 60 | 9802.3 | 17345.6 | +76.95 | [+59.53, +94.47] | [+62.19, +91.92] | 1.927 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 9066.1 | 16526.9 | +82.29 | [+62.75, +101.09] | [+65.88, +98.16] | 1.935 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 15691.5 | 28326.2 | +80.52 | [+59.67, +103.44] | [+62.80, +99.77] | 2.008 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 24369.0 | 37178.6 | +52.57 | [+35.36, +72.04] | [+37.82, +68.72] | 1.692 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 28460.3 | 39630.0 | +39.25 | [+24.09, +56.15] | [+26.23, +53.29] | 1.523 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 29904.4 | 40444.8 | +35.25 | [+21.39, +50.38] | [+23.36, +48.08] | 1.454 | <0.0001 | slower/larger |
| client_wall_s | 60 | 1.8329 | 1.9775 | +7.89 | [+5.84, +9.88] | [+6.16, +9.55] | 1.089 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 1.5118 | 1.8239 | +20.64 | [+18.07, +23.22] | [+18.45, +22.76] | 1.216 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.5169 | 0.5112 | -1.10 | [-3.45, +1.35] | [-3.09, +0.98] | 0.993 | 0.3386 | no material change |
| broker_sys_s | 60 | 0.6056 | 0.7684 | +26.89 | [+21.37, +32.40] | [+22.20, +31.48] | 1.288 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 1.1225 | 1.2796 | +14.00 | [+11.22, +16.77] | [+11.65, +16.34] | 1.161 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 13586.2 | 13559.0 | -0.20 | [-1.32, +0.96] | [-1.14, +0.77] | 0.989 | 0.6402 | no material change |
| broker_maxrss_kib | 60 | 5715 | 5040 | -11.81 | [-13.54, -10.06] | [-13.29, -10.33] | 0.896 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9239 | 0.9092 | -0.0238 | [-0.0397, -0.0078] |
| single_rtt_mean_us | 184.7 | 181.8 | -4.7 | [-7.9, -1.6] |
| single_rtt_p50_us | 174.3 | 171.1 | -3.9 | [-6.8, -1.1] |
| single_rtt_p90_us | 217.0 | 213.4 | -4.9 | [-9.7, -0.1] |
| single_rtt_p99_us | 310.8 | 290.1 | -16.8 | [-34.3, +0.8] |
| single_rtt_p999_us | 869.9 | 687.9 | -152.2 | [-317.3, +12.9] |
| single_rtt_max_us | 2421.8 | 1870.1 | -2174.5 | [-5067.4, +718.3] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7485 | 0.7390 | -0.0137 | [-0.0362, +0.0087] |
| multi_rtt_mean_us | 725.1 | 714.5 | -14.8 | [-36.9, +7.3] |
| multi_rtt_p50_us | 673.9 | 669.7 | -7.7 | [-25.8, +10.4] |
| multi_rtt_p90_us | 942.5 | 914.1 | -34.3 | [-79.5, +11.0] |
| multi_rtt_p99_us | 1424.3 | 1327.0 | -59.2 | [-179.8, +61.3] |
| multi_rtt_p999_us | 2485.5 | 2267.5 | -200.5 | [-660.0, +258.9] |
| multi_rtt_max_us | 3263.7 | 3010.6 | -780.2 | [-1868.8, +308.5] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.1149 | 0.2994 | +0.1791 | [+0.1606, +0.1976] |
| fanout_delivery_mean_us | 9200.4 | 17718.0 | +7543.3 | [+6171.4, +8915.2] |
| fanout_delivery_p50_us | 8408.1 | 17370.6 | +7460.8 | [+6030.5, +8891.1] |
| fanout_delivery_p90_us | 14252.0 | 28449.7 | +12634.7 | [+10200.0, +15069.4] |
| fanout_delivery_p99_us | 21186.9 | 36713.8 | +12809.6 | [+9314.2, +16305.1] |
| fanout_delivery_p999_us | 25294.7 | 38929.8 | +11169.7 | [+7378.1, +14961.3] |
| fanout_delivery_max_us | 27447.0 | 39365.5 | +10540.4 | [+6847.5, +14233.3] |
| client_wall_s | 1.8244 | 1.9682 | +0.1446 | [+0.1069, +0.1823] |
| client_cpu_s | 1.5045 | 1.8173 | +0.3121 | [+0.2737, +0.3504] |
| broker_user_s | 0.5113 | 0.5090 | -0.0057 | [-0.0188, +0.0074] |
| broker_sys_s | 0.5972 | 0.7664 | +0.1628 | [+0.1310, +0.1947] |
| broker_cpu_s | 1.1154 | 1.2662 | +0.1572 | [+0.1261, +0.1882] |
| broker_vcsw | 13609.0 | 13575.0 | -27.2 | [-187.0, +132.6] |
| broker_maxrss_kib | 5646 | 5072 | -675 | [-791, -559] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
