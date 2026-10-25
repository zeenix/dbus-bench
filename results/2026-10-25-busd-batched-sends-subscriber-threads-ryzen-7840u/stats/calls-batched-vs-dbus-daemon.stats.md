candidate batched against baseline dbus-daemon, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1351 | 0.0707 | -47.67 | [-48.37, -46.93] | [-48.26, -47.06] | 0.521 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1543 | 0.4470 | -61.28 | [-61.64, -60.96] | [-61.57, -61.00] | 0.388 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3187 | 0.5467 | -58.54 | [-58.90, -58.23] | [-58.83, -58.27] | 0.415 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9427 | 0.4784 | -49.25 | [-49.68, -48.83] | [-49.62, -48.89] | 0.506 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 26987.5 | 2276.2 | -91.57 | [-91.73, -91.40] | [-91.70, -91.43] | 0.083 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8735 | 0.4290 | -50.89 | [-51.35, -50.44] | [-51.27, -50.51] | 0.489 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1263 | 0.3487 | -69.04 | [-69.39, -68.73] | [-69.33, -68.77] | 0.311 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.4978 | 0.1980 | -60.23 | [-60.85, -59.62] | [-60.74, -59.71] | 0.399 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7516 | 0.2167 | -71.17 | [-71.58, -70.77] | [-71.51, -70.83] | 0.287 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2495 | 0.4147 | -66.81 | [-67.10, -66.55] | [-67.05, -66.58] | 0.332 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2051.9 | 5755.5 | +180.49 | [+177.12, +183.81] | [+177.73, +183.29] | 2.815 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6230 | 6708 | +7.67 | [+6.95, +8.38] | [+7.07, +8.27] | 1.078 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20395 | 20393 | -0.01 | [-0.03, +0.00] | [-0.03, +0.00] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1336 | 0.0707 | -0.0644 | [-0.0660, -0.0628] |
| multi_s | 1.1426 | 0.4431 | -0.7073 | [-0.7157, -0.6990] |
| client_wall_s | 1.3074 | 0.5424 | -0.7720 | [-0.7809, -0.7630] |
| client_cpu_s | 0.9352 | 0.4742 | -0.4643 | [-0.4702, -0.4585] |
| client_vcsw | 26744.0 | 2235.5 | -24711.3 | [-25031.0, -24391.7] |
| multi_client_cpu_s | 0.8700 | 0.4300 | -0.4445 | [-0.4504, -0.4386] |
| multi_broker_cpu_s | 1.1200 | 0.3500 | -0.7777 | [-0.7867, -0.7686] |
| broker_user_s | 0.4922 | 0.1967 | -0.2998 | [-0.3058, -0.2939] |
| broker_sys_s | 0.7483 | 0.2171 | -0.5350 | [-0.5414, -0.5285] |
| broker_cpu_s | 1.2394 | 0.4122 | -0.8348 | [-0.8434, -0.8262] |
| broker_vcsw | 2044.0 | 5772.0 | +3703.6 | [+3636.2, +3770.9] |
| broker_maxrss_kib | 6228 | 6722 | +478 | [+434, +522] |
| broker_ru_maxrss_kib | 20444 | 20444 | -2 | [-6, +2] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
