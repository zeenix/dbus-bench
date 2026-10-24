candidate batched against baseline queue, from /tmp/batched-sends-bench/batched-sends-results-ac6e6fa/calls.json
60 pairs (rounds 3 to 62); margin +-5%; bootstrap of 10000 resamples, seed 1

| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % | median ratio | Wilcoxon p | verdict |
|---|---:|---:|---:|---:|---|---|---:|---:|---|
| single_s | 60 | 0.0719 | 0.0715 | -0.55 | [-1.59, +0.51] | [-1.43, +0.34] | 0.997 | 0.4034 | no material change |
| multi_s | 60 | 0.4639 | 0.4647 | +0.17 | [-0.90, +1.25] | [-0.71, +1.07] | 0.996 | 0.9062 | no material change |
| client_wall_s | 60 | 0.5633 | 0.5639 | +0.11 | [-0.84, +1.09] | [-0.66, +0.91] | 0.998 | 0.9121 | no material change |
| client_cpu_s | 60 | 0.4920 | 0.4929 | +0.17 | [-0.68, +0.99] | [-0.53, +0.86] | 1.004 | 0.5961 | no material change |
| client_vcsw | 60 | 2474.3 | 2554.7 | +3.25 | [-0.53, +7.37] | [+0.08, +6.65] | 1.021 | 0.1460 | inconclusive |
| multi_client_cpu_s | 60 | 0.4432 | 0.4450 | +0.41 | [-0.71, +1.51] | [-0.49, +1.32] | 1.000 | 0.2999 | no material change |
| multi_broker_cpu_s | 60 | 0.3645 | 0.3647 | +0.05 | [-1.23, +1.32] | [-1.00, +1.11] | 1.000 | 0.7544 | no material change |
| broker_user_s | 60 | 0.2083 | 0.2105 | +1.06 | [-1.11, +3.37] | [-0.78, +3.00] | 1.017 | 0.3652 | no material change |
| broker_sys_s | 60 | 0.2178 | 0.2161 | -0.78 | [-2.46, +0.99] | [-2.21, +0.68] | 0.989 | 0.3731 | no material change |
| broker_cpu_s | 60 | 0.4261 | 0.4266 | +0.12 | [-0.81, +1.08] | [-0.67, +0.92] | 0.994 | 0.7404 | no material change |
| broker_vcsw | 60 | 5423.9 | 5534.9 | +2.05 | [+0.12, +3.99] | [+0.42, +3.69] | 1.022 | 0.0625 | no material change; repeatable change (+) |
| broker_maxrss_kib | 60 | 6709 | 6694 | -0.22 | [-0.92, +0.49] | [-0.82, +0.38] | 0.996 | 0.5461 | no material change |
| broker_ru_maxrss_kib | 60 | 20527 | 20527 | +0.00 | [-0.03, +0.03] | [-0.02, +0.02] | 1.000 | 1.0000 | no material change |

### Differences in the units of the metrics

| metric | baseline median | candidate median | mean diff (candidate - baseline) | 95% CI of the mean diff |
|---|---:|---:|---:|---|
| single_s | 0.0718 | 0.0711 | -0.0004 | [-0.0012, +0.0004] |
| multi_s | 0.4637 | 0.4645 | +0.0008 | [-0.0042, +0.0057] |
| client_wall_s | 0.5623 | 0.5651 | +0.0006 | [-0.0047, +0.0060] |
| client_cpu_s | 0.4914 | 0.4921 | +0.0008 | [-0.0033, +0.0050] |
| client_vcsw | 2481.5 | 2492.0 | +80.4 | [-18.4, +179.2] |
| multi_client_cpu_s | 0.4400 | 0.4450 | +0.0018 | [-0.0031, +0.0067] |
| multi_broker_cpu_s | 0.3650 | 0.3600 | +0.0002 | [-0.0045, +0.0049] |
| broker_user_s | 0.2081 | 0.2083 | +0.0022 | [-0.0025, +0.0070] |
| broker_sys_s | 0.2206 | 0.2158 | -0.0017 | [-0.0056, +0.0022] |
| broker_cpu_s | 0.4266 | 0.4256 | +0.0005 | [-0.0036, +0.0046] |
| broker_vcsw | 5424.0 | 5572.0 | +111.1 | [+3.5, +218.7] |
| broker_maxrss_kib | 6720 | 6682 | -14 | [-64, +35] |
| broker_ru_maxrss_kib | 20504 | 20504 | +0 | [-6, +6] |

diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-5%): "no material change" if the 90% CI lies within the
margin, "slower/larger" or "faster/smaller" if the 95% CI lies beyond it, "inconclusive" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.
