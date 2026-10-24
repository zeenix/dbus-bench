candidate timeout against baseline timeout-before, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 2.1689 | 2.0755 | -4.31 | [-5.61, -2.96] | [-5.40, -3.19] | 0.952 | <0.0001 | inconclusive; repeatable change (-) |
| multi_s | 40 | 2.5120 | 2.2574 | -10.13 | [-11.58, -8.63] | [-11.38, -8.87] | 0.893 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 4.7128 | 4.3648 | -7.38 | [-8.53, -6.25] | [-8.36, -6.43] | 0.926 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 4.3877 | 4.1745 | -4.86 | [-5.95, -3.76] | [-5.77, -3.93] | 0.950 | <0.0001 | inconclusive; repeatable change (-) |
| client_vcsw | 40 | 13813.5 | 2934.1 | -78.76 | [-80.71, -76.61] | [-80.42, -76.96] | 0.214 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 2.3775 | 2.2018 | -7.39 | [-8.80, -5.86] | [-8.59, -6.15] | 0.919 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 2.4915 | 1.9040 | -23.58 | [-25.08, -22.13] | [-24.83, -22.35] | 0.767 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 1.8118 | 1.6467 | -9.11 | [-10.52, -7.66] | [-10.31, -7.90] | 0.904 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 2.4725 | 1.8265 | -26.13 | [-27.30, -25.01] | [-27.10, -25.17] | 0.748 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 4.2842 | 3.4732 | -18.93 | [-19.99, -17.94] | [-19.82, -18.08] | 0.817 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 6818.6 | 14708.8 | +115.72 | [+110.54, +120.98] | [+111.34, +120.10] | 2.188 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 11275 | 11222 | -0.47 | [-2.46, +1.47] | [-2.14, +1.18] | 0.995 | 0.7167 | no material change |
| broker_ru_maxrss_kib | 40 | 20651 | 20651 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 2.1675 | 2.0627 | -0.0934 | [-0.1241, -0.0626] |
| multi_s | 2.5138 | 2.2360 | -0.2546 | [-0.2957, -0.2134] |
| client_wall_s | 4.6885 | 4.3299 | -0.3480 | [-0.4067, -0.2893] |
| client_cpu_s | 4.3746 | 4.1404 | -0.2132 | [-0.2652, -0.1612] |
| client_vcsw | 14168.0 | 2969.5 | -10879.4 | [-12024.9, -9734.0] |
| multi_client_cpu_s | 2.3700 | 2.1700 | -0.1758 | [-0.2132, -0.1383] |
| multi_broker_cpu_s | 2.5000 | 1.8800 | -0.5875 | [-0.6314, -0.5436] |
| broker_user_s | 1.7989 | 1.6313 | -0.1650 | [-0.1931, -0.1370] |
| broker_sys_s | 2.4727 | 1.8126 | -0.6459 | [-0.6821, -0.6098] |
| broker_cpu_s | 4.2704 | 3.4584 | -0.8110 | [-0.8636, -0.7584] |
| broker_vcsw | 6748.5 | 14927.5 | +7890.2 | [+7605.5, +8174.9] |
| broker_maxrss_kib | 11220 | 11196 | -53 | [-288, +182] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
