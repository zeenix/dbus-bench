candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.7228 | 3.7058 | -0.46 | [-2.78, +2.02] | [-2.43, +1.64] | 0.993 | 0.5101 | no material change |
| multi_s | 40 | 6.9981 | 4.3901 | -37.27 | [-38.75, -35.73] | [-38.52, -36.01] | 0.631 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 10.7276 | 8.1037 | -24.46 | [-25.90, -22.93] | [-25.67, -23.19] | 0.751 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 10.5932 | 7.4607 | -29.57 | [-30.76, -28.32] | [-30.57, -28.52] | 0.701 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 205.8 | 10858.4 | +5175.53 | [+4615.29, +5802.48] | [+4701.72, +5696.40] | 53.365 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 6.9205 | 4.0178 | -41.94 | [-43.17, -40.64] | [-42.99, -40.85] | 0.577 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 2.6027 | 3.2625 | +25.35 | [+21.68, +29.00] | [+22.28, +28.40] | 1.235 | <0.0001 | slower/larger |
| broker_user_s | 40 | 1.3750 | 3.0305 | +120.41 | [+114.68, +126.19] | [+115.57, +125.34] | 2.206 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 2.8709 | 2.5272 | -11.97 | [-14.46, -9.46] | [-14.08, -9.87] | 0.870 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 4.2459 | 5.5577 | +30.90 | [+27.97, +33.99] | [+28.41, +33.44] | 1.297 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 203965.9 | 18781.2 | -90.79 | [-90.95, -90.64] | [-90.92, -90.66] | 0.092 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 8549 | 7043 | -17.62 | [-18.52, -16.63] | [-18.38, -16.80] | 0.816 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18772 | 18772 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.7298 | 3.7073 | -0.0170 | [-0.1113, +0.0773] |
| multi_s | 6.9090 | 4.3492 | -2.6081 | [-2.7368, -2.4794] |
| client_wall_s | 10.6731 | 8.0934 | -2.6239 | [-2.8030, -2.4449] |
| client_cpu_s | 10.5690 | 7.3674 | -3.1325 | [-3.2855, -2.9795] |
| client_vcsw | 197.0 | 10653.0 | +10652.5 | [+9675.4, +11629.6] |
| multi_client_cpu_s | 6.8350 | 3.9700 | -2.9028 | [-3.0178, -2.7877] |
| multi_broker_cpu_s | 2.5950 | 3.2350 | +0.6598 | [+0.5606, +0.7589] |
| broker_user_s | 1.3568 | 2.9792 | +1.6555 | [+1.5841, +1.7270] |
| broker_sys_s | 2.8831 | 2.5386 | -0.3437 | [-0.4209, -0.2666] |
| broker_cpu_s | 4.2402 | 5.5213 | +1.3118 | [+1.1817, +1.4419] |
| broker_vcsw | 204222.5 | 18682.0 | -185184.6 | [-188094.6, -182274.7] |
| broker_maxrss_kib | 8566 | 7020 | -1506 | [-1596, -1416] |
| broker_ru_maxrss_kib | 18708 | 18708 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
