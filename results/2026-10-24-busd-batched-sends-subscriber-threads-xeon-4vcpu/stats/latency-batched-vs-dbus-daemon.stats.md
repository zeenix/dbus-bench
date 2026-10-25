candidate batched against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9518 | 0.9126 | -4.11 | [-5.32, -2.85] | [-5.12, -3.06] | 0.958 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_mean_us | 60 | 190.3 | 182.4 | -4.11 | [-5.32, -2.86] | [-5.13, -3.06] | 0.958 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p50_us | 60 | 180.0 | 171.8 | -4.59 | [-5.81, -3.36] | [-5.60, -3.54] | 0.961 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p90_us | 60 | 222.0 | 214.5 | -3.41 | [-4.95, -1.80] | [-4.69, -2.09] | 0.970 | 0.0001 | no material change; repeatable change (-) |
| single_rtt_p99_us | 60 | 308.5 | 299.5 | -2.93 | [-6.00, +0.30] | [-5.54, -0.23] | 0.969 | 0.1038 | inconclusive |
| single_rtt_p999_us | 60 | 821.3 | 803.2 | -2.21 | [-14.87, +12.57] | [-13.01, +10.00] | 0.966 | 0.8946 | inconclusive |
| single_rtt_max_us | 60 | 2759.9 | 2750.4 | -0.34 | [-18.25, +21.42] | [-15.63, +17.56] | 1.045 | 0.6856 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.8618 | 0.7514 | -12.81 | [-15.28, -10.14] | [-14.91, -10.59] | 0.875 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 847.3 | 726.8 | -14.22 | [-16.69, -11.56] | [-16.31, -12.01] | 0.859 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 779.9 | 694.4 | -10.96 | [-13.00, -8.80] | [-12.69, -9.14] | 0.890 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1178.5 | 950.9 | -19.31 | [-23.39, -14.85] | [-22.78, -15.61] | 0.796 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1924.7 | 1465.1 | -23.88 | [-29.93, -17.11] | [-29.12, -18.18] | 0.765 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3401.4 | 2656.7 | -21.90 | [-34.62, -7.60] | [-32.71, -9.88] | 0.899 | 0.0044 | faster/smaller |
| multi_rtt_max_us | 60 | 4774.2 | 4334.6 | -9.21 | [-33.25, +25.69] | [-30.05, +18.70] | 0.882 | 0.1664 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3821 | 0.1013 | -73.50 | [-75.35, -71.35] | [-75.06, -71.73] | 0.269 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 11416.2 | 4902.9 | -57.05 | [-60.08, -53.73] | [-59.58, -54.25] | 0.428 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 10610.4 | 4615.3 | -56.50 | [-59.81, -52.64] | [-59.30, -53.27] | 0.429 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 19547.2 | 8350.0 | -57.28 | [-60.00, -54.38] | [-59.57, -54.81] | 0.418 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 27694.3 | 12141.5 | -56.16 | [-60.95, -51.43] | [-60.16, -52.12] | 0.446 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 30739.0 | 14723.4 | -52.10 | [-57.12, -47.23] | [-56.33, -47.92] | 0.495 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 31484.7 | 17202.4 | -45.36 | [-50.93, -39.80] | [-50.07, -40.63] | 0.582 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.2303 | 1.7983 | -19.37 | [-20.86, -17.84] | [-20.61, -18.07] | 0.806 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.9553 | 1.4977 | -23.40 | [-24.90, -21.78] | [-24.67, -22.05] | 0.756 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.7956 | 0.4960 | -37.65 | [-39.18, -36.08] | [-38.93, -36.33] | 0.623 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.9191 | 0.5798 | -36.91 | [-39.36, -34.34] | [-38.96, -34.81] | 0.640 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.7147 | 1.0759 | -37.26 | [-38.58, -35.88] | [-38.36, -36.11] | 0.628 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10449.0 | 13705.0 | +31.16 | [+29.73, +32.53] | [+29.98, +32.30] | 1.318 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5045 | 5101 | +1.12 | [+0.35, +1.85] | [+0.47, +1.73] | 1.014 | 0.0012 | no material change; repeatable change (+) |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9535 | 0.9159 | -0.0391 | [-0.0516, -0.0266] |
| single_rtt_mean_us | 190.6 | 183.1 | -7.8 | [-10.3, -5.3] |
| single_rtt_p50_us | 180.2 | 173.2 | -8.3 | [-10.6, -5.9] |
| single_rtt_p90_us | 220.9 | 213.1 | -7.6 | [-11.2, -3.9] |
| single_rtt_p99_us | 304.4 | 298.9 | -9.0 | [-19.3, +1.2] |
| single_rtt_p999_us | 712.8 | 743.4 | -18.1 | [-134.1, +97.8] |
| single_rtt_max_us | 2305.5 | 2416.4 | -9.5 | [-567.5, +548.5] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.8588 | 0.7465 | -0.1104 | [-0.1347, -0.0860] |
| multi_rtt_mean_us | 846.2 | 721.8 | -120.4 | [-144.4, -96.5] |
| multi_rtt_p50_us | 776.4 | 669.6 | -85.4 | [-103.2, -67.7] |
| multi_rtt_p90_us | 1170.4 | 949.5 | -227.6 | [-285.9, -169.3] |
| multi_rtt_p99_us | 1937.4 | 1456.4 | -459.6 | [-609.5, -309.6] |
| multi_rtt_p999_us | 2990.6 | 2319.7 | -744.8 | [-1298.3, -191.2] |
| multi_rtt_max_us | 3785.9 | 3186.6 | -439.5 | [-1918.4, +1039.3] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3875 | 0.1013 | -0.2809 | [-0.3086, -0.2531] |
| fanout_delivery_mean_us | 11512.7 | 4913.4 | -6513.3 | [-7303.9, -5722.7] |
| fanout_delivery_p50_us | 10904.4 | 4635.0 | -5995.1 | [-6853.0, -5137.2] |
| fanout_delivery_p90_us | 19029.0 | 8202.9 | -11197.2 | [-12332.0, -10062.4] |
| fanout_delivery_p99_us | 25868.1 | 11833.2 | -15552.8 | [-18503.9, -12601.7] |
| fanout_delivery_p999_us | 28158.4 | 14251.2 | -16015.5 | [-19233.7, -12797.4] |
| fanout_delivery_max_us | 28919.1 | 16914.1 | -14282.4 | [-17521.2, -11043.5] |
| client_wall_s | 2.2449 | 1.8011 | -0.4320 | [-0.4732, -0.3907] |
| client_cpu_s | 1.9742 | 1.4963 | -0.4576 | [-0.4968, -0.4185] |
| broker_user_s | 0.7880 | 0.4945 | -0.2996 | [-0.3164, -0.2828] |
| broker_sys_s | 0.9169 | 0.5756 | -0.3393 | [-0.3728, -0.3058] |
| broker_cpu_s | 1.7160 | 1.0807 | -0.6388 | [-0.6738, -0.6039] |
| broker_vcsw | 10345.5 | 13749.5 | +3256.0 | [+3125.2, +3386.8] |
| broker_maxrss_kib | 5034 | 5106 | +57 | [+18, +96] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
