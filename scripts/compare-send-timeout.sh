#!/bin/bash
# Repeats the comparison of results/2026-10-22-busd-send-timeout-xeon-4vcpu.md, between four builds
# of busd that differ in how they send to a client that is slow to read:
#
# * baseline: busd's main branch, with a queue for each client (z-galaxy/busd#376);
# * revert: that queue reverted, so that a send to a client waits for as long as it takes;
# * timeout: the revert, then a time limit of 1 s on each send, past which the bus disconnects the
#   client, or whichever later commit of that branch TIMEOUT_REV names, such as 7f3ba5a, with a
#   limit of 100 ms and the sends of each message to all of its recipients at once;
# * read-ahead: timeout with read-ahead.diff, which has busd read more messages ahead from each
#   client.
#
# It builds them and the clients, then runs two scripts of those results, one after the other, and
# packs what they write into one archive:
#
# 1. run-benchmarks.sh: the builds against each other, round by round, on method calls, signals,
#    latencies and a connection that 100 proxies share (all with the clients on zbus 6), then on
#    that connection with the read-ahead build as well. It writes the tables (.md), the runs
#    (.json) and the comparisons in pairs (.stats.md and .stats.json).
# 2. run-stalls.sh: clients that stop reading, against the builds and, as far as it is installed,
#    dbus-broker: subscribers of the bus's signals that are frozen, and a connection that many
#    proxies share, with the client on zbus 4.3. It writes logs (.log).
#
# It expects a checkout of busd under $CHECKOUT (default: ~/checkout), laid out as on GitHub:
# $CHECKOUT/z-galaxy/busd. That checkout, and the one of dbus-bench that this script is in, are
# left as they are, apart from fetching the commits measured if they lack them: the baseline from
# z-galaxy/busd, the revert and the timeout from the ccr-314882eb-9cvuxt branch of zeenix/busd, and
# the commit of the client on zbus 4.3 from the some-changes branch of zeenix/dbus-bench. Each
# build of busd, and the client on zbus 4.3, is made from an export of its commit, under $WORK
# (default: /tmp/send-timeout-bench), and is reused by the next run. The clients of this repository
# are built in its checkout. The results go to $WORK/send-timeout-results-COMMIT, where COMMIT is
# the short hash of the timeout commit, so that a run of each of those commits keeps its own: each
# run empties it, and has the scripts write their results there, along with environment.txt, which
# notes the versions that their logs do not name. The archive is
# $WORK/send-timeout-results-COMMIT.tar.gz.
#
# With ZRUNTIME_REV, a commit of zruntime, it measures that commit instead, on three builds that run
# on a commit of zruntime rather than on the release that busd's lock file names:
#
# * baseline and timeout, as above, both on that commit of zruntime;
# * timeout-before: timeout on the commit of zruntime before it, its first parent.
#
# It runs only the paired comparisons of run-benchmarks.sh, without the read-ahead build, between
# those three: timeout against timeout-before says what the commit of zruntime changes, and
# baseline against timeout and timeout-before what the time limit costs with and without it.
# baseline uses no time limit of zruntime's, so one build of it does for both. That needs a
# checkout of zruntime too, at $CHECKOUT/z-galaxy/zruntime, which the commit is fetched into from
# the ccr-314882eb-9cvuxt branch of zeenix/zruntime if it lacks it. The exports of zruntime are
# under $WORK as well, and the results go to $WORK/send-timeout-results-COMMIT-zruntime-ZCOMMIT,
# where ZCOMMIT is the short hash of the commit of zruntime.
#
# Usage: scripts/compare-send-timeout.sh
#
# For example, TIMEOUT_REV=7f3ba5a ZRUNTIME_REV=99e2ebd scripts/compare-send-timeout.sh measures the
# commit of zruntime that starts the clock of a time limit only once a send has to wait, with the
# limit of 100 ms.
#
# The environment sets the rest. ROUNDS (default: 60), SHARED_ROUNDS (default: 40) and
# READ_AHEAD_ROUNDS (default: 30) are the numbers of rounds of the comparisons of the calls, the
# signals and the latencies, of the shared connection, and of the shared connection with more
# read-ahead, each after WARMUP (default: 3) rounds that the tables leave out. FROZEN_CALLS_K1
# (default: 1500) and FROZEN_CALLS_K3 (default: 600) are the numbers of calls of the test with
# frozen subscribers, with one of them and with two or three, and SHARED_REPEATS (default: 3) is
# how many times each run of the shared connection with 100 proxies or fewer repeats.
#
# dbus-broker, which needs dbus-broker-launch and systemd-socket-activate, and the test with frozen
# subscribers, which needs gdbus and dbus-send, are left out where those are missing. Where there is
# no systemd, dbus-broker-launch fails unless stalls/fake-journald.py of those results runs, to
# stand in for journald: start it, and name the file it writes to in JOURNAL, so that the logs have
# dbus-broker's lines about the clients that it disconnects. With systemd, those lines go to the
# real journal instead, and the logs have none.
#
# With the default rounds, a run takes about 55 minutes on a 4-vCPU Xeon VM, once the builds are
# made: 28 minutes for the first four comparisons of run-benchmarks.sh, 12 for its last one, with
# more read-ahead, and 14 for run-stalls.sh, as in the results. The first run makes the builds too,
# which took about 6 minutes there. To check that everything works first, a short run takes about
# 11 minutes there, once the builds are made: ROUNDS=2 SHARED_ROUNDS=2 READ_AHEAD_ROUNDS=2 WARMUP=1
# FROZEN_CALLS_K1=30 FROZEN_CALLS_K3=30 SHARED_REPEATS=1 scripts/compare-send-timeout.sh
# A run with ZRUNTIME_REV takes about 28 minutes there, as the first four comparisons do.
set -euo pipefail

