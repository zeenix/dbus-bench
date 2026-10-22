candidate timeout against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1513 | 0.1485 | -1.85 | [-5.05, +0.95] | [-4.43, +0.58] | 0.998 | 0.4309 | no material change |
| multi_s | 60 | 0.6643 | 0.6833 | +2.86 | [+0.12, +5.81] | [+0.57, +5.32] | 1.042 | 0.0520 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 0.8206 | 0.8369 | +1.98 | [-0.23, +4.36] | [+0.10, +3.95] | 1.029 | 0.0904 | no material change |
| client_cpu_s | 60 | 0.7122 | 0.7296 | +2.45 | [+0.30, +4.75] | [+0.61, +4.33] | 1.024 | 0.0502 | no material change; repeatable change (+) |
| client_vcsw | 60 | 4403.1 | 4381.4 | -0.49 | [-2.93, +1.99] | [-2.51, +1.60] | 0.986 | 0.4013 | no material change |
| multi_client_cpu_s | 60 | 0.6308 | 0.6480 | +2.72 | [+0.21, +5.40] | [+0.57, +4.93] | 1.031 | 0.0614 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.4788 | 0.4790 | +0.03 | [-2.07, +2.34] | [-1.75, +1.96] | 1.000 | 0.6041 | no material change |
| broker_user_s | 60 | 0.2806 | 0.2756 | -1.76 | [-5.60, +2.31] | [-5.04, +1.66] | 0.952 | 0.3575 | inconclusive |
| broker_sys_s | 60 | 0.2782 | 0.2832 | +1.80 | [-1.78, +5.37] | [-1.17, +4.79] | 1.030 | 0.1085 | no material change |
| broker_cpu_s | 60 | 0.5588 | 0.5588 | +0.01 | [-1.80, +1.99] | [-1.52, +1.64] | 0.997 | 0.5961 | no material change |
| broker_vcsw | 60 | 5162.9 | 5326.7 | +3.17 | [-0.54, +7.03] | [+0.01, +6.39] | 1.033 | 0.0947 | inconclusive |
| broker_maxrss_kib | 60 | 4807 | 4792 | -0.32 | [-0.99, +0.33] | [-0.87, +0.23] | 0.998 | 0.5562 | no material change |
| broker_ru_maxrss_kib | 60 | 18643 | 18643 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1466 | 0.1478 | -0.0028 | [-0.0076, +0.0020] |
| multi_s | 0.6585 | 0.6737 | +0.0190 | [-0.0003, +0.0383] |
| client_wall_s | 0.8154 | 0.8261 | +0.0163 | [-0.0029, +0.0354] |
| client_cpu_s | 0.6994 | 0.7206 | +0.0174 | [+0.0014, +0.0335] |
| client_vcsw | 4396.5 | 4345.5 | -21.7 | [-133.2, +89.8] |
| multi_client_cpu_s | 0.6200 | 0.6400 | +0.0172 | [+0.0006, +0.0338] |
| multi_broker_cpu_s | 0.4800 | 0.4700 | +0.0002 | [-0.0107, +0.0110] |
| broker_user_s | 0.2764 | 0.2704 | -0.0049 | [-0.0165, +0.0067] |
| broker_sys_s | 0.2761 | 0.2765 | +0.0050 | [-0.0051, +0.0151] |
| broker_cpu_s | 0.5535 | 0.5542 | +0.0001 | [-0.0107, +0.0109] |
| broker_vcsw | 5287.0 | 5453.5 | +163.8 | [-33.4, +361.0] |
| broker_maxrss_kib | 4814 | 4792 | -15 | [-48, +18] |
| broker_ru_maxrss_kib | 18684 | 18684 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
