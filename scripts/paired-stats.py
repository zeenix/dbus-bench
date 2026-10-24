#!/usr/bin/env python3
r"""Compare two labels of a results file in pairs, round by round.

The results files that compare-brokers.py and compare-latency.py write hold one run of every label
in every round, and the labels of a round run in a random order, close together in time. The two
runs of a round therefore share most of the machine's drift, and comparing them as pairs, rather
than as two independent samples, cancels it. This script pairs the measured runs of --baseline and
--candidate by round (warmup runs are always left out, and so is a round in which either label has
no run, such as one that failed) and says, for each metric, whether the candidate changed it by
more than a margin.

Usage::

    scripts/paired-stats.py RESULTS.json --baseline LABEL --candidate LABEL \
        [--metric NAME ...] [--margin 5] [--json OUT]
    scripts/paired-stats.py --self-test

Put RESULTS.json before --metric, which takes every word up to the next option. The metrics are
the fields of the runs: by default each one that is a number in every measured run of both labels,
less ``round`` and ``broker_exit`` (an exit status, not a measurement). ``--metric`` names others,
and then the pairs of rounds in which either label lacks the field (or has null there) are left out
of that metric alone, which its ``n`` shows. The fields that some runs lack are named on standard
error, as not compared by default.

Per metric (a row of the table on standard output; the medians and the mean difference are in a
second table below it, and every number is in the ``--json`` file):

    n                   the number of pairs
    baseline mean,      the mean and the median of each label over the pairs
    candidate mean
    diff                the mean of the paired differences, candidate - baseline, with its 95%
                        confidence interval from the paired t interval, mean +- t * s / sqrt(n)
                        (s is the sample standard deviation of the differences and t the 97.5%
                        quantile of Student's t distribution with n - 1 degrees of freedom)
    diff %              100 * (mean_candidate / mean_baseline - 1), the change relative to the
                        baseline, with two confidence intervals from one percentile bootstrap: the
                        rounds are resampled with replacement 10000 times (always from the seed 1,
                        so a run can be repeated exactly), the same rounds for both labels, and the
                        ratio of the means is taken in each resample. The 95% interval is the
                        2.5th to the 97.5th percentile of the 10000 values and the 90% interval
                        the 5th to the 95th (percentiles by linear interpolation between order
                        statistics, as numpy's default). A resample whose baseline mean is not
                        positive has no ratio and is left out (counted in the JSON file).
    median ratio        the median over the pairs of candidate / baseline (pairs whose baseline is
                        0 have no ratio)
    Wilcoxon p          the two-sided p-value of the Wilcoxon signed-rank test of the differences,
                        by its normal approximation: pairs without a difference are dropped, ties
                        among the absolute differences get their average rank and the variance is
                        corrected for them, and there is no continuity correction (as in scipy's
                        default). Only the pairs that differ count, so it is crude for fewer than
                        about 10 of them. It is shown for reference and never decides the verdict.
    verdict             decided by the margin M (--margin, in percent, 5 by default) and the
                        bootstrap intervals of diff % alone:

        no material change   the 90% interval lies within (-M, +M) entirely: the change is
                             shown to be smaller than M (this is the equivalence test, TOST:
                             two one-sided tests at the 5% level)
        slower/larger        the 95% interval lies above +M entirely
        faster/smaller       the 95% interval lies below -M entirely
        inconclusive         anything else: the data cannot tell whether the change is within
                             the margin (also when diff % is undefined, as when the baseline mean
                             is 0, or there are fewer than 2 pairs)

    repeatable change   a flag next to the verdict when the 95% interval excludes 0, which means a
                        change of the sign shown is likely whatever its size, even if it is
                        within the margin (a change larger than M is repeatable by definition,
                        and the verdict says no more than that)

The metrics are for values where less is better, which the words of the verdicts assume. The
numbers are in the units of the field, seconds, KiB or microseconds, as the end of its name says
(_s, _kib, _us), and other fields, such as counts, as they are.

``--json OUT`` writes every number: for each metric also the medians, the mean difference with its
interval and standard error, the t quantile, the Wilcoxon statistics, and the rounds that were
paired and those that were left out.

``--self-test`` checks the statistics against published values and exact results and exits with
status 0 if they all pass. It needs no results file.

Only the Python standard library is used, so Student's t quantile comes from the regularized
incomplete beta function (a continued fraction, evaluated by Lentz's method) inverted by bisection.
With few pairs (under about 10) the intervals are too narrow and the Wilcoxon approximation is
poor: take 15 rounds or more. Means are sensitive to the odd slow run, so where the percent
difference and the median ratio disagree, look at the runs.
"""

