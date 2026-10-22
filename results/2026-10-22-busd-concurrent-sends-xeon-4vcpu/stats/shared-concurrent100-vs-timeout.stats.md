candidate concurrent100 against baseline timeout, from /tmp/claude-0/-home-user/9bf77134-b3af-5785-becd-76c8f58ff061/scratchpad/bench/out-concurrent/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.2955 | 3.2888 | -0.20 | [-2.57, +2.07] | [-2.18, +1.72] | 0.998 | 0.7984 | no material change |
| multi_s | 40 | 3.7679 | 3.7542 | -0.36 | [-2.95, +2.24] | [-2.54, +1.81] | 1.000 | 0.7675 | no material change |
| client_wall_s | 40 | 7.0694 | 7.0492 | -0.28 | [-2.32, +1.70] | [-2.00, +1.36] | 1.002 | 0.9786 | no material change |
| client_cpu_s | 40 | 6.4790 | 6.4743 | -0.07 | [-1.64, +1.47] | [-1.39, +1.24] | 1.004 | 0.8507 | no material change |
| client_vcsw | 40 | 10539.7 | 10262.7 | -2.63 | [-13.24, +9.78] | [-11.77, +7.56] | 0.937 | 0.6095 | inconclusive |
| multi_client_cpu_s | 40 | 3.4220 | 3.4300 | +0.23 | [-1.75, +2.24] | [-1.46, +1.94] | 0.994 | 0.8890 | no material change |
| multi_broker_cpu_s | 40 | 2.9740 | 2.9447 | -0.98 | [-3.86, +1.99] | [-3.41, +1.51] | 0.969 | 0.5363 | no material change |
| broker_user_s | 40 | 2.5246 | 2.5218 | -0.11 | [-2.56, +2.26] | [-2.15, +1.91] | 1.004 | 0.8193 | no material change |
| broker_sys_s | 40 | 2.3937 | 2.3555 | -1.60 | [-4.19, +1.10] | [-3.77, +0.65] | 0.982 | 0.3007 | no material change |
| broker_cpu_s | 40 | 4.9183 | 4.8773 | -0.83 | [-2.98, +1.33] | [-2.63, +0.95] | 0.986 | 0.4679 | no material change |
| broker_vcsw | 40 | 18466.1 | 18648.4 | +0.99 | [-0.86, +2.92] | [-0.57, +2.62] | 1.012 | 0.3332 | no material change |
| broker_maxrss_kib | 40 | 6997 | 7054 | +0.81 | [-0.59, +2.19] | [-0.37, +1.98] | 1.008 | 0.2672 | no material change |
| broker_ru_maxrss_kib | 40 | 18703 | 18700 | -0.02 | [-0.05, +0.00] | [-0.05, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.2545 | 3.2751 | -0.0067 | [-0.0858, +0.0725] |
| multi_s | 3.7096 | 3.7277 | -0.0137 | [-0.1164, +0.0890] |
| client_wall_s | 7.0327 | 7.0257 | -0.0201 | [-0.1679, +0.1276] |
| client_cpu_s | 6.4900 | 6.4436 | -0.0047 | [-0.1097, +0.1004] |
| client_vcsw | 10375.5 | 10515.0 | -277.0 | [-1568.9, +1014.9] |
| multi_client_cpu_s | 3.4150 | 3.4350 | +0.0080 | [-0.0636, +0.0796] |
| multi_broker_cpu_s | 2.9500 | 2.9350 | -0.0292 | [-0.1208, +0.0623] |
| broker_user_s | 2.4940 | 2.5116 | -0.0028 | [-0.0666, +0.0610] |
| broker_sys_s | 2.3990 | 2.3655 | -0.0382 | [-0.1048, +0.0284] |
| broker_cpu_s | 4.9055 | 4.8919 | -0.0410 | [-0.1513, +0.0693] |
| broker_vcsw | 18437.5 | 18653.0 | +182.3 | [-184.5, +549.1] |
| broker_maxrss_kib | 6982 | 7024 | +57 | [-44, +158] |
| broker_ru_maxrss_kib | 18700 | 18700 | -3 | [-10, +3] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
