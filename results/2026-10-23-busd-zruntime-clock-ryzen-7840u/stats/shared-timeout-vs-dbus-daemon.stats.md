candidate timeout against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3712 | 2.0755 | -67.42 | [-67.68, -67.16] | [-67.64, -67.20] | 0.324 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7375 | 2.2574 | -60.66 | [-61.19, -60.05] | [-61.12, -60.16] | 0.391 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.1408 | 4.3648 | -64.05 | [-64.36, -63.70] | [-64.32, -63.76] | 0.358 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.1722 | 4.1745 | -48.92 | [-49.40, -48.39] | [-49.32, -48.48] | 0.509 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 211263.3 | 2934.1 | -98.61 | [-98.69, -98.53] | [-98.68, -98.54] | 0.014 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3755 | 2.2018 | -49.68 | [-50.39, -48.88] | [-50.29, -49.03] | 0.499 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.7067 | 1.9040 | -66.64 | [-67.21, -66.07] | [-67.12, -66.16] | 0.331 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.6910 | 1.6467 | -64.90 | [-65.35, -64.38] | [-65.29, -64.48] | 0.348 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.4221 | 1.8265 | -75.39 | [-75.69, -75.09] | [-75.65, -75.13] | 0.245 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.1131 | 3.4732 | -71.33 | [-71.61, -71.04] | [-71.56, -71.09] | 0.287 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 26.500 | 14708.825 | +55405.00 | [+49059.20, +62658.52] | [+50014.00, +61496.79] | 591.793 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8546 | 11222 | +31.31 | [+29.09, +33.64] | [+29.44, +33.25] | 1.309 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20651 | 20651 | +0.00 | [+0.00, +0.00] | [+0.00, +0.00] | 1.000 | - | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3696 | 2.0627 | -4.2957 | [-4.3169, -4.2746] |
| multi_s | 5.7119 | 2.2360 | -3.4801 | [-3.5305, -3.4297] |
| client_wall_s | 12.1217 | 4.3299 | -7.7760 | [-7.8323, -7.7196] |
| client_cpu_s | 8.1609 | 4.1404 | -3.9977 | [-4.0518, -3.9436] |
| client_vcsw | 211821.5 | 2969.5 | -208329.2 | [-210483.0, -206175.3] |
| multi_client_cpu_s | 4.3600 | 2.1700 | -2.1738 | [-2.2183, -2.1292] |
| multi_broker_cpu_s | 5.6800 | 1.8800 | -3.8027 | [-3.8555, -3.7500] |
| broker_user_s | 4.6912 | 1.6313 | -3.0443 | [-3.0792, -3.0093] |
| broker_sys_s | 7.4170 | 1.8126 | -5.5956 | [-5.6398, -5.5513] |
| broker_cpu_s | 12.0948 | 3.4584 | -8.6398 | [-8.6943, -8.5854] |
| broker_vcsw | 25.000 | 14927.500 | +14682.325 | [+14419.607, +14945.043] |
| broker_maxrss_kib | 8506 | 11196 | +2676 | [+2481, +2872] |
| broker_ru_maxrss_kib | 20696 | 20696 | +0 | [+0, +0] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
