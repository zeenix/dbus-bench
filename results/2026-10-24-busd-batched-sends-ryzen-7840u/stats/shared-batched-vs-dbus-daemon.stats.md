candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3939 | 2.0382 | -68.12 | [-68.37, -67.88] | [-68.33, -67.92] | 0.319 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7512 | 2.2409 | -61.04 | [-61.43, -60.61] | [-61.37, -60.69] | 0.389 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.1779 | 4.3121 | -64.59 | [-64.81, -64.37] | [-64.77, -64.41] | 0.354 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.2030 | 4.1228 | -49.74 | [-50.07, -49.41] | [-50.02, -49.46] | 0.502 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 212676.5 | 2832.1 | -98.67 | [-98.73, -98.60] | [-98.72, -98.61] | 0.013 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3803 | 2.1825 | -50.17 | [-50.69, -49.63] | [-50.61, -49.73] | 0.495 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.7190 | 1.9395 | -66.09 | [-66.52, -65.63] | [-66.45, -65.71] | 0.338 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.6936 | 1.6382 | -65.10 | [-65.41, -64.77] | [-65.36, -64.82] | 0.348 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.4553 | 1.7629 | -76.35 | [-76.65, -76.04] | [-76.60, -76.08] | 0.235 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.1489 | 3.4011 | -72.00 | [-72.23, -71.77] | [-72.19, -71.81] | 0.278 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 26.375 | 14890.400 | +56356.49 | [+50795.49, +63070.62] | [+51558.96, +61932.74] | 588.705 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8467 | 11238 | +32.73 | [+30.95, +34.48] | [+31.26, +34.19] | 1.331 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20510 | 20510 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3892 | 2.0329 | -4.3557 | [-4.3773, -4.3341] |
| multi_s | 5.7202 | 2.2364 | -3.5103 | [-3.5439, -3.4766] |
| client_wall_s | 12.1573 | 4.2919 | -7.8658 | [-7.9038, -7.8278] |
| client_cpu_s | 8.1968 | 4.1102 | -4.0802 | [-4.1152, -4.0452] |
| client_vcsw | 212622.0 | 2788.0 | -209844.4 | [-211387.8, -208301.1] |
| multi_client_cpu_s | 4.3700 | 2.1700 | -2.1978 | [-2.2270, -2.1685] |
| multi_broker_cpu_s | 5.6950 | 1.9200 | -3.7795 | [-3.8184, -3.7406] |
| broker_user_s | 4.6795 | 1.6309 | -3.0554 | [-3.0857, -3.0252] |
| broker_sys_s | 7.4540 | 1.7500 | -5.6924 | [-5.7253, -5.6594] |
| broker_cpu_s | 12.1261 | 3.3710 | -8.7478 | [-8.7897, -8.7059] |
| broker_vcsw | 25.500 | 14992.500 | +14864.025 | [+14576.208, +15151.842] |
| broker_maxrss_kib | 8468 | 11222 | +2771 | [+2630, +2912] |
| broker_ru_maxrss_kib | 20564 | 20564 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
