candidate batched against baseline baseline, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2635 | 0.2156 | -18.15 | [-18.64, -17.67] | [-18.57, -17.74] | 0.820 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3953 | 0.1381 | -65.06 | [-65.22, -64.88] | [-65.20, -64.91] | 0.349 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.7113 | 0.4077 | -42.69 | [-43.00, -42.37] | [-42.95, -42.42] | 0.573 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 2.6183 | 1.2006 | -54.14 | [-54.28, -54.01] | [-54.26, -54.03] | 0.458 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 121136.0 | 10121.2 | -91.64 | [-91.66, -91.63] | [-91.66, -91.63] | 0.084 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 2.1820 | 0.7743 | -64.51 | [-64.69, -64.33] | [-64.66, -64.36] | 0.354 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.3647 | 0.1068 | -70.70 | [-71.15, -70.25] | [-71.09, -70.32] | 0.297 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.3264 | 0.2372 | -27.34 | [-28.63, -26.03] | [-28.43, -26.23] | 0.727 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3573 | 0.1402 | -60.76 | [-61.54, -59.94] | [-61.41, -60.08] | 0.392 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6837 | 0.3774 | -44.80 | [-45.00, -44.59] | [-44.97, -44.63] | 0.552 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 129.9 | 142.7 | +9.88 | [+4.67, +15.20] | [+5.51, +14.33] | 1.151 | 0.0010 | inconclusive; repeatable change (+) |
| broker_maxrss_kib | 60 | 6299 | 6373 | +1.18 | [+0.16, +2.20] | [+0.32, +2.05] | 1.009 | 0.0433 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 20262 | 20259 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2632 | 0.2157 | -0.0478 | [-0.0493, -0.0463] |
| multi_s | 0.3955 | 0.1376 | -0.2571 | [-0.2585, -0.2558] |
| client_wall_s | 0.7093 | 0.4057 | -0.3036 | [-0.3067, -0.3006] |
| client_cpu_s | 2.6177 | 1.1986 | -1.4177 | [-1.4234, -1.4119] |
| client_vcsw | 121136.0 | 10121.5 | -111014.8 | [-111033.9, -110995.7] |
| multi_client_cpu_s | 2.1800 | 0.7700 | -1.4077 | [-1.4140, -1.4013] |
| multi_broker_cpu_s | 0.3600 | 0.1100 | -0.2578 | [-0.2603, -0.2554] |
| broker_user_s | 0.3263 | 0.2372 | -0.0892 | [-0.0946, -0.0839] |
| broker_sys_s | 0.3558 | 0.1393 | -0.2171 | [-0.2219, -0.2122] |
| broker_cpu_s | 0.6834 | 0.3768 | -0.3063 | [-0.3083, -0.3043] |
| broker_vcsw | 125.5 | 140.0 | +12.8 | [+6.1, +19.6] |
| broker_maxrss_kib | 6288 | 6394 | +74 | [+9, +140] |
| broker_ru_maxrss_kib | 20268 | 20268 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
