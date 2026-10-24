candidate revert against baseline baseline, from signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5187 | 0.4259 | -17.89 | [-20.97, -14.60] | [-20.52, -15.17] | 0.786 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.5005 | 0.5101 | +1.91 | [-2.17, +6.24] | [-1.52, +5.51] | 0.990 | 0.8771 | inconclusive |
| client_wall_s | 60 | 1.0454 | 0.9489 | -9.23 | [-12.03, -6.16] | [-11.62, -6.69] | 0.890 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.8894 | 0.8826 | -0.77 | [-3.17, +1.70] | [-2.82, +1.34] | 0.977 | 0.2081 | no material change |
| client_vcsw | 60 | 241.0 | 152.8 | -36.59 | [-43.28, -29.35] | [-42.16, -30.48] | 0.592 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.4860 | 0.4908 | +0.99 | [-2.72, +4.80] | [-2.12, +4.21] | 0.991 | 0.7183 | no material change |
| multi_broker_cpu_s | 60 | 0.2225 | 0.2087 | -6.22 | [-10.98, -1.39] | [-10.18, -2.14] | 0.952 | 0.0055 | inconclusive; repeatable change (-) |
| broker_user_s | 60 | 0.3314 | 0.3356 | +1.30 | [-2.51, +5.50] | [-2.00, +4.88] | 0.980 | 0.9648 | no material change |
| broker_sys_s | 60 | 0.2813 | 0.2200 | -21.77 | [-25.25, -18.37] | [-24.65, -18.92] | 0.798 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.6126 | 0.5557 | -9.29 | [-11.74, -6.79] | [-11.34, -7.21] | 0.914 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1112.1 | 355.2 | -68.06 | [-70.99, -64.50] | [-70.62, -65.16] | 0.299 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 51375 | 4809 | -90.64 | [-90.86, -90.40] | [-90.83, -90.44] | 0.090 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 51297 | 18652 | -63.64 | [-64.53, -62.65] | [-64.39, -62.83] | 0.353 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5015 | 0.4148 | -0.0928 | [-0.1122, -0.0735] |
| multi_s | 0.4849 | 0.4963 | +0.0096 | [-0.0120, +0.0311] |
| client_wall_s | 1.0212 | 0.9196 | -0.0965 | [-0.1295, -0.0634] |
| client_cpu_s | 0.8843 | 0.8747 | -0.0069 | [-0.0297, +0.0160] |
| client_vcsw | 234.5 | 147.0 | -88.2 | [-111.3, -65.1] |
| multi_client_cpu_s | 0.4750 | 0.4800 | +0.0048 | [-0.0139, +0.0235] |
| multi_broker_cpu_s | 0.2100 | 0.2000 | -0.0138 | [-0.0252, -0.0025] |
| broker_user_s | 0.3285 | 0.3339 | +0.0043 | [-0.0095, +0.0181] |
| broker_sys_s | 0.2749 | 0.2175 | -0.0612 | [-0.0728, -0.0497] |
| broker_cpu_s | 0.5958 | 0.5499 | -0.0569 | [-0.0733, -0.0405] |
| broker_vcsw | 1125.5 | 329.0 | -756.9 | [-816.3, -697.4] |
| broker_maxrss_kib | 52876 | 4796 | -46566 | [-47904, -45228] |
| broker_ru_maxrss_kib | 52868 | 18652 | -32645 | [-33994, -31295] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
