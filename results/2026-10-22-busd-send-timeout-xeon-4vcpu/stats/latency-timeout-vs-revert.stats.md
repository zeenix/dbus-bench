candidate timeout against baseline revert, from latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.7199 | 0.7189 | -0.15 | [-2.42, +2.06] | [-2.04, +1.72] | 0.998 | 0.8482 | no material change |
| single_rtt_mean_us | 60 | 143.9 | 143.7 | -0.14 | [-2.42, +2.07] | [-2.04, +1.72] | 0.998 | 0.8482 | no material change |
| single_rtt_p50_us | 60 | 130.4 | 131.0 | +0.47 | [-0.97, +1.98] | [-0.75, +1.75] | 0.997 | 0.9355 | no material change |
| single_rtt_p90_us | 60 | 168.4 | 170.2 | +1.07 | [-1.89, +4.10] | [-1.49, +3.63] | 0.986 | 0.7853 | no material change |
| single_rtt_p99_us | 60 | 315.4 | 308.9 | -2.06 | [-9.88, +6.48] | [-8.63, +5.13] | 1.033 | 0.5809 | inconclusive |
| single_rtt_p999_us | 60 | 1344.6 | 1250.2 | -7.02 | [-25.24, +14.27] | [-22.42, +10.70] | 0.981 | 0.7572 | inconclusive |
| single_rtt_max_us | 60 | 7315.9 | 4409.2 | -39.73 | [-59.63, -6.83] | [-56.99, -13.08] | 0.888 | 0.0976 | faster/smaller |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7168 | 0.7439 | +3.78 | [-0.71, +9.15] | [-0.08, +8.16] | 1.029 | 0.1429 | inconclusive |
| multi_rtt_mean_us | 60 | 689.9 | 718.8 | +4.18 | [-0.23, +9.49] | [+0.38, +8.49] | 1.027 | 0.1069 | inconclusive |
| multi_rtt_p50_us | 60 | 640.6 | 658.7 | +2.83 | [-1.19, +8.23] | [-0.67, +7.27] | 1.001 | 0.5658 | inconclusive |
| multi_rtt_p90_us | 60 | 903.7 | 971.0 | +7.45 | [-0.35, +16.29] | [+0.97, +14.66] | 1.025 | 0.1053 | inconclusive |
| multi_rtt_p99_us | 60 | 1701.8 | 1914.6 | +12.50 | [+1.06, +24.80] | [+2.84, +22.72] | 1.201 | 0.0636 | inconclusive; repeatable change (+) |
| multi_rtt_p999_us | 60 | 4218.7 | 4352.3 | +3.17 | [-24.09, +32.09] | [-19.93, +28.79] | 1.197 | 0.0429 | inconclusive |
| multi_rtt_max_us | 60 | 6689.7 | 7619.6 | +13.90 | [-27.47, +73.16] | [-21.56, +62.39] | 1.215 | 0.2217 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2567 | 0.2651 | +3.27 | [-0.87, +7.59] | [-0.23, +6.89] | 1.014 | 0.2389 | inconclusive |
| fanout_delivery_mean_us | 60 | 22869.1 | 23677.3 | +3.53 | [-0.64, +7.87] | [+0.02, +7.19] | 1.035 | 0.1450 | inconclusive |
| fanout_delivery_p50_us | 60 | 22483.2 | 23205.6 | +3.21 | [-0.89, +7.44] | [-0.22, +6.79] | 1.037 | 0.1294 | inconclusive |
| fanout_delivery_p90_us | 60 | 28775.1 | 30870.5 | +7.28 | [+0.68, +14.53] | [+1.70, +13.37] | 1.035 | 0.1491 | inconclusive; repeatable change (+) |
| fanout_delivery_p99_us | 60 | 32932.2 | 35917.9 | +9.07 | [+0.19, +18.92] | [+1.49, +17.18] | 1.018 | 0.3062 | inconclusive; repeatable change (+) |
| fanout_delivery_p999_us | 60 | 34460.0 | 37167.7 | +7.86 | [-0.99, +17.57] | [+0.20, +15.97] | 1.004 | 0.4889 | inconclusive |
| fanout_delivery_max_us | 60 | 35360.7 | 38404.0 | +8.61 | [-0.15, +18.21] | [+1.08, +16.55] | 1.014 | 0.3652 | inconclusive |
| client_wall_s | 60 | 1.7108 | 1.7484 | +2.20 | [-0.32, +4.88] | [+0.07, +4.44] | 1.021 | 0.0595 | no material change |
| client_cpu_s | 60 | 1.3211 | 1.3449 | +1.80 | [-0.73, +5.02] | [-0.38, +4.36] | 0.999 | 0.5809 | no material change |
| broker_user_s | 60 | 0.4318 | 0.4553 | +5.45 | [+1.44, +9.44] | [+2.04, +8.87] | 1.054 | 0.0046 | inconclusive; repeatable change (+) |
| broker_sys_s | 60 | 0.5196 | 0.5243 | +0.90 | [-1.77, +3.52] | [-1.37, +3.12] | 1.019 | 0.3498 | no material change |
| broker_cpu_s | 60 | 0.9515 | 0.9796 | +2.96 | [+0.75, +5.09] | [+1.10, +4.79] | 1.036 | 0.0009 | no material change; repeatable change (+) |
| broker_vcsw | 60 | 13560.5 | 13575.1 | +0.11 | [-1.56, +2.19] | [-1.32, +1.82] | 0.998 | 0.3931 | no material change |
| broker_maxrss_kib | 60 | 5000 | 5029 | +0.58 | [-0.11, +1.27] | [+0.00, +1.16] | 1.007 | 0.0897 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.7131 | 0.6968 | -0.0010 | [-0.0178, +0.0157] |
| single_rtt_mean_us | 142.5 | 139.3 | -0.2 | [-3.6, +3.1] |
| single_rtt_p50_us | 129.2 | 130.3 | +0.6 | [-1.3, +2.6] |
| single_rtt_p90_us | 166.1 | 163.7 | +1.8 | [-3.5, +7.1] |
| single_rtt_p99_us | 303.6 | 299.4 | -6.5 | [-33.7, +20.7] |
| single_rtt_p999_us | 1172.9 | 1109.7 | -94.4 | [-382.4, +193.6] |
| single_rtt_max_us | 3592.3 | 3675.0 | -2906.6 | [-5724.1, -89.2] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7145 | 0.7129 | +0.0271 | [-0.0091, +0.0632] |
| multi_rtt_mean_us | 687.6 | 691.6 | +28.9 | [-5.4, +63.2] |
| multi_rtt_p50_us | 626.1 | 629.0 | +18.1 | [-13.2, +49.5] |
| multi_rtt_p90_us | 877.1 | 918.3 | +67.3 | [-8.6, +143.2] |
| multi_rtt_p99_us | 1654.9 | 1855.9 | +212.8 | [+12.0, +413.6] |
| multi_rtt_p999_us | 3596.0 | 4035.6 | +133.6 | [-1170.7, +1437.9] |
| multi_rtt_max_us | 4959.5 | 5551.3 | +929.9 | [-2331.8, +4191.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2482 | 0.2518 | +0.0084 | [-0.0029, +0.0197] |
| fanout_delivery_mean_us | 22038.1 | 22659.1 | +808.2 | [-196.5, +1812.9] |
| fanout_delivery_p50_us | 21539.1 | 22822.5 | +722.4 | [-237.3, +1682.1] |
| fanout_delivery_p90_us | 27407.2 | 28311.9 | +2095.4 | [+36.9, +4153.9] |
| fanout_delivery_p99_us | 32074.5 | 32463.6 | +2985.7 | [-191.5, +6162.9] |
| fanout_delivery_p999_us | 34146.3 | 32915.1 | +2707.7 | [-612.5, +6027.8] |
| fanout_delivery_max_us | 34346.9 | 34809.3 | +3043.3 | [-320.2, +6406.9] |
| client_wall_s | 1.7197 | 1.7053 | +0.0376 | [-0.0081, +0.0833] |
| client_cpu_s | 1.3268 | 1.3209 | +0.0238 | [-0.0147, +0.0624] |
| broker_user_s | 0.4242 | 0.4485 | +0.0235 | [+0.0062, +0.0408] |
| broker_sys_s | 0.5110 | 0.5273 | +0.0047 | [-0.0096, +0.0189] |
| broker_cpu_s | 0.9390 | 0.9671 | +0.0282 | [+0.0071, +0.0493] |
| broker_vcsw | 13691.5 | 13440.0 | +14.6 | [-249.5, +278.8] |
| broker_maxrss_kib | 4998 | 5036 | +29 | [-6, +64] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
