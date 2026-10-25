candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1883 | 0.2156 | +14.54 | [+13.81, +15.22] | [+13.93, +15.12] | 1.146 | <0.0001 | slower/larger |
| multi_s | 60 | 0.2200 | 0.1381 | -37.22 | [-37.77, -36.65] | [-37.68, -36.75] | 0.627 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 0.4534 | 0.4077 | -10.10 | [-10.62, -9.58] | [-10.54, -9.65] | 0.898 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 1.4800 | 1.2006 | -18.87 | [-19.33, -18.42] | [-19.26, -18.50] | 0.813 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 34726.6 | 10121.2 | -70.85 | [-70.90, -70.81] | [-70.89, -70.81] | 0.292 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 1.0648 | 0.7743 | -27.28 | [-27.88, -26.66] | [-27.78, -26.76] | 0.728 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 0.1900 | 0.1068 | -43.77 | [-44.87, -42.63] | [-44.69, -42.83] | 0.567 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.1329 | 0.2372 | +78.42 | [+74.69, +82.15] | [+75.25, +81.58] | 1.775 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2816 | 0.1402 | -50.22 | [-51.15, -49.26] | [-51.01, -49.41] | 0.502 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 0.4146 | 0.3774 | -8.97 | [-9.52, -8.44] | [-9.43, -8.52] | 0.911 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 510.0 | 142.7 | -72.02 | [-73.44, -70.43] | [-73.25, -70.67] | 0.284 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 15078 | 6373 | -57.73 | [-58.89, -56.59] | [-58.71, -56.77] | 0.425 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20264 | 20259 | -0.02 | [-0.05, +0.00] | [-0.04, +0.00] | 1.000 | 0.1573 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1875 | 0.2157 | +0.0274 | [+0.0261, +0.0286] |
| multi_s | 0.2192 | 0.1376 | -0.0819 | [-0.0836, -0.0802] |
| client_wall_s | 0.4519 | 0.4057 | -0.0458 | [-0.0483, -0.0432] |
| client_cpu_s | 1.4774 | 1.1986 | -0.2793 | [-0.2871, -0.2716] |
| client_vcsw | 34729.5 | 10121.5 | -24605.4 | [-24625.5, -24585.2] |
| multi_client_cpu_s | 1.0650 | 0.7700 | -0.2905 | [-0.2983, -0.2827] |
| multi_broker_cpu_s | 0.1900 | 0.1100 | -0.0832 | [-0.0859, -0.0804] |
| broker_user_s | 0.1333 | 0.2372 | +0.1043 | [+0.1007, +0.1078] |
| broker_sys_s | 0.2801 | 0.1393 | -0.1414 | [-0.1453, -0.1375] |
| broker_cpu_s | 0.4128 | 0.3768 | -0.0372 | [-0.0396, -0.0347] |
| broker_vcsw | 498.0 | 140.0 | -367.3 | [-388.0, -346.5] |
| broker_maxrss_kib | 14972 | 6394 | -8705 | [-9119, -8290] |
| broker_ru_maxrss_kib | 20268 | 20268 | -4 | [-10, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
