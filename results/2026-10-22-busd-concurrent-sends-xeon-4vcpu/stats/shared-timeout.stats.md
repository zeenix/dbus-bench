candidate timeout against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 2.9322 | 3.2955 | +12.39 | [+9.83, +14.96] | [+10.23, +14.55] | 1.131 | <0.0001 | slower/larger |
| multi_s | 40 | 3.8875 | 3.7679 | -3.08 | [-5.55, -0.52] | [-5.16, -0.90] | 0.976 | 0.0360 | inconclusive; repeatable change (-) |
| client_wall_s | 40 | 6.8256 | 7.0694 | +3.57 | [+1.64, +5.56] | [+1.93, +5.24] | 1.040 | 0.0006 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 6.0799 | 6.4790 | +6.56 | [+5.16, +8.00] | [+5.39, +7.78] | 1.071 | <0.0001 | slower/larger |
| client_vcsw | 40 | 19939.2 | 10539.7 | -47.14 | [-52.30, -41.58] | [-51.50, -42.48] | 0.532 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.3952 | 3.4220 | +0.79 | [-0.80, +2.49] | [-0.55, +2.19] | 1.021 | 0.4508 | no material change |
| multi_broker_cpu_s | 40 | 3.2268 | 2.9740 | -7.83 | [-10.34, -5.28] | [-9.88, -5.72] | 0.919 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 2.6297 | 2.5246 | -4.00 | [-6.00, -1.90] | [-5.67, -2.26] | 0.956 | 0.0009 | inconclusive; repeatable change (-) |
| broker_sys_s | 40 | 2.6092 | 2.3937 | -8.26 | [-10.43, -6.03] | [-10.08, -6.41] | 0.915 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 5.2389 | 4.9183 | -6.12 | [-7.81, -4.33] | [-7.57, -4.64] | 0.931 | <0.0001 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 13737.7 | 18466.1 | +34.42 | [+30.79, +38.24] | [+31.40, +37.61] | 1.350 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7484 | 6997 | -6.50 | [-7.76, -5.19] | [-7.58, -5.40] | 0.939 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18703 | 18703 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 2.9326 | 3.2545 | +0.3633 | [+0.2905, +0.4362] |
| multi_s | 3.7945 | 3.7096 | -0.1196 | [-0.2245, -0.0148] |
| client_wall_s | 6.7691 | 7.0327 | +0.2438 | [+0.1070, +0.3805] |
| client_cpu_s | 6.0792 | 6.4900 | +0.3991 | [+0.3122, +0.4860] |
| client_vcsw | 19192.5 | 10375.5 | -9399.5 | [-10891.0, -7907.9] |
| multi_client_cpu_s | 3.4000 | 3.4150 | +0.0267 | [-0.0312, +0.0847] |
| multi_broker_cpu_s | 3.2100 | 2.9500 | -0.2528 | [-0.3393, -0.1662] |
| broker_user_s | 2.6319 | 2.4940 | -0.1051 | [-0.1620, -0.0482] |
| broker_sys_s | 2.5778 | 2.3990 | -0.2155 | [-0.2770, -0.1540] |
| broker_cpu_s | 5.1955 | 4.9055 | -0.3206 | [-0.4175, -0.2237] |
| broker_vcsw | 13725.5 | 18437.5 | +4728.4 | [+4289.8, +5167.0] |
| broker_maxrss_kib | 7446 | 6982 | -487 | [-592, -381] |
| broker_ru_maxrss_kib | 18700 | 18700 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
