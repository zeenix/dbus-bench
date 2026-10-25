candidate baseline against baseline queue, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.6032 | 0.4805 | -20.35 | [-23.26, -17.34] | [-22.82, -17.85] | 0.795 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.5711 | 0.5686 | -0.44 | [-4.02, +3.18] | [-3.46, +2.52] | 1.003 | 0.8946 | no material change |
| client_wall_s | 60 | 1.1990 | 1.0620 | -11.42 | [-14.13, -8.78] | [-13.66, -9.21] | 0.890 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.0394 | 1.0156 | -2.30 | [-5.37, +0.83] | [-4.88, +0.31] | 0.978 | 0.1779 | no material change |
| client_vcsw | 60 | 250.1 | 167.5 | -33.04 | [-41.45, -24.49] | [-40.11, -25.85] | 0.663 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5648 | 0.5645 | -0.06 | [-3.57, +3.47] | [-3.02, +2.85] | 1.000 | 0.8861 | no material change |
| multi_broker_cpu_s | 60 | 0.2543 | 0.2483 | -2.36 | [-6.42, +1.81] | [-5.77, +1.19] | 0.982 | 0.3090 | inconclusive |
| broker_user_s | 60 | 0.4148 | 0.4159 | +0.27 | [-3.98, +4.68] | [-3.30, +3.93] | 1.044 | 0.5859 | no material change |
| broker_sys_s | 60 | 0.3011 | 0.2425 | -19.48 | [-23.02, -16.00] | [-22.44, -16.54] | 0.808 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.7159 | 0.6584 | -8.03 | [-10.86, -5.14] | [-10.43, -5.62] | 0.937 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 1142.8 | 341.9 | -70.08 | [-71.84, -68.24] | [-71.54, -68.55] | 0.297 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 52435 | 4864 | -90.72 | [-90.90, -90.53] | [-90.87, -90.56] | 0.093 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 52406 | 18946 | -63.85 | [-64.55, -63.10] | [-64.43, -63.22] | 0.361 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5819 | 0.4730 | -0.1228 | [-0.1434, -0.1021] |
| multi_s | 0.5604 | 0.5618 | -0.0025 | [-0.0236, +0.0185] |
| client_wall_s | 1.1712 | 1.0418 | -0.1370 | [-0.1720, -0.1020] |
| client_cpu_s | 1.0199 | 0.9866 | -0.0239 | [-0.0571, +0.0094] |
| client_vcsw | 242.5 | 160.0 | -82.7 | [-111.8, -53.5] |
| multi_client_cpu_s | 0.5500 | 0.5550 | -0.0003 | [-0.0207, +0.0201] |
| multi_broker_cpu_s | 0.2500 | 0.2400 | -0.0060 | [-0.0170, +0.0050] |
| broker_user_s | 0.4101 | 0.4188 | +0.0011 | [-0.0175, +0.0197] |
| broker_sys_s | 0.3009 | 0.2460 | -0.0586 | [-0.0707, -0.0466] |
| broker_cpu_s | 0.7070 | 0.6543 | -0.0575 | [-0.0798, -0.0352] |
| broker_vcsw | 1142.0 | 335.5 | -800.9 | [-846.1, -755.7] |
| broker_maxrss_kib | 52264 | 4872 | -47571 | [-48617, -46525] |
| broker_ru_maxrss_kib | 52264 | 19040 | -33460 | [-34513, -32407] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
