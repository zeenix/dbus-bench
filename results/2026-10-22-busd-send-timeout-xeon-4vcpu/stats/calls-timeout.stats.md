candidate timeout against baseline baseline, from calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1638 | 0.1607 | -1.90 | [-5.65, +1.96] | [-5.10, +1.40] | 0.976 | 0.4706 | inconclusive |
| multi_s | 60 | 0.7211 | 0.7214 | +0.04 | [-4.02, +4.08] | [-3.38, +3.41] | 0.994 | 0.7740 | no material change |
| client_wall_s | 60 | 0.8907 | 0.8880 | -0.31 | [-3.88, +3.26] | [-3.32, +2.64] | 0.994 | 0.9648 | no material change |
| client_cpu_s | 60 | 0.7525 | 0.7553 | +0.36 | [-2.55, +3.31] | [-2.05, +2.82] | 1.005 | 0.7516 | no material change |
| client_vcsw | 60 | 4664.2 | 4768.4 | +2.23 | [-3.93, +8.85] | [-2.94, +7.78] | 1.011 | 0.4684 | inconclusive |
| multi_client_cpu_s | 60 | 0.6673 | 0.6687 | +0.20 | [-3.01, +3.47] | [-2.48, +2.94] | 1.015 | 0.8342 | no material change |
| multi_broker_cpu_s | 60 | 0.5130 | 0.5043 | -1.69 | [-5.88, +2.56] | [-5.22, +1.83] | 0.970 | 0.3538 | inconclusive |
| broker_user_s | 60 | 0.3220 | 0.3098 | -3.79 | [-7.69, +0.33] | [-7.11, -0.33] | 0.961 | 0.0366 | inconclusive |
| broker_sys_s | 60 | 0.2772 | 0.2782 | +0.36 | [-5.88, +6.95] | [-4.97, +5.83] | 1.010 | 0.7628 | inconclusive |
| broker_cpu_s | 60 | 0.5992 | 0.5880 | -1.87 | [-5.71, +2.01] | [-5.06, +1.40] | 0.981 | 0.2135 | inconclusive |
| broker_vcsw | 60 | 5159.1 | 5323.0 | +3.18 | [-0.15, +6.62] | [+0.33, +6.09] | 1.031 | 0.0595 | inconclusive |
| broker_maxrss_kib | 60 | 4904 | 4880 | -0.49 | [-1.08, +0.11] | [-0.99, +0.01] | 0.996 | 0.1186 | no material change |
| broker_ru_maxrss_kib | 60 | 18715 | 18715 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1564 | 0.1593 | -0.0031 | [-0.0098, +0.0035] |
| multi_s | 0.7043 | 0.7068 | +0.0003 | [-0.0297, +0.0304] |
| client_wall_s | 0.8711 | 0.8767 | -0.0027 | [-0.0355, +0.0300] |
| client_cpu_s | 0.7470 | 0.7406 | +0.0027 | [-0.0199, +0.0254] |
| client_vcsw | 4515.0 | 4515.5 | +104.2 | [-203.6, +412.0] |
| multi_client_cpu_s | 0.6600 | 0.6550 | +0.0013 | [-0.0210, +0.0236] |
| multi_broker_cpu_s | 0.4900 | 0.4900 | -0.0087 | [-0.0313, +0.0140] |
| broker_user_s | 0.3179 | 0.3046 | -0.0122 | [-0.0259, +0.0014] |
| broker_sys_s | 0.2653 | 0.2683 | +0.0010 | [-0.0176, +0.0196] |
| broker_cpu_s | 0.5761 | 0.5698 | -0.0112 | [-0.0355, +0.0131] |
| broker_vcsw | 5264.0 | 5384.5 | +163.9 | [-16.7, +344.5] |
| broker_maxrss_kib | 4904 | 4876 | -24 | [-54, +6] |
| broker_ru_maxrss_kib | 18668 | 18668 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