from __future__ import annotations

import argparse
import json
import math
import os
import random
import statistics
import sys
from typing import NoReturn

RESAMPLES = 10000  # bootstrap resamples
SEED = 1  # seed of the bootstrap
FEW = 10  # fewer pairs than this get a warning
ENOUGH = 15  # the number of pairs that the warning advises
SKIPPED = {"round", "broker_exit"}  # numeric fields of a run that are not metrics

NO_CHANGE = "no material change"
LARGER = "slower/larger"
SMALLER = "faster/smaller"
INCONCLUSIVE = "inconclusive"


# Student's t distribution, from the regularized incomplete beta function.

def betacf(a: float, b: float, x: float) -> float:
    """The continued fraction of the incomplete beta function I_x(a, b), by Lentz's method."""
    tiny = 1e-300  # stands in for a zero that Lentz's method must not divide by
    qab, qap, qam = a + b, a + 1.0, a - 1.0
    c = 1.0
    d = 1.0 - qab * x / qap
    d = 1.0 / (d if abs(d) > tiny else tiny)
    h = d
    for m in range(1, 10001):
        m2 = 2 * m
        # An even and an odd term of the fraction per step.
        aa = m * (b - m) * x / ((qam + m2) * (a + m2))
        d = 1.0 + aa * d
        d = 1.0 / (d if abs(d) > tiny else tiny)
        c = 1.0 + aa / c
        c = c if abs(c) > tiny else tiny
        h *= d * c
        aa = -(a + m) * (qab + m) * x / ((a + m2) * (qap + m2))
        d = 1.0 + aa * d
        d = 1.0 / (d if abs(d) > tiny else tiny)
        c = 1.0 + aa / c
        c = c if abs(c) > tiny else tiny
        delta = d * c
        h *= delta
        if abs(delta - 1.0) < 1e-15:
            return h
    raise ArithmeticError(f"the continued fraction of I_{x}({a}, {b}) does not converge")


def betainc(a: float, b: float, x: float) -> float:
    """The regularized incomplete beta function I_x(a, b), for a, b > 0 and 0 <= x <= 1."""
    if not 0.0 <= x <= 1.0:
        raise ValueError(f"x = {x} is not in [0, 1]")
    if x == 0.0 or x == 1.0:
        return x
    front = math.exp(math.lgamma(a + b) - math.lgamma(a) - math.lgamma(b)
                     + a * math.log(x) + b * math.log1p(-x))
    # The fraction converges quickly for x below the mean of the distribution: use the symmetry
    # I_x(a, b) = 1 - I_(1-x)(b, a) for the others.
    if x < (a + 1.0) / (a + b + 2.0):
        return front * betacf(a, b, x) / a
    return 1.0 - front * betacf(b, a, 1.0 - x) / b


def t_sf(t: float, df: float) -> float:
    """P(T > t) for Student's t distribution with df degrees of freedom."""
    tail = 0.5 * betainc(df / 2.0, 0.5, df / (df + t * t))  # P(T > |t|)
    return tail if t >= 0 else 1.0 - tail


def t_cdf(t: float, df: float) -> float:
    return 1.0 - t_sf(t, df)


def t_ppf(p: float, df: float) -> float:
    """The quantile of Student's t distribution: t with P(T <= t) = p, by bisection."""
    if not 0.0 < p < 1.0:
        raise ValueError(f"p = {p} is not in (0, 1)")
    if p == 0.5:
        return 0.0
    if p < 0.5:
        return -t_ppf(1.0 - p, df)
    upper = 1.0 - p  # t_sf falls as t rises: find where it reaches this
    lo, hi = 0.0, 1.0
    while t_sf(hi, df) > upper:
        lo, hi = hi, hi * 2.0
        if hi > 1e300:
            raise ArithmeticError(f"no t quantile for p = {p}")
    for _ in range(300):
        mid = (lo + hi) / 2.0
        if t_sf(mid, df) > upper:
            lo = mid
        else:
            hi = mid
        if hi - lo <= 1e-14 * hi:
            break
    return (lo + hi) / 2.0


# The statistics of one metric.

