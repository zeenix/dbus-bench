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
# are built in its checkout. Each run empties $WORK/send-timeout-results and has the scripts write
# their results there, along with environment.txt, which notes the versions that their logs do not
# name. The archive is $WORK/send-timeout-results.tar.gz.
#
# Usage: scripts/compare-send-timeout.sh
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

have "$busd" https://github.com/z-galaxy/busd main "$baseline_rev"
have "$busd" https://github.com/zeenix/busd ccr-314882eb-9cvuxt "$revert_rev"
have "$busd" https://github.com/zeenix/busd ccr-314882eb-9cvuxt "$timeout_rev"
have "$bench" https://github.com/zeenix/dbus-bench some-changes "$zbus43_rev"

export_rev "$busd" "$baseline_rev" "$work/busd-baseline"
export_rev "$busd" "$revert_rev" "$work/busd-revert"
export_rev "$busd" "$timeout_rev" "$work/busd-timeout"
# read-ahead is the timeout commit with a patch that changes busd's code only, so its build can be
# locked too.
export_rev "$busd" "$timeout_rev" "$work/busd-read-ahead" git apply "$read_ahead_patch"
# The patch of the client on zbus 4.3 has it run the phase of the shared connection alone, if
# $DBUS_BENCH_SHARED_ONLY is set, and with as many proxies as $DBUS_BENCH_CLIENTS says.
export_rev "$bench" "$zbus43_rev" "$work/dbus-bench-zbus43" git apply "$zbus43_patch"

busd_builds=(baseline revert timeout read-ahead)
for build in "${busd_builds[@]}"; do
    (cd "$work/busd-$build" && cargo build --release --locked)
done
(cd "$bench" && cargo build --release --locked)
(cd "$work/dbus-bench-zbus43" && cargo build --release --locked)
# The pinger is a crate of its own, with its own lock file. Its target directory is under $work, so
# that the build leaves nothing in the repository.
(cd "$pinger" && CARGO_TARGET_DIR="$work/pinger-target" cargo build --release --locked)

# The scripts of the results want the binaries in one directory, under these names.
bin=$work/bin
mkdir -p "$bin"
for build in "${busd_builds[@]}"; do
    cp "$work/busd-$build/target/release/busd" "$bin/busd-$build"
done
for client in dbus-bench fanout latency shared; do
    cp "$bench/target/release/$client" "$bin/$client"
done
cp "$work/dbus-bench-zbus43/target/release/dbus-bench" "$bin/dbus-bench-zbus43"

# What an earlier run left in the results would end up in the archive, so each run starts afresh.
out=$work/send-timeout-results
archive=$work/send-timeout-results.tar.gz
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
} > "$out/environment.txt"

# Each script below is added to the failures if it goes wrong, and the next one runs all the same.
# What they did write is packed up at the end. The variables that are not set here, such as ROUNDS
# and JOURNAL, are theirs to read from the environment.
failed=()

export BASELINE_REV=$baseline_rev REVERT_REV=$revert_rev TIMEOUT_REV=$timeout_rev
cd "$bench"
echo "Running the paired comparisons (run-benchmarks.sh)." >&2
if ! BIN=$bin OUT=$out "$results/run-benchmarks.sh"; then
    failed+=("the paired comparisons (run-benchmarks.sh)")
fi
echo "Running the clients that stop reading (run-stalls.sh)." >&2
if ! BIN=$bin OUT=$out PINGER=$work/pinger-target/release/pinger "$results/run-stalls.sh"; then
    failed+=("the clients that stop reading (run-stalls.sh)")
fi

(cd "$out" && tar -czf "$archive" -- *)
echo "The results are in $out, and all of them are packed in $archive."
if [ ${#failed[@]} -gt 0 ]; then
    echo "These went wrong, so their results are incomplete or missing:" >&2
    printf '  %s\n' "${failed[@]}" >&2
    exit 1
fi
