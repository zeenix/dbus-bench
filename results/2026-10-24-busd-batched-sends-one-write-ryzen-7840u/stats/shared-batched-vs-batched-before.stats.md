candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.9748 | 1.9677 | -0.36 | [-1.42, +0.70] | [-1.27, +0.54] | 0.993 | 0.5542 | no material change |
| multi_s | 40 | 2.1643 | 2.1975 | +1.54 | [+0.44, +2.64] | [+0.61, +2.46] | 1.017 | 0.0061 | no material change; repeatable change (+) |
| client_wall_s | 40 | 4.1695 | 4.1959 | +0.63 | [-0.18, +1.41] | [-0.04, +1.29] | 1.004 | 0.0438 | no material change |
| client_cpu_s | 40 | 4.0045 | 4.0286 | +0.60 | [-0.18, +1.31] | [-0.03, +1.20] | 1.007 | 0.0150 | no material change |
| client_vcsw | 40 | 2050.1 | 2273.0 | +10.88 | [+0.59, +22.44] | [+1.96, +20.54] | 1.022 | 0.1746 | inconclusive; repeatable change (+) |
| multi_client_cpu_s | 40 | 2.1162 | 2.1440 | +1.31 | [+0.26, +2.35] | [+0.43, +2.19] | 1.017 | 0.0094 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.8445 | 1.8798 | +1.91 | [-0.09, +3.91] | [+0.22, +3.58] | 1.019 | 0.0153 | no material change |
| broker_user_s | 40 | 1.5519 | 1.5617 | +0.63 | [-0.71, +1.95] | [-0.50, +1.74] | 1.011 | 0.2944 | no material change |
| broker_sys_s | 40 | 1.7092 | 1.7187 | +0.56 | [-1.47, +2.63] | [-1.14, +2.29] | 1.009 | 0.5816 | no material change |
| broker_cpu_s | 40 | 3.2611 | 3.2804 | +0.59 | [-0.75, +1.92] | [-0.54, +1.71] | 1.002 | 0.3971 | no material change |
| broker_vcsw | 40 | 15387.5 | 15269.0 | -0.77 | [-3.16, +1.56] | [-2.78, +1.22] | 0.996 | 0.5578 | no material change |
| broker_maxrss_kib | 40 | 11447 | 11322 | -1.09 | [-2.56, +0.44] | [-2.33, +0.16] | 0.978 | 0.1923 | no material change |
| broker_ru_maxrss_kib | 40 | 20590 | 20590 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.9673 | 1.9499 | -0.0071 | [-0.0294, +0.0152] |
| multi_s | 2.1531 | 2.1820 | +0.0333 | [+0.0086, +0.0579] |
| client_wall_s | 4.1484 | 4.1769 | +0.0264 | [-0.0078, +0.0606] |
| client_cpu_s | 3.9742 | 4.0128 | +0.0241 | [-0.0063, +0.0546] |
| client_vcsw | 1949.5 | 2061.0 | +223.0 | [-13.5, +459.5] |
| multi_client_cpu_s | 2.1100 | 2.1300 | +0.0278 | [+0.0050, +0.0505] |
| multi_broker_cpu_s | 1.8100 | 1.8500 | +0.0353 | [-0.0033, +0.0738] |
| broker_user_s | 1.5444 | 1.5539 | +0.0098 | [-0.0117, +0.0313] |
| broker_sys_s | 1.7003 | 1.7139 | +0.0096 | [-0.0274, +0.0465] |
| broker_cpu_s | 3.2302 | 3.2547 | +0.0193 | [-0.0264, +0.0650] |
| broker_vcsw | 15490.5 | 15467.5 | -118.5 | [-502.0, +264.9] |
| broker_maxrss_kib | 11498 | 11236 | -125 | [-303, +54] |
| broker_ru_maxrss_kib | 20628 | 20628 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
