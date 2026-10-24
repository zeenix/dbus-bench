candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/latency.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_rtt_count | 60 | 5000.0 | 5000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| single_rtt_elapsed_s | 60 | 0.3363 | 0.3386 | +0.69 | [-0.19, +1.58] | [-0.06, +1.43] | 1.004 | 0.2189 | no material change |
| single_rtt_mean_us | 60 | 65.8 | 66.3 | +0.70 | [-0.20, +1.61] | [-0.06, +1.45] | 1.004 | 0.2148 | no material change |
| single_rtt_p50_us | 60 | 62.0 | 62.4 | +0.57 | [-0.44, +1.60] | [-0.29, +1.44] | 1.000 | 0.2899 | no material change |
| single_rtt_p90_us | 60 | 77.8 | 78.7 | +1.12 | [-1.15, +3.39] | [-0.81, +3.02] | 1.000 | 0.4407 | no material change |
| single_rtt_p99_us | 60 | 122.2 | 124.9 | +2.22 | [-0.90, +5.35] | [-0.40, +4.84] | 1.035 | 0.1263 | no material change |
| single_rtt_p999_us | 60 | 211.4 | 224.4 | +6.12 | [-2.10, +15.26] | [-0.84, +13.75] | 1.033 | 0.2287 | inconclusive |
| single_rtt_max_us | 60 | 486.4 | 553.9 | +13.86 | [-5.62, +36.96] | [-2.91, +32.99] | 1.234 | 0.0595 | inconclusive |
| multi_rtt_count | 60 | 20000.0 | 20000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| multi_rtt_elapsed_s | 60 | 0.5054 | 0.5056 | +0.04 | [-0.71, +0.76] | [-0.58, +0.64] | 1.000 | 0.8138 | no material change |
| multi_rtt_mean_us | 60 | 500.4 | 500.7 | +0.07 | [-0.66, +0.78] | [-0.53, +0.65] | 1.002 | 0.7460 | no material change |
| multi_rtt_p50_us | 60 | 484.9 | 486.1 | +0.24 | [-0.29, +0.75] | [-0.19, +0.67] | 1.005 | 0.2583 | no material change |
| multi_rtt_p90_us | 60 | 542.0 | 537.7 | -0.78 | [-2.67, +1.01] | [-2.34, +0.74] | 1.001 | 0.6479 | no material change |
| multi_rtt_p99_us | 60 | 908.8 | 895.7 | -1.45 | [-4.44, +1.69] | [-4.01, +1.17] | 0.980 | 0.2711 | no material change |
| multi_rtt_p999_us | 60 | 1341.8 | 1295.2 | -3.47 | [-10.65, +4.46] | [-9.59, +3.11] | 0.973 | 0.3536 | inconclusive |
| multi_rtt_max_us | 60 | 1638.1 | 1642.1 | +0.25 | [-7.14, +8.21] | [-6.06, +6.93] | 1.006 | 0.9442 | inconclusive |
| fanout_delivery_count | 60 | 40000.0 | 40000.0 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |
| fanout_delivery_elapsed_s | 60 | 0.2519 | 0.2460 | -2.33 | [-3.26, -1.45] | [-3.10, -1.58] | 0.984 | <0.0001 | no material change; repeatable change (-) |
| fanout_delivery_mean_us | 60 | 26518.2 | 27376.6 | +3.24 | [+1.84, +4.65] | [+2.03, +4.42] | 1.040 | <0.0001 | no material change; repeatable change (+) |
| fanout_delivery_p50_us | 60 | 27258.6 | 27871.2 | +2.25 | [+0.91, +3.65] | [+1.12, +3.42] | 1.019 | 0.0026 | no material change; repeatable change (+) |
| fanout_delivery_p90_us | 60 | 32755.0 | 32880.5 | +0.38 | [-0.90, +1.67] | [-0.71, +1.47] | 1.002 | 0.5758 | no material change |
| fanout_delivery_p99_us | 60 | 35316.7 | 36553.1 | +3.50 | [+1.37, +5.62] | [+1.72, +5.25] | 1.047 | 0.0018 | inconclusive; repeatable change (+) |
| fanout_delivery_p999_us | 60 | 38496.0 | 38349.3 | -0.38 | [-2.13, +1.28] | [-1.84, +1.02] | 0.996 | 0.8081 | no material change |
| fanout_delivery_max_us | 60 | 39226.9 | 38965.9 | -0.67 | [-2.39, +1.01] | [-2.11, +0.74] | 0.993 | 0.4572 | no material change |
| client_wall_s | 60 | 1.1317 | 1.1273 | -0.39 | [-0.90, +0.13] | [-0.82, +0.05] | 0.992 | 0.1313 | no material change |
| client_cpu_s | 60 | 0.9737 | 0.9689 | -0.50 | [-1.07, +0.08] | [-0.98, -0.02] | 0.994 | 0.0836 | no material change |
| broker_user_s | 60 | 0.3014 | 0.3027 | +0.44 | [-1.32, +2.17] | [-1.04, +1.92] | 1.022 | 0.4936 | no material change |
| broker_sys_s | 60 | 0.3079 | 0.3019 | -1.96 | [-3.75, -0.16] | [-3.45, -0.44] | 0.971 | 0.0646 | no material change; repeatable change (-) |
| broker_cpu_s | 60 | 0.6094 | 0.6046 | -0.78 | [-1.49, -0.05] | [-1.37, -0.18] | 0.991 | 0.0547 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 14001.4 | 14002.9 | +0.01 | [-0.35, +0.37] | [-0.29, +0.31] | 1.001 | 0.9121 | no material change |
| broker_maxrss_kib | 60 | 7087 | 7094 | +0.10 | [-0.48, +0.70] | [-0.39, +0.60] | 1.003 | 0.8771 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_rtt_count | 5000.0 | 5000.0 | +0.0 | [+0.0, +0.0] |
| single_rtt_elapsed_s | 0.3379 | 0.3382 | +0.0023 | [-0.0007, +0.0053] |
| single_rtt_mean_us | 66.2 | 66.2 | +0.5 | [-0.1, +1.1] |
| single_rtt_p50_us | 61.7 | 61.7 | +0.4 | [-0.3, +1.0] |
| single_rtt_p90_us | 77.2 | 77.2 | +0.9 | [-0.9, +2.7] |
| single_rtt_p99_us | 120.5 | 127.0 | +2.7 | [-1.2, +6.6] |
| single_rtt_p999_us | 198.3 | 210.2 | +12.9 | [-5.5, +31.4] |
| single_rtt_max_us | 365.1 | 503.4 | +67.4 | [-31.5, +166.4] |
| multi_rtt_count | 20000.0 | 20000.0 | +0.0 | [+0.0, +0.0] |
| multi_rtt_elapsed_s | 0.5046 | 0.5067 | +0.0002 | [-0.0036, +0.0040] |
| multi_rtt_mean_us | 499.4 | 502.0 | +0.3 | [-3.3, +4.0] |
| multi_rtt_p50_us | 485.6 | 488.6 | +1.2 | [-1.4, +3.7] |
| multi_rtt_p90_us | 528.9 | 528.9 | -4.2 | [-14.5, +6.0] |
| multi_rtt_p99_us | 914.8 | 916.6 | -13.1 | [-42.3, +16.0] |
| multi_rtt_p999_us | 1257.4 | 1202.2 | -46.6 | [-152.5, +59.3] |
| multi_rtt_max_us | 1464.0 | 1491.9 | +4.0 | [-125.4, +133.5] |
| fanout_delivery_count | 40000.0 | 40000.0 | +0.0 | [+0.0, +0.0] |
| fanout_delivery_elapsed_s | 0.2521 | 0.2456 | -0.0059 | [-0.0082, -0.0035] |
| fanout_delivery_mean_us | 26605.6 | 27491.0 | +858.5 | [+476.0, +1240.9] |
| fanout_delivery_p50_us | 27254.9 | 27595.0 | +612.6 | [+234.1, +991.1] |
| fanout_delivery_p90_us | 32721.3 | 32546.7 | +125.5 | [-306.7, +557.6] |
| fanout_delivery_p99_us | 35211.1 | 36987.3 | +1236.4 | [+487.9, +1984.8] |
| fanout_delivery_p999_us | 38235.8 | 38085.6 | -146.7 | [-816.0, +522.6] |
| fanout_delivery_max_us | 38939.2 | 38605.0 | -261.0 | [-949.6, +427.5] |
| client_wall_s | 1.1339 | 1.1296 | -0.0044 | [-0.0104, +0.0016] |
| client_cpu_s | 0.9741 | 0.9717 | -0.0049 | [-0.0106, +0.0009] |
| broker_user_s | 0.2988 | 0.3015 | +0.0013 | [-0.0042, +0.0068] |
| broker_sys_s | 0.3073 | 0.3028 | -0.0060 | [-0.0118, -0.0003] |
| broker_cpu_s | 0.6092 | 0.6029 | -0.0047 | [-0.0092, -0.0002] |
| broker_vcsw | 14008.0 | 14025.0 | +1.5 | [-50.2, +53.1] |
| broker_maxrss_kib | 7086 | 7084 | +7 | [-37, +51] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
