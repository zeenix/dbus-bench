candidate concurrent100 against baseline timeout, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.6899 | 0.6821 | -1.13 | [-2.70, +0.40] | [-2.45, +0.16] | 0.988 | 0.1926 | no material change |
| single_rtt_mean_us | 60 | 137.9 | 136.3 | -1.14 | [-2.70, +0.40] | [-2.46, +0.15] | 0.988 | 0.1926 | no material change |
| single_rtt_p50_us | 60 | 126.9 | 125.9 | -0.81 | [-2.20, +0.60] | [-1.96, +0.36] | 0.993 | 0.3097 | no material change |
| single_rtt_p90_us | 60 | 159.0 | 156.5 | -1.57 | [-3.50, +0.42] | [-3.19, +0.11] | 0.974 | 0.1332 | no material change |
| single_rtt_p99_us | 60 | 272.7 | 270.7 | -0.75 | [-8.39, +7.28] | [-7.13, +5.94] | 1.013 | 0.9706 | inconclusive |
| single_rtt_p999_us | 60 | 967.4 | 963.5 | -0.41 | [-14.17, +15.26] | [-11.90, +12.64] | 1.026 | 0.8252 | inconclusive |
| single_rtt_max_us | 60 | 8062.3 | 6872.2 | -14.76 | [-58.13, +82.77] | [-53.46, +60.52] | 0.822 | 0.2028 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.6681 | 0.6586 | -1.42 | [-4.63, +1.94] | [-4.10, +1.37] | 0.991 | 0.3931 | no material change |
| multi_rtt_mean_us | 60 | 644.7 | 635.7 | -1.40 | [-4.62, +1.96] | [-4.07, +1.40] | 0.993 | 0.4266 | no material change |
| multi_rtt_p50_us | 60 | 608.8 | 602.4 | -1.05 | [-3.72, +1.74] | [-3.27, +1.27] | 0.991 | 0.4138 | no material change |
| multi_rtt_p90_us | 60 | 825.3 | 820.0 | -0.64 | [-5.61, +4.49] | [-4.79, +3.68] | 0.989 | 0.6694 | no material change |
| multi_rtt_p99_us | 60 | 1445.7 | 1405.4 | -2.79 | [-11.31, +6.13] | [-9.93, +4.77] | 0.985 | 0.8081 | inconclusive |
| multi_rtt_p999_us | 60 | 3351.7 | 3129.4 | -6.63 | [-19.59, +8.67] | [-17.80, +6.53] | 1.102 | 0.8482 | inconclusive |
| multi_rtt_max_us | 60 | 7579.8 | 5526.8 | -27.09 | [-55.86, +25.15] | [-52.53, +16.27] | 1.063 | 0.7073 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2471 | 0.2394 | -3.12 | [-6.31, +0.19] | [-5.78, -0.31] | 0.982 | 0.0736 | inconclusive |
| fanout_delivery_mean_us | 60 | 22073.8 | 21363.9 | -3.22 | [-6.61, +0.32] | [-6.03, -0.24] | 0.978 | 0.0605 | inconclusive |
| fanout_delivery_p50_us | 60 | 21801.1 | 21068.2 | -3.36 | [-7.10, +0.58] | [-6.42, -0.10] | 0.974 | 0.0679 | inconclusive |
| fanout_delivery_p90_us | 60 | 27296.4 | 26592.0 | -2.58 | [-7.08, +2.21] | [-6.43, +1.42] | 0.984 | 0.2478 | inconclusive |
| fanout_delivery_p99_us | 60 | 31702.9 | 30241.6 | -4.61 | [-13.25, +4.72] | [-11.92, +3.33] | 0.987 | 0.3275 | inconclusive |
| fanout_delivery_p999_us | 60 | 33220.8 | 31479.5 | -5.24 | [-14.39, +4.68] | [-12.91, +2.93] | 1.004 | 0.4309 | inconclusive |
| fanout_delivery_max_us | 60 | 34159.9 | 32301.4 | -5.44 | [-14.32, +4.14] | [-12.83, +2.43] | 0.981 | 0.2959 | inconclusive |
| client_wall_s | 60 | 1.6228 | 1.5975 | -1.56 | [-3.30, +0.22] | [-3.02, -0.07] | 0.984 | 0.1118 | no material change |
| client_cpu_s | 60 | 1.2566 | 1.2458 | -0.86 | [-2.85, +1.17] | [-2.55, +0.84] | 0.986 | 0.3386 | no material change |
| broker_user_s | 60 | 0.4244 | 0.4147 | -2.29 | [-5.12, +0.63] | [-4.68, +0.18] | 0.981 | 0.1827 | no material change |
| broker_sys_s | 60 | 0.4946 | 0.4960 | +0.29 | [-1.97, +2.59] | [-1.63, +2.21] | 1.009 | 0.5910 | no material change |
| broker_cpu_s | 60 | 0.9190 | 0.9107 | -0.90 | [-2.41, +0.53] | [-2.15, +0.32] | 1.000 | 0.6219 | no material change |
| broker_vcsw | 60 | 13514.8 | 13485.6 | -0.22 | [-1.45, +1.00] | [-1.24, +0.80] | 0.999 | 0.8946 | no material change |
| broker_maxrss_kib | 60 | 4946 | 4972 | +0.54 | [-0.20, +1.29] | [-0.09, +1.17] | 1.006 | 0.2161 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.6837 | 0.6828 | -0.0078 | [-0.0189, +0.0032] |
| single_rtt_mean_us | 136.7 | 136.5 | -1.6 | [-3.8, +0.6] |
| single_rtt_p50_us | 126.2 | 125.3 | -1.0 | [-2.9, +0.8] |
| single_rtt_p90_us | 157.3 | 156.1 | -2.5 | [-5.7, +0.7] |
| single_rtt_p99_us | 255.9 | 267.4 | -2.0 | [-24.0, +19.9] |
| single_rtt_p999_us | 855.6 | 915.6 | -3.9 | [-150.1, +142.2] |
| single_rtt_max_us | 2547.4 | 2480.6 | -1190.1 | [-6675.5, +4295.3] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.6552 | 0.6487 | -0.0095 | [-0.0320, +0.0130] |
| multi_rtt_mean_us | 633.5 | 625.7 | -9.0 | [-30.7, +12.6] |
| multi_rtt_p50_us | 594.2 | 592.8 | -6.4 | [-23.3, +10.6] |
| multi_rtt_p90_us | 806.1 | 803.4 | -5.3 | [-48.1, +37.6] |
| multi_rtt_p99_us | 1363.4 | 1368.7 | -40.3 | [-172.2, +91.5] |
| multi_rtt_p999_us | 3032.6 | 2912.9 | -222.3 | [-736.1, +291.4] |
| multi_rtt_max_us | 4481.4 | 4312.5 | -2053.0 | [-5857.9, +1751.9] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2366 | 0.2332 | -0.0077 | [-0.0160, +0.0006] |
| fanout_delivery_mean_us | 21197.1 | 20846.1 | -709.9 | [-1496.4, +76.7] |
| fanout_delivery_p50_us | 20757.6 | 20161.7 | -732.9 | [-1589.2, +123.4] |
| fanout_delivery_p90_us | 25625.8 | 25301.4 | -704.4 | [-2009.5, +600.7] |
| fanout_delivery_p99_us | 28560.8 | 28682.9 | -1461.2 | [-4492.1, +1569.6] |
| fanout_delivery_p999_us | 29684.3 | 30180.4 | -1741.3 | [-5089.3, +1606.7] |
| fanout_delivery_max_us | 30372.0 | 30420.4 | -1858.5 | [-5183.6, +1466.5] |
| client_wall_s | 1.6027 | 1.5823 | -0.0253 | [-0.0544, +0.0038] |
| client_cpu_s | 1.2376 | 1.2350 | -0.0109 | [-0.0366, +0.0149] |
| broker_user_s | 0.4186 | 0.4120 | -0.0097 | [-0.0225, +0.0031] |
| broker_sys_s | 0.4933 | 0.5009 | +0.0014 | [-0.0101, +0.0129] |
| broker_cpu_s | 0.9021 | 0.9055 | -0.0083 | [-0.0225, +0.0059] |
| broker_vcsw | 13560.0 | 13490.5 | -29.2 | [-198.2, +139.7] |
| broker_maxrss_kib | 4946 | 4964 | +26 | [-11, +64] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
