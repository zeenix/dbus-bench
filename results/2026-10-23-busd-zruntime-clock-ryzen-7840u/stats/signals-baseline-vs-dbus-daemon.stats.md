candidate baseline against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.8598 | 0.3805 | -55.74 | [-55.96, -55.51] | [-55.92, -55.55] | 0.441 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.2063 | 0.3827 | -68.27 | [-68.57, -67.96] | [-68.52, -68.01] | 0.313 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 2.1011 | 0.8251 | -60.73 | [-60.96, -60.49] | [-60.93, -60.53] | 0.390 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.2433 | 0.7000 | -43.70 | [-44.05, -43.34] | [-43.99, -43.40] | 0.560 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 18179.8 | 209.2 | -98.85 | [-98.87, -98.83] | [-98.86, -98.84] | 0.012 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.5457 | 0.3673 | -32.68 | [-33.46, -31.91] | [-33.33, -32.03] | 0.670 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1788 | 0.1860 | -84.22 | [-84.47, -83.98] | [-84.43, -84.02] | 0.159 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.6993 | 0.2611 | -62.66 | [-63.22, -62.09] | [-63.14, -62.18] | 0.371 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 1.3778 | 0.2617 | -81.01 | [-81.28, -80.73] | [-81.23, -80.77] | 0.189 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 2.0771 | 0.5228 | -74.83 | [-74.99, -74.68] | [-74.96, -74.70] | 0.251 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 15.300 | 813.833 | +5219.17 | [+4990.12, +5448.20] | [+5026.87, +5409.01] | 52.167 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 5578 | 54207 | +871.85 | [+863.58, +879.97] | [+864.96, +878.58] | 9.741 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20529 | 53987 | +162.98 | [+161.56, +164.38] | [+161.78, +164.19] | 2.635 | <0.0001 | slower/larger |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.8581 | 0.3785 | -0.4793 | [-0.4825, -0.4761] |
| multi_s | 1.2025 | 0.3767 | -0.8236 | [-0.8277, -0.8195] |
| client_wall_s | 2.0959 | 0.8195 | -1.2760 | [-1.2822, -1.2698] |
| client_cpu_s | 1.2401 | 0.6922 | -0.5433 | [-0.5488, -0.5378] |
| client_vcsw | 18116.0 | 210.5 | -17970.6 | [-18050.1, -17891.1] |
| multi_client_cpu_s | 0.5400 | 0.3600 | -0.1783 | [-0.1835, -0.1732] |
| multi_broker_cpu_s | 1.1800 | 0.1900 | -0.9928 | [-0.9968, -0.9889] |
| broker_user_s | 0.7031 | 0.2609 | -0.4382 | [-0.4455, -0.4309] |
| broker_sys_s | 1.3798 | 0.2604 | -1.1161 | [-1.1239, -1.1083] |
| broker_cpu_s | 2.0721 | 0.5206 | -1.5543 | [-1.5598, -1.5488] |
| broker_vcsw | 15.000 | 782.500 | +798.533 | [+769.999, +827.067] |
| broker_maxrss_kib | 5562 | 54236 | +48629 | [+48304, +48954] |
| broker_ru_maxrss_kib | 20576 | 54080 | +33458 | [+33170, +33746] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
