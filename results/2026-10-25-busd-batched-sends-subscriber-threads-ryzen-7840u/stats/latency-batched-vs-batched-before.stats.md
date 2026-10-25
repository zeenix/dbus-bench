candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3322 | 0.3333 | +0.35 | [-0.47, +1.20] | [-0.34, +1.05] | 1.003 | 0.4936 | no material change |
| single_rtt_mean_us | 60 | 65.0 | 65.2 | +0.36 | [-0.48, +1.22] | [-0.34, +1.07] | 1.003 | 0.4889 | no material change |
| single_rtt_p50_us | 60 | 62.3 | 62.5 | +0.41 | [-0.70, +1.58] | [-0.54, +1.38] | 1.000 | 0.7275 | no material change |
| single_rtt_p90_us | 60 | 73.1 | 73.9 | +1.16 | [-0.56, +2.97] | [-0.30, +2.67] | 1.014 | 0.1872 | no material change |
| single_rtt_p99_us | 60 | 114.0 | 114.0 | +0.00 | [-3.66, +3.81] | [-3.06, +3.18] | 1.005 | 0.7887 | no material change |
| single_rtt_p999_us | 60 | 200.7 | 205.9 | +2.61 | [-5.20, +12.00] | [-4.08, +10.33] | 1.016 | 0.8713 | inconclusive |
| single_rtt_max_us | 60 | 435.5 | 452.3 | +3.87 | [-27.22, +48.52] | [-22.83, +40.89] | 1.059 | 0.5363 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5030 | 0.5030 | -0.01 | [-0.57, +0.55] | [-0.49, +0.46] | 1.003 | 0.7516 | no material change |
| multi_rtt_mean_us | 60 | 498.1 | 498.1 | +0.00 | [-0.52, +0.54] | [-0.45, +0.45] | 1.003 | 0.7516 | no material change |
| multi_rtt_p50_us | 60 | 484.2 | 485.0 | +0.17 | [-0.09, +0.47] | [-0.05, +0.42] | 1.000 | 0.5209 | no material change |
| multi_rtt_p90_us | 60 | 534.4 | 531.2 | -0.61 | [-2.29, +1.06] | [-2.02, +0.80] | 0.999 | 0.7742 | no material change |
| multi_rtt_p99_us | 60 | 891.3 | 889.7 | -0.18 | [-3.31, +2.98] | [-2.84, +2.46] | 1.010 | 0.7797 | no material change |
| multi_rtt_p999_us | 60 | 1161.8 | 1170.3 | +0.73 | [-4.10, +5.30] | [-3.21, +4.59] | 1.014 | 0.3993 | no material change |
| multi_rtt_max_us | 60 | 1438.9 | 1414.3 | -1.71 | [-8.30, +5.07] | [-7.31, +3.96] | 0.996 | 0.7771 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.0545 | 0.0502 | -7.80 | [-8.45, -7.17] | [-8.35, -7.27] | 0.922 | <0.0001 | faster/smaller |
| fanout_delivery_mean_us | 60 | 3039.9 | 2246.2 | -26.11 | [-26.64, -25.59] | [-26.54, -25.67] | 0.739 | <0.0001 | faster/smaller |
| fanout_delivery_p50_us | 60 | 3041.8 | 2261.4 | -25.66 | [-26.16, -25.15] | [-26.07, -25.23] | 0.743 | <0.0001 | faster/smaller |
| fanout_delivery_p90_us | 60 | 3922.4 | 3378.6 | -13.86 | [-14.49, -13.25] | [-14.39, -13.35] | 0.861 | <0.0001 | faster/smaller |
| fanout_delivery_p99_us | 60 | 4303.9 | 3836.8 | -10.85 | [-12.74, -8.76] | [-12.47, -9.11] | 0.881 | <0.0001 | faster/smaller |
| fanout_delivery_p999_us | 60 | 4522.3 | 4083.3 | -9.71 | [-11.84, -7.36] | [-11.51, -7.74] | 0.891 | <0.0001 | faster/smaller |
| fanout_delivery_max_us | 60 | 4748.5 | 4365.4 | -8.07 | [-10.56, -5.45] | [-10.15, -5.87] | 0.917 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.9384 | 0.9347 | -0.40 | [-0.92, +0.13] | [-0.84, +0.04] | 0.996 | 0.2273 | no material change |
| client_cpu_s | 60 | 1.0594 | 1.0681 | +0.82 | [+0.43, +1.25] | [+0.48, +1.17] | 1.010 | 0.0005 | no material change; repeatable change (+) |
| broker_user_s | 60 | 0.2933 | 0.2970 | +1.23 | [-0.90, +3.32] | [-0.53, +2.97] | 1.012 | 0.2245 | no material change |
| broker_sys_s | 60 | 0.3071 | 0.2983 | -2.85 | [-4.36, -1.27] | [-4.13, -1.55] | 0.980 | 0.0010 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.6004 | 0.5953 | -0.85 | [-1.52, -0.19] | [-1.41, -0.30] | 0.994 | 0.0221 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 13969.5 | 13979.9 | +0.07 | [-0.23, +0.38] | [-0.18, +0.33] | 1.002 | 0.6375 | no material change |
| broker_maxrss_kib | 60 | 7046 | 7001 | -0.65 | [-1.35, +0.06] | [-1.24, -0.05] | 0.995 | 0.1275 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3317 | 0.3327 | +0.0012 | [-0.0016, +0.0040] |
| single_rtt_mean_us | 64.9 | 65.1 | +0.2 | [-0.3, +0.8] |
| single_rtt_p50_us | 61.7 | 61.7 | +0.3 | [-0.5, +1.0] |
| single_rtt_p90_us | 71.2 | 73.0 | +0.9 | [-0.5, +2.2] |
| single_rtt_p99_us | 109.8 | 112.8 | +0.0 | [-4.3, +4.3] |
| single_rtt_p999_us | 189.4 | 190.0 | +5.2 | [-12.1, +22.6] |
| single_rtt_max_us | 268.9 | 316.4 | +16.9 | [-146.9, +180.6] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5055 | 0.5043 | -0.0001 | [-0.0030, +0.0028] |
| multi_rtt_mean_us | 499.7 | 499.2 | +0.0 | [-2.7, +2.8] |
| multi_rtt_p50_us | 485.6 | 485.6 | +0.8 | [-0.6, +2.2] |
| multi_rtt_p90_us | 526.0 | 523.6 | -3.2 | [-12.4, +5.9] |
| multi_rtt_p99_us | 915.4 | 913.6 | -1.6 | [-30.7, +27.5] |
| multi_rtt_p999_us | 1135.7 | 1144.0 | +8.5 | [-46.9, +63.8] |
| multi_rtt_max_us | 1402.2 | 1383.2 | -24.7 | [-125.0, +75.6] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.0544 | 0.0501 | -0.0043 | [-0.0046, -0.0039] |
| fanout_delivery_mean_us | 3033.8 | 2243.7 | -793.6 | [-813.0, -774.3] |
| fanout_delivery_p50_us | 3043.1 | 2260.1 | -780.4 | [-798.7, -762.1] |
| fanout_delivery_p90_us | 3915.8 | 3380.9 | -543.8 | [-570.9, -516.6] |
| fanout_delivery_p99_us | 4250.0 | 3751.3 | -467.0 | [-559.7, -374.4] |
| fanout_delivery_p999_us | 4458.4 | 3986.4 | -439.0 | [-547.3, -330.8] |
| fanout_delivery_max_us | 4655.5 | 4258.9 | -383.1 | [-513.5, -252.7] |
| client_wall_s | 0.9425 | 0.9359 | -0.0038 | [-0.0088, +0.0013] |
| client_cpu_s | 1.0599 | 1.0655 | +0.0087 | [+0.0042, +0.0131] |
| broker_user_s | 0.2945 | 0.2947 | +0.0036 | [-0.0026, +0.0098] |
| broker_sys_s | 0.3061 | 0.2963 | -0.0087 | [-0.0137, -0.0038] |
| broker_cpu_s | 0.6027 | 0.5975 | -0.0051 | [-0.0092, -0.0010] |
| broker_vcsw | 13958.0 | 13980.5 | +10.4 | [-34.0, +54.8] |
| broker_maxrss_kib | 7068 | 7024 | -45 | [-97, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
