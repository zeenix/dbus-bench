candidate baseline against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/signals.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1883 | 0.2635 | +39.94 | [+39.03, +40.82] | [+39.17, +40.68] | 1.402 | <0.0001 | slower/larger |
| multi_s | 60 | 0.2200 | 0.3953 | +79.67 | [+78.35, +81.04] | [+78.56, +80.83] | 1.803 | <0.0001 | slower/larger |
| client_wall_s | 60 | 0.4534 | 0.7113 | +56.87 | [+55.92, +57.77] | [+56.08, +57.62] | 1.571 | <0.0001 | slower/larger |
| client_cpu_s | 60 | 1.4800 | 2.6183 | +76.92 | [+76.14, +77.66] | [+76.28, +77.54] | 1.773 | <0.0001 | slower/larger |
| client_vcsw | 60 | 34726.6 | 121136.0 | +248.83 | [+248.74, +248.94] | [+248.75, +248.92] | 3.488 | <0.0001 | slower/larger |
| multi_client_cpu_s | 60 | 1.0648 | 2.1820 | +104.91 | [+103.74, +106.12] | [+103.95, +105.92] | 2.053 | <0.0001 | slower/larger |
| multi_broker_cpu_s | 60 | 0.1900 | 0.3647 | +91.93 | [+89.82, +94.07] | [+90.17, +93.71] | 1.924 | <0.0001 | slower/larger |
| broker_user_s | 60 | 0.1329 | 0.3264 | +145.54 | [+139.92, +151.44] | [+140.84, +150.40] | 2.435 | <0.0001 | slower/larger |
| broker_sys_s | 60 | 0.2816 | 0.3573 | +26.85 | [+24.83, +28.92] | [+25.17, +28.57] | 1.272 | <0.0001 | slower/larger |
| broker_cpu_s | 60 | 0.4146 | 0.6837 | +64.91 | [+63.96, +65.82] | [+64.12, +65.68] | 1.652 | <0.0001 | slower/larger |
| broker_vcsw | 60 | 510.0 | 129.9 | -74.53 | [-75.75, -73.25] | [-75.56, -73.47] | 0.253 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 60 | 15078 | 6299 | -58.23 | [-59.32, -57.14] | [-59.14, -57.31] | 0.421 | <0.0001 | faster/smaller |
| broker_ru_maxrss_kib | 60 | 20264 | 20262 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1875 | 0.2632 | +0.0752 | [+0.0737, +0.0767] |
| multi_s | 0.2192 | 0.3955 | +0.1753 | [+0.1730, +0.1775] |
| client_wall_s | 0.4519 | 0.7093 | +0.2579 | [+0.2544, +0.2613] |
| client_cpu_s | 1.4774 | 2.6177 | +1.1383 | [+1.1299, +1.1468] |
| client_vcsw | 34729.5 | 121136.0 | +86409.4 | [+86396.4, +86422.4] |
| multi_client_cpu_s | 1.0650 | 2.1800 | +1.1172 | [+1.1088, +1.1255] |
| multi_broker_cpu_s | 0.1900 | 0.3600 | +0.1747 | [+0.1719, +0.1775] |
| broker_user_s | 0.1333 | 0.3263 | +0.1935 | [+0.1886, +0.1984] |
| broker_sys_s | 0.2801 | 0.3558 | +0.0756 | [+0.0702, +0.0810] |
| broker_cpu_s | 0.4128 | 0.6834 | +0.2691 | [+0.2662, +0.2720] |
| broker_vcsw | 498.0 | 125.5 | -380.1 | [-399.5, -360.7] |
| broker_maxrss_kib | 14972 | 6288 | -8779 | [-9186, -8372] |
| broker_ru_maxrss_kib | 20268 | 20268 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
