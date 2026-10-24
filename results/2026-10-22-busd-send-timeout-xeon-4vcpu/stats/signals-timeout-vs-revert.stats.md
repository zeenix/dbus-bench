candidate timeout against baseline revert, from signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4259 | 0.4174 | -1.98 | [-6.15, +2.44] | [-5.46, +1.74] | 0.971 | 0.2727 | inconclusive |
| multi_s | 60 | 0.5101 | 0.4954 | -2.87 | [-7.08, +1.33] | [-6.38, +0.70] | 1.000 | 0.3972 | inconclusive |
| client_wall_s | 60 | 0.9489 | 0.9255 | -2.47 | [-5.69, +0.88] | [-5.12, +0.35] | 0.987 | 0.2389 | inconclusive |
| client_cpu_s | 60 | 0.8826 | 0.8616 | -2.38 | [-4.85, +0.20] | [-4.46, -0.19] | 0.992 | 0.1152 | no material change |
| client_vcsw | 60 | 152.8 | 184.3 | +20.63 | [+6.80, +35.78] | [+8.90, +33.32] | 1.231 | 0.0056 | slower/larger |
| multi_client_cpu_s | 60 | 0.4908 | 0.4802 | -2.17 | [-5.51, +1.23] | [-5.00, +0.71] | 1.000 | 0.3962 | inconclusive |
| multi_broker_cpu_s | 60 | 0.2087 | 0.2110 | +1.12 | [-2.99, +5.43] | [-2.36, +4.75] | 1.000 | 0.5399 | no material change |
| broker_user_s | 60 | 0.3356 | 0.3371 | +0.43 | [-3.60, +4.54] | [-2.90, +3.88] | 1.005 | 0.6694 | no material change |
| broker_sys_s | 60 | 0.2200 | 0.2271 | +3.22 | [-0.63, +7.25] | [+0.04, +6.62] | 1.059 | 0.0962 | inconclusive |
| broker_cpu_s | 60 | 0.5557 | 0.5642 | +1.53 | [-1.15, +4.17] | [-0.69, +3.77] | 1.038 | 0.0511 | no material change |
| broker_vcsw | 60 | 355.2 | 309.0 | -13.01 | [-21.95, -3.61] | [-20.46, -4.99] | 0.899 | 0.0054 | inconclusive; repeatable change (-) |
| broker_maxrss_kib | 60 | 4809 | 4827 | +0.37 | [-0.25, +0.99] | [-0.14, +0.90] | 1.004 | 0.2975 | no material change |
| broker_ru_maxrss_kib | 60 | 18652 | 18652 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.4148 | 0.4086 | -0.0084 | [-0.0274, +0.0105] |
| multi_s | 0.4963 | 0.4870 | -0.0147 | [-0.0373, +0.0079] |
| client_wall_s | 0.9196 | 0.9015 | -0.0234 | [-0.0557, +0.0089] |
| client_cpu_s | 0.8747 | 0.8524 | -0.0210 | [-0.0444, +0.0024] |
| client_vcsw | 147.0 | 160.0 | +31.5 | [+9.9, +53.1] |
| multi_client_cpu_s | 0.4800 | 0.4700 | -0.0107 | [-0.0280, +0.0067] |
| multi_broker_cpu_s | 0.2000 | 0.2100 | +0.0023 | [-0.0067, +0.0114] |
| broker_user_s | 0.3339 | 0.3331 | +0.0015 | [-0.0125, +0.0154] |
| broker_sys_s | 0.2175 | 0.2268 | +0.0071 | [-0.0016, +0.0157] |
| broker_cpu_s | 0.5499 | 0.5604 | +0.0085 | [-0.0066, +0.0236] |
| broker_vcsw | 329.0 | 309.0 | -46.2 | [-83.2, -9.2] |
| broker_maxrss_kib | 4796 | 4838 | +18 | [-12, +48] |
| broker_ru_maxrss_kib | 18652 | 18652 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