def quantile(ordered: list[float], q: float) -> float:
    """The quantile q of sorted values, by linear interpolation between the order statistics."""
    pos = q * (len(ordered) - 1)
    below = int(math.floor(pos))
    above = min(below + 1, len(ordered) - 1)
    return ordered[below] + (ordered[above] - ordered[below]) * (pos - below)


_resamples: dict[tuple[int, int, int], list[list[int]]] = {}


def resample_indices(n: int, resamples: int, seed: int) -> list[list[int]]:
    """The indices of the pairs in each bootstrap resample: n draws with replacement from range(n).

    The draws depend only on n, so they are made once and shared by the metrics (which come out
    the same as if each metric started a generator of its own from the seed). They are made from
    random(), whose stream the random module guarantees, rather than from choices() or randrange(),
    whose algorithm it may change, so a result can be reproduced with any Python.
    """
    key = (n, resamples, seed)
    if key not in _resamples:
        rand = random.Random(seed).random
        _resamples[key] = [[int(rand() * n) for _ in range(n)] for _ in range(resamples)]
    return _resamples[key]


def bootstrap_percent(base: list[float], cand: list[float], resamples: int, seed: int
                      ) -> tuple[list[float], int]:
    """100 * (mean_candidate / mean_baseline - 1) in each resample of the pairs, sorted, and how
    many resamples had no such value (their baseline mean was not positive)."""
    get_base, get_cand = base.__getitem__, cand.__getitem__
    values, skipped = [], 0
    for indices in resample_indices(len(base), resamples, seed):
        base_sum = sum(map(get_base, indices))
        if base_sum <= 0.0:
            skipped += 1
            continue
        values.append(100.0 * (sum(map(get_cand, indices)) / base_sum - 1.0))
    values.sort()
    return values, skipped


def wilcoxon(diffs: list[float], tol: float = 0.0) -> dict | None:
    """The Wilcoxon signed-rank test of paired differences, by the normal approximation.

    Differences up to `tol` in size count as 0 and are dropped; absolute differences within `tol`
    of each other are tied (floating-point noise would split ties otherwise, such as those of
    values counted in clock ticks), and get the average of their ranks. The variance has the
    correction for ties, n(n+1)(2n+1)/24 - sum(t^3 - t)/48 over the groups of t tied values. The
    p-value is two-sided, without continuity correction. None if no difference is left.
    """
    nonzero = [d for d in diffs if abs(d) > tol]
    n = len(nonzero)
    if n == 0:
        return None
    order = sorted(range(n), key=lambda i: abs(nonzero[i]))
    ranks = [0.0] * n
    ties = []  # the sizes of the groups of tied values
    start = 0
    while start < n:
        end = start
        while end + 1 < n and abs(nonzero[order[end + 1]]) - abs(nonzero[order[start]]) <= tol:
            end += 1
        for k in range(start, end + 1):
            ranks[order[k]] = (start + end) / 2.0 + 1.0
        if end > start:
            ties.append(end - start + 1)
        start = end + 1
    w_plus = sum(rank for rank, d in zip(ranks, nonzero) if d > 0)
    mean = n * (n + 1) / 4.0
    variance = n * (n + 1) * (2 * n + 1) / 24.0 - sum(t ** 3 - t for t in ties) / 48.0
    z = (w_plus - mean) / math.sqrt(variance)
    return {"p": math.erfc(abs(z) / math.sqrt(2.0)), "z": z, "w_plus": w_plus,
            "n_nonzero": n, "variance": variance, "ranks": ranks}


def classify(ci95: list[float] | None, ci90: list[float] | None, margin: float
             ) -> tuple[str, bool]:
    """The verdict on the change in percent, and whether it is a repeatable change."""
    if ci95 is None or ci90 is None:
        return INCONCLUSIVE, False
    repeatable = ci95[0] > 0.0 or ci95[1] < 0.0
    # The 90% interval lies within the 95% one, so at most one of the first three holds.
    if ci90[0] > -margin and ci90[1] < margin:
        return NO_CHANGE, repeatable
    if ci95[0] > margin:
        return LARGER, repeatable
    if ci95[1] < -margin:
        return SMALLER, repeatable
    return INCONCLUSIVE, repeatable


