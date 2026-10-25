candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9518 | 0.9078 | -4.62 | [-5.93, -3.24] | [-5.74, -3.47] | 0.955 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_mean_us | 60 | 190.3 | 181.5 | -4.63 | [-5.93, -3.24] | [-5.74, -3.48] | 0.955 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p50_us | 60 | 180.0 | 170.6 | -5.26 | [-6.64, -3.88] | [-6.41, -4.11] | 0.951 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p90_us | 60 | 222.0 | 214.2 | -3.53 | [-5.42, -1.58] | [-5.13, -1.90] | 0.964 | 0.0008 | inconclusive; repeatable change (-) |
| single_rtt_p99_us | 60 | 308.5 | 301.9 | -2.15 | [-6.52, +3.63] | [-5.91, +2.49] | 0.944 | 0.0142 | inconclusive |
| single_rtt_p999_us | 60 | 821.3 | 797.1 | -2.95 | [-17.81, +14.62] | [-15.51, +11.69] | 0.938 | 0.4936 | inconclusive |
| single_rtt_max_us | 60 | 2759.9 | 2224.5 | -19.40 | [-35.06, -0.11] | [-32.64, -3.63] | 0.797 | 0.0414 | inconclusive; repeatable change (-) |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.8618 | 0.7370 | -14.49 | [-16.63, -12.18] | [-16.31, -12.56] | 0.853 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 847.3 | 712.0 | -15.96 | [-18.08, -13.68] | [-17.76, -14.06] | 0.841 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 779.9 | 686.5 | -11.98 | [-13.73, -10.13] | [-13.46, -10.43] | 0.878 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1178.5 | 914.4 | -22.40 | [-26.15, -18.33] | [-25.56, -19.04] | 0.762 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 1924.7 | 1379.8 | -28.31 | [-33.22, -22.77] | [-32.46, -23.71] | 0.708 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3401.4 | 2604.3 | -23.44 | [-36.45, -8.11] | [-34.44, -10.98] | 0.759 | 0.0007 | faster/smaller |
| multi_rtt_max_us | 60 | 4774.2 | 3739.7 | -21.67 | [-37.69, -0.24] | [-35.62, -4.34] | 0.673 | 0.0065 | inconclusive; repeatable change (-) |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3821 | 0.2961 | -22.51 | [-28.91, -15.41] | [-27.95, -16.58] | 0.787 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 11416.2 | 17345.6 | +51.94 | [+39.48, +65.20] | [+41.50, +63.13] | 1.573 | <0.0001 | slower/larger |
| fanout_delivery_p50_us | 60 | 10610.4 | 16526.9 | +55.76 | [+41.33, +71.74] | [+43.47, +69.05] | 1.611 | <0.0001 | slower/larger |
| fanout_delivery_p90_us | 60 | 19547.2 | 28326.2 | +44.91 | [+33.94, +56.54] | [+35.61, +54.61] | 1.443 | <0.0001 | slower/larger |
| fanout_delivery_p99_us | 60 | 27694.3 | 37178.6 | +34.25 | [+18.76, +49.54] | [+21.37, +47.08] | 1.389 | <0.0001 | slower/larger |
| fanout_delivery_p999_us | 60 | 30739.0 | 39630.0 | +28.92 | [+14.25, +43.13] | [+16.80, +41.11] | 1.359 | <0.0001 | slower/larger |
| fanout_delivery_max_us | 60 | 31484.7 | 40444.8 | +28.46 | [+14.02, +42.31] | [+16.60, +40.24] | 1.358 | <0.0001 | slower/larger |
| client_wall_s | 60 | 2.2303 | 1.9775 | -11.33 | [-12.96, -9.67] | [-12.69, -9.95] | 0.902 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.9553 | 1.8239 | -6.72 | [-8.68, -4.73] | [-8.39, -5.03] | 0.942 | <0.0001 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.7956 | 0.5112 | -35.74 | [-37.36, -34.11] | [-37.08, -34.36] | 0.637 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.9191 | 0.7684 | -16.40 | [-19.73, -12.81] | [-19.21, -13.40] | 0.835 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.7147 | 1.2796 | -25.37 | [-27.20, -23.51] | [-26.89, -23.81] | 0.749 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 10449.0 | 13559.0 | +29.76 | [+27.93, +31.48] | [+28.22, +31.22] | 1.309 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5045 | 5040 | -0.09 | [-0.92, +0.67] | [-0.78, +0.56] | 1.005 | 0.7516 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.9535 | 0.9092 | -0.0440 | [-0.0574, -0.0306] |
| single_rtt_mean_us | 190.6 | 181.8 | -8.8 | [-11.5, -6.1] |
| single_rtt_p50_us | 180.2 | 171.1 | -9.5 | [-12.1, -6.9] |
| single_rtt_p90_us | 220.9 | 213.4 | -7.8 | [-12.3, -3.4] |
| single_rtt_p99_us | 304.4 | 290.1 | -6.6 | [-22.6, +9.3] |
| single_rtt_p999_us | 712.8 | 687.9 | -24.2 | [-161.7, +113.2] |
| single_rtt_max_us | 2305.5 | 1870.1 | -535.5 | [-1089.0, +18.1] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.8588 | 0.7390 | -0.1249 | [-0.1461, -0.1036] |
| multi_rtt_mean_us | 846.2 | 714.5 | -135.2 | [-156.0, -114.5] |
| multi_rtt_p50_us | 776.4 | 669.7 | -93.4 | [-108.8, -78.0] |
| multi_rtt_p90_us | 1170.4 | 914.1 | -264.0 | [-318.1, -209.9] |
| multi_rtt_p99_us | 1937.4 | 1327.0 | -544.8 | [-670.5, -419.2] |
| multi_rtt_p999_us | 2990.6 | 2267.5 | -797.1 | [-1377.1, -217.1] |
| multi_rtt_max_us | 3785.9 | 3010.6 | -1034.5 | [-2072.9, +3.8] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3875 | 0.2994 | -0.0860 | [-0.1173, -0.0547] |
| fanout_delivery_mean_us | 11512.7 | 17718.0 | +5929.5 | [+4660.4, +7198.5] |
| fanout_delivery_p50_us | 10904.4 | 17370.6 | +5916.5 | [+4560.3, +7272.8] |
| fanout_delivery_p90_us | 19029.0 | 28449.7 | +8779.0 | [+6759.1, +10798.9] |
| fanout_delivery_p99_us | 25868.1 | 36713.8 | +9484.3 | [+5713.1, +13255.6] |
| fanout_delivery_p999_us | 28158.4 | 38929.8 | +8891.0 | [+4858.6, +12923.5] |
| fanout_delivery_max_us | 28919.1 | 39365.5 | +8960.1 | [+4930.3, +12989.8] |
| client_wall_s | 2.2449 | 1.9682 | -0.2527 | [-0.2927, -0.2128] |
| client_cpu_s | 1.9742 | 1.8173 | -0.1314 | [-0.1724, -0.0904] |
| broker_user_s | 0.7880 | 0.5090 | -0.2844 | [-0.3019, -0.2668] |
| broker_sys_s | 0.9169 | 0.7664 | -0.1507 | [-0.1868, -0.1146] |
| broker_cpu_s | 1.7160 | 1.2662 | -0.4351 | [-0.4734, -0.3967] |
| broker_vcsw | 10345.5 | 13575.0 | +3109.9 | [+2940.2, +3279.7] |
| broker_maxrss_kib | 5034 | 5072 | -5 | [-46, +37] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
