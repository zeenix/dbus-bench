candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-4f346a3/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.9958 | 0.9503 | -4.57 | [-5.98, -3.13] | [-5.75, -3.37] | 0.956 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_mean_us | 60 | 199.1 | 190.0 | -4.57 | [-5.98, -3.13] | [-5.76, -3.37] | 0.956 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p50_us | 60 | 188.4 | 179.1 | -4.97 | [-6.52, -3.44] | [-6.27, -3.70] | 0.957 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p90_us | 60 | 236.5 | 227.2 | -3.92 | [-5.52, -2.28] | [-5.28, -2.54] | 0.952 | <0.0001 | inconclusive; repeatable change (-) |
| single_rtt_p99_us | 60 | 347.4 | 332.4 | -4.31 | [-8.21, -0.35] | [-7.60, -1.00] | 0.987 | 0.1069 | inconclusive; repeatable change (-) |
| single_rtt_p999_us | 60 | 988.2 | 961.6 | -2.69 | [-14.53, +11.34] | [-12.73, +8.80] | 1.101 | 0.8195 | inconclusive |
| single_rtt_max_us | 60 | 3301.9 | 2763.8 | -16.30 | [-34.26, +6.79] | [-31.67, +2.62] | 0.980 | 0.3613 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.9567 | 0.8090 | -15.44 | [-18.51, -12.40] | [-17.98, -12.88] | 0.856 | <0.0001 | faster/smaller |
| multi_rtt_mean_us | 60 | 938.3 | 783.1 | -16.53 | [-19.59, -13.54] | [-19.05, -14.00] | 0.841 | <0.0001 | faster/smaller |
| multi_rtt_p50_us | 60 | 850.6 | 743.0 | -12.66 | [-16.13, -9.10] | [-15.64, -9.63] | 0.890 | <0.0001 | faster/smaller |
| multi_rtt_p90_us | 60 | 1375.4 | 1051.3 | -23.56 | [-27.57, -19.43] | [-26.86, -20.09] | 0.774 | <0.0001 | faster/smaller |
| multi_rtt_p99_us | 60 | 2098.6 | 1593.1 | -24.09 | [-27.92, -20.17] | [-27.28, -20.83] | 0.760 | <0.0001 | faster/smaller |
| multi_rtt_p999_us | 60 | 3929.8 | 3034.9 | -22.77 | [-35.35, -8.63] | [-33.39, -11.01] | 0.796 | 0.0019 | faster/smaller |
| multi_rtt_max_us | 60 | 5763.5 | 4092.9 | -28.99 | [-43.93, -11.40] | [-41.52, -14.35] | 0.759 | 0.0010 | faster/smaller |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.3935 | 0.3132 | -20.41 | [-23.45, -17.00] | [-23.00, -17.60] | 0.772 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 74573.4 | 27804.6 | -62.72 | [-64.37, -60.85] | [-64.13, -61.16] | 0.362 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 60838.2 | 27482.5 | -54.83 | [-57.39, -51.96] | [-57.01, -52.43] | 0.440 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 161406.1 | 36111.3 | -77.63 | [-78.86, -76.26] | [-78.66, -76.51] | 0.209 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 192619.1 | 41635.0 | -78.38 | [-79.64, -77.06] | [-79.46, -77.29] | 0.206 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 196942.8 | 43214.3 | -78.06 | [-79.38, -76.67] | [-79.18, -76.89] | 0.205 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 198432.1 | 44706.3 | -77.47 | [-78.82, -76.01] | [-78.63, -76.28] | 0.207 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.3637 | 2.0939 | -11.41 | [-13.05, -9.82] | [-12.78, -10.07] | 0.889 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.6924 | 1.5862 | -6.28 | [-8.00, -4.57] | [-7.72, -4.84] | 0.942 | <0.0001 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.8643 | 0.5477 | -36.63 | [-38.48, -34.77] | [-38.19, -35.09] | 0.632 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7790 | 0.6476 | -16.86 | [-19.35, -14.34] | [-18.93, -14.72] | 0.821 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.6433 | 1.1953 | -27.26 | [-28.75, -25.81] | [-28.52, -26.01] | 0.738 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 14990.7 | 13415.5 | -10.51 | [-11.72, -9.29] | [-11.53, -9.46] | 0.896 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 6156 | 5083 | -17.44 | [-17.96, -16.90] | [-17.88, -16.98] | 0.825 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 1.0098 | 0.9489 | -0.0455 | [-0.0604, -0.0306] |
| single_rtt_mean_us | 201.8 | 189.7 | -9.1 | [-12.1, -6.1] |
| single_rtt_p50_us | 191.0 | 177.9 | -9.4 | [-12.4, -6.3] |
| single_rtt_p90_us | 238.8 | 227.0 | -9.3 | [-13.3, -5.2] |
| single_rtt_p99_us | 343.8 | 331.3 | -15.0 | [-29.5, -0.5] |
| single_rtt_p999_us | 962.3 | 948.2 | -26.6 | [-157.9, +104.7] |
| single_rtt_max_us | 2680.4 | 2343.7 | -538.2 | [-1312.1, +235.7] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.9358 | 0.7962 | -0.1477 | [-0.1813, -0.1141] |
| multi_rtt_mean_us | 918.1 | 769.6 | -155.1 | [-188.1, -122.1] |
| multi_rtt_p50_us | 836.5 | 729.9 | -107.6 | [-141.2, -74.1] |
| multi_rtt_p90_us | 1334.8 | 1085.0 | -324.0 | [-393.1, -254.9] |
| multi_rtt_p99_us | 2115.8 | 1557.7 | -505.5 | [-600.0, -411.0] |
| multi_rtt_p999_us | 3384.6 | 2694.6 | -894.8 | [-1540.5, -249.1] |
| multi_rtt_max_us | 4321.4 | 3472.8 | -1670.6 | [-2942.0, -399.2] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.3844 | 0.2975 | -0.0803 | [-0.0944, -0.0663] |
| fanout_delivery_mean_us | 72030.9 | 26330.7 | -46768.8 | [-49379.2, -44158.4] |
| fanout_delivery_p50_us | 57982.2 | 25965.5 | -33355.7 | [-36265.3, -30446.1] |
| fanout_delivery_p90_us | 160735.0 | 33593.7 | -125294.8 | [-130674.2, -119915.4] |
| fanout_delivery_p99_us | 193834.7 | 39047.7 | -150984.1 | [-156275.8, -145692.3] |
| fanout_delivery_p999_us | 197017.5 | 40398.0 | -153728.4 | [-159068.0, -148388.9] |
| fanout_delivery_max_us | 200583.2 | 40483.2 | -153725.7 | [-159235.9, -148215.5] |
| client_wall_s | 2.3488 | 2.0715 | -0.2698 | [-0.3119, -0.2277] |
| client_cpu_s | 1.6833 | 1.5598 | -0.1063 | [-0.1368, -0.0757] |
| broker_user_s | 0.8496 | 0.5372 | -0.3166 | [-0.3383, -0.2950] |
| broker_sys_s | 0.7770 | 0.6468 | -0.1313 | [-0.1541, -0.1086] |
| broker_cpu_s | 1.6279 | 1.1810 | -0.4480 | [-0.4804, -0.4156] |
| broker_vcsw | 15057.0 | 13516.5 | -1575.2 | [-1784.4, -1366.1] |
| broker_maxrss_kib | 6178 | 5084 | -1074 | [-1111, -1036] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
