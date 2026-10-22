candidate timeout against baseline revert, from shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.4950 | 3.5614 | +1.90 | [-0.73, +4.57] | [-0.31, +4.17] | 1.025 | 0.1923 | no material change |
| multi_s | 40 | 4.2838 | 4.2156 | -1.59 | [-4.95, +1.67] | [-4.35, +1.13] | 0.995 | 0.5633 | no material change |
| client_wall_s | 40 | 7.7853 | 7.7835 | -0.02 | [-2.14, +2.00] | [-1.77, +1.67] | 1.007 | 0.8613 | no material change |
| client_cpu_s | 40 | 7.0082 | 6.9515 | -0.81 | [-2.66, +1.05] | [-2.36, +0.76] | 0.994 | 0.4046 | no material change |
| client_vcsw | 40 | 14752.5 | 15365.0 | +4.15 | [-8.11, +17.09] | [-6.29, +14.99] | 1.097 | 0.3897 | inconclusive |
| multi_client_cpu_s | 40 | 3.7830 | 3.6950 | -2.33 | [-4.89, +0.20] | [-4.50, -0.19] | 0.978 | 0.1131 | no material change |
| multi_broker_cpu_s | 40 | 3.3325 | 3.3535 | +0.63 | [-2.96, +4.28] | [-2.39, +3.70] | 1.016 | 0.6653 | no material change |
| broker_user_s | 40 | 2.7765 | 2.8364 | +2.15 | [-0.19, +4.49] | [+0.21, +4.13] | 1.022 | 0.1158 | no material change |
| broker_sys_s | 40 | 2.6252 | 2.6448 | +0.75 | [-2.30, +3.80] | [-1.81, +3.31] | 1.005 | 0.5276 | no material change |
| broker_cpu_s | 40 | 5.4017 | 5.4812 | +1.47 | [-0.85, +3.84] | [-0.49, +3.43] | 1.014 | 0.2704 | no material change |
| broker_vcsw | 40 | 18609.8 | 17758.6 | -4.57 | [-7.06, -1.82] | [-6.69, -2.30] | 0.948 | 0.0011 | inconclusive; repeatable change (-) |
| broker_maxrss_kib | 40 | 7015 | 7054 | +0.55 | [-0.95, +2.14] | [-0.73, +1.85] | 1.008 | 0.5275 | no material change |
| broker_ru_maxrss_kib | 40 | 18725 | 18722 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.5217 | 3.5321 | +0.0664 | [-0.0296, +0.1625] |
| multi_s | 4.2667 | 4.2020 | -0.0682 | [-0.2167, +0.0803] |
| client_wall_s | 7.7359 | 7.6928 | -0.0018 | [-0.1703, +0.1668] |
| client_cpu_s | 6.9477 | 6.9318 | -0.0567 | [-0.1956, +0.0822] |
| client_vcsw | 16307.0 | 14266.0 | +612.5 | [-1298.5, +2523.5] |
| multi_client_cpu_s | 3.7350 | 3.6650 | -0.0880 | [-0.1912, +0.0152] |
| multi_broker_cpu_s | 3.4150 | 3.3300 | +0.0210 | [-0.1031, +0.1451] |
| broker_user_s | 2.8012 | 2.8089 | +0.0598 | [-0.0068, +0.1264] |
| broker_sys_s | 2.6659 | 2.6062 | +0.0197 | [-0.0632, +0.1026] |
| broker_cpu_s | 5.4661 | 5.4894 | +0.0795 | [-0.0505, +0.2095] |
| broker_vcsw | 18737.5 | 17634.0 | -851.1 | [-1371.2, -331.1] |
| broker_maxrss_kib | 6984 | 7008 | +39 | [-73, +151] |
| broker_ru_maxrss_kib | 18712 | 18712 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
