candidate batched against baseline queue, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.4998 | 0.3278 | -34.42 | [-36.69, -31.93] | [-36.37, -32.31] | 0.643 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.3310 | 0.2830 | -14.52 | [-17.12, -11.86] | [-16.69, -12.35] | 0.851 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.8691 | 0.6430 | -26.01 | [-27.87, -24.02] | [-27.56, -24.37] | 0.734 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2772 | 1.2327 | -3.48 | [-5.25, -1.64] | [-4.97, -1.95] | 0.957 | 0.0005 | no material change; repeatable change (-) |
| client_vcsw | 60 | 2510.3 | 5040.4 | +100.78 | [+86.02, +116.09] | [+88.44, +113.55] | 1.999 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.8207 | 0.7828 | -4.61 | [-6.73, -2.34] | [-6.39, -2.75] | 0.939 | <0.0001 | inconclusive; repeatable change (-) |
| multi_broker_cpu_s | 60 | 0.3080 | 0.1910 | -37.99 | [-40.49, -35.47] | [-40.10, -35.90] | 0.617 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.3940 | 0.3462 | -12.12 | [-15.01, -9.14] | [-14.52, -9.61] | 0.881 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3197 | 0.1757 | -45.05 | [-47.30, -42.81] | [-46.98, -43.14] | 0.546 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.7136 | 0.5219 | -26.87 | [-28.42, -25.30] | [-28.19, -25.56] | 0.741 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 377.6 | 579.6 | +53.51 | [+26.92, +82.46] | [+31.09, +77.70] | 1.448 | 0.0007 | slower/larger |
| broker_maxrss_kib | 60 | 47035 | 4787 | -89.82 | [-90.51, -88.92] | [-90.41, -89.09] | 0.094 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 47876 | 18836 | -60.66 | [-62.87, -57.89] | [-62.54, -58.41] | 0.372 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5104 | 0.3187 | -0.1720 | [-0.1883, -0.1558] |
| multi_s | 0.3237 | 0.2807 | -0.0481 | [-0.0575, -0.0386] |
| client_wall_s | 0.8642 | 0.6342 | -0.2261 | [-0.2465, -0.2057] |
| client_cpu_s | 1.2816 | 1.2223 | -0.0445 | [-0.0685, -0.0205] |
| client_vcsw | 2525.5 | 4831.5 | +2530.1 | [+2201.7, +2858.4] |
| multi_client_cpu_s | 0.8050 | 0.7700 | -0.0378 | [-0.0563, -0.0193] |
| multi_broker_cpu_s | 0.3000 | 0.1800 | -0.1170 | [-0.1263, -0.1077] |
| broker_user_s | 0.3932 | 0.3436 | -0.0477 | [-0.0605, -0.0350] |
| broker_sys_s | 0.3212 | 0.1739 | -0.1440 | [-0.1535, -0.1345] |
| broker_cpu_s | 0.7060 | 0.5152 | -0.1918 | [-0.2046, -0.1789] |
| broker_vcsw | 384.5 | 498.5 | +202.0 | [+101.6, +302.5] |
| broker_maxrss_kib | 50660 | 4786 | -42248 | [-45946, -38551] |
| broker_ru_maxrss_kib | 50628 | 18840 | -29040 | [-32113, -25967] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
