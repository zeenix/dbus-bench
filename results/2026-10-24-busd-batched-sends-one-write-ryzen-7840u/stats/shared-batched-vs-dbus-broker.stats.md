candidate batched against baseline dbus-broker, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/shared.json
40 pairs (rounds 3 to 42); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 40 | 1.8517 | 1.9677 | +6.27 | [+5.29, +7.26] | [+5.45, +7.09] | 1.059 | <0.0001 | slower/larger |
| multi_s | 40 | 2.0985 | 2.1975 | +4.72 | [+3.70, +5.72] | [+3.88, +5.57] | 1.049 | <0.0001 | inconclusive; repeatable change (+) |
| client_wall_s | 40 | 3.9801 | 4.1959 | +5.42 | [+4.81, +6.05] | [+4.89, +5.95] | 1.055 | <0.0001 | inconclusive; repeatable change (+) |
| client_cpu_s | 40 | 3.9440 | 4.0286 | +2.14 | [+1.62, +2.68] | [+1.70, +2.59] | 1.025 | <0.0001 | no material change; repeatable change (+) |
| client_vcsw | 40 | 252.1 | 2273.0 | +801.64 | [+679.65, +969.61] | [+696.83, +939.84] | 9.472 | <0.0001 | slower/larger |
| multi_client_cpu_s | 40 | 2.0830 | 2.1440 | +2.93 | [+1.95, +3.90] | [+2.11, +3.75] | 1.029 | <0.0001 | no material change; repeatable change (+) |
| multi_broker_cpu_s | 40 | 1.4745 | 1.8798 | +27.48 | [+25.60, +29.51] | [+25.88, +29.15] | 1.266 | <0.0001 | slower/larger |
| broker_user_s | 40 | 0.9253 | 1.5617 | +68.77 | [+66.65, +70.90] | [+66.99, +70.58] | 1.677 | <0.0001 | slower/larger |
| broker_sys_s | 40 | 1.6896 | 1.7187 | +1.73 | [+0.28, +3.21] | [+0.50, +2.96] | 1.014 | 0.0424 | no material change; repeatable change (+) |
| broker_cpu_s | 40 | 2.6149 | 3.2804 | +25.45 | [+24.23, +26.77] | [+24.40, +26.53] | 1.245 | <0.0001 | slower/larger |
| broker_vcsw | 40 | 103067.4 | 15269.0 | -85.19 | [-85.63, -84.77] | [-85.55, -84.83] | 0.151 | <0.0001 | faster/smaller |
| broker_maxrss_kib | 40 | 9279 | 11322 | +22.02 | [+20.12, +23.96] | [+20.41, +23.62] | 1.229 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 40 | 20586 | 20590 | +0.02 | [+0.00, +0.05] | [+0.00, +0.05] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 1.8470 | 1.9499 | +0.1160 | [+0.0975, +0.1346] |
| multi_s | 2.0894 | 2.1820 | +0.0991 | [+0.0773, +0.1209] |
| client_wall_s | 3.9679 | 4.1769 | +0.2159 | [+0.1894, +0.2424] |
| client_cpu_s | 3.9299 | 4.0128 | +0.0845 | [+0.0624, +0.1067] |
| client_vcsw | 198.0 | 2061.0 | +2020.9 | [+1772.0, +2269.9] |
| multi_client_cpu_s | 2.0750 | 2.1300 | +0.0610 | [+0.0401, +0.0819] |
| multi_broker_cpu_s | 1.4650 | 1.8500 | +0.4053 | [+0.3753, +0.4352] |
| broker_user_s | 0.9226 | 1.5539 | +0.6363 | [+0.6179, +0.6547] |
| broker_sys_s | 1.6773 | 1.7139 | +0.0292 | [+0.0031, +0.0552] |
| broker_cpu_s | 2.5974 | 3.2547 | +0.6655 | [+0.6310, +0.7000] |
| broker_vcsw | 102494.5 | 15467.5 | -87798.4 | [-89748.3, -85848.5] |
| broker_maxrss_kib | 9294 | 11236 | +2043 | [+1867, +2219] |
| broker_ru_maxrss_kib | 20628 | 20628 | +3 | [-3, +10] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
