candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8791 | 2.0774 | +10.56 | [+8.88, +12.03] | [+9.17, +11.82] | 1.107 | <0.0001 | slower/larger |
| multi_s | 40 | 2.2559 | 2.2495 | -0.28 | [-1.69, +1.18] | [-1.45, +0.92] | 0.987 | 0.6477 | no material change |
| client_wall_s | 40 | 4.1678 | 4.3598 | +4.61 | [+3.36, +5.81] | [+3.58, +5.61] | 1.045 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 4.0400 | 4.1674 | +3.15 | [+2.15, +4.18] | [+2.32, +4.01] | 1.034 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 2668.2 | 2871.6 | +7.62 | [-8.32, +26.68] | [-5.90, +23.50] | 1.098 | 0.1357 | inconclusive |
| multi_client_cpu_s | 40 | 2.1970 | 2.1957 | -0.06 | [-1.37, +1.31] | [-1.15, +1.09] | 0.995 | 0.9332 | no material change |
| multi_broker_cpu_s | 40 | 1.9672 | 1.8837 | -4.24 | [-6.25, -2.25] | [-5.92, -2.58] | 0.955 | 0.0008 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 1.6662 | 1.6426 | -1.42 | [-3.20, +0.37] | [-2.91, +0.09] | 0.978 | 0.1429 | no material change |
| broker_sys_s | 40 | 1.7570 | 1.8073 | +2.87 | [+0.84, +4.95] | [+1.17, +4.57] | 1.030 | 0.0091 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 3.4232 | 3.4500 | +0.78 | [-0.74, +2.25] | [-0.47, +2.03] | 1.009 | 0.1746 | no material change |
| broker_vcsw | 40 | 12132.6 | 14886.8 | +22.70 | [+16.90, +28.15] | [+17.88, +27.34] | 1.220 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11789 | 11361 | -3.63 | [-5.20, -2.06] | [-4.94, -2.31] | 0.962 | 0.0003 | no material change; repeatable change (-) |
| broker_ru_maxrss_kib | 40 | 20510 | 20510 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8636 | 2.0683 | +0.1984 | [+0.1696, +0.2272] |
| multi_s | 2.2476 | 2.2407 | -0.0064 | [-0.0401, +0.0273] |
| client_wall_s | 4.1592 | 4.3412 | +0.1920 | [+0.1402, +0.2437] |
| client_cpu_s | 4.0359 | 4.1478 | +0.1273 | [+0.0852, +0.1695] |
| client_vcsw | 2388.5 | 2812.0 | +203.4 | [-259.5, +666.3] |
| multi_client_cpu_s | 2.1900 | 2.1900 | -0.0012 | [-0.0319, +0.0294] |
| multi_broker_cpu_s | 1.9450 | 1.8850 | -0.0835 | [-0.1262, -0.0408] |
| broker_user_s | 1.6629 | 1.6272 | -0.0236 | [-0.0552, +0.0080] |
| broker_sys_s | 1.7411 | 1.7948 | +0.0504 | [+0.0137, +0.0870] |
| broker_cpu_s | 3.3995 | 3.4485 | +0.0268 | [-0.0269, +0.0804] |
| broker_vcsw | 12314.0 | 14919.5 | +2754.2 | [+2150.4, +3357.9] |
| broker_maxrss_kib | 11788 | 11322 | -428 | [-627, -230] |
| broker_ru_maxrss_kib | 20564 | 20564 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
