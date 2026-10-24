candidate baseline against baseline dbus-broker, from $WORK/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 3.8784 | 3.8893 | +0.28 | [-1.79, +2.44] | [-1.50, +2.08] | 0.993 | 0.9786 | no material change |
| multi_s | 40 | 7.1867 | 4.7799 | -33.49 | [-35.61, -31.23] | [-35.29, -31.60] | 0.672 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 11.0723 | 8.6766 | -21.64 | [-23.31, -19.86] | [-23.04, -20.16] | 0.778 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 10.9147 | 7.9002 | -27.62 | [-29.14, -25.97] | [-28.92, -26.24] | 0.710 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 211.7 | 13245.7 | +6158.29 | [+5297.66, +7194.90] | [+5435.07, +7005.36] | 59.861 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 7.1005 | 4.2910 | -39.57 | [-41.40, -37.62] | [-41.11, -37.93] | 0.603 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 2.7372 | 3.6010 | +31.56 | [+26.81, +36.50] | [+27.57, +35.74] | 1.303 | <0.0001 | slower/larger |
| broker_user_s | 40 | 1.4524 | 3.2945 | +126.83 | [+120.43, +133.17] | [+121.54, +132.13] | 2.303 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 3.0073 | 2.7198 | -9.56 | [-12.30, -6.63] | [-11.89, -7.13] | 0.884 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 4.4597 | 6.0143 | +34.86 | [+31.89, +37.92] | [+32.36, +37.46] | 1.339 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 198124.0 | 18122.1 | -90.85 | [-91.10, -90.60] | [-91.06, -90.64] | 0.091 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 8618 | 7089 | -17.75 | [-18.71, -16.72] | [-18.56, -16.89] | 0.818 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 40 | 18746 | 18746 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 3.8839 | 3.8441 | +0.0109 | [-0.0746, +0.0965] |
| multi_s | 7.1487 | 4.7416 | -2.4068 | [-2.6016, -2.2121] |
| client_wall_s | 11.0632 | 8.5486 | -2.3958 | [-2.6138, -2.1778] |
| client_cpu_s | 10.8962 | 7.7152 | -3.0146 | [-3.2205, -2.8086] |
| client_vcsw | 205.0 | 13249.0 | +13034.0 | [+11769.4, +14298.6] |
| multi_client_cpu_s | 7.0800 | 4.2150 | -2.8095 | [-2.9880, -2.6310] |
| multi_broker_cpu_s | 2.7000 | 3.6100 | +0.8637 | [+0.7339, +0.9936] |
| broker_user_s | 1.4404 | 3.2543 | +1.8421 | [+1.7609, +1.9233] |
| broker_sys_s | 3.0268 | 2.6961 | -0.2875 | [-0.3774, -0.1976] |
| broker_cpu_s | 4.4328 | 5.9590 | +1.5545 | [+1.4229, +1.6862] |
| broker_vcsw | 198165.5 | 18168.0 | -180001.9 | [-183992.3, -176011.5] |
| broker_maxrss_kib | 8630 | 7032 | -1529 | [-1625, -1433] |
| broker_ru_maxrss_kib | 18784 | 18784 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
