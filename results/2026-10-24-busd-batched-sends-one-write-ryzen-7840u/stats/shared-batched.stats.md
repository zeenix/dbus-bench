candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 2.0129 | 1.9677 | -2.25 | [-3.11, -1.37] | [-2.97, -1.51] | 0.975 | <0.0001 | no material change; repeatable change (-) |
| multi_s | 40 | 2.1860 | 2.1975 | +0.53 | [-0.79, +1.68] | [-0.55, +1.51] | 1.013 | 0.0956 | no material change |
| client_wall_s | 40 | 4.2293 | 4.1959 | -0.79 | [-1.54, -0.11] | [-1.42, -0.20] | 0.993 | 0.0266 | no material change; repeatable change (-) |
| client_cpu_s | 40 | 4.0564 | 4.0286 | -0.69 | [-1.44, +0.01] | [-1.31, -0.10] | 0.995 | 0.0599 | no material change |
| client_vcsw | 40 | 2366.2 | 2273.0 | -3.94 | [-11.71, +5.79] | [-10.62, +3.93] | 0.922 | 0.0372 | inconclusive |
| multi_client_cpu_s | 40 | 2.1365 | 2.1440 | +0.35 | [-0.94, +1.49] | [-0.72, +1.32] | 1.010 | 0.1936 | no material change |
| multi_broker_cpu_s | 40 | 1.8313 | 1.8798 | +2.65 | [+0.95, +4.43] | [+1.20, +4.12] | 1.022 | 0.0021 | no material change; repeatable change (+) |
| broker_user_s | 40 | 1.5953 | 1.5617 | -2.11 | [-3.30, -0.93] | [-3.10, -1.11] | 0.984 | 0.0032 | no material change; repeatable change (-) |
| broker_sys_s | 40 | 1.7433 | 1.7187 | -1.41 | [-2.96, +0.25] | [-2.74, -0.02] | 0.991 | 0.0806 | no material change |
| broker_cpu_s | 40 | 3.3386 | 3.2804 | -1.74 | [-2.73, -0.68] | [-2.56, -0.87] | 0.976 | 0.0007 | no material change; repeatable change (-) |
| broker_vcsw | 40 | 15130.2 | 15269.0 | +0.92 | [-1.43, +3.08] | [-1.03, +2.76] | 1.023 | 0.0572 | no material change |
| broker_maxrss_kib | 40 | 11525 | 11322 | -1.76 | [-3.62, +0.10] | [-3.32, -0.21] | 0.988 | 0.0956 | no material change |
| broker_ru_maxrss_kib | 40 | 20586 | 20590 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 2.0061 | 1.9499 | -0.0452 | [-0.0634, -0.0270] |
| multi_s | 2.1674 | 2.1820 | +0.0115 | [-0.0166, +0.0397] |
| client_wall_s | 4.1962 | 4.1769 | -0.0333 | [-0.0651, -0.0015] |
| client_cpu_s | 4.0353 | 4.0128 | -0.0278 | [-0.0586, +0.0029] |
| client_vcsw | 2164.5 | 2061.0 | -93.2 | [-311.2, +124.9] |
| multi_client_cpu_s | 2.1200 | 2.1300 | +0.0075 | [-0.0195, +0.0345] |
| multi_broker_cpu_s | 1.8050 | 1.8500 | +0.0485 | [+0.0157, +0.0813] |
| broker_user_s | 1.5921 | 1.5539 | -0.0336 | [-0.0536, -0.0137] |
| broker_sys_s | 1.7126 | 1.7139 | -0.0246 | [-0.0542, +0.0050] |
| broker_cpu_s | 3.3114 | 3.2547 | -0.0582 | [-0.0940, -0.0224] |
| broker_vcsw | 15143.5 | 15467.5 | +138.8 | [-218.4, +496.0] |
| broker_maxrss_kib | 11490 | 11236 | -203 | [-426, +21] |
| broker_ru_maxrss_kib | 20628 | 20628 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
