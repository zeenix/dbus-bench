candidate baseline against baseline dbus-daemon, from $WORK/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.5491 | 0.4805 | -12.50 | [-16.67, -8.13] | [-15.96, -8.81] | 0.874 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.7559 | 0.5686 | -24.77 | [-27.05, -22.44] | [-26.68, -22.81] | 0.756 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3168 | 1.0620 | -19.35 | [-21.56, -17.01] | [-21.20, -17.37] | 0.815 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2279 | 1.0156 | -17.29 | [-19.34, -15.16] | [-19.01, -15.48] | 0.832 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 2380.7 | 167.5 | -92.97 | [-94.08, -91.59] | [-93.92, -91.83] | 0.076 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.7465 | 0.5645 | -24.38 | [-26.64, -22.04] | [-26.27, -22.43] | 0.757 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.3963 | 0.2483 | -37.34 | [-39.31, -35.35] | [-38.99, -35.69] | 0.623 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6157 | 0.4159 | -32.45 | [-35.49, -29.20] | [-35.03, -29.74] | 0.691 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.3263 | 0.2425 | -25.69 | [-28.84, -22.35] | [-28.36, -22.90] | 0.736 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.9420 | 0.6584 | -30.11 | [-32.33, -27.73] | [-31.98, -28.13] | 0.701 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 9270.5 | 341.9 | -96.31 | [-96.51, -96.10] | [-96.48, -96.13] | 0.036 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 7787 | 4864 | -37.54 | [-38.80, -36.38] | [-38.58, -36.55] | 0.638 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 18946 | 18946 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.5337 | 0.4730 | -0.0687 | [-0.0954, -0.0419] |
| multi_s | 0.7544 | 0.5618 | -0.1873 | [-0.2075, -0.1670] |
| client_wall_s | 1.2958 | 1.0418 | -0.2548 | [-0.2899, -0.2197] |
| client_cpu_s | 1.2184 | 0.9866 | -0.2123 | [-0.2413, -0.1833] |
| client_vcsw | 1994.5 | 160.0 | -2213.2 | [-2605.3, -1821.2] |
| multi_client_cpu_s | 0.7500 | 0.5550 | -0.1820 | [-0.2018, -0.1622] |
| multi_broker_cpu_s | 0.4000 | 0.2400 | -0.1480 | [-0.1581, -0.1379] |
| broker_user_s | 0.5988 | 0.4188 | -0.1998 | [-0.2251, -0.1746] |
| broker_sys_s | 0.3268 | 0.2460 | -0.0838 | [-0.0969, -0.0707] |
| broker_cpu_s | 0.9358 | 0.6543 | -0.2836 | [-0.3127, -0.2546] |
| broker_vcsw | 9388.0 | 335.5 | -8928.5 | [-9268.0, -8589.1] |
| broker_maxrss_kib | 7656 | 4872 | -2923 | [-3083, -2763] |
| broker_ru_maxrss_kib | 19040 | 19040 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
