#!/usr/bin/env python3
"""Tabulate runs.json: the medians of builds of the benchmark against those of a baseline build.

Usage: analyze.py RUNS_JSON BASELINE BUILD...

For each broker and metric, prints the median of the baseline build, then for each other build its
median, its change from the baseline's and the p-value of a two-sided Mann-Whitney U test (20,000
permutations), as Markdown. The warmup runs are left out. Each broker's table is followed by the
median share of the multi-client phase that the client was busy.
"""

import json
import random
import statistics
import sys
from collections import defaultdict

METRICS = [
    "single_s", "multi_s", "client_cpu_s", "multi_client_cpu_s", "broker_cpu_s",
    "multi_broker_cpu_s",
]
PERMUTATIONS = 20_000


def main() -> None:
    path, baseline, *builds = sys.argv[1:]
    with open(path, encoding="utf-8") as f:
        doc = json.load(f)
    values = defaultdict(list)  # (build, broker, metric) -> values
    busy = defaultdict(list)  # (build, broker) -> shares of the multi-client phase
    for run in doc["runs"]:
        if run["warmup"]:
            continue
        for metric in METRICS:
            if run[metric] is not None:
                values[(run["build"], run["label"], metric)].append(run[metric])
        if run["multi_client_cpu_s"] is not None:
            busy[(run["build"], run["label"])].append(run["multi_client_cpu_s"] / run["multi_s"])
    rng = random.Random(0)
    for broker in doc["brokers"]:
        print(f"\n## {broker}\n")
        print("| metric | " + " | ".join([baseline, *builds]) + " |")
        print("|---|" + "---:|" * (1 + len(builds)))
        for metric in METRICS:
            base = values[(baseline, broker, metric)]
            base_median = statistics.median(base)
            cells = [f"{base_median:.3f}"]
            for build in builds:
                these = values[(build, broker, metric)]
                median = statistics.median(these)
                change = (median - base_median) / base_median * 100
                p = mann_whitney_p(these, base, rng)
                cells.append(f"{median:.3f} ({change:+.1f}%, p = {p:.4f})")
            print(f"| {metric} | " + " | ".join(cells) + " |")
        shares = ", ".join(
            f"{build} {statistics.median(busy[(build, broker)]):.0%}"
            for build in [baseline, *builds]
        )
        print(f"\nShare of the multi-client phase that the client was busy (median): {shares}")


def mann_whitney_p(x: list[float], y: list[float], rng: random.Random) -> float:
    """The p-value of a two-sided Mann-Whitney U test of x against y, by permutation."""
    pooled = ranks(x + y)
    centre = len(x) * (len(pooled) + 1) / 2
    observed = abs(sum(pooled[: len(x)]) - centre)
    hits = 0
    for _ in range(PERMUTATIONS):
        rng.shuffle(pooled)
        if abs(sum(pooled[: len(x)]) - centre) >= observed - 1e-9:
            hits += 1
    return (hits + 1) / (PERMUTATIONS + 1)


def ranks(values: list[float]) -> list[float]:
    """The ranks of the values, from 1, with tied values sharing the mean of their ranks."""
    order = sorted(range(len(values)), key=lambda i: values[i])
    result = [0.0] * len(values)
    start = 0
    while start < len(order):
        end = start
        while end + 1 < len(order) and values[order[end + 1]] == values[order[start]]:
            end += 1
        for k in range(start, end + 1):
            result[order[k]] = (start + end) / 2 + 1
        start = end + 1
    return result


if __name__ == "__main__":
    main()
