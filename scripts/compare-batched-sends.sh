#!/bin/bash
# Compares the builds of busd that differ in how they send what they forward to a client, along
# with dbus-broker and dbus-daemon, as far as they are installed:
#
# * queue: busd with a queue for each client (z-galaxy/busd#376), and a task of the client's own
#   that writes the queue to the client's socket, a message at a time;
# * baseline: busd's main branch, which forwards the messages of each peer one at a time and writes
#   each of them to a client with a system call of its own, within a time limit;
# * batched: busd that forwards the messages of each peer in batches, of those that are there
#   already, and writes those of a batch that go to a client in one go, with several small messages
#   in each system call, through `Connection::send_all` of zbus (z-galaxy/zbus#2078). It is the
#   commit that BATCHED_REV names, ac6e6fa of zeenix/busd by default, an earlier version of
#   z-galaxy/busd#383, which builds on zbus from the branch of z-galaxy/zbus#2079;
# * batched-before: the commit that BEFORE_REV names, 4f346a3 by default, which forwards in batches
#   as batched does, on an earlier commit of that zbus, which ended each write before the message
#   that would take it past 16 KiB, rather than with it, so that a batch that went past 16 KiB took
#   two writes. An empty BEFORE_REV leaves it out.
#
# All of them run on the commit of zruntime that busd's main branch pins: baseline and the batched
# builds as their lock files have it, and queue through a patch of the zruntime that its lock file
# names.
#
# It runs the paired comparisons of results/2026-10-23-busd-zruntime-clock-ryzen-7840u.md between
# them: method calls, signals and latencies, with the clients on zbus 6, and the connection that 100
# proxies share, then 100 connections, each of which serves the object that it calls. Every round
# runs each broker once, in an order shuffled for each round, after WARMUP rounds that the tables
# leave out. It writes the tables (.md), the runs (.json) and the comparisons in pairs (.stats.md
# and .stats.json): batched against baseline, queue and batched-before, baseline against queue, and
# dbus-broker and dbus-daemon against baseline and batched.
#
# It expects a checkout of busd under $CHECKOUT (default: ~/checkout), laid out as on GitHub:
# $CHECKOUT/z-galaxy/busd. That checkout, and the one of dbus-bench that this script is in, are left
# as they are, apart from fetching the commits measured, by their hashes, if they lack them: queue
# and baseline from z-galaxy/busd, and the batched builds from zeenix/busd. A short BATCHED_REV or
# BEFORE_REV, which a fetch cannot name, is looked for on the ccr-fd1ce738-0xtuf0 branch: name a
# commit that the branch no longer has in full. Each build of busd is made from an export of its
# commit, under $WORK (default: /tmp/batched-sends-bench), and is reused by the next run. The
# clients of this repository are built in its checkout. The results go to
# $WORK/batched-sends-results-COMMIT, where COMMIT is the short hash of the batched commit: each run
# empties it, and writes its results there, along with environment.txt, which notes the versions
# that the tables do not name. The archive is $WORK/batched-sends-results-COMMIT.tar.gz.
#
# Usage: scripts/compare-batched-sends.sh
#
# The environment sets the rest. ROUNDS (default: 60) and SHARED_ROUNDS (default: 40) are the
# numbers of rounds of the comparisons of the calls, the signals and the latencies, and of the
# shared connection, each after WARMUP (default: 3) rounds.
#
# dbus-broker, which needs dbus-broker-launch and systemd-socket-activate, and dbus-daemon are left
# out where they are missing. Where there is no systemd, dbus-broker-launch fails unless something
# stands in for journald: results/2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py
# does, started before this script.
#
# A short run, to check that everything works, is ROUNDS=2 SHARED_ROUNDS=2 WARMUP=1.
set -euo pipefail