def analyze(metric: str, base: list[float], cand: list[float], margin: float,
            resamples: int = RESAMPLES, seed: int = SEED) -> dict:
    """Every statistic of one metric, from its values in the paired rounds (equally many)."""
    n = len(base)
    diffs = [c - b for b, c in zip(base, cand)]
    tol = 1e-9 * max(abs(x) for x in (*base, *cand))  # below this, differences are rounding
    mean_base, mean_cand = statistics.fmean(base), statistics.fmean(cand)
    mean_diff = statistics.fmean(diffs)
    notes = []

    diff = {"mean": mean_diff, "sd": None, "se": None, "df": n - 1, "t": None, "ci95": None}
    if n >= 2:
        sd = statistics.stdev(diffs)
        t = t_ppf(0.975, n - 1)
        se = sd / math.sqrt(n)
        diff.update(sd=sd, se=se, t=t, ci95=[mean_diff - t * se, mean_diff + t * se])

    pct = {"value": None, "ci95": None, "ci90": None, "resamples": 0, "skipped": 0}
    if all(abs(d) <= tol for d in diffs):  # the same in every pair, even if it is 0 (no ratio)
        pct["value"] = 0.0
        if n >= 2:
            pct.update(ci95=[0.0, 0.0], ci90=[0.0, 0.0])
    elif mean_base <= 0.0:
        notes.append("the baseline mean is not positive, so there is no percent difference")
    else:
        pct["value"] = 100.0 * (mean_cand / mean_base - 1.0)
        if n >= 2:
            values, skipped = bootstrap_percent(base, cand, resamples, seed)
            pct.update(resamples=len(values), skipped=skipped)
            if skipped:
                notes.append(f"{skipped} bootstrap resamples had a baseline mean that is not "
                             f"positive and are left out")
            if values:
                pct.update(ci95=[quantile(values, 0.025), quantile(values, 0.975)],
                           ci90=[quantile(values, 0.05), quantile(values, 0.95)])
    if n < 2:
        notes.append("one pair only: no intervals")

    ratios = [c / b for b, c in zip(base, cand) if b != 0.0]
    test = wilcoxon(diffs, tol)
    verdict, repeatable = classify(pct["ci95"], pct["ci90"], margin)
    return {
        "metric": metric, "n": n,
        "baseline": {"mean": mean_base, "median": statistics.median(base)},
        "candidate": {"mean": mean_cand, "median": statistics.median(cand)},
        "diff": diff, "pct": pct,
        "median_ratio": statistics.median(ratios) if ratios else None,
        "wilcoxon": None if test is None else {k: v for k, v in test.items() if k != "ranks"},
        "verdict": verdict, "repeatable_change": repeatable, "notes": notes,
    }


# The results file.

def is_number(value: object) -> bool:
    return (isinstance(value, (int, float)) and not isinstance(value, bool)
            and math.isfinite(value))


def fail(message: str) -> NoReturn:
    sys.exit(f"{os.path.basename(sys.argv[0])}: error: {message}")


def load_results(path: str) -> dict:
    try:
        with open(path, encoding="utf-8") as f:
            data = json.load(f)
    except (OSError, ValueError) as e:
        fail(f"cannot read {path}: {e}")
    if not isinstance(data, dict) or not isinstance(data.get("runs"), list):
        fail(f"{path} has no list of runs: it is not a results file of compare-brokers.py "
             f"or compare-latency.py")
    return data


def measured_runs(data: dict, label: str) -> dict[int, dict]:
    """The measured (not warmup) runs of a label, by round."""
    runs: dict[int, dict] = {}
    for run in data["runs"]:
        if not isinstance(run, dict) or run.get("label") != label or run.get("warmup"):
            continue
        rnd = run.get("round")
        if not isinstance(rnd, int) or isinstance(rnd, bool):
            fail(f"a run of {label!r} has no round number")
        if rnd in runs:
            fail(f"{label!r} has two measured runs in round {rnd}: they cannot be paired")
        runs[rnd] = run
    if not runs:
        labels = sorted({run.get("label") for run in data["runs"] if isinstance(run, dict)
                         and not run.get("warmup") and isinstance(run.get("label"), str)})
        fail(f"no measured run of {label!r}; the file has: {', '.join(labels) or 'none'}")
    return runs


def default_metrics(runs: list[dict]) -> tuple[list[str], dict[str, int]]:
    """The fields that are a number in every one of the runs, in the order of the first run, and
    how many runs lack a number in each of the others that are a number in some run."""
    names = known_metrics(runs)
    missing = {name: sum(not is_number(run.get(name)) for run in runs) for name in names}
    return ([name for name in names if not missing[name] and name not in SKIPPED],
            {name: count for name, count in missing.items() if count and name not in SKIPPED})


