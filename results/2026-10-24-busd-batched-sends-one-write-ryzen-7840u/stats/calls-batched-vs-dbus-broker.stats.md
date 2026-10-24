candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0609 | 0.0715 | +17.47 | [+16.09, +18.82] | [+16.30, +18.61] | 1.184 | <0.0001 | slower/larger |
| multi_s | 60 | 0.4443 | 0.4647 | +4.59 | [+3.40, +5.77] | [+3.60, +5.58] | 1.046 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 60 | 0.5330 | 0.5639 | +5.80 | [+4.73, +6.86] | [+4.90, +6.68] | 1.060 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.4866 | 0.4929 | +1.29 | [+0.33, +2.27] | [+0.49, +2.10] | 1.016 | 0.0104 | no material change; repeatable change (+) |
| client_vcsw | 60 | 2080.1 | 2554.7 | +22.82 | [+19.15, +26.70] | [+19.76, +26.08] | 1.198 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.4293 | 0.4450 | +3.65 | [+2.31, +5.03] | [+2.51, +4.78] | 1.024 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.2957 | 0.3647 | +23.34 | [+21.85, +24.86] | [+22.10, +24.60] | 1.233 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1235 | 0.2105 | +70.48 | [+66.20, +74.87] | [+66.87, +74.15] | 1.708 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2310 | 0.2161 | -6.44 | [-8.06, -4.76] | [-7.79, -5.01] | 0.924 | <0.0001 | inconclusive; repeatable change (-) |
| broker_cpu_s | 60 | 0.3545 | 0.4266 | +20.36 | [+19.21, +21.52] | [+19.42, +21.32] | 1.200 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 21420.5 | 5534.9 | -74.16 | [-74.59, -73.74] | [-74.53, -73.80] | 0.259 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 8264 | 6694 | -19.00 | [-19.60, -18.41] | [-19.51, -18.51] | 0.810 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20530 | 20527 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0605 | 0.0711 | +0.0106 | [+0.0098, +0.0114] |
| multi_s | 0.4399 | 0.4645 | +0.0204 | [+0.0151, +0.0257] |
| client_wall_s | 0.5292 | 0.5651 | +0.0309 | [+0.0252, +0.0366] |
| client_cpu_s | 0.4829 | 0.4921 | +0.0063 | [+0.0015, +0.0110] |
| client_vcsw | 2081.0 | 2492.0 | +474.6 | [+394.0, +555.2] |
| multi_client_cpu_s | 0.4300 | 0.4450 | +0.0157 | [+0.0099, +0.0214] |
| multi_broker_cpu_s | 0.3000 | 0.3600 | +0.0690 | [+0.0647, +0.0733] |
| broker_user_s | 0.1225 | 0.2083 | +0.0870 | [+0.0829, +0.0911] |
| broker_sys_s | 0.2307 | 0.2158 | -0.0149 | [-0.0189, -0.0108] |
| broker_cpu_s | 0.3533 | 0.4256 | +0.0722 | [+0.0683, +0.0761] |
| broker_vcsw | 21270.5 | 5572.0 | -15885.6 | [-16135.5, -15635.6] |
| broker_maxrss_kib | 8262 | 6682 | -1570 | [-1628, -1511] |
| broker_ru_maxrss_kib | 20504 | 20504 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
