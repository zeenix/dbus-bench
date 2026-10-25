candidate batched against baseline batched-before, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2239 | 0.2156 | -3.68 | [-4.22, -3.15] | [-4.14, -3.23] | 0.967 | <0.0001 | no material change; repeatable change (-) |
| multi_s | 60 | 0.1564 | 0.1381 | -11.68 | [-12.14, -11.23] | [-12.06, -11.30] | 0.884 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.4329 | 0.4077 | -5.84 | [-6.41, -5.28] | [-6.30, -5.38] | 0.940 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.1757 | 1.2006 | +2.12 | [+1.75, +2.50] | [+1.81, +2.44] | 1.019 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 60 | 9588.5 | 10121.2 | +5.56 | [+5.33, +5.78] | [+5.37, +5.74] | 1.056 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.7597 | 0.7743 | +1.93 | [+1.36, +2.49] | [+1.46, +2.41] | 1.026 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.1222 | 0.1068 | -12.55 | [-14.11, -10.93] | [-13.88, -11.19] | 0.846 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.2496 | 0.2372 | -4.97 | [-6.43, -3.56] | [-6.19, -3.80] | 0.949 | <0.0001 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.1542 | 0.1402 | -9.10 | [-11.02, -7.07] | [-10.71, -7.41] | 0.904 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.4038 | 0.3774 | -6.55 | [-6.88, -6.22] | [-6.82, -6.28] | 0.935 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 144.1 | 142.7 | -0.99 | [-5.80, +3.96] | [-5.03, +3.13] | 0.981 | 0.6752 | inconclusive |
| broker_maxrss_kib | 60 | 6402 | 6373 | -0.45 | [-1.31, +0.40] | [-1.18, +0.26] | 1.003 | 0.4034 | no material change |
| broker_ru_maxrss_kib | 60 | 20262 | 20259 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2232 | 0.2157 | -0.0082 | [-0.0095, -0.0070] |
| multi_s | 0.1553 | 0.1376 | -0.0183 | [-0.0191, -0.0174] |
| client_wall_s | 0.4308 | 0.4057 | -0.0253 | [-0.0278, -0.0227] |
| client_cpu_s | 1.1706 | 1.1986 | +0.0249 | [+0.0205, +0.0294] |
| client_vcsw | 9595.0 | 10121.5 | +532.7 | [+511.1, +554.3] |
| multi_client_cpu_s | 0.7600 | 0.7700 | +0.0147 | [+0.0102, +0.0191] |
| multi_broker_cpu_s | 0.1200 | 0.1100 | -0.0153 | [-0.0174, -0.0132] |
| broker_user_s | 0.2500 | 0.2372 | -0.0124 | [-0.0161, -0.0087] |
| broker_sys_s | 0.1537 | 0.1393 | -0.0140 | [-0.0173, -0.0108] |
| broker_cpu_s | 0.4036 | 0.3768 | -0.0264 | [-0.0278, -0.0251] |
| broker_vcsw | 144.0 | 140.0 | -1.4 | [-8.7, +5.9] |
| broker_maxrss_kib | 6412 | 6394 | -29 | [-85, +28] |
| broker_ru_maxrss_kib | 20268 | 20268 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
