candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3961 | 0.3237 | -18.28 | [-19.04, -17.54] | [-18.92, -17.66] | 0.814 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3963 | 0.3909 | -1.38 | [-2.23, -0.47] | [-2.11, -0.62] | 0.983 | 0.0018 | no material change; repeatable change (-) |
| client_wall_s | 60 | 0.8513 | 0.7725 | -9.25 | [-9.90, -8.59] | [-9.80, -8.70] | 0.904 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.7218 | 0.7113 | -1.44 | [-2.09, -0.78] | [-1.98, -0.89] | 0.986 | <0.0001 | no material change; repeatable change (-) |
| client_vcsw | 60 | 217.3 | 125.6 | -42.21 | [-44.35, -40.13] | [-44.01, -40.48] | 0.590 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.3828 | 0.3783 | -1.18 | [-2.16, -0.22] | [-2.00, -0.35] | 1.000 | 0.0265 | no material change; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.1980 | 0.2100 | +6.06 | [+4.59, +7.59] | [+4.81, +7.36] | 1.050 | <0.0001 | inconclusive; repeatable change (+) |
| broker_user_s | 60 | 0.2747 | 0.2792 | +1.63 | [-0.37, +3.70] | [-0.06, +3.36] | 1.019 | 0.1491 | no material change |
| broker_sys_s | 60 | 0.2712 | 0.2529 | -6.75 | [-8.56, -4.84] | [-8.29, -5.15] | 0.912 | <0.0001 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.5460 | 0.5321 | -2.53 | [-3.18, -1.89] | [-3.08, -1.99] | 0.978 | <0.0001 | no material change; repeatable change (-) |
| broker_vcsw | 60 | 820.2 | 376.7 | -54.07 | [-55.84, -52.27] | [-55.55, -52.54] | 0.476 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 55214 | 6578 | -88.09 | [-88.17, -88.01] | [-88.15, -88.02] | 0.119 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54875 | 20529 | -62.59 | [-62.81, -62.36] | [-62.78, -62.39] | 0.375 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3948 | 0.3231 | -0.0724 | [-0.0758, -0.0690] |
| multi_s | 0.3948 | 0.3875 | -0.0055 | [-0.0091, -0.0018] |
| client_wall_s | 0.8493 | 0.7705 | -0.0788 | [-0.0848, -0.0727] |
| client_cpu_s | 0.7226 | 0.7076 | -0.0104 | [-0.0153, -0.0055] |
| client_vcsw | 217.0 | 129.5 | -91.7 | [-96.8, -86.6] |
| multi_client_cpu_s | 0.3800 | 0.3800 | -0.0045 | [-0.0084, -0.0006] |
| multi_broker_cpu_s | 0.2000 | 0.2100 | +0.0120 | [+0.0090, +0.0150] |
| broker_user_s | 0.2740 | 0.2808 | +0.0045 | [-0.0014, +0.0103] |
| broker_sys_s | 0.2714 | 0.2519 | -0.0183 | [-0.0237, -0.0129] |
| broker_cpu_s | 0.5450 | 0.5310 | -0.0138 | [-0.0175, -0.0101] |
| broker_vcsw | 777.0 | 375.0 | -443.5 | [-472.7, -414.3] |
| broker_maxrss_kib | 55330 | 6588 | -48636 | [-48966, -48306] |
| broker_ru_maxrss_kib | 54782 | 20572 | -34346 | [-34687, -34005] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