def known_metrics(runs: list[dict]) -> list[str]:
    """The fields that are a number in some of the runs, in the order they are first seen."""
    names: dict[str, None] = {}
    for run in runs:
        names.update((name, None) for name, value in run.items()
                     if is_number(value) and name != "round")
    return list(names)


# Output.

def places(result: dict) -> int:
    """How many decimals the values of a metric get: by the unit that its name ends in, and for
    other fields, such as counts, by their size."""
    name = result["metric"]
    for suffix, decimals in (("_s", 4), ("_kib", 0), ("_us", 1)):
        if name.endswith(suffix):
            return decimals
    return 1 if abs(result["baseline"]["mean"]) >= 100 else 3


def fmt(value: float | None, decimals: int, sign: bool = False) -> str:
    if value is None:
        return "-"
    return f"{value:{'+' if sign else ''}.{decimals}f}"


def fmt_pct(value: float | None) -> str:
    return "-" if value is None else f"{value:+.2f}"


def fmt_interval(interval: list[float] | None) -> str:
    return "-" if interval is None else f"[{interval[0]:+.2f}, {interval[1]:+.2f}]"


def fmt_p(p: float | None) -> str:
    return "-" if p is None else "<0.0001" if p < 0.0001 else f"{p:.4f}"


def verdict_text(result: dict) -> str:
    text = result["verdict"]
    if result["repeatable_change"] and text in (NO_CHANGE, INCONCLUSIVE):
        text += f"; repeatable change ({'+' if result['pct']['ci95'][0] > 0 else '-'})"
    return text


def print_tables(results: list[dict], margin: float) -> None:
    print("| metric | n | baseline mean | candidate mean | diff % | 95% CI % | 90% CI % "
          "| median ratio | Wilcoxon p | verdict |")
    print("|---|---:|---:|---:|---:|---|---|---:|---:|---|")
    for r in results:
        d = places(r)
        ratio = r["median_ratio"]
        test = r["wilcoxon"]
        print(f"| {r['metric']} | {r['n']} | {fmt(r['baseline']['mean'], d)} "
              f"| {fmt(r['candidate']['mean'], d)} | {fmt_pct(r['pct']['value'])} "
              f"| {fmt_interval(r['pct']['ci95'])} | {fmt_interval(r['pct']['ci90'])} "
              f"| {'-' if ratio is None else f'{ratio:.3f}'} "
              f"| {fmt_p(None if test is None else test['p'])} | {verdict_text(r)} |")
    print("\n### Differences in the units of the metrics\n")
    print("| metric | baseline median | candidate median | mean diff (candidate - baseline) "
          "| 95% CI of the mean diff |")
    print("|---|---:|---:|---:|---|")
    for r in results:
        d = places(r)
        diff = r["diff"]
        ci = diff["ci95"]
        interval = "-" if ci is None else f"[{fmt(ci[0], d, True)}, {fmt(ci[1], d, True)}]"
        print(f"| {r['metric']} | {fmt(r['baseline']['median'], d)} "
              f"| {fmt(r['candidate']['median'], d)} | {fmt(diff['mean'], d, True)} "
              f"| {interval} |")
    print(f"""
diff % is 100 * (candidate mean / baseline mean - 1), with percentile bootstrap intervals over the
pairs (verdicts use the margin of +-{margin:g}%): "{NO_CHANGE}" if the 90% CI lies within the
margin, "{LARGER}" or "{SMALLER}" if the 95% CI lies beyond it, "{INCONCLUSIVE}" otherwise;
"repeatable change" if the 95% CI excludes 0. The Wilcoxon p-value is for reference only.""")
    for r in results:
        for note in r["notes"]:
            print(f"- {r['metric']}: {note}")


