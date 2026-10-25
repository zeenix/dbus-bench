candidate batched against baseline baseline, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.4153 | 3.3924 | -0.67 | [-2.73, +1.45] | [-2.40, +1.10] | 0.997 | 0.7267 | no material change |
| multi_s | 40 | 3.8547 | 3.8161 | -1.00 | [-4.27, +2.31] | [-3.74, +1.77] | 1.002 | 0.7067 | no material change |
| client_wall_s | 40 | 7.2765 | 7.2153 | -0.84 | [-2.83, +1.19] | [-2.50, +0.88] | 0.980 | 0.4846 | no material change |
| client_cpu_s | 40 | 6.7359 | 6.6771 | -0.87 | [-2.52, +0.88] | [-2.27, +0.60] | 0.989 | 0.3332 | no material change |
| client_vcsw | 40 | 9338.4 | 8680.6 | -7.04 | [-16.21, +3.48] | [-14.82, +1.71] | 0.884 | 0.2064 | inconclusive |
| multi_client_cpu_s | 40 | 3.5410 | 3.5290 | -0.34 | [-3.11, +2.43] | [-2.64, +2.00] | 1.016 | 0.9111 | no material change |
| multi_broker_cpu_s | 40 | 2.8725 | 2.8758 | +0.11 | [-3.32, +3.72] | [-2.75, +3.17] | 1.017 | 0.8877 | no material change |
| broker_user_s | 40 | 2.6937 | 2.6996 | +0.22 | [-1.53, +1.98] | [-1.25, +1.68] | 1.001 | 0.5816 | no material change |
| broker_sys_s | 40 | 2.3127 | 2.2825 | -1.30 | [-5.17, +2.96] | [-4.57, +2.28] | 0.980 | 0.3678 | no material change |
| broker_cpu_s | 40 | 5.0063 | 4.9822 | -0.48 | [-2.66, +1.85] | [-2.34, +1.47] | 0.991 | 0.6477 | no material change |
| broker_vcsw | 40 | 19247.6 | 18966.3 | -1.46 | [-3.37, +0.41] | [-3.07, +0.10] | 0.987 | 0.1601 | no material change |
| broker_maxrss_kib | 40 | 7086 | 7090 | +0.06 | [-1.41, +1.54] | [-1.18, +1.31] | 1.002 | 0.8350 | no material change |
| broker_ru_maxrss_kib | 40 | 18754 | 18754 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.4187 | 3.3471 | -0.0229 | [-0.0985, +0.0526] |
| multi_s | 3.8322 | 3.7686 | -0.0386 | [-0.1707, +0.0935] |
| client_wall_s | 7.2479 | 7.1474 | -0.0612 | [-0.2138, +0.0913] |
| client_cpu_s | 6.7028 | 6.6199 | -0.0588 | [-0.1779, +0.0603] |
| client_vcsw | 9331.0 | 8168.0 | -657.7 | [-1644.5, +329.1] |
| multi_client_cpu_s | 3.5050 | 3.5000 | -0.0120 | [-0.1145, +0.0905] |
| multi_broker_cpu_s | 2.8600 | 2.8150 | +0.0033 | [-0.1019, +0.1084] |
| broker_user_s | 2.6713 | 2.6899 | +0.0060 | [-0.0429, +0.0549] |
| broker_sys_s | 2.3395 | 2.2716 | -0.0301 | [-0.1280, +0.0677] |
| broker_cpu_s | 5.0193 | 4.8978 | -0.0242 | [-0.1414, +0.0931] |
| broker_vcsw | 19455.5 | 18978.5 | -281.3 | [-658.7, +96.1] |
| broker_maxrss_kib | 7112 | 7052 | +4 | [-105, +113] |
| broker_ru_maxrss_kib | 18744 | 18744 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
