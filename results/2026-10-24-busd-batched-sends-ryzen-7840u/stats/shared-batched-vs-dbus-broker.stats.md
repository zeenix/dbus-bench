candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.9065 | 2.0382 | +6.91 | [+5.73, +8.03] | [+5.91, +7.85] | 1.070 | <0.0001 | slower/larger |
| multi_s | 40 | 2.1735 | 2.2409 | +3.10 | [+1.62, +4.64] | [+1.86, +4.38] | 1.034 | 0.0004 | no material change; repeatable change (+) |
| client_wall_s | 40 | 4.1125 | 4.3121 | +4.85 | [+3.81, +5.84] | [+3.99, +5.69] | 1.050 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 4.0694 | 4.1228 | +1.31 | [+0.32, +2.27] | [+0.46, +2.12] | 1.013 | 0.0025 | no material change; repeatable change (+) |
| client_vcsw | 40 | 430.0 | 2832.1 | +558.63 | [+487.08, +640.69] | [+498.34, +627.31] | 6.866 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.1562 | 2.1825 | +1.22 | [-0.29, +2.77] | [-0.05, +2.52] | 1.017 | 0.1095 | no material change |
| multi_broker_cpu_s | 40 | 1.5257 | 1.9395 | +27.12 | [+25.31, +29.01] | [+25.61, +28.69] | 1.265 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9496 | 1.6382 | +72.51 | [+70.18, +74.99] | [+70.52, +74.59] | 1.716 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.7659 | 1.7629 | -0.17 | [-1.77, +1.45] | [-1.51, +1.18] | 0.997 | 0.8402 | no material change |
| broker_cpu_s | 40 | 2.7155 | 3.4011 | +25.25 | [+23.91, +26.60] | [+24.11, +26.39] | 1.251 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 107221.9 | 14890.4 | -86.11 | [-86.46, -85.77] | [-86.40, -85.83] | 0.142 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9428 | 11238 | +19.20 | [+17.47, +20.97] | [+17.74, +20.68] | 1.186 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20510 | 20510 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8939 | 2.0329 | +0.1317 | [+0.1097, +0.1537] |
| multi_s | 2.1507 | 2.2364 | +0.0674 | [+0.0334, +0.1015] |
| client_wall_s | 4.0804 | 4.2919 | +0.1997 | [+0.1570, +0.2423] |
| client_cpu_s | 4.0365 | 4.1102 | +0.0534 | [+0.0118, +0.0950] |
| client_vcsw | 415.5 | 2788.0 | +2402.1 | [+2255.2, +2549.0] |
| multi_client_cpu_s | 2.1350 | 2.1700 | +0.0263 | [-0.0084, +0.0609] |
| multi_broker_cpu_s | 1.5200 | 1.9200 | +0.4137 | [+0.3857, +0.4418] |
| broker_user_s | 0.9439 | 1.6309 | +0.6886 | [+0.6708, +0.7064] |
| broker_sys_s | 1.7437 | 1.7500 | -0.0029 | [-0.0334, +0.0275] |
| broker_cpu_s | 2.6943 | 3.3710 | +0.6856 | [+0.6507, +0.7205] |
| broker_vcsw | 107284.0 | 14992.5 | -92331.6 | [-94314.1, -90349.0] |
| broker_maxrss_kib | 9458 | 11222 | +1810 | [+1647, +1974] |
| broker_ru_maxrss_kib | 20564 | 20564 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