def describe_rounds(rounds: list[int], only_base: list[int], only_cand: list[int]) -> str:
    text = (f"{len(rounds)} pairs (rounds {min(rounds)} to {max(rounds)})" if len(rounds) > 1
            else f"1 pair (round {rounds[0]})")
    for name, left in (("baseline", only_base), ("candidate", only_cand)):
        if left:
            text += (f"; left out, as only the {name} has a run in it: round "
                     + ", ".join(map(str, left)))
    return text


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("results", nargs="?", metavar="RESULTS.json",
                   help="results of compare-brokers.py or compare-latency.py")
    p.add_argument("--baseline", metavar="LABEL", help="the label to compare against")
    p.add_argument("--candidate", metavar="LABEL", help="the label that is compared")
    p.add_argument("--metric", nargs="+", action="extend", metavar="NAME",
                   help="the metrics to compare (default: every field that is a number in "
                        "every measured run of both labels, less round and broker_exit)")
    p.add_argument("--margin", type=float, default=5.0, metavar="PERCENT",
                   help="the change that does not matter, in percent (default: %(default)g)")
    p.add_argument("--json", metavar="OUT", help="write every number here, as JSON")
    p.add_argument("--self-test", action="store_true",
                   help="check the statistics against known values and exit")
    args = p.parse_args()
    if args.self_test:
        return args
    if not (args.results and args.baseline and args.candidate):
        p.error("RESULTS.json, --baseline and --candidate are required")
    if args.baseline == args.candidate:
        p.error("--baseline and --candidate name the same label")
    if not math.isfinite(args.margin) or args.margin < 0:
        p.error("--margin must be 0 or more")
    return args


def main() -> int:
    args = parse_args()
    if args.self_test:
        return self_test()
    data = load_results(args.results)
    base_runs = measured_runs(data, args.baseline)
    cand_runs = measured_runs(data, args.candidate)
    rounds = sorted(base_runs.keys() & cand_runs.keys())
    only_base = sorted(base_runs.keys() - cand_runs.keys())
    only_cand = sorted(cand_runs.keys() - base_runs.keys())
    if not rounds:
        fail(f"{args.baseline!r} and {args.candidate!r} have no measured round in common")

    all_runs = [*base_runs.values(), *cand_runs.values()]
    lacking: dict[str, int] = {}
    if args.metric:
        metrics = list(dict.fromkeys(args.metric))
    else:
        metrics, lacking = default_metrics(all_runs)
        if lacking:
            print("note: not compared, as some runs have no number there (--metric NAME compares "
                  "the rounds that have): "
                  + ", ".join(f"{name} ({count} of {len(all_runs)} runs)"
                              for name, count in lacking.items()), file=sys.stderr)
    if not metrics:
        fail("no field is a number in every run of both labels; name metrics with --metric")
    for metric in metrics:
        if not any(is_number(run.get(metric)) for run in all_runs):
            fail(f"{metric!r} is not a numeric field of these runs; they have: "
                 f"{', '.join(known_metrics(all_runs))}")

    results = []
    for metric in metrics:
        pairs = [(base_runs[r][metric], cand_runs[r][metric]) for r in rounds
                 if is_number(base_runs[r].get(metric)) and is_number(cand_runs[r].get(metric))]
        if not pairs:
            fail(f"{metric!r} is not a number in any round of both labels")
        result = analyze(metric, [float(b) for b, _ in pairs], [float(c) for _, c in pairs],
                         args.margin)
        if len(pairs) < len(rounds):
            result["notes"].append(f"{len(rounds) - len(pairs)} of the {len(rounds)} paired "
                                   f"rounds lack this field in a run")
        results.append(result)

    if args.json:
        report = {
            "source": {"file": args.results, "started": data.get("started"),
                       "machine": data.get("machine"),
                       "meta": (data.get("config") or {}).get("meta")},
            "baseline": args.baseline, "candidate": args.candidate, "margin_pct": args.margin,
            "bootstrap": {"resamples": RESAMPLES, "seed": SEED,
                          "intervals": "percentile, linear interpolation"},
            "rounds": {"paired": rounds, "only_baseline": only_base, "only_candidate": only_cand},
            "not_compared": lacking,
            "metrics": results,
        }
        os.makedirs(os.path.dirname(os.path.abspath(args.json)), exist_ok=True)
        with open(args.json, "w", encoding="utf-8") as f:
            json.dump(report, f, indent=2, allow_nan=False)
            f.write("\n")

    if len(rounds) < FEW:
        print(f"warning: with {len(rounds)} pairs the intervals are too narrow and the Wilcoxon "
              f"approximation is poor; take {ENOUGH} rounds or more", file=sys.stderr)
    print(f"candidate {args.candidate} against baseline {args.baseline}, "
          f"from {args.results}")
    print(f"{describe_rounds(rounds, only_base, only_cand)}; margin +-{args.margin:g}%; "
          f"bootstrap of {RESAMPLES} resamples, seed {SEED}\n")
    print_tables(results, args.margin)
    return 0


