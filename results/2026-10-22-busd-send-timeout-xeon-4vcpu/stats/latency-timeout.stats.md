candidate timeout against baseline baseline, from latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.7254 | 0.7189 | -0.90 | [-4.07, +2.13] | [-3.51, +1.66] | 0.978 | 0.5315 | no material change |
| single_rtt_mean_us | 60 | 145.0 | 143.7 | -0.90 | [-4.07, +2.13] | [-3.51, +1.66] | 0.978 | 0.5363 | no material change |
| single_rtt_p50_us | 60 | 131.4 | 131.0 | -0.36 | [-2.23, +1.59] | [-1.94, +1.30] | 0.991 | 0.4181 | no material change |
| single_rtt_p90_us | 60 | 169.1 | 170.2 | +0.63 | [-3.29, +4.66] | [-2.69, +4.02] | 0.993 | 0.9355 | no material change |
| single_rtt_p99_us | 60 | 335.4 | 308.9 | -7.91 | [-25.09, +8.12] | [-22.19, +5.96] | 0.981 | 0.6219 | inconclusive |
| single_rtt_p999_us | 60 | 1459.9 | 1250.2 | -14.37 | [-37.28, +15.31] | [-33.84, +10.55] | 0.978 | 0.7967 | inconclusive |
| single_rtt_max_us | 60 | 6544.2 | 4409.2 | -32.62 | [-56.37, +7.20] | [-53.22, -0.07] | 0.884 | 0.2825 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.7542 | 0.7439 | -1.36 | [-7.06, +4.12] | [-6.03, +3.25] | 1.022 | 0.6964 | inconclusive |
| multi_rtt_mean_us | 60 | 730.9 | 718.8 | -1.66 | [-7.29, +3.77] | [-6.31, +2.93] | 1.020 | 0.8540 | inconclusive |
| multi_rtt_p50_us | 60 | 659.6 | 658.7 | -0.14 | [-6.15, +5.67] | [-5.04, +4.79] | 1.013 | 0.7404 | inconclusive |
| multi_rtt_p90_us | 60 | 1003.7 | 971.0 | -3.26 | [-11.07, +4.63] | [-9.76, +3.44] | 1.035 | 0.9121 | inconclusive |
| multi_rtt_p99_us | 60 | 2032.3 | 1914.6 | -5.79 | [-15.88, +5.21] | [-14.23, +3.48] | 0.940 | 0.4616 | inconclusive |
| multi_rtt_p999_us | 60 | 4466.9 | 4352.3 | -2.56 | [-16.23, +13.52] | [-14.24, +10.77] | 1.001 | 0.7967 | inconclusive |
| multi_rtt_max_us | 60 | 7299.1 | 7619.6 | +4.39 | [-20.60, +39.79] | [-17.53, +32.82] | 1.013 | 0.6694 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2693 | 0.2651 | -1.57 | [-5.70, +2.86] | [-5.03, +2.19] | 0.971 | 0.1038 | inconclusive |
| fanout_delivery_mean_us | 60 | 58706.1 | 23677.3 | -59.67 | [-61.30, -57.87] | [-61.06, -58.16] | 0.398 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 59704.1 | 23205.6 | -61.13 | [-62.81, -59.42] | [-62.57, -59.67] | 0.393 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 92487.1 | 30870.5 | -66.62 | [-68.73, -64.14] | [-68.43, -64.55] | 0.312 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 101684.4 | 35917.9 | -64.68 | [-67.62, -61.29] | [-67.16, -61.89] | 0.324 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 104818.9 | 37167.7 | -64.54 | [-67.61, -60.96] | [-67.16, -61.60] | 0.325 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 105691.2 | 38404.0 | -63.66 | [-66.76, -60.05] | [-66.32, -60.71] | 0.332 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.7685 | 1.7484 | -1.14 | [-4.11, +1.71] | [-3.64, +1.29] | 0.981 | 0.5461 | no material change |
| client_cpu_s | 60 | 1.3513 | 1.3449 | -0.47 | [-4.18, +2.90] | [-3.55, +2.39] | 1.000 | 0.9179 | no material change |
| broker_user_s | 60 | 0.4588 | 0.4553 | -0.76 | [-4.51, +3.00] | [-3.88, +2.41] | 1.004 | 0.8424 | no material change |
| broker_sys_s | 60 | 0.5285 | 0.5243 | -0.79 | [-3.80, +2.33] | [-3.31, +1.86] | 0.986 | 0.6534 | no material change |
| broker_cpu_s | 60 | 0.9873 | 0.9796 | -0.77 | [-3.18, +1.56] | [-2.80, +1.19] | 1.001 | 0.8195 | no material change |
| broker_vcsw | 60 | 13820.8 | 13575.1 | -1.78 | [-4.08, +0.49] | [-3.67, +0.11] | 0.983 | 0.0779 | no material change |
| broker_maxrss_kib | 60 | 6305 | 5029 | -20.23 | [-20.96, -19.52] | [-20.84, -19.63] | 0.794 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.7119 | 0.6968 | -0.0065 | [-0.0296, +0.0166] |
| single_rtt_mean_us | 142.3 | 139.3 | -1.3 | [-5.9, +3.3] |
| single_rtt_p50_us | 130.2 | 130.3 | -0.5 | [-3.1, +2.1] |
| single_rtt_p90_us | 165.7 | 163.7 | +1.1 | [-5.8, +8.0] |
| single_rtt_p99_us | 299.0 | 299.4 | -26.5 | [-91.8, +38.7] |
| single_rtt_p999_us | 1151.7 | 1109.7 | -209.7 | [-668.3, +248.8] |
| single_rtt_max_us | 3918.7 | 3675.0 | -2135.0 | [-4905.1, +635.2] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.7011 | 0.7129 | -0.0102 | [-0.0539, +0.0334] |
| multi_rtt_mean_us | 679.5 | 691.6 | -12.1 | [-54.2, +29.9] |
| multi_rtt_p50_us | 623.5 | 629.0 | -0.9 | [-40.9, +39.1] |
| multi_rtt_p90_us | 920.8 | 918.3 | -32.7 | [-116.2, +50.7] |
| multi_rtt_p99_us | 1883.3 | 1855.9 | -117.7 | [-349.0, +113.6] |
| multi_rtt_p999_us | 3918.1 | 4035.6 | -114.5 | [-823.4, +594.4] |
| multi_rtt_max_us | 5713.6 | 5551.3 | +320.5 | [-1930.4, +2571.4] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2619 | 0.2518 | -0.0042 | [-0.0163, +0.0078] |
| fanout_delivery_mean_us | 58278.9 | 22659.1 | -35028.8 | [-36752.6, -33305.1] |
| fanout_delivery_p50_us | 57776.8 | 22822.5 | -36498.5 | [-38545.1, -34452.0] |
| fanout_delivery_p90_us | 88753.1 | 28311.9 | -61616.6 | [-65211.5, -58021.7] |
| fanout_delivery_p99_us | 96865.0 | 32463.6 | -65766.5 | [-70598.6, -60934.4] |
| fanout_delivery_p999_us | 99621.1 | 32915.1 | -67651.2 | [-72832.6, -62469.9] |
| fanout_delivery_max_us | 99718.4 | 34809.3 | -67287.1 | [-72594.2, -61980.1] |
| client_wall_s | 1.7101 | 1.7053 | -0.0201 | [-0.0736, +0.0333] |
| client_cpu_s | 1.3085 | 1.3209 | -0.0064 | [-0.0556, +0.0429] |
| broker_user_s | 0.4455 | 0.4485 | -0.0035 | [-0.0213, +0.0144] |
| broker_sys_s | 0.5171 | 0.5273 | -0.0042 | [-0.0210, +0.0126] |
| broker_cpu_s | 0.9611 | 0.9671 | -0.0076 | [-0.0319, +0.0166] |
| broker_vcsw | 13822.5 | 13440.0 | -245.7 | [-570.7, +79.4] |
| broker_maxrss_kib | 6348 | 5036 | -1275 | [-1331, -1220] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
