candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 6.3237 | 1.9677 | -68.88 | [-69.11, -68.66] | [-69.07, -68.69] | 0.309 | <0.0001 | faster/smaller |
| multi_s | 40 | 5.7145 | 2.1975 | -61.54 | [-61.91, -61.21] | [-61.84, -61.26] | 0.383 | <0.0001 | faster/smaller |
| client_wall_s | 40 | 12.0691 | 4.1959 | -65.23 | [-65.45, -65.03] | [-65.42, -65.06] | 0.347 | <0.0001 | faster/smaller |
| client_cpu_s | 40 | 8.0930 | 4.0286 | -50.22 | [-50.51, -49.95] | [-50.46, -49.99] | 0.497 | <0.0001 | faster/smaller |
| client_vcsw | 40 | 215730.8 | 2273.0 | -98.95 | [-99.06, -98.82] | [-99.04, -98.84] | 0.010 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 40 | 4.3608 | 2.1440 | -50.83 | [-51.29, -50.41] | [-51.21, -50.48] | 0.491 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 40 | 5.6858 | 1.8798 | -66.94 | [-67.45, -66.39] | [-67.37, -66.49] | 0.327 | <0.0001 | faster/smaller |
| broker_user_s | 40 | 4.6504 | 1.5617 | -66.42 | [-66.81, -66.04] | [-66.74, -66.10] | 0.336 | <0.0001 | faster/smaller |
| broker_sys_s | 40 | 7.3933 | 1.7187 | -76.75 | [-77.12, -76.37] | [-77.06, -76.44] | 0.232 | <0.0001 | faster/smaller |
| broker_cpu_s | 40 | 12.0437 | 3.2804 | -72.76 | [-73.05, -72.46] | [-73.01, -72.51] | 0.272 | <0.0001 | faster/smaller |
| broker_vcsw | 40 | 22.750 | 15269.000 | +67016.48 | [+59466.40, +76438.40] | [+60549.70, +74740.91] | 744.600 | <0.0001 | slower/larger |
| broker_maxrss_kib | 40 | 8439 | 11322 | +34.16 | [+31.72, +36.52] | [+32.11, +36.15] | 1.353 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20586 | 20590 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 6.3121 | 1.9499 | -4.3560 | [-4.3730, -4.3391] |
| multi_s | 5.6977 | 2.1820 | -3.5170 | [-3.5531, -3.4809] |
| client_wall_s | 12.0288 | 4.1769 | -7.8732 | [-7.9181, -7.8282] |
| client_cpu_s | 8.0562 | 4.0128 | -4.0645 | [-4.1023, -4.0266] |
| client_vcsw | 216403.0 | 2061.0 | -213457.8 | [-215199.6, -211716.0] |
| multi_client_cpu_s | 4.3400 | 2.1300 | -2.2168 | [-2.2455, -2.1880] |
| multi_broker_cpu_s | 5.6650 | 1.8500 | -3.8060 | [-3.8493, -3.7627] |
| broker_user_s | 4.6346 | 1.5539 | -3.0888 | [-3.1176, -3.0599] |
| broker_sys_s | 7.3786 | 1.7139 | -5.6745 | [-5.7189, -5.6301] |
| broker_cpu_s | 12.0042 | 3.2547 | -8.7633 | [-8.8150, -8.7116] |
| broker_vcsw | 20.000 | 15467.500 | +15246.250 | [+14924.926, +15567.574] |
| broker_maxrss_kib | 8384 | 11236 | +2883 | [+2689, +3077] |
| broker_ru_maxrss_kib | 20628 | 20628 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
