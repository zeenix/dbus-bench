candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.7228 | 3.6464 | -2.05 | [-4.90, +1.07] | [-4.46, +0.57] | 0.969 | 0.0348 | no material change |
| multi_s | 40 | 6.9981 | 4.2749 | -38.91 | [-40.40, -37.45] | [-40.17, -37.69] | 0.610 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 10.7276 | 7.9283 | -26.09 | [-27.64, -24.46] | [-27.41, -24.72] | 0.732 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 10.5932 | 7.2823 | -31.25 | [-32.57, -29.85] | [-32.38, -30.08] | 0.680 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 205.8 | 10657.0 | +5077.68 | [+4579.06, +5653.65] | [+4657.31, +5557.35] | 50.125 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 6.9205 | 3.9062 | -43.56 | [-44.74, -42.41] | [-44.55, -42.59] | 0.561 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 2.6027 | 3.2337 | +24.24 | [+20.33, +28.18] | [+20.96, +27.54] | 1.233 | <0.0001 | slower/larger |
| broker_user_s | 40 | 1.3750 | 2.9727 | +116.20 | [+110.65, +121.71] | [+111.60, +120.87] | 2.124 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 2.8709 | 2.5155 | -12.38 | [-15.60, -9.01] | [-15.11, -9.59] | 0.865 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 4.2459 | 5.4882 | +29.26 | [+26.04, +32.63] | [+26.55, +32.05] | 1.264 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 203965.9 | 18508.0 | -90.93 | [-91.13, -90.72] | [-91.09, -90.75] | 0.091 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 8549 | 7195 | -15.84 | [-16.68, -14.98] | [-16.55, -15.12] | 0.842 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18772 | 18778 | +0.03 | [+0.00, +0.10] | [+0.00, +0.10] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.7298 | 3.5956 | -0.0764 | [-0.1943, +0.0415] |
| multi_s | 6.9090 | 4.1986 | -2.7233 | [-2.8394, -2.6072] |
| client_wall_s | 10.6731 | 7.7311 | -2.7993 | [-2.9800, -2.6187] |
| client_cpu_s | 10.5690 | 7.1287 | -3.3108 | [-3.4681, -3.1535] |
| client_vcsw | 197.0 | 10077.0 | +10451.1 | [+9424.9, +11477.4] |
| multi_client_cpu_s | 6.8350 | 3.8550 | -3.0143 | [-3.1144, -2.9141] |
| multi_broker_cpu_s | 2.5950 | 3.1650 | +0.6310 | [+0.5253, +0.7367] |
| broker_user_s | 1.3568 | 2.9255 | +1.5977 | [+1.5233, +1.6721] |
| broker_sys_s | 2.8831 | 2.4816 | -0.3554 | [-0.4543, -0.2565] |
| broker_cpu_s | 4.2402 | 5.3672 | +1.2423 | [+1.0951, +1.3895] |
| broker_vcsw | 204222.5 | 18497.5 | -185457.9 | [-188468.3, -182447.5] |
| broker_maxrss_kib | 8566 | 7168 | -1354 | [-1435, -1273] |
| broker_ru_maxrss_kib | 18708 | 18708 | +6 | [-7, +19] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
