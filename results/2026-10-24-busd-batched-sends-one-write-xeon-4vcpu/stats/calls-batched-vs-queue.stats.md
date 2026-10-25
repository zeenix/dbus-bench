candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2047 | 0.2084 | +1.80 | [-1.18, +4.93] | [-0.70, +4.42] | 0.999 | 0.3275 | no material change |
| multi_s | 60 | 0.8125 | 0.8082 | -0.53 | [-3.65, +2.82] | [-3.19, +2.28] | 0.982 | 0.5412 | no material change |
| client_wall_s | 60 | 1.0238 | 1.0231 | -0.07 | [-2.76, +2.81] | [-2.35, +2.33] | 0.992 | 0.6694 | no material change |
| client_cpu_s | 60 | 0.8645 | 0.8683 | +0.44 | [-2.13, +3.11] | [-1.75, +2.69] | 1.017 | 0.7797 | no material change |
| client_vcsw | 60 | 4928.6 | 5001.5 | +1.48 | [-4.35, +7.84] | [-3.44, +6.74] | 1.026 | 0.4138 | inconclusive |
| multi_client_cpu_s | 60 | 0.7578 | 0.7600 | +0.29 | [-2.55, +3.25] | [-2.12, +2.77] | 1.012 | 0.8621 | no material change |
| multi_broker_cpu_s | 60 | 0.5988 | 0.5923 | -1.09 | [-5.17, +3.47] | [-4.61, +2.66] | 0.992 | 0.3983 | no material change |
| broker_user_s | 60 | 0.3772 | 0.3634 | -3.65 | [-7.11, -0.12] | [-6.57, -0.70] | 0.956 | 0.0556 | inconclusive; repeatable change (-) |
| broker_sys_s | 60 | 0.3350 | 0.3435 | +2.55 | [-3.42, +9.34] | [-2.58, +8.08] | 1.001 | 0.5029 | inconclusive |
| broker_cpu_s | 60 | 0.7122 | 0.7069 | -0.74 | [-4.35, +3.26] | [-3.85, +2.60] | 1.003 | 0.5461 | no material change |
| broker_vcsw | 60 | 4970.1 | 5038.6 | +1.38 | [-2.42, +5.53] | [-1.87, +4.86] | 1.033 | 0.3633 | no material change |
| broker_maxrss_kib | 60 | 4924 | 4930 | +0.12 | [-0.52, +0.78] | [-0.42, +0.67] | 0.999 | 0.8003 | no material change |
| broker_ru_maxrss_kib | 60 | 19033 | 19029 | -0.02 | [-0.06, +0.00] | [-0.04, +0.00] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2043 | 0.2052 | +0.0037 | [-0.0027, +0.0100] |
| multi_s | 0.8030 | 0.7998 | -0.0043 | [-0.0316, +0.0231] |
| client_wall_s | 1.0116 | 1.0120 | -0.0007 | [-0.0302, +0.0288] |
| client_cpu_s | 0.8617 | 0.8635 | +0.0038 | [-0.0197, +0.0273] |
| client_vcsw | 4717.5 | 4916.5 | +72.9 | [-232.4, +378.2] |
| multi_client_cpu_s | 0.7500 | 0.7600 | +0.0022 | [-0.0206, +0.0250] |
| multi_broker_cpu_s | 0.6000 | 0.5850 | -0.0065 | [-0.0334, +0.0204] |
| broker_user_s | 0.3711 | 0.3593 | -0.0138 | [-0.0278, +0.0002] |
| broker_sys_s | 0.3221 | 0.3336 | +0.0085 | [-0.0132, +0.0303] |
| broker_cpu_s | 0.7053 | 0.7002 | -0.0052 | [-0.0336, +0.0231] |
| broker_vcsw | 5121.5 | 5131.0 | +68.6 | [-135.0, +272.2] |
| broker_maxrss_kib | 4908 | 4926 | +6 | [-27, +39] |
| broker_ru_maxrss_kib | 19016 | 19016 | -4 | [-10, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
