candidate timeout against baseline revert, from calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1584 | 0.1607 | +1.46 | [-1.73, +4.89] | [-1.27, +4.31] | 1.019 | 0.3691 | no material change |
| multi_s | 60 | 0.7307 | 0.7214 | -1.27 | [-4.41, +1.92] | [-3.92, +1.41] | 0.993 | 0.5076 | no material change |
| client_wall_s | 60 | 0.8953 | 0.8880 | -0.82 | [-3.53, +1.98] | [-3.11, +1.51] | 0.997 | 0.6012 | no material change |
| client_cpu_s | 60 | 0.7652 | 0.7553 | -1.30 | [-3.94, +1.44] | [-3.51, +1.00] | 0.990 | 0.4374 | no material change |
| client_vcsw | 60 | 4598.3 | 4768.4 | +3.70 | [-3.41, +10.95] | [-2.22, +9.81] | 1.040 | 0.0194 | inconclusive |
| multi_client_cpu_s | 60 | 0.6790 | 0.6687 | -1.52 | [-4.46, +1.46] | [-3.96, +0.99] | 0.984 | 0.4402 | no material change |
| multi_broker_cpu_s | 60 | 0.4977 | 0.5043 | +1.34 | [-2.68, +5.39] | [-2.02, +4.76] | 1.020 | 0.3834 | no material change |
| broker_user_s | 60 | 0.3075 | 0.3098 | +0.76 | [-3.34, +5.23] | [-2.78, +4.46] | 0.990 | 0.7404 | no material change |
| broker_sys_s | 60 | 0.2729 | 0.2782 | +1.92 | [-4.17, +8.35] | [-3.22, +7.25] | 1.025 | 0.5363 | inconclusive |
| broker_cpu_s | 60 | 0.5804 | 0.5880 | +1.31 | [-2.38, +5.06] | [-1.74, +4.42] | 1.002 | 0.3731 | no material change |
| broker_vcsw | 60 | 5385.1 | 5323.0 | -1.15 | [-4.74, +2.50] | [-4.11, +1.92] | 0.976 | 0.3891 | no material change |
| broker_maxrss_kib | 60 | 4836 | 4880 | +0.92 | [+0.18, +1.63] | [+0.31, +1.52] | 1.009 | 0.0058 | no material change; repeatable change (+) |
| broker_ru_maxrss_kib | 60 | 18713 | 18715 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1540 | 0.1593 | +0.0023 | [-0.0031, +0.0077] |
| multi_s | 0.7068 | 0.7068 | -0.0093 | [-0.0337, +0.0151] |
| client_wall_s | 0.8711 | 0.8767 | -0.0074 | [-0.0333, +0.0186] |
| client_cpu_s | 0.7447 | 0.7406 | -0.0099 | [-0.0315, +0.0116] |
| client_vcsw | 4301.5 | 4515.5 | +170.1 | [-164.6, +504.8] |
| multi_client_cpu_s | 0.6600 | 0.6550 | -0.0103 | [-0.0314, +0.0107] |
| multi_broker_cpu_s | 0.4900 | 0.4900 | +0.0067 | [-0.0140, +0.0273] |
| broker_user_s | 0.3049 | 0.3046 | +0.0023 | [-0.0114, +0.0161] |
| broker_sys_s | 0.2724 | 0.2683 | +0.0052 | [-0.0122, +0.0227] |
| broker_cpu_s | 0.5693 | 0.5698 | +0.0076 | [-0.0145, +0.0296] |
| broker_vcsw | 5386.0 | 5384.5 | -62.2 | [-259.9, +135.5] |
| broker_maxrss_kib | 4836 | 4876 | +45 | [+9, +80] |
| broker_ru_maxrss_kib | 18668 | 18668 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