if [ $# -gt 0 ]; then
    echo "usage: scripts/compare-batched-sends.sh (the environment sets the rest: see the top)" >&2
    exit 2
fi

checkout=${CHECKOUT:-$HOME/checkout}
work=${WORK:-/tmp/batched-sends-bench}
# The scripts below run from another directory, so $work must not be relative.
case $work in
/*) ;;
*) work=$PWD/$work ;;
esac
rounds=${ROUNDS:-60}
shared_rounds=${SHARED_ROUNDS:-40}
warmup=${WARMUP:-3}
bench=$(cd "$(dirname "$0")/.." && pwd)
busd=$checkout/z-galaxy/busd

# The commits measured: busd's main branch with the queue for each client; busd's main branch since,
# with the time limit of 100 ms on each send to a client (z-galaxy/busd#382); busd that forwards in
# batches; and, unless BEFORE_REV is empty, an earlier commit of it. And the commit of zruntime that
# all but the first pin, which queue is built on too.
queue_rev=0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
baseline_rev=0b89e3a5b746dd7e739706e4ab4e6b15ec89413a
batched_rev=${BATCHED_REV:-ac6e6fa16f5b0b63cce856dc618ca2328c51e713}
before_rev=${BEFORE_REV-4f346a36a23efe3a88b9539ff1130c55c660be70}
zruntime_rev=99e2ebd807723177bec5d7c5216e48448c3a91c9

# Makes sure that the repository $1 has the commit $4, by fetching it from $2 if it lacks it: by its
# hash, which reaches a commit that the branch $3 no longer has, as a rebase of the branch leaves
# behind, or, for a short hash, which a fetch cannot name, with that branch.
have() {
    git -C "$1" cat-file -e "$4^{commit}" 2>/dev/null ||
        git -C "$1" fetch -q "$2" "$4" 2>/dev/null ||
        git -C "$1" fetch -q "$2" "$3"
    if ! git -C "$1" cat-file -e "$4^{commit}" 2>/dev/null; then
        echo "$2 gave no commit $4: name a commit that its branch $3 no longer has in full." >&2
        exit 1
    fi
}

# The first line that the command prints, whatever becomes of the command.
first_line() {
    "$@" 2> /dev/null | sed -n 1p || true
}

# What an export is made from: the commit $1, the command $2... that is run in it, and the code of
# that command where it is a function of this script.
export_inputs() {
    printf '%s\n' "$@"
    if [ $# -gt 1 ] && declare -F "$2" > /dev/null; then
        declare -f "$2"
    fi
}

# Exports the commit $2 of the repository $1 to the directory $3, and runs the command $4..., if
# any, in it, unless the directory holds an export made from the same inputs already (see
# export_inputs). The export is made under another name, which becomes $3 once the command has
# run, so that a run that stops halfway leaves no export behind that the next run would take for a
# finished one.
export_rev() {
    local repo=$1 rev=$2 dir=$3 inputs
    shift 3
    inputs=$(export_inputs "$rev" "$@")
    if [ "$(cat "$dir/.export-inputs" 2> /dev/null)" = "$inputs" ]; then
        return
    fi
    rm -rf "$dir" "$dir.new"
    mkdir -p "$dir.new"
    git -C "$repo" archive "$rev" | tar -x -C "$dir.new"
    if [ $# -gt 0 ]; then
        (cd "$dir.new" && "$@")
    fi
    printf '%s\n' "$inputs" > "$dir.new/.export-inputs"
    mv "$dir.new" "$dir"
}

# Has the export of busd in the current directory build on the commit $1 of zruntime, rather than
# on the release that its lock file names. The patch goes in the export's Cargo configuration, and
# zruntime, and only zruntime, is moved off the release in the lock file, so that the build can
# stay locked.
use_zruntime() {
    mkdir -p .cargo
    printf '[patch.crates-io]\nzruntime = { git = "%s", rev = "%s" }\n' \
        https://github.com/z-galaxy/zruntime "$1" >> .cargo/config.toml
    cargo update -q -p zruntime
}

have "$busd" https://github.com/z-galaxy/busd main "$queue_rev"
have "$busd" https://github.com/z-galaxy/busd main "$baseline_rev"
have "$busd" https://github.com/zeenix/busd ccr-fd1ce738-0xtuf0 "$batched_rev"
# BATCHED_REV and BEFORE_REV may be short hashes: the results name the full ones.
batched_rev=$(git -C "$busd" rev-parse --verify "$batched_rev^{commit}")
builds=(queue baseline batched)
if [ -n "$before_rev" ]; then
    have "$busd" https://github.com/zeenix/busd ccr-fd1ce738-0xtuf0 "$before_rev"
    before_rev=$(git -C "$busd" rev-parse --verify "$before_rev^{commit}")
    builds+=(batched-before)
fi

export_rev "$busd" "$queue_rev" "$work/busd-queue" use_zruntime "$zruntime_rev"
export_rev "$busd" "$baseline_rev" "$work/busd-baseline"
export_rev "$busd" "$batched_rev" "$work/busd-batched"
if [ -n "$before_rev" ]; then
    export_rev "$busd" "$before_rev" "$work/busd-batched-before"
fi
for build in "${builds[@]}"; do
    (cd "$work/busd-$build" && cargo build --release --locked)
done
(cd "$bench" && cargo build --release --locked)

# The scripts want the binaries in one directory, under these names.
bin=$work/bin
mkdir -p "$bin"
for build in "${builds[@]}"; do
    cp "$work/busd-$build/target/release/busd" "$bin/busd-$build"
done
for client in dbus-bench fanout latency shared; do
    cp "$bench/target/release/$client" "$bin/$client"
done

# What an earlier run of the same commit left in the results would end up in the archive, so each
# run starts afresh.
out=$work/batched-sends-results-${batched_rev:0:7}
archive=$out.tar.gz
rm -rf "$out"
mkdir -p "$out"
# The versions that the tables do not name.
{
    echo "date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "kernel: $(uname -r)"
    echo "cpu: $(sed -n 's/^model name\t*: //p' /proc/cpuinfo | sed -n 1p) x $(nproc)"
    echo "rustc: $(first_line rustc --version)"
    echo "cargo: $(first_line cargo --version)"
    echo "dbus-bench: $(first_line git -C "$bench" describe --always --dirty --abbrev=40)"
    echo "dbus-broker: $(first_line dbus-broker --version)"
    echo "dbus-daemon: $(first_line dbus-daemon --version)"
} > "$out/environment.txt"

# busd logs why it disconnects a client at its debug level, and nothing at that level while it
# forwards messages, so the log that a failed run shows names the cause, at no cost to the others.
brokers=(
    --broker queue "RUST_LOG=busd=debug $bin/busd-queue --address {address}"
    --broker baseline "RUST_LOG=busd=debug $bin/busd-baseline --address {address}"
    --broker batched "RUST_LOG=busd=debug $bin/busd-batched --address {address}"
)
meta=(--meta "rustc=$(first_line rustc --version)" --meta "queue=$queue_rev"
    --meta "baseline=$baseline_rev" --meta "batched=$batched_rev" --meta "zruntime=$zruntime_rev")
pairs=(baseline:batched queue:batched queue:baseline)
if [ -n "$before_rev" ]; then
    brokers+=(--broker batched-before
        "RUST_LOG=busd=debug $bin/busd-batched-before --address {address}")
    meta+=(--meta "batched-before=$before_rev")
    pairs+=(batched-before:batched)
fi
# dbus-broker runs only under its launcher, which takes its socket from systemd's socket activation
# and connects to the bus that $DBUS_SESSION_BUS_ADDRESS names, the one it launches here rather
# than the desktop's: see scripts/compare-brokers.py.
if command -v dbus-broker-launch > /dev/null && command -v systemd-socket-activate > /dev/null; then
    launch="dbus-broker-launch --scope user"
    brokers+=(--broker dbus-broker
        "systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS={address} -l {path} $launch")
    meta+=(--meta "dbus-broker=$(first_line dbus-broker --version)")
    pairs+=(dbus-broker:baseline dbus-broker:batched)
else
    echo "dbus-broker-launch or systemd-socket-activate is not installed: leaving dbus-broker" \
        "out of the comparisons." >&2
fi
if command -v dbus-daemon > /dev/null; then
    brokers+=(--broker dbus-daemon "dbus-daemon --session --nofork --address={address}")
    meta+=(--meta "dbus-daemon=$(first_line dbus-daemon --version)")
    pairs+=(dbus-daemon:baseline dbus-daemon:batched)
else
    echo "dbus-daemon is not installed: leaving it out of the comparisons." >&2
fi

# Each comparison is added to the failures if it goes wrong, and the next one runs all the same.
# What they did write is packed up at the end.
failed=()
cd "$bench"
echo "== method calls (the benchmark, on zbus 6): $rounds rounds" >&2
python3 scripts/compare-brokers.py --bench "$bin/dbus-bench" --rounds "$rounds" \
    --warmup "$warmup" --seed 31 --out "$out/calls.json" "${meta[@]}" "${brokers[@]}" \
    > "$out/calls.md" || failed+=(calls)
echo "== signals (fanout: a burst to 1 subscriber, broadcasts to 20): $rounds rounds" >&2
python3 scripts/compare-brokers.py --bench "$bin/fanout" --rounds "$rounds" \
    --warmup "$warmup" --seed 32 --out "$out/signals.json" "${meta[@]}" "${brokers[@]}" \
    > "$out/signals.md" || failed+=(signals)
echo "== latencies: $rounds rounds" >&2
python3 scripts/compare-latency.py --bench "$bin/latency" --rounds "$rounds" \
    --warmup "$warmup" --seed 33 --out "$out/latency.json" "${meta[@]}" "${brokers[@]}" \
    > "$out/latency.md" || failed+=(latency)
echo "== 100 proxies sharing a connection, then 100 connections (zbus 6):" \
    "$shared_rounds rounds" >&2
DBUS_BENCH_CLIENTS=100 python3 scripts/compare-brokers.py --bench "$bin/shared" \
    --rounds "$shared_rounds" --warmup "$warmup" --seed 34 --out "$out/shared.json" \
    "${meta[@]}" "${brokers[@]}" > "$out/shared.md" || failed+=(shared)

for workload in calls signals latency shared; do
    [ -e "$out/$workload.json" ] || continue
    for pair in "${pairs[@]}"; do
        base=${pair%:*} cand=${pair#*:}
        name=$workload-$cand
        [ "$base" = baseline ] || name=$workload-$cand-vs-$base
        python3 scripts/paired-stats.py "$out/$workload.json" --baseline "$base" \
            --candidate "$cand" --json "$out/$name.stats.json" > "$out/$name.stats.md" ||
            failed+=("the comparison of $cand against $base on $workload")
    done
done

(cd "$out" && tar -czf "$archive" -- *)
echo "The results are in $out, and all of them are packed in $archive."
if [ ${#failed[@]} -gt 0 ]; then
    echo "These went wrong, so their results are incomplete or missing:" >&2
    printf '  %s\n' "${failed[@]}" >&2
    exit 1
fi
