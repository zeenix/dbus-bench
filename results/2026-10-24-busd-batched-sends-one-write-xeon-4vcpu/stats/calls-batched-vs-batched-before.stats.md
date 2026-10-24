candidate batched against baseline batched-before, from $WORK/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.2080 | 0.2084 | +0.22 | [-2.70, +3.26] | [-2.23, +2.75] | 0.995 | 1.0000 | no material change |
| multi_s | 60 | 0.8186 | 0.8082 | -1.27 | [-4.63, +2.01] | [-4.10, +1.50] | 0.996 | 0.6910 | no material change |
| client_wall_s | 60 | 1.0332 | 1.0231 | -0.98 | [-3.81, +1.73] | [-3.35, +1.34] | 1.001 | 0.7183 | no material change |
| client_cpu_s | 60 | 0.8800 | 0.8683 | -1.33 | [-4.42, +1.63] | [-3.92, +1.23] | 0.984 | 0.6167 | no material change |
| client_vcsw | 60 | 4957.2 | 5001.5 | +0.89 | [-3.60, +5.98] | [-2.93, +5.06] | 1.014 | 0.8859 | inconclusive |
| multi_client_cpu_s | 60 | 0.7688 | 0.7600 | -1.15 | [-4.68, +2.26] | [-4.09, +1.77] | 1.000 | 0.8404 | no material change |
| multi_broker_cpu_s | 60 | 0.5885 | 0.5923 | +0.65 | [-2.46, +3.96] | [-2.00, +3.42] | 1.009 | 0.8041 | no material change |
| broker_user_s | 60 | 0.3763 | 0.3634 | -3.41 | [-6.90, +0.18] | [-6.40, -0.41] | 0.967 | 0.0850 | inconclusive |
| broker_sys_s | 60 | 0.3246 | 0.3435 | +5.81 | [+0.76, +11.30] | [+1.55, +10.42] | 1.048 | 0.0713 | inconclusive; repeatable change (+) |
| broker_cpu_s | 60 | 0.7009 | 0.7069 | +0.86 | [-1.94, +3.77] | [-1.49, +3.32] | 1.007 | 0.6063 | no material change |
| broker_vcsw | 60 | 5093.1 | 5038.6 | -1.07 | [-5.05, +3.06] | [-4.41, +2.35] | 0.991 | 0.8024 | no material change |
| broker_maxrss_kib | 60 | 4962 | 4930 | -0.66 | [-1.34, +0.06] | [-1.24, -0.05] | 0.992 | 0.0510 | no material change |
| broker_ru_maxrss_kib | 60 | 19031 | 19029 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.2073 | 0.2052 | +0.0004 | [-0.0059, +0.0067] |
| multi_s | 0.8114 | 0.7998 | -0.0104 | [-0.0391, +0.0183] |
| client_wall_s | 1.0241 | 1.0120 | -0.0101 | [-0.0404, +0.0202] |
| client_cpu_s | 0.8713 | 0.8635 | -0.0117 | [-0.0400, +0.0166] |
| client_vcsw | 4767.0 | 4916.5 | +44.3 | [-203.1, +291.7] |
| multi_client_cpu_s | 0.7600 | 0.7600 | -0.0088 | [-0.0370, +0.0193] |
| multi_broker_cpu_s | 0.5800 | 0.5850 | +0.0038 | [-0.0161, +0.0237] |
| broker_user_s | 0.3680 | 0.3593 | -0.0128 | [-0.0272, +0.0015] |
| broker_sys_s | 0.3210 | 0.3336 | +0.0189 | [+0.0011, +0.0366] |
| broker_cpu_s | 0.6973 | 0.7002 | +0.0060 | [-0.0149, +0.0270] |
| broker_vcsw | 5184.0 | 5131.0 | -54.4 | [-270.0, +161.2] |
| broker_maxrss_kib | 4966 | 4926 | -33 | [-69, +4] |
| broker_ru_maxrss_kib | 19016 | 19016 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