# The self-test: published values, exact results and a synthetic comparison.

def exact_wilcoxon_p(diffs: list[int]) -> float:
    """The exact two-sided p-value of the signed-rank test, for distinct integer |differences|
    that rank 1..n: the count of every sum of a subset of 1..n by dynamic programming."""
    n = len(diffs)
    counts = [1] + [0] * (n * (n + 1) // 2)
    for rank in range(1, n + 1):
        for total in range(len(counts) - 1, rank - 1, -1):
            counts[total] += counts[total - rank]
    order = sorted(range(n), key=lambda i: abs(diffs[i]))
    w_plus = sum(rank for rank, i in enumerate(order, 1) if diffs[i] > 0)
    below = sum(counts[: w_plus + 1]) / 2 ** n
    above = sum(counts[w_plus:]) / 2 ** n
    return min(1.0, 2.0 * min(below, above))


def self_test() -> int:
    failed = 0

    def check(name: str, got: float, want: float, tol: float) -> None:
        nonlocal failed
        good = abs(got - want) <= tol
        failed += not good
        print(f"{'ok  ' if good else 'FAIL'} {name} = {got:.6f} (want {want:g} +- {tol:g})")

    def expect(name: str, good: bool, detail: str = "") -> None:
        nonlocal failed
        failed += not good
        print(f"{'ok  ' if good else 'FAIL'} {name}" + (f" ({detail})" if detail else ""))

    print("Student's t quantiles, against published values:")
    for p, df, want in ((0.975, 29, 2.04523), (0.975, 39, 2.02269), (0.975, 9, 2.26216),
                        (0.95, 29, 1.69913)):
        check(f"t_{{{p}, {df}}}", t_ppf(p, df), want, 6e-6)
    for p, df, want in ((0.975, 4, 2.776), (0.975, 10, 2.228), (0.975, 30, 2.042),
                        (0.975, 60, 2.000), (0.975, 120, 1.980), (0.95, 9, 1.833),
                        (0.995, 29, 2.756)):
        check(f"t_{{{p}, {df}}}", t_ppf(p, df), want, 6e-4)
    print("Student's t, against the exact forms of 1 and 2 degrees of freedom, and the normal:")
    for t in (0.3, 1.0, 2.5, 12.706):
        check(f"t_cdf({t}, 1)", t_cdf(t, 1), 0.5 + math.atan(t) / math.pi, 1e-12)
        check(f"t_cdf({t}, 2)", t_cdf(t, 2), 0.5 + t / (2 * math.sqrt(2 + t * t)), 1e-12)
    check("t_{0.975, 1e5} - z_{0.975}", t_ppf(0.975, 1e5) - 1.959963984540054, 2.4e-5, 2e-6)
    check("t_{0.025, 29} + t_{0.975, 29}", t_ppf(0.025, 29) + t_ppf(0.975, 29), 0.0, 1e-12)
    print("incomplete beta:")
    check("I_0.3(1, 1)", betainc(1, 1, 0.3), 0.3, 1e-14)
    check("I_0.3(4, 1)", betainc(4, 1, 0.3), 0.3 ** 4, 1e-14)
    check("I_0.3(1, 4)", betainc(1, 4, 0.3), 1 - 0.7 ** 4, 1e-14)
    check("I_0.5(7.5, 7.5)", betainc(7.5, 7.5, 0.5), 0.5, 1e-13)

    print("quantile (linear interpolation):")
    check("quantile([1, 2, 3, 4], 0.25)", quantile([1, 2, 3, 4], 0.25), 1.75, 1e-15)
    check("quantile(range(11), 0.9)", quantile(list(range(11)), 0.9), 9.0, 1e-15)

    print("Wilcoxon signed-rank, on Darwin's plant data as scipy documents it:")
    darwin = [6, 8, 14, 16, 23, 24, 28, 29, 41, -48, 49, 56, 60, -67, 75]
    exact = exact_wilcoxon_p(darwin)
    check("exact two-sided p (scipy: 0.041259765625)", exact, 0.041259765625, 1e-12)
    test = wilcoxon([float(d) for d in darwin])
    check("W+ = 120 - 24", test["w_plus"], 96.0, 1e-12)
    check("normal approximation against the exact p", test["p"], exact, 3e-3)
    print("Wilcoxon, with ties (absolute differences 1, 1, 2, 2, 2, 5, 7, 7, 9, a zero dropped):")
    tied = [1.0, -1.0, 2.0, 2.0, -2.0, 5.0, 7.0, -7.0, 9.0, 0.0]
    test = wilcoxon(tied)
    # Given the ranks, the statistic is the sum of the ranks with independent random signs: its
    # variance is sum(rank^2) / 4, which the formula with the correction for ties must equal.
    check("variance with the correction for ties", test["variance"],
          sum(r * r for r in test["ranks"]) / 4.0, 1e-12)
    check("ranks of the 9 differences add up to 45", sum(test["ranks"]), 45.0, 1e-12)
    jittered = wilcoxon([d * (1 + 1e-12 * i) for i, d in enumerate(tied)], tol=1e-9 * 9)
    check("floating-point noise does not split ties", jittered["variance"], test["variance"],
          1e-12)
    expect("no difference, no test", wilcoxon([0.0, 0.0]) is None)

    print("bootstrap and verdicts:")
    same = analyze("same", [1.0, 2.0, 3.0, 4.0], [1.0, 2.0, 3.0, 4.0], 5.0)
    check("identical values: diff %", same["pct"]["value"], 0.0, 1e-12)
    expect("identical values: CIs are [0, 0], so no material change",
           same["pct"]["ci95"] == [0.0, 0.0] and same["verdict"] == NO_CHANGE)
    tenth = analyze("tenth", [1.0, 2.0, 3.0, 4.0], [1.1, 2.2, 3.3, 4.4], 5.0)
    check("10% more in every pair: 95% CI low", tenth["pct"]["ci95"][0], 10.0, 1e-9)
    check("10% more in every pair: 90% CI high", tenth["pct"]["ci90"][1], 10.0, 1e-9)
    expect("10% more in every pair: slower/larger", tenth["verdict"] == LARGER)
    for ci95, ci90, margin, want, repeatable in (
            ([-1.4, 1.9], [-1.0, 1.5], 5.0, NO_CHANGE, False),
            ([0.5, 3.0], [0.8, 2.7], 5.0, NO_CHANGE, True),
            ([-3.0, -0.5], [-2.7, -0.8], 5.0, NO_CHANGE, True),
            ([5.2, 9.0], [5.5, 8.5], 5.0, LARGER, True),
            ([-9.0, -5.2], [-8.5, -5.5], 5.0, SMALLER, True),
            ([-2.0, 7.0], [-1.0, 6.0], 5.0, INCONCLUSIVE, False),
            ([3.0, 9.0], [3.5, 8.0], 5.0, INCONCLUSIVE, True),
            ([4.0, 8.0], [5.0, 7.0], 5.0, INCONCLUSIVE, True),  # 90% CI starts at the margin
            ([5.0, 8.0], [5.5, 7.0], 5.0, INCONCLUSIVE, True),  # 95% CI starts at the margin
            ([-4.9, 4.9], [-4.5, 4.5], 5.0, NO_CHANGE, False),
            ([-4.9, 4.9], [-4.5, 5.0], 5.0, INCONCLUSIVE, False)):
        got = classify(ci95, ci90, margin)
        expect(f"verdict for 95% {ci95}, 90% {ci90}, margin {margin:g}",
               got == (want, repeatable), f"{got[0]}, repeatable {got[1]}")
    expect("no intervals, no verdict", classify(None, None, 5.0) == (INCONCLUSIVE, False))

    print("a synthetic comparison, the candidate 2% above the baseline, 40 pairs:")
    rng = random.Random(20260101)
    base = [rng.gauss(0.09, 0.0009) for _ in range(40)]
    cand = [1.02 * b + rng.gauss(0.0, 0.0009) for b in base]
    found = analyze("synthetic_s", base, cand, 5.0)
    low, high = found["pct"]["ci95"]
    check("diff %", found["pct"]["value"], 2.0, 1.0)
    expect("95% CI contains 2", low < 2.0 < high, f"[{low:.2f}, {high:.2f}]")
    low, high = found["diff"]["ci95"]
    expect("t interval of the mean difference contains 0.02 * mean", low < 0.0018 < high,
           f"[{low:.5f}, {high:.5f}]")
    expect("verdict: no material change, repeatable",
           found["verdict"] == NO_CHANGE and found["repeatable_change"], verdict_text(found))

    print(f"{'all checks passed' if not failed else f'{failed} check(s) FAILED'}")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
