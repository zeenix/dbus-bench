candidate baseline against baseline dbus-daemon, from /tmp/send-timeout-bench/send-timeout-results-7f3ba5a-zruntime-99e2ebd/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.1358 | 0.0713 | -47.47 | [-48.15, -46.80] | [-48.04, -46.91] | 0.525 | <0.0001 | faster/smaller |
| multi_s | 60 | 1.1594 | 0.4521 | -61.01 | [-61.26, -60.74] | [-61.22, -60.78] | 0.391 | <0.0001 | faster/smaller |
| client_wall_s | 60 | 1.3263 | 0.5542 | -58.22 | [-58.47, -57.96] | [-58.43, -58.00] | 0.418 | <0.0001 | faster/smaller |
| client_cpu_s | 60 | 0.9476 | 0.4835 | -48.98 | [-49.29, -48.65] | [-49.24, -48.71] | 0.508 | <0.0001 | faster/smaller |
| client_vcsw | 60 | 27044.0 | 2234.9 | -91.74 | [-91.87, -91.60] | [-91.85, -91.62] | 0.082 | <0.0001 | faster/smaller |
| multi_client_cpu_s | 60 | 0.8793 | 0.4347 | -50.57 | [-50.93, -50.18] | [-50.87, -50.25] | 0.492 | <0.0001 | faster/smaller |
| multi_broker_cpu_s | 60 | 1.1312 | 0.3512 | -68.96 | [-69.21, -68.69] | [-69.18, -68.73] | 0.310 | <0.0001 | faster/smaller |
| broker_user_s | 60 | 0.5059 | 0.1969 | -61.09 | [-61.72, -60.47] | [-61.61, -60.57] | 0.391 | <0.0001 | faster/smaller |
| broker_sys_s | 60 | 0.7492 | 0.2190 | -70.77 | [-71.15, -70.39] | [-71.08, -70.45] | 0.291 | <0.0001 | faster/smaller |
| broker_cpu_s | 60 | 1.2551 | 0.4159 | -66.86 | [-67.05, -66.68] | [-67.02, -66.71] | 0.331 | <0.0001 | faster/smaller |
| broker_vcsw | 60 | 2048.2 | 5542.6 | +170.61 | [+167.69, +173.49] | [+168.19, +173.02] | 2.701 | <0.0001 | slower/larger |
| broker_maxrss_kib | 60 | 6201 | 6669 | +7.55 | [+6.93, +8.17] | [+7.03, +8.07] | 1.076 | <0.0001 | slower/larger |
| broker_ru_maxrss_kib | 60 | 20658 | 20660 | +0.01 | [+0.00, +0.03] | [+0.00, +0.03] | 1.000 | 0.3173 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.1347 | 0.0707 | -0.0644 | [-0.0659, -0.0629] |
| multi_s | 1.1531 | 0.4500 | -0.7073 | [-0.7125, -0.7021] |
| client_wall_s | 1.3185 | 0.5506 | -0.7721 | [-0.7777, -0.7665] |
| client_cpu_s | 0.9452 | 0.4804 | -0.4641 | [-0.4683, -0.4598] |
| client_vcsw | 26769.5 | 2203.0 | -24809.1 | [-25105.6, -24512.6] |
| multi_client_cpu_s | 0.8800 | 0.4300 | -0.4447 | [-0.4492, -0.4402] |
| multi_broker_cpu_s | 1.1300 | 0.3500 | -0.7800 | [-0.7854, -0.7746] |
| broker_user_s | 0.5050 | 0.1968 | -0.3091 | [-0.3145, -0.3037] |
| broker_sys_s | 0.7493 | 0.2206 | -0.5302 | [-0.5352, -0.5251] |
| broker_cpu_s | 1.2479 | 0.4145 | -0.8392 | [-0.8441, -0.8344] |
| broker_vcsw | 2035.5 | 5559.0 | +3494.4 | [+3436.5, +3552.3] |
| broker_maxrss_kib | 6176 | 6688 | +468 | [+430, +506] |
| broker_ru_maxrss_kib | 20696 | 20696 | +2 | [-2, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
