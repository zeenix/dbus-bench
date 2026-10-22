candidate concurrent100 against baseline baseline, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1513 | 0.1488 | -1.66 | [-4.31, +0.83] | [-3.84, +0.47] | 0.981 | 0.3498 | no material change |
| multi_s | 60 | 0.6643 | 0.6701 | +0.88 | [-1.92, +3.93] | [-1.51, +3.41] | 0.995 | 0.9296 | no material change |
| client_wall_s | 60 | 0.8206 | 0.8254 | +0.58 | [-1.78, +3.16] | [-1.41, +2.73] | 0.996 | 0.8024 | no material change |
| client_cpu_s | 60 | 0.7122 | 0.7160 | +0.53 | [-1.72, +2.87] | [-1.35, +2.52] | 1.005 | 0.8655 | no material change |
| client_vcsw | 60 | 4403.1 | 4486.4 | +1.89 | [-1.00, +5.08] | [-0.55, +4.58] | 1.031 | 0.2121 | no material change |
| multi_client_cpu_s | 60 | 0.6308 | 0.6330 | +0.34 | [-2.20, +3.03] | [-1.83, +2.61] | 0.986 | 0.8797 | no material change |
| multi_broker_cpu_s | 60 | 0.4788 | 0.4762 | -0.56 | [-3.07, +2.06] | [-2.65, +1.64] | 0.979 | 0.5906 | no material change |
| broker_user_s | 60 | 0.2806 | 0.2765 | -1.45 | [-5.80, +2.91] | [-5.09, +2.23] | 0.984 | 0.5171 | inconclusive |
| broker_sys_s | 60 | 0.2782 | 0.2799 | +0.62 | [-2.87, +4.25] | [-2.31, +3.62] | 1.010 | 0.8540 | no material change |
| broker_cpu_s | 60 | 0.5588 | 0.5564 | -0.42 | [-2.67, +1.93] | [-2.32, +1.53] | 0.989 | 0.4706 | no material change |
| broker_vcsw | 60 | 5162.9 | 5281.3 | +2.29 | [-1.95, +6.72] | [-1.29, +5.95] | 1.003 | 0.4483 | inconclusive |
| broker_maxrss_kib | 60 | 4807 | 4784 | -0.47 | [-0.99, +0.07] | [-0.92, -0.03] | 0.995 | 0.0786 | no material change |
| broker_ru_maxrss_kib | 60 | 18643 | 18646 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1466 | 0.1493 | -0.0025 | [-0.0066, +0.0016] |
| multi_s | 0.6585 | 0.6546 | +0.0058 | [-0.0142, +0.0259] |
| client_wall_s | 0.8154 | 0.8134 | +0.0048 | [-0.0161, +0.0257] |
| client_cpu_s | 0.6994 | 0.7001 | +0.0037 | [-0.0132, +0.0207] |
| client_vcsw | 4396.5 | 4358.5 | +83.2 | [-55.5, +222.0] |
| multi_client_cpu_s | 0.6200 | 0.6100 | +0.0022 | [-0.0149, +0.0192] |
| multi_broker_cpu_s | 0.4800 | 0.4600 | -0.0027 | [-0.0154, +0.0101] |
| broker_user_s | 0.2764 | 0.2672 | -0.0041 | [-0.0169, +0.0088] |
| broker_sys_s | 0.2761 | 0.2800 | +0.0017 | [-0.0086, +0.0120] |
| broker_cpu_s | 0.5535 | 0.5405 | -0.0023 | [-0.0157, +0.0110] |
| broker_vcsw | 5287.0 | 5494.5 | +118.4 | [-110.4, +347.2] |
| broker_maxrss_kib | 4814 | 4786 | -23 | [-49, +4] |
| broker_ru_maxrss_kib | 18684 | 18684 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
