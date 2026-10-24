candidate timeout against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8977 | 2.0755 | +9.37 | [+8.30, +10.39] | [+8.48, +10.23] | 1.090 | <0.0001 | slower/larger |
| multi_s | 40 | 2.1672 | 2.2574 | +4.16 | [+2.37, +5.98] | [+2.66, +5.68] | 1.043 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 40 | 4.0967 | 4.3648 | +6.54 | [+5.33, +7.81] | [+5.52, +7.58] | 1.066 | <0.0001 | slower/larger |
| client_cpu_s | 40 | 4.0536 | 4.1745 | +2.98 | [+1.84, +4.19] | [+2.02, +3.97] | 1.031 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 455.9 | 2934.1 | +543.55 | [+467.21, +630.55] | [+479.82, +615.92] | 6.427 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.1515 | 2.2018 | +2.34 | [+0.59, +4.11] | [+0.87, +3.83] | 1.019 | 0.0052 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.5270 | 1.9040 | +24.69 | [+22.39, +26.95] | [+22.77, +26.57] | 1.252 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9547 | 1.6467 | +72.48 | [+69.90, +75.25] | [+70.33, +74.78] | 1.725 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.7571 | 1.8265 | +3.95 | [+2.60, +5.28] | [+2.83, +5.06] | 1.052 | <0.0001 | inconclusive; repeatable change (+) |
| broker_cpu_s | 40 | 2.7118 | 3.4732 | +28.08 | [+26.63, +29.54] | [+26.86, +29.30] | 1.283 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 106739.6 | 14708.8 | -86.22 | [-86.61, -85.81] | [-86.55, -85.88] | 0.138 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9340 | 11222 | +20.16 | [+18.12, +22.23] | [+18.45, +21.89] | 1.201 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20651 | 20651 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8849 | 2.0627 | +0.1778 | [+0.1576, +0.1980] |
| multi_s | 2.1475 | 2.2360 | +0.0902 | [+0.0500, +0.1305] |
| client_wall_s | 4.0705 | 4.3299 | +0.2681 | [+0.2170, +0.3192] |
| client_cpu_s | 4.0275 | 4.1404 | +0.1209 | [+0.0721, +0.1698] |
| client_vcsw | 436.0 | 2969.5 | +2478.2 | [+2274.8, +2681.6] |
| multi_client_cpu_s | 2.1350 | 2.1700 | +0.0502 | [+0.0109, +0.0896] |
| multi_broker_cpu_s | 1.5150 | 1.8800 | +0.3770 | [+0.3424, +0.4116] |
| broker_user_s | 0.9481 | 1.6313 | +0.6920 | [+0.6689, +0.7151] |
| broker_sys_s | 1.7502 | 1.8126 | +0.0695 | [+0.0453, +0.0936] |
| broker_cpu_s | 2.7085 | 3.4584 | +0.7615 | [+0.7234, +0.7996] |
| broker_vcsw | 106893.0 | 14927.5 | -92030.8 | [-94428.8, -89632.7] |
| broker_maxrss_kib | 9370 | 11196 | +1883 | [+1688, +2078] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
