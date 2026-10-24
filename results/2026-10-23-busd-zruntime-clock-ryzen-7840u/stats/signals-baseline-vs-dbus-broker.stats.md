candidate baseline against baseline dbus-broker, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3027 | 0.3805 | +25.72 | [+25.06, +26.39] | [+25.16, +26.29] | 1.252 | <0.0001 | slower/larger |
| multi_s | 60 | 0.3740 | 0.3827 | +2.33 | [+1.03, +3.62] | [+1.22, +3.44] | 1.016 | 0.0003 | no material change; repeatable change (+) |
| client_wall_s | 60 | 0.7093 | 0.8251 | +16.33 | [+15.37, +17.29] | [+15.51, +17.14] | 1.160 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 0.6801 | 0.7000 | +2.92 | [+2.07, +3.78] | [+2.20, +3.64] | 1.026 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 60 | 12.083 | 209.217 | +1631.45 | [+1427.75, +1864.26] | [+1461.07, +1827.07] | 21.200 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.3590 | 0.3673 | +2.32 | [+0.92, +3.72] | [+1.11, +3.50] | 1.028 | 0.0023 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 60 | 0.1152 | 0.1860 | +61.51 | [+57.00, +66.17] | [+57.67, +65.44] | 1.636 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1183 | 0.2611 | +120.75 | [+115.35, +126.16] | [+116.23, +125.35] | 2.216 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2426 | 0.2617 | +7.87 | [+5.75, +10.06] | [+6.08, +9.70] | 1.088 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.3609 | 0.5228 | +44.87 | [+43.28, +46.49] | [+43.51, +46.23] | 1.455 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 7309.0 | 813.8 | -88.87 | [-89.24, -88.47] | [-89.18, -88.53] | 0.108 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41049 | 54207 | +32.05 | [+30.92, +33.25] | [+31.08, +33.06] | 1.316 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 36460 | 53987 | +48.07 | [+46.72, +49.51] | [+46.92, +49.27] | 1.472 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3021 | 0.3785 | +0.0779 | [+0.0759, +0.0798] |
| multi_s | 0.3699 | 0.3767 | +0.0087 | [+0.0037, +0.0137] |
| client_wall_s | 0.7056 | 0.8195 | +0.1158 | [+0.1091, +0.1225] |
| client_cpu_s | 0.6772 | 0.6922 | +0.0199 | [+0.0139, +0.0259] |
| client_vcsw | 10.000 | 210.500 | +197.133 | [+193.870, +200.396] |
| multi_client_cpu_s | 0.3600 | 0.3600 | +0.0083 | [+0.0032, +0.0135] |
| multi_broker_cpu_s | 0.1200 | 0.1900 | +0.0708 | [+0.0667, +0.0750] |
| broker_user_s | 0.1166 | 0.2609 | +0.1428 | [+0.1387, +0.1470] |
| broker_sys_s | 0.2422 | 0.2604 | +0.0191 | [+0.0139, +0.0243] |
| broker_cpu_s | 0.3570 | 0.5206 | +0.1619 | [+0.1571, +0.1668] |
| broker_vcsw | 7334.5 | 782.5 | -6495.2 | [-6536.3, -6454.1] |
| broker_maxrss_kib | 41440 | 54236 | +13158 | [+12728, +13588] |
| broker_ru_maxrss_kib | 36756 | 54080 | +17527 | [+17113, +17941] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
