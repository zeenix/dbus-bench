candidate revert against baseline baseline, from shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.1583 | 3.4950 | +10.66 | [+7.05, +14.48] | [+7.61, +13.87] | 1.088 | <0.0001 | slower/larger |
| multi_s | 40 | 4.3565 | 4.2838 | -1.67 | [-5.10, +1.95] | [-4.58, +1.36] | 1.000 | 0.3070 | no material change |
| client_wall_s | 40 | 7.5214 | 7.7853 | +3.51 | [+0.63, +6.62] | [+1.05, +6.11] | 1.021 | 0.0617 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 6.5868 | 7.0082 | +6.40 | [+4.15, +8.85] | [+4.49, +8.46] | 1.063 | <0.0001 | inconclusive; repeatable change (+) |
| client_vcsw | 40 | 25082.6 | 14752.5 | -41.18 | [-47.23, -34.44] | [-46.30, -35.67] | 0.611 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 3.7230 | 3.7830 | +1.61 | [-1.11, +4.63] | [-0.70, +4.09] | 1.011 | 0.3933 | no material change |
| multi_broker_cpu_s | 40 | 3.5767 | 3.3325 | -6.83 | [-10.58, -2.91] | [-9.99, -3.55] | 0.939 | 0.0030 | inconclusive; repeatable change (-) |
| broker_user_s | 40 | 2.9613 | 2.7765 | -6.24 | [-9.26, -3.10] | [-8.76, -3.57] | 0.929 | 0.0013 | inconclusive; repeatable change (-) |
| broker_sys_s | 40 | 2.7973 | 2.6252 | -6.15 | [-9.84, -2.36] | [-9.26, -2.96] | 0.963 | 0.0061 | inconclusive; repeatable change (-) |
| broker_cpu_s | 40 | 5.7586 | 5.4017 | -6.20 | [-9.25, -3.01] | [-8.78, -3.51] | 0.933 | 0.0016 | inconclusive; repeatable change (-) |
| broker_vcsw | 40 | 14301.0 | 18609.8 | +30.13 | [+24.49, +35.94] | [+25.36, +35.00] | 1.334 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 7520 | 7015 | -6.72 | [-8.04, -5.43] | [-7.83, -5.61] | 0.933 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18722 | 18725 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.1297 | 3.5217 | +0.3368 | [+0.2209, +0.4526] |
| multi_s | 4.3602 | 4.2667 | -0.0727 | [-0.2352, +0.0898] |
| client_wall_s | 7.5399 | 7.7359 | +0.2639 | [+0.0310, +0.4969] |
| client_cpu_s | 6.5395 | 6.9477 | +0.4214 | [+0.2633, +0.5795] |
| client_vcsw | 24642.0 | 16307.0 | -10330.0 | [-12491.8, -8168.2] |
| multi_client_cpu_s | 3.6950 | 3.7350 | +0.0600 | [-0.0500, +0.1700] |
| multi_broker_cpu_s | 3.6600 | 3.4150 | -0.2442 | [-0.3915, -0.0970] |
| broker_user_s | 2.9722 | 2.8012 | -0.1848 | [-0.2825, -0.0870] |
| broker_sys_s | 2.8021 | 2.6659 | -0.1722 | [-0.2836, -0.0608] |
| broker_cpu_s | 5.8224 | 5.4661 | -0.3569 | [-0.5485, -0.1654] |
| broker_vcsw | 14013.5 | 18737.5 | +4308.8 | [+3578.8, +5038.7] |
| broker_maxrss_kib | 7542 | 6984 | -505 | [-611, -400] |
| broker_ru_maxrss_kib | 18712 | 18712 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