if [ $# -gt 0 ]; then
    echo "usage: scripts/compare-send-timeout.sh (the environment sets the rest: see the top)" >&2
    exit 2
fi

checkout=${CHECKOUT:-$HOME/checkout}
work=${WORK:-/tmp/send-timeout-bench}
# The scripts below run from another directory, so $work must not be relative.
case $work in
/*) ;;
*) work=$PWD/$work ;;
esac
bench=$(cd "$(dirname "$0")/.." && pwd)
busd=$checkout/z-galaxy/busd
zruntime=$checkout/z-galaxy/zruntime
# The scripts and patches of the results, and the pinger of the earlier look into stalls.
results=$bench/results/2026-10-22-busd-send-timeout-xeon-4vcpu
read_ahead_patch=$results/read-ahead.diff
zbus43_patch=$results/stalls/zbus43-clients.diff
pinger=$bench/results/2026-10-20-busd-stalled-reader-xeon-4vcpu/pinger

# The commits measured: busd's main branch with the queue for each client; the revert of the queue,
# and the time limit on the revert, both on the branch of zeenix/busd; and the commit of the
# some-changes branch of zeenix/dbus-bench that has the client on zbus 4.3.
baseline_rev=0c52e9c60bddc518480ff68da18f3c2ec8cc3f3c
revert_rev=41407f0d123260d68d8dbb8b4e48aed2ee2932c7
timeout_rev=${TIMEOUT_REV:-e93cec585f1543d5a256b9a1a32d089ac2a84967}
zbus43_rev=7b5f2351d1c8dab30f4b1e1f9b70b9f3bad8208c
# The commit of zruntime to measure, if any: see the top.
zruntime_rev=${ZRUNTIME_REV:-}

# Makes sure that the repository $1 has the commit $4, by fetching $3 from $2 if it lacks it.
have() {
    git -C "$1" cat-file -e "$4^{commit}" 2>/dev/null || git -C "$1" fetch -q "$2" "$3"
    git -C "$1" cat-file -e "$4^{commit}"
}

# The first line that the command prints, whatever becomes of the command.
first_line() {
    "$@" 2> /dev/null | sed -n 1p || true
}

# What an export is made from: the commit $1, the command $2... that is run in it, the code of that
# command where it is a function of this script, and what the files among its arguments hold.
export_inputs() {
    local arg
    printf '%s\n' "$@"
    if [ $# -gt 1 ] && declare -F "$2" > /dev/null; then
        declare -f "$2"
    fi
    for arg in "${@:2}"; do
        if [ -f "$arg" ]; then
            sha256sum < "$arg"
        fi
    done
}

# Exports the commit $2 of the repository $1 to the directory $3, and runs the command $4..., if
# any, in it, unless the directory holds an export made from the same inputs already (see
# export_inputs): one made from another commit, command or patch is made afresh, along with its
# build. The export is made under another name, which becomes $3 once the command has run, so that
# a run that stops halfway leaves no export behind that the next run would take for a finished one.
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

# Has the export of busd in the current directory build on the export of zruntime in $1, rather
# than on the release of zruntime that its lock file names. The patch alone leaves the lock file on
# that release, so zruntime, and only zruntime, is moved off it there, and the build can stay
# locked.
use_zruntime() {
    printf '\n[patch.crates-io]\nzruntime = { path = "%s" }\n' "$1" >> Cargo.toml
    cargo update -q -p zruntime
}

# The paired comparisons of a run with ZRUNTIME_REV: the first four of run-benchmarks.sh, with its
# rounds and seeds, between the builds on zruntime. Called from the condition of an if, the
# function runs with errexit off, so each step returns on a failure itself.
compare_zruntime() {
    local rounds=${ROUNDS:-60} shared_rounds=${SHARED_ROUNDS:-40} warmup=${WARMUP:-3}
    local brokers meta workload pair base cand name
    brokers=(
        --broker baseline "$bin/busd-zr-baseline --address {address}"
        --broker timeout "$bin/busd-zr-timeout --address {address}"
        --broker timeout-before "$bin/busd-zr-timeout-before --address {address}"
    )
    meta=(--meta "rustc=$(first_line rustc --version)" --meta "baseline=$baseline_rev"
        --meta "timeout=$timeout_rev" --meta "zruntime=$zruntime_rev"
        --meta "zruntime-before=$zruntime_before_rev")

    echo "== method calls (the benchmark, on zbus 6): $rounds rounds" >&2
    python3 scripts/compare-brokers.py --bench "$bin/dbus-bench" --rounds "$rounds" \
        --warmup "$warmup" --seed 11 --out "$out/calls.json" "${meta[@]}" "${brokers[@]}" \
        > "$out/calls.md" || return
    echo "== signals (fanout: a burst to 1 subscriber, broadcasts to 20): $rounds rounds" >&2
    python3 scripts/compare-brokers.py --bench "$bin/fanout" --rounds "$rounds" \
        --warmup "$warmup" --seed 12 --out "$out/signals.json" "${meta[@]}" "${brokers[@]}" \
        > "$out/signals.md" || return
    echo "== latencies: $rounds rounds" >&2
    python3 scripts/compare-latency.py --bench "$bin/latency" --rounds "$rounds" \
        --warmup "$warmup" --seed 13 --out "$out/latency.json" "${meta[@]}" "${brokers[@]}" \
        > "$out/latency.md" || return
    echo "== 100 proxies sharing a connection, then 100 connections (zbus 6):" \
        "$shared_rounds rounds" >&2
    DBUS_BENCH_CLIENTS=100 python3 scripts/compare-brokers.py --bench "$bin/shared" \
        --rounds "$shared_rounds" --warmup "$warmup" --seed 14 --out "$out/shared.json" \
        "${meta[@]}" "${brokers[@]}" > "$out/shared.md" || return

    for workload in calls signals latency shared; do
        for pair in timeout-before:timeout baseline:timeout baseline:timeout-before; do
            base=${pair%:*} cand=${pair#*:}
            name=$workload-$cand
            [ "$base" = baseline ] || name=$workload-$cand-vs-$base
            python3 scripts/paired-stats.py "$out/$workload.json" --baseline "$base" \
                --candidate "$cand" --json "$out/$name.stats.json" > "$out/$name.stats.md" ||
                return
        done
    done
}

have "$busd" https://github.com/z-galaxy/busd main "$baseline_rev"
have "$busd" https://github.com/zeenix/busd ccr-314882eb-9cvuxt "$revert_rev"
have "$busd" https://github.com/zeenix/busd ccr-314882eb-9cvuxt "$timeout_rev"
# TIMEOUT_REV may be a short hash: the results name the full one.
timeout_rev=$(git -C "$busd" rev-parse --verify "$timeout_rev^{commit}")

if [ -n "$zruntime_rev" ]; then
    have "$zruntime" https://github.com/zeenix/zruntime ccr-314882eb-9cvuxt "$zruntime_rev"
    # So may ZRUNTIME_REV.
    zruntime_rev=$(git -C "$zruntime" rev-parse --verify "$zruntime_rev^{commit}")
    zruntime_before_rev=$(git -C "$zruntime" rev-parse --verify "$zruntime_rev^")
    # An export of zruntime is named after its commit, so that the exports of busd on it are made
    # afresh, builds and all, for another commit. Cargo tells that a path dependency changed by the
    # times of its files, which in an export are the time of its commit, and so can go back.
    zruntime_dir=$work/zruntime-${zruntime_rev:0:7}
    zruntime_before_dir=$work/zruntime-${zruntime_before_rev:0:7}
    export_rev "$zruntime" "$zruntime_rev" "$zruntime_dir"
    export_rev "$zruntime" "$zruntime_before_rev" "$zruntime_before_dir"
    export_rev "$busd" "$baseline_rev" "$work/busd-zr-baseline" use_zruntime "$zruntime_dir"
    export_rev "$busd" "$timeout_rev" "$work/busd-zr-timeout" use_zruntime "$zruntime_dir"
    export_rev "$busd" "$timeout_rev" "$work/busd-zr-timeout-before" use_zruntime \
        "$zruntime_before_dir"
    busd_builds=(zr-baseline zr-timeout zr-timeout-before)
else
    have "$bench" https://github.com/zeenix/dbus-bench some-changes "$zbus43_rev"
    export_rev "$busd" "$baseline_rev" "$work/busd-baseline"
    export_rev "$busd" "$revert_rev" "$work/busd-revert"
    export_rev "$busd" "$timeout_rev" "$work/busd-timeout"
    # read-ahead is the timeout commit with a patch that changes busd's code only, so its build
    # can be locked too.
    export_rev "$busd" "$timeout_rev" "$work/busd-read-ahead" git apply "$read_ahead_patch"
    # The patch of the client on zbus 4.3 has it run the phase of the shared connection alone, if
    # $DBUS_BENCH_SHARED_ONLY is set, and with as many proxies as $DBUS_BENCH_CLIENTS says.
    export_rev "$bench" "$zbus43_rev" "$work/dbus-bench-zbus43" git apply "$zbus43_patch"
    busd_builds=(baseline revert timeout read-ahead)
fi

for build in "${busd_builds[@]}"; do
    (cd "$work/busd-$build" && cargo build --release --locked)
done
(cd "$bench" && cargo build --release --locked)

# The scripts of the results want the binaries in one directory, under these names.
bin=$work/bin
mkdir -p "$bin"
for build in "${busd_builds[@]}"; do
    cp "$work/busd-$build/target/release/busd" "$bin/busd-$build"
done
for client in dbus-bench fanout latency shared; do
    cp "$bench/target/release/$client" "$bin/$client"
done
# The clients of run-stalls.sh, which a run with ZRUNTIME_REV leaves out.
if [ -z "$zruntime_rev" ]; then
    (cd "$work/dbus-bench-zbus43" && cargo build --release --locked)
    cp "$work/dbus-bench-zbus43/target/release/dbus-bench" "$bin/dbus-bench-zbus43"
    # The pinger is a crate of its own, with its own lock file. Its target directory is under
    # $work, so that the build leaves nothing in the repository.
    (cd "$pinger" && CARGO_TARGET_DIR="$work/pinger-target" cargo build --release --locked)
fi

# What an earlier run of the same commits left in the results would end up in the archive, so each
# run starts afresh.
out=$work/send-timeout-results-${timeout_rev:0:7}
if [ -n "$zruntime_rev" ]; then
    out+=-zruntime-${zruntime_rev:0:7}
fi
archive=$out.tar.gz
rm -rf "$out"
mkdir -p "$out"
# The versions that the logs of run-stalls.sh do not name.
{
    echo "date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "kernel: $(uname -r)"
    echo "rustc: $(first_line rustc --version)"
    echo "cargo: $(first_line cargo --version)"
    echo "dbus-bench: $(first_line git -C "$bench" describe --always --dirty --abbrev=40)"
    echo "dbus-broker: $(first_line dbus-broker --version)"
    if [ -n "$zruntime_rev" ]; then
        echo "zruntime: $zruntime_rev"
        echo "zruntime-before: $zruntime_before_rev"
    fi
} > "$out/environment.txt"

# Each script below is added to the failures if it goes wrong, and the next one runs all the same.
# What they did write is packed up at the end. The variables that are not set here, such as ROUNDS
# and JOURNAL, are theirs to read from the environment.
failed=()

export BASELINE_REV=$baseline_rev REVERT_REV=$revert_rev TIMEOUT_REV=$timeout_rev
cd "$bench"
if [ -n "$zruntime_rev" ]; then
    echo "Running the paired comparisons of the builds on zruntime." >&2
    if ! compare_zruntime; then
        failed+=("the paired comparisons of the builds on zruntime")
    fi
else
    echo "Running the paired comparisons (run-benchmarks.sh)." >&2
    if ! BIN=$bin OUT=$out "$results/run-benchmarks.sh"; then
        failed+=("the paired comparisons (run-benchmarks.sh)")
    fi
    echo "Running the clients that stop reading (run-stalls.sh)." >&2
    if ! BIN=$bin OUT=$out PINGER=$work/pinger-target/release/pinger "$results/run-stalls.sh"; then
        failed+=("the clients that stop reading (run-stalls.sh)")
    fi
fi

(cd "$out" && tar -czf "$archive" -- *)
echo "The results are in $out, and all of them are packed in $archive."
if [ ${#failed[@]} -gt 0 ]; then
    echo "These went wrong, so their results are incomplete or missing:" >&2
    printf '  %s\n' "${failed[@]}" >&2
    exit 1
fi
