#!/bin/bash
# The runs of this directory: the paired comparisons of the queue of busd's main branch
# (baseline), the time limit of 1 s with sends one after the other (timeout) and the time limit
# of 100 ms with the sends of a message to all of its recipients at once (concurrent100), then the
# runs with clients that stop reading against the latter two. Every round of a comparison runs each
# broker once, in an order that is shuffled for each round (reproducibly, from --seed), on a fresh
# broker process each time, after WARMUP rounds (default: 3) that the tables leave out.
#
# Run it from the root of dbus-bench, with $BIN the directory of the binaries, $OUT the directory to
# write the results to and $PINGER the pinger of results/2026-10-20-busd-stalled-reader-xeon-4vcpu.
# The binaries are the builds of busd (busd-baseline, busd-timeout and busd-concurrent100) and the
# clients: dbus-bench (the benchmark itself), fanout, latency and shared of this repository, and
# dbus-bench-zbus43, which scripts/compare-send-timeout.sh says how to build. ROUNDS (default: 60)
# is the number of rounds of the comparisons of the calls, the signals and the latencies, and
# SHARED_ROUNDS (default: 40) that of the shared connection.
set -u
: "${BIN:?}" "${OUT:?}" "${PINGER:?}"
ROUNDS=${ROUNDS:-60}
SHARED_ROUNDS=${SHARED_ROUNDS:-40}
WARMUP=${WARMUP:-3}
stalls=results/2026-10-22-busd-send-timeout-xeon-4vcpu/stalls
export PINGER JOURNAL=
mkdir -p "$OUT"
brokers=(
    --broker baseline "$BIN/busd-baseline --address {address}"
    --broker timeout "$BIN/busd-timeout --address {address}"
    --broker concurrent100 "$BIN/busd-concurrent100 --address {address}"
)
meta=(--meta "rustc=$(rustc --version)" --meta "baseline=0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c"
    --meta "timeout=8d57e20 (the code of e93cec5)"
    --meta "concurrent100=7f3ba5a7b8289a390a01245c8b19b1f3f5d4ad6c")

echo "== calls: $ROUNDS rounds" >&2
python3 scripts/compare-brokers.py --bench "$BIN/dbus-bench" --rounds "$ROUNDS" \
    --warmup "$WARMUP" --seed 21 --out "$OUT/calls.json" "${meta[@]}" "${brokers[@]}" \
    > "$OUT/calls.md"
echo "== signals: $ROUNDS rounds" >&2
python3 scripts/compare-brokers.py --bench "$BIN/fanout" --rounds "$ROUNDS" --warmup "$WARMUP" \
    --seed 22 --out "$OUT/signals.json" "${meta[@]}" "${brokers[@]}" > "$OUT/signals.md"
echo "== latency: $ROUNDS rounds" >&2
python3 scripts/compare-latency.py --bench "$BIN/latency" --rounds "$ROUNDS" --warmup "$WARMUP" \
    --seed 23 --out "$OUT/latency.json" "${meta[@]}" "${brokers[@]}" > "$OUT/latency.md"
echo "== shared: $SHARED_ROUNDS rounds" >&2
DBUS_BENCH_CLIENTS=100 python3 scripts/compare-brokers.py --bench "$BIN/shared" \
    --rounds "$SHARED_ROUNDS" --warmup "$WARMUP" --seed 24 --out "$OUT/shared.json" \
    "${meta[@]}" "${brokers[@]}" > "$OUT/shared.md"
for workload in calls signals latency shared; do
    for pair in baseline:concurrent100 timeout:concurrent100 baseline:timeout; do
        base=${pair%:*} cand=${pair#*:}
        name=$workload-$cand
        [ "$base" = baseline ] || name=$workload-$cand-vs-$base
        python3 scripts/paired-stats.py "$OUT/$workload.json" --baseline "$base" \
            --candidate "$cand" --json "$OUT/$name.stats.json" > "$OUT/$name.stats.md"
    done
done

# Subscribers of the bus's own signals that stop reading, while new clients call the bus.
{
    K=1 "$stalls/frozen-timed.sh" "concurrent100 K=1" "$BIN/busd-concurrent100" 1500
    for k in 2 3 5; do
        K=$k "$stalls/frozen-timed.sh" "concurrent100 K=$k" "$BIN/busd-concurrent100" 600
    done
    for k in 3 5; do
        K=$k "$stalls/frozen-timed.sh" "timeout K=$k" "$BIN/busd-timeout" 600
    done
} 2>&1 | tee "$OUT/frozen.log"

# The zbus 4.3 client of the `some-changes` branch: all of it, then the phase where the proxies
# share one connection alone, by the number of proxies.
{
    "$stalls/shared-phase.sh" "concurrent100 whole client" "$BIN/busd-concurrent100" \
        "$BIN/dbus-bench-zbus43" 1 60
    export DBUS_BENCH_SHARED_ONLY=1
    for n in 100 96 92 88 80 64; do
        DBUS_BENCH_CLIENTS=$n "$stalls/shared-phase.sh" "concurrent100 n=$n" \
            "$BIN/busd-concurrent100" "$BIN/dbus-bench-zbus43" 3
    done
} 2>&1 | tee "$OUT/shared-zbus43.log"
