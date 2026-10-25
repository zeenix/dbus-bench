candidate batched against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.8784 | 3.9477 | +1.79 | [-1.10, +4.67] | [-0.63, +4.21] | 1.020 | 0.3265 | no material change |
| multi_s | 40 | 7.1867 | 4.6709 | -35.01 | [-37.24, -32.84] | [-36.86, -33.18] | 0.647 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 11.0723 | 8.6262 | -22.09 | [-24.17, -20.08] | [-23.84, -20.38] | 0.767 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 10.9147 | 7.8247 | -28.31 | [-30.04, -26.57] | [-29.77, -26.86] | 0.705 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 211.7 | 13366.0 | +6215.15 | [+5276.37, +7421.77] | [+5403.83, +7208.85] | 61.932 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 7.1005 | 4.1940 | -40.93 | [-42.73, -39.10] | [-42.44, -39.39] | 0.586 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 2.7372 | 3.5515 | +29.75 | [+24.66, +35.05] | [+25.48, +34.16] | 1.247 | <0.0001 | slower/larger |
| broker_user_s | 40 | 1.4524 | 3.2830 | +126.03 | [+118.89, +133.65] | [+119.93, +132.41] | 2.245 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 3.0073 | 2.7392 | -8.92 | [-12.54, -5.09] | [-11.96, -5.71] | 0.894 | 0.0003 | faster/smaller |
| broker_cpu_s | 40 | 4.4597 | 6.0222 | +35.03 | [+30.89, +39.26] | [+31.54, +38.67] | 1.330 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 198124.0 | 17722.0 | -91.06 | [-91.32, -90.79] | [-91.28, -90.84] | 0.091 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 8618 | 7038 | -18.33 | [-19.25, -17.36] | [-19.11, -17.52] | 0.814 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18746 | 18746 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.8839 | 3.8763 | +0.0693 | [-0.0475, +0.1862] |
| multi_s | 7.1487 | 4.6217 | -2.5159 | [-2.7087, -2.3231] |
| client_wall_s | 11.0632 | 8.6545 | -2.4462 | [-2.6984, -2.1939] |
| client_cpu_s | 10.8962 | 7.7658 | -3.0900 | [-3.3124, -2.8677] |
| client_vcsw | 205.0 | 12306.0 | +13154.4 | [+11423.3, +14885.5] |
| multi_client_cpu_s | 7.0800 | 4.1650 | -2.9065 | [-3.0836, -2.7294] |
| multi_broker_cpu_s | 2.7000 | 3.4750 | +0.8143 | [+0.6681, +0.9604] |
| broker_user_s | 1.4404 | 3.2388 | +1.8305 | [+1.7326, +1.9285] |
| broker_sys_s | 3.0268 | 2.7052 | -0.2681 | [-0.3869, -0.1493] |
| broker_cpu_s | 4.4328 | 5.9373 | +1.5624 | [+1.3734, +1.7514] |
| broker_vcsw | 198165.5 | 17605.5 | -180402.0 | [-184435.5, -176368.5] |
| broker_maxrss_kib | 8630 | 7014 | -1580 | [-1674, -1486] |
| broker_ru_maxrss_kib | 18784 | 18784 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
