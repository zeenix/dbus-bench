candidate baseline against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3773 | 0.2635 | -30.17 | [-31.11, -29.01] | [-30.97, -29.22] | 0.688 | <0.0001 | faster/smaller |
| multi_s | 60 | 0.2424 | 0.3953 | +63.05 | [+61.76, +64.25] | [+61.96, +64.06] | 1.632 | <0.0001 | slower/larger |
| client_wall_s | 60 | 0.6709 | 0.7113 | +6.02 | [+5.14, +7.01] | [+5.27, +6.82] | 1.055 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 1.0523 | 2.6183 | +148.83 | [+147.51, +150.11] | [+147.73, +149.90] | 2.497 | <0.0001 | slower/larger |
| client_vcsw | 60 | 2452.1 | 121136.0 | +4840.06 | [+4787.17, +4884.78] | [+4796.62, +4878.47] | 50.043 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.6637 | 2.1820 | +228.78 | [+226.17, +231.41] | [+226.60, +230.96] | 3.278 | <0.0001 | slower/larger |
| multi_broker_cpu_s | 60 | 0.2130 | 0.3647 | +71.21 | [+69.14, +73.16] | [+69.46, +72.86] | 1.714 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.2783 | 0.3264 | +17.28 | [+15.68, +18.90] | [+15.93, +18.65] | 1.174 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2777 | 0.3573 | +28.63 | [+26.71, +30.55] | [+26.99, +30.24] | 1.278 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.5561 | 0.6837 | +22.95 | [+22.35, +23.53] | [+22.44, +23.43] | 1.229 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 419.4 | 129.9 | -69.04 | [-70.28, -67.71] | [-70.11, -67.92] | 0.310 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 54769 | 6299 | -88.50 | [-88.90, -87.98] | [-88.85, -88.08] | 0.109 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 54211 | 20262 | -62.62 | [-63.84, -61.07] | [-63.68, -61.37] | 0.360 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3816 | 0.2632 | -0.1138 | [-0.1196, -0.1080] |
| multi_s | 0.2412 | 0.3955 | +0.1528 | [+0.1505, +0.1552] |
| client_wall_s | 0.6737 | 0.7093 | +0.0404 | [+0.0343, +0.0466] |
| client_cpu_s | 1.0507 | 2.6177 | +1.5660 | [+1.5571, +1.5750] |
| client_vcsw | 2420.5 | 121136.0 | +118683.9 | [+118655.6, +118712.2] |
| multi_client_cpu_s | 0.6600 | 2.1800 | +1.5183 | [+1.5094, +1.5273] |
| multi_broker_cpu_s | 0.2100 | 0.3600 | +0.1517 | [+0.1484, +0.1549] |
| broker_user_s | 0.2779 | 0.3263 | +0.0481 | [+0.0437, +0.0525] |
| broker_sys_s | 0.2788 | 0.3558 | +0.0795 | [+0.0747, +0.0844] |
| broker_cpu_s | 0.5555 | 0.6834 | +0.1276 | [+0.1246, +0.1306] |
| broker_vcsw | 432.0 | 125.5 | -289.6 | [-303.6, -275.6] |
| broker_maxrss_kib | 56748 | 6288 | -48470 | [-50751, -46190] |
| broker_ru_maxrss_kib | 56074 | 20268 | -33949 | [-36023, -31875] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
