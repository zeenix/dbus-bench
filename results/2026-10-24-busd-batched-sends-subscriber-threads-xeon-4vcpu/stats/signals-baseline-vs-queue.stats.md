candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4998 | 0.3795 | -24.07 | [-26.75, -21.31] | [-26.33, -21.72] | 0.774 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3310 | 0.9592 | +189.76 | [+173.56, +205.84] | [+176.36, +203.38] | 3.005 | <0.0001 | slower/larger |
| client_wall_s | 60 | 0.8691 | 1.3698 | +57.60 | [+50.91, +64.26] | [+52.05, +63.23] | 1.610 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 1.2772 | 2.3845 | +86.69 | [+80.41, +92.99] | [+81.45, +91.94] | 1.915 | <0.0001 | slower/larger |
| client_vcsw | 60 | 2510.3 | 79625.1 | +3071.87 | [+2880.93, +3285.58] | [+2911.44, +3250.04] | 31.794 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.8207 | 1.9102 | +132.76 | [+123.40, +142.04] | [+124.95, +140.61] | 2.383 | <0.0001 | slower/larger |
| multi_broker_cpu_s | 60 | 0.3080 | 0.9175 | +197.89 | [+181.15, +214.94] | [+183.70, +212.15] | 3.042 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.3940 | 0.4436 | +12.61 | [+8.08, +17.29] | [+8.74, +16.61] | 1.135 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.3197 | 0.8560 | +167.77 | [+152.66, +183.07] | [+155.35, +180.58] | 2.659 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.7136 | 1.2996 | +82.12 | [+74.52, +89.65] | [+75.78, +88.48] | 1.844 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 377.6 | 112.5 | -70.21 | [-74.09, -65.62] | [-73.53, -66.44] | 0.250 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 47035 | 4734 | -89.94 | [-90.61, -89.05] | [-90.51, -89.22] | 0.094 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 47876 | 18836 | -60.66 | [-62.87, -57.89] | [-62.54, -58.41] | 0.372 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5104 | 0.3704 | -0.1203 | [-0.1374, -0.1032] |
| multi_s | 0.3237 | 0.9671 | +0.6282 | [+0.5785, +0.6779] |
| client_wall_s | 0.8642 | 1.3721 | +0.5006 | [+0.4466, +0.5547] |
| client_cpu_s | 1.2816 | 2.4021 | +1.1072 | [+1.0363, +1.1781] |
| client_vcsw | 2525.5 | 81379.5 | +77114.8 | [+72773.4, +81456.2] |
| multi_client_cpu_s | 0.8050 | 1.9050 | +1.0895 | [+1.0211, +1.1579] |
| multi_broker_cpu_s | 0.3000 | 0.9250 | +0.6095 | [+0.5588, +0.6602] |
| broker_user_s | 0.3932 | 0.4415 | +0.0497 | [+0.0322, +0.0672] |
| broker_sys_s | 0.3212 | 0.8542 | +0.5363 | [+0.4901, +0.5825] |
| broker_cpu_s | 0.7060 | 1.3092 | +0.5860 | [+0.5341, +0.6380] |
| broker_vcsw | 384.5 | 96.0 | -265.1 | [-298.3, -231.8] |
| broker_maxrss_kib | 50660 | 4732 | -42301 | [-45998, -38605] |
| broker_ru_maxrss_kib | 50628 | 18840 | -29040 | [-32113, -25967] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
