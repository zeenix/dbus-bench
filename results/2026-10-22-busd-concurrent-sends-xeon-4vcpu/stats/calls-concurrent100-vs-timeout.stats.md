candidate concurrent100 against baseline timeout, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1485 | 0.1488 | +0.20 | [-2.06, +2.48] | [-1.69, +2.12] | 0.991 | 0.8946 | no material change |
| multi_s | 60 | 0.6833 | 0.6701 | -1.93 | [-4.49, +0.81] | [-4.10, +0.34] | 0.971 | 0.1351 | no material change |
| client_wall_s | 60 | 0.8369 | 0.8254 | -1.37 | [-3.48, +0.81] | [-3.12, +0.44] | 0.984 | 0.1851 | no material change |
| client_cpu_s | 60 | 0.7296 | 0.7160 | -1.87 | [-3.85, +0.18] | [-3.54, -0.15] | 0.990 | 0.1511 | no material change |
| client_vcsw | 60 | 4381.4 | 4486.4 | +2.40 | [-1.31, +6.66] | [-0.77, +5.96] | 1.033 | 0.3010 | inconclusive |
| multi_client_cpu_s | 60 | 0.6480 | 0.6330 | -2.31 | [-4.59, +0.10] | [-4.24, -0.29] | 0.984 | 0.1115 | no material change |
| multi_broker_cpu_s | 60 | 0.4790 | 0.4762 | -0.59 | [-2.87, +1.73] | [-2.50, +1.39] | 1.000 | 0.5312 | no material change |
| broker_user_s | 60 | 0.2756 | 0.2765 | +0.31 | [-3.39, +4.13] | [-2.82, +3.52] | 0.996 | 0.8195 | no material change |
| broker_sys_s | 60 | 0.2832 | 0.2799 | -1.16 | [-4.92, +2.70] | [-4.31, +2.09] | 1.005 | 0.5859 | no material change |
| broker_cpu_s | 60 | 0.5588 | 0.5564 | -0.43 | [-2.50, +1.73] | [-2.17, +1.39] | 0.991 | 0.4616 | no material change |
| broker_vcsw | 60 | 5326.7 | 5281.3 | -0.85 | [-4.38, +2.78] | [-3.82, +2.15] | 1.013 | 0.7656 | no material change |
| broker_maxrss_kib | 60 | 4792 | 4784 | -0.15 | [-0.82, +0.51] | [-0.72, +0.41] | 0.998 | 0.6774 | no material change |
| broker_ru_maxrss_kib | 60 | 18643 | 18646 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1478 | 0.1493 | +0.0003 | [-0.0032, +0.0038] |
| multi_s | 0.6737 | 0.6546 | -0.0132 | [-0.0320, +0.0056] |
| client_wall_s | 0.8261 | 0.8134 | -0.0115 | [-0.0299, +0.0070] |
| client_cpu_s | 0.7206 | 0.7001 | -0.0137 | [-0.0289, +0.0015] |
| client_vcsw | 4345.5 | 4358.5 | +105.0 | [-72.1, +282.0] |
| multi_client_cpu_s | 0.6400 | 0.6100 | -0.0150 | [-0.0308, +0.0008] |
| multi_broker_cpu_s | 0.4700 | 0.4600 | -0.0028 | [-0.0142, +0.0085] |
| broker_user_s | 0.2704 | 0.2672 | +0.0009 | [-0.0097, +0.0115] |
| broker_sys_s | 0.2765 | 0.2800 | -0.0033 | [-0.0145, +0.0079] |
| broker_cpu_s | 0.5542 | 0.5405 | -0.0024 | [-0.0146, +0.0097] |
| broker_vcsw | 5453.5 | 5494.5 | -45.4 | [-242.7, +151.9] |
| broker_maxrss_kib | 4792 | 4786 | -7 | [-41, +26] |
| broker_ru_maxrss_kib | 18684 | 18684 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
