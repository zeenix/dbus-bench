candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8583 | 0.2985 | -65.22 | [-65.40, -65.04] | [-65.37, -65.07] | 0.347 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2069 | 0.3581 | -70.33 | [-70.51, -70.15] | [-70.48, -70.18] | 0.295 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1003 | 0.7164 | -65.89 | [-66.09, -65.70] | [-66.06, -65.73] | 0.341 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2460 | 0.6608 | -46.97 | [-47.24, -46.69] | [-47.19, -46.74] | 0.530 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 18039.8 | 41.3 | -99.77 | [-99.78, -99.76] | [-99.78, -99.76] | 0.002 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5478 | 0.3430 | -37.39 | [-38.01, -36.76] | [-37.91, -36.85] | 0.630 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1800 | 0.1042 | -91.17 | [-91.30, -91.04] | [-91.28, -91.06] | 0.085 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6895 | 0.2287 | -66.83 | [-67.29, -66.36] | [-67.22, -66.44] | 0.331 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3862 | 0.1430 | -89.68 | [-89.87, -89.49] | [-89.84, -89.52] | 0.102 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0757 | 0.3717 | -82.09 | [-82.18, -82.00] | [-82.17, -82.01] | 0.179 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 16.233 | 628.117 | +3769.30 | [+3511.20, +4003.28] | [+3554.72, +3972.58] | 40.652 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5658 | 6623 | +17.06 | [+16.17, +18.00] | [+16.31, +17.85] | 1.166 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20468 | 20472 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8559 | 0.2973 | -0.5598 | [-0.5629, -0.5566] |
| multi_s | 1.2023 | 0.3560 | -0.8488 | [-0.8524, -0.8453] |
| client_wall_s | 2.0952 | 0.7159 | -1.3840 | [-1.3902, -1.3777] |
| client_cpu_s | 1.2430 | 0.6587 | -0.5852 | [-0.5900, -0.5805] |
| client_vcsw | 18049.5 | 41.0 | -17998.5 | [-18110.5, -17886.4] |
| multi_client_cpu_s | 0.5500 | 0.3400 | -0.2048 | [-0.2093, -0.2004] |
| multi_broker_cpu_s | 1.1800 | 0.1000 | -1.0758 | [-1.0792, -1.0725] |
| broker_user_s | 0.6911 | 0.2288 | -0.4608 | [-0.4676, -0.4541] |
| broker_sys_s | 1.3864 | 0.1416 | -1.2432 | [-1.2502, -1.2362] |
| broker_cpu_s | 2.0719 | 0.3706 | -1.7040 | [-1.7096, -1.6984] |
| broker_vcsw | 15.000 | 622.500 | +611.883 | [+600.903, +622.864] |
| broker_maxrss_kib | 5664 | 6628 | +965 | [+916, +1014] |
| broker_ru_maxrss_kib | 20500 | 20500 | +4 | [-2, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
