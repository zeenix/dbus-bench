#!/bin/bash
# The paired comparisons of this directory. Every round runs each broker once, in an order that is
# shuffled for each round (reproducibly, from --seed), on a fresh broker process each time, after
# WARMUP rounds (default: 3) that the tables leave out. Run it from the root of dbus-bench, with
# $BIN the directory of the binaries and $OUT the directory to write the results to:
# scripts/compare-send-timeout.sh builds the binaries and runs this script. The clients in $BIN are
# dbus-bench (the benchmark itself), fanout, latency and shared. The brokers are builds of busd:
#   baseline       busd-baseline: busd's main before the revert (a queue for each client, busd PR
#                  #376), at $BASELINE_REV
#   timeout        busd-timeout: the revert, then sends with a time limit, at $TIMEOUT_REV
#   revert         busd-revert: the revert alone (sends with no time limit), for reference, at
#                  $REVERT_REV
#   timeout-rq256  busd-read-ahead: timeout with read-ahead.diff and BUSD_MAX_QUEUED=256, in the
#                  last comparison
# The results name the three commits, whose defaults are the full SHAs that the results of this
# directory measured. ROUNDS (default: 60) is the number of rounds of the comparisons of the calls,
# the signals and the latencies, SHARED_ROUNDS (default: 40) that of the shared connection, and
# READ_AHEAD_ROUNDS (default: 30) that of the shared connection with more read-ahead.
set -eu
: "${BIN:?set BIN to the directory of the binaries}" "${OUT:?set OUT to the output directory}"
ROUNDS=${ROUNDS:-60}
SHARED_ROUNDS=${SHARED_ROUNDS:-40}
READ_AHEAD_ROUNDS=${READ_AHEAD_ROUNDS:-30}
WARMUP=${WARMUP:-3}
BASELINE_REV=${BASELINE_REV:-0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c}
REVERT_REV=${REVERT_REV:-41407f0d123260d68d8dbb8b4e48aed2ee2932c7}
TIMEOUT_REV=${TIMEOUT_REV:-e93cec585f1543d5a256b9a1a32d089ac2a84967}
mkdir -p "$OUT"
brokers=(
    --broker baseline "$BIN/busd-baseline --address {address}"
    --broker timeout "$BIN/busd-timeout --address {address}"
    --broker revert "$BIN/busd-revert --address {address}"
)
meta=(--meta "rustc=$(rustc --version)" --meta "baseline=$BASELINE_REV"
    --meta "timeout=$TIMEOUT_REV" --meta "revert=$REVERT_REV")

echo "== method calls (the benchmark, on zbus 6): $ROUNDS rounds" >&2
python3 scripts/compare-brokers.py --bench "$BIN/dbus-bench" --rounds "$ROUNDS" \
    --warmup "$WARMUP" --seed 11 --out "$OUT/calls.json" "${meta[@]}" "${brokers[@]}" \
    > "$OUT/calls.md"
echo "== signals (fanout: a burst to 1 subscriber, broadcasts to 20): $ROUNDS rounds" >&2
python3 scripts/compare-brokers.py --bench "$BIN/fanout" --rounds "$ROUNDS" --warmup "$WARMUP" \
    --seed 12 --out "$OUT/signals.json" "${meta[@]}" "${brokers[@]}" > "$OUT/signals.md"
echo "== latencies: $ROUNDS rounds" >&2
python3 scripts/compare-latency.py --bench "$BIN/latency" --rounds "$ROUNDS" --warmup "$WARMUP" \
    --seed 13 --out "$OUT/latency.json" "${meta[@]}" "${brokers[@]}" > "$OUT/latency.md"
echo "== 100 proxies sharing a connection, then 100 connections (zbus 6): $SHARED_ROUNDS rounds" >&2
DBUS_BENCH_CLIENTS=100 python3 scripts/compare-brokers.py --bench "$BIN/shared" \
    --rounds "$SHARED_ROUNDS" --warmup "$WARMUP" --seed 14 --out "$OUT/shared.json" \
    "${meta[@]}" "${brokers[@]}" > "$OUT/shared.md"

for workload in calls signals latency shared; do
    for pair in baseline:timeout baseline:revert revert:timeout; do
        base=${pair%:*} cand=${pair#*:}
        name=$workload-$cand
        [ "$base" = baseline ] || name=$workload-$cand-vs-$base
        python3 scripts/paired-stats.py "$OUT/$workload.json" --baseline "$base" \
            --candidate "$cand" --json "$OUT/$name.stats.json" > "$OUT/$name.stats.md"
    done
done

echo "== the same shared connection, with more read-ahead: $READ_AHEAD_ROUNDS rounds" >&2
DBUS_BENCH_CLIENTS=100 python3 scripts/compare-brokers.py --bench "$BIN/shared" \
    --rounds "$READ_AHEAD_ROUNDS" --warmup "$WARMUP" --seed 15 \
    --out "$OUT/shared-read-ahead.json" "${meta[@]}" \
    --broker baseline "$BIN/busd-baseline --address {address}" \
    --broker timeout "$BIN/busd-timeout --address {address}" \
    --broker timeout-rq256 "env BUSD_MAX_QUEUED=256 $BIN/busd-read-ahead --address {address}" \
    > "$OUT/shared-read-ahead.md"
for pair in baseline:timeout baseline:timeout-rq256 timeout:timeout-rq256; do
    base=${pair%:*} cand=${pair#*:}
    name=shared-read-ahead-$cand
    [ "$base" = baseline ] || name=shared-read-ahead-$cand-vs-$base
    python3 scripts/paired-stats.py "$OUT/shared-read-ahead.json" --baseline "$base" \
        --candidate "$cand" --json "$OUT/$name.stats.json" > "$OUT/$name.stats.md"
done
