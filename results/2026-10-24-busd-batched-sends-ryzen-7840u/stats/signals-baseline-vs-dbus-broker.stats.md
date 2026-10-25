candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-4f346a3/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.3030 | 0.3135 | +3.49 | [+2.88, +4.13] | [+2.97, +4.02] | 1.031 | <0.0001 | no material change; repeatable change (+) |
| multi_s | 60 | 0.3750 | 0.3772 | +0.59 | [-0.44, +1.65] | [-0.29, +1.48] | 1.003 | 0.2538 | no material change |
| client_wall_s | 60 | 0.7111 | 0.7519 | +5.74 | [+4.95, +6.55] | [+5.07, +6.41] | 1.055 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 60 | 0.6815 | 0.6901 | +1.26 | [+0.55, +2.01] | [+0.66, +1.88] | 1.010 | 0.0005 | no material change; repeatable change (+) |
| client_vcsw | 60 | 11.517 | 131.367 | +1040.67 | [+928.21, +1164.55] | [+946.19, +1143.40] | 13.829 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 0.3598 | 0.3633 | +0.97 | [-0.14, +2.10] | [+0.00, +1.95] | 1.000 | 0.1045 | no material change |
| multi_broker_cpu_s | 60 | 0.1198 | 0.2053 | +71.35 | [+67.26, +75.89] | [+67.95, +75.11] | 1.750 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1214 | 0.2738 | +125.48 | [+119.56, +131.67] | [+120.51, +130.69] | 2.250 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2446 | 0.2513 | +2.71 | [+0.83, +4.66] | [+1.14, +4.35] | 1.016 | 0.0118 | no material change; repeatable change (+) |
| broker_cpu_s | 60 | 0.3661 | 0.5251 | +43.44 | [+41.86, +45.03] | [+42.11, +44.77] | 1.448 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 7258.6 | 377.9 | -94.79 | [-94.91, -94.68] | [-94.89, -94.70] | 0.051 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 41014 | 6605 | -83.89 | [-84.06, -83.72] | [-84.03, -83.75] | 0.161 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 36428 | 20468 | -43.81 | [-44.36, -43.21] | [-44.28, -43.31] | 0.557 | <0.0001 | faster/smaller |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.3026 | 0.3137 | +0.0106 | [+0.0086, +0.0125] |
| multi_s | 0.3715 | 0.3726 | +0.0022 | [-0.0019, +0.0063] |
| client_wall_s | 0.7063 | 0.7487 | +0.0408 | [+0.0351, +0.0466] |
| client_cpu_s | 0.6772 | 0.6855 | +0.0086 | [+0.0035, +0.0137] |
| client_vcsw | 10.000 | 135.000 | +119.850 | [+115.552, +124.148] |
| multi_client_cpu_s | 0.3600 | 0.3600 | +0.0035 | [-0.0007, +0.0077] |
| multi_broker_cpu_s | 0.1200 | 0.2100 | +0.0855 | [+0.0819, +0.0891] |
| broker_user_s | 0.1212 | 0.2729 | +0.1524 | [+0.1479, +0.1568] |
| broker_sys_s | 0.2426 | 0.2510 | +0.0066 | [+0.0019, +0.0114] |
| broker_cpu_s | 0.3618 | 0.5236 | +0.1590 | [+0.1547, +0.1634] |
| broker_vcsw | 7296.5 | 377.5 | -6880.7 | [-6921.2, -6840.1] |
| broker_maxrss_kib | 41420 | 6610 | -34408 | [-34794, -34023] |
| broker_ru_maxrss_kib | 36756 | 20500 | -15960 | [-16343, -15577] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
