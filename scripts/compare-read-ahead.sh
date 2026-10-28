#!/bin/bash
# Compares busd on zbus's main branch with busd on z-galaxy/zbus#2090, which has a connection read
# ahead of each message it receives, along with dbus-broker and dbus-daemon, as far as they are
# installed:
#
# * before: busd's main branch at e57b173, on zbus at 7960179, the merge of z-galaxy/zbus#2088,
#   which #2090 builds on;
# * after: the same busd on zbus at ZBUS_AFTER_REV, 82992ca by default, the head of
#   z-galaxy/zbus#2090. That zbus reads as much as the socket of a connection holds into a buffer
#   of 4 KiB that the connection keeps, and takes each message that is whole in it out of it
#   without reading again, where zbus's main branch reads the primary header of each message and
#   then the rest of it, into a `Vec` that it reallocates to the length of the message. A message
#   longer than the buffer still takes two reads, into an allocation of its exact length;
# * with NOTRIM=1, before-notrim and after-notrim too: before and after with glibc's trim threshold
#   raised to 4 MiB, through GLIBC_TUNABLES, so that glibc doesn't give the top of the heap back
#   to the kernel and take it again. On a 4-vCPU Xeon VM, after had glibc do that 3 to 10 times as
#   often as before on the method calls, though the large allocations of both are the same.
#
# The busd of both is z-galaxy/busd's main branch at e57b173, with the commit of zbus that its
# Cargo.toml patches crates.io's zbus with set to that of the build, and its lock file updated to
# match: the script checks that the lock files of before and after differ in the crates of zbus
# alone. The clients of this repository build on the zbus and the zruntime that its own lock file
# has, whichever broker they run against.
#
# It runs the paired comparisons of scripts/compare-batched-sends.sh: method calls, signals and
# latencies, and the connection that 100 callers share to call one service, then 100 services, each
# with a client of its own, and the method calls of the `dicts` client. Every round runs each broker
# once, in an order shuffled for each round, after WARMUP rounds that the tables leave out. It
# writes the tables (.md), the runs (.json) and the comparisons in pairs (.stats.md and
# .stats.json): after against before, before and after against dbus-broker, after against
# dbus-daemon and, with NOTRIM=1, before-notrim against before, after-notrim against after and
# after-notrim against before-notrim.
#
# It expects a checkout of busd under $CHECKOUT (default: ~/checkout), laid out as on GitHub:
# $CHECKOUT/z-galaxy/busd. That checkout, and the one of dbus-bench that this script is in, are left
# as they are, apart from fetching the commit of busd measured, if it lacks it. Cargo fetches the
# commits of zbus from z-galaxy/zbus. Each build of busd is made from an export of its commit,
# under $WORK (default: /tmp/read-ahead-bench), and is reused by the next run. The clients of this
# repository are built in its checkout. The results go to $WORK/read-ahead-results-COMMIT, where
# COMMIT is the short hash of the after commit of zbus: each run empties it, and writes its results
# there, along with environment.txt, which notes the versions that the tables do not name. The
# archive is $WORK/read-ahead-results-COMMIT.tar.gz.
#
# Usage: scripts/compare-read-ahead.sh
#
# The environment sets the rest. ROUNDS (default: 60) and SHARED_ROUNDS (default: 40) are the
# numbers of rounds of the comparisons of the calls, the signals, the latencies and the dicts, and
# of the shared connection, each after WARMUP (default: 3) rounds.
#
# dbus-broker, which needs dbus-broker-launch and systemd-socket-activate, and dbus-daemon are left
# out where they are missing. Where there is no systemd, dbus-broker-launch fails unless something
# stands in for journald: results/2026-10-22-busd-send-timeout-xeon-4vcpu/stalls/fake-journald.py
# does, started before this script.
#
# A short run, to check that everything works, is ROUNDS=2 SHARED_ROUNDS=2 WARMUP=1.
set -euo pipefail

if [ $# -gt 0 ]; then
    echo "usage: scripts/compare-read-ahead.sh (the environment sets the rest: see the top)" >&2
    exit 2
fi

checkout=${CHECKOUT:-$HOME/checkout}
work=${WORK:-/tmp/read-ahead-bench}
# The scripts below run from another directory, so $work must not be relative.
case $work in
/*) ;;
*) work=$PWD/$work ;;
esac
rounds=${ROUNDS:-60}
shared_rounds=${SHARED_ROUNDS:-40}
warmup=${WARMUP:-3}
notrim=${NOTRIM:-0}
bench=$(cd "$(dirname "$0")/.." && pwd)
busd=$checkout/z-galaxy/busd

# The commits measured: busd's main branch, on zbus's main branch and on z-galaxy/zbus#2090.
busd_rev=e57b173ff08f6ae62b103b0f9587b254fc15b4ff
zbus_before=79601795ca566407fdedc8773751436751645e50
zbus_after=${ZBUS_AFTER_REV:-82992ca2af4d7db3b941ecf09353648810001d8d}
# glibc gives the top of the heap back to the kernel once it is larger than this.
trim_threshold=$((4 * 1024 * 1024))

# Makes sure that the repository $1 has the commit $3, by fetching it from $2 if it lacks it.
have() {
    git -C "$1" cat-file -e "$3^{commit}" 2>/dev/null || git -C "$1" fetch -q "$2" "$3"
    git -C "$1" cat-file -e "$3^{commit}"
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

# The commit of git that the lock file in the current directory has the package $1 at, if any.
locked_rev() {
    sed -n "/^name = \"$1\"\$/,/^\$/s/^source = \"git+.*#\([0-9a-f]*\)\"\$/\1/p" Cargo.lock
}

# The packages that the lock file in the current directory has, one per line, with their versions
# and sources, but for zbus and the other crates of its repository that it takes from git.
locked_packages() {
    awk '/^\[\[package\]\]$/ { if (name) print name, version, source; name = version = source = "" }
        /^name = / { name = $3 } /^version = / { version = $3 } /^source = / { source = $3 }
        END { if (name) print name, version, source }' Cargo.lock |
        grep -v -E '^"zbus(_[a-z]+)?" [^ ]+ "git\+'
}

# Has the export of busd in the current directory build on the commit $1 of z-galaxy/zbus, by
# setting the commit that its Cargo.toml patches crates.io's zbus with, and updating its lock file
# to match. The patch has to be there, with a commit of z-galaxy/zbus, for it to be set.
build_on_zbus() {
    local zbus=$1
    if ! grep -q -x '\[patch\.crates-io\.zbus\]' Cargo.toml; then
        echo "The export of busd was to patch crates.io's zbus, but its Cargo.toml doesn't." >&2
        return 1
    fi
    sed -i "/^\[patch\.crates-io\.zbus\]\$/,/^\$/{
        s|^git = .*|git = \"https://github.com/z-galaxy/zbus\"|
        s|^rev = .*|rev = \"$zbus\"|
    }" Cargo.toml
    cargo update -q -p zbus
    if [ "$(locked_rev zbus)" != "$zbus" ]; then
        echo "The lock file of the export of busd has zbus at $(locked_rev zbus), not $zbus." >&2
        return 1
    fi
}

have "$busd" https://github.com/z-galaxy/busd "$busd_rev"
export_rev "$busd" "$busd_rev" "$work/busd-before" build_on_zbus "$zbus_before"
export_rev "$busd" "$busd_rev" "$work/busd-after" build_on_zbus "$zbus_after"
zruntime=$(cd "$work/busd-after" && locked_rev zruntime)
# after is to differ from before in the crates of zbus alone.
lock_diff=$(diff <(cd "$work/busd-before" && locked_packages) \
    <(cd "$work/busd-after" && locked_packages) | grep '^[<>] ' || true)
if [ -n "$lock_diff" ]; then
    echo "after was to differ from before in the crates of zbus alone, but their lock files" \
        "differ in these packages too (< before, > after):" >&2
    echo "$lock_diff" >&2
    exit 1
fi
builds=(before after)
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
for client in dbus-bench fanout latency shared dicts; do
    cp "$bench/target/release/$client" "$bin/$client"
done

# What an earlier run of the same commit left in the results would end up in the archive, so each
# run starts afresh.
out=$work/read-ahead-results-${zbus_after:0:7}
archive=$out.tar.gz
rm -rf "$out"
mkdir -p "$out"
# The versions that the tables do not name.
{
    echo "date: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
    echo "kernel: $(uname -r)"
    echo "cpu: $(sed -n 's/^model name\t*: //p' /proc/cpuinfo | sed -n 1p) x $(nproc)"
    echo "glibc: $(first_line ldd --version)"
    echo "rustc: $(first_line rustc --version)"
    echo "cargo: $(first_line cargo --version)"
    echo "dbus-bench: $(first_line git -C "$bench" describe --always --dirty --abbrev=40)"
    echo "clients: zbus $(cd "$bench" && locked_rev zbus), zruntime $(cd "$bench" &&
        locked_rev zruntime)"
    echo "dbus-broker: $(first_line dbus-broker --version)"
    echo "dbus-daemon: $(first_line dbus-daemon --version)"
} > "$out/environment.txt"

# busd logs why it disconnects a client at its debug level, and nothing at that level while it
# forwards messages, so the log that a failed run shows names the cause, at no cost to the others.
brokers=(
    --broker before "RUST_LOG=busd=debug $bin/busd-before --address {address}"
    --broker after "RUST_LOG=busd=debug $bin/busd-after --address {address}"
)
meta=(--meta "rustc=$(first_line rustc --version)" --meta "busd=$busd_rev"
    --meta "zbus-before=$zbus_before" --meta "zbus-after=$zbus_after" --meta "zruntime=$zruntime")
pairs=(before:after)
if [ "$notrim" = 1 ]; then
    tunables="GLIBC_TUNABLES=glibc.malloc.trim_threshold=$trim_threshold"
    brokers+=(
        --broker before-notrim "RUST_LOG=busd=debug $tunables $bin/busd-before --address {address}"
        --broker after-notrim "RUST_LOG=busd=debug $tunables $bin/busd-after --address {address}"
    )
    meta+=(--meta "notrim=$tunables")
    pairs+=(before:before-notrim after:after-notrim before-notrim:after-notrim)
fi
# dbus-broker runs only under its launcher, which takes its socket from systemd's socket activation
# and connects to the bus that $DBUS_SESSION_BUS_ADDRESS names, the one it launches here rather
# than the desktop's: see scripts/compare-brokers.py.
if command -v dbus-broker-launch > /dev/null && command -v systemd-socket-activate > /dev/null; then
    launch="dbus-broker-launch --scope user"
    brokers+=(--broker dbus-broker
        "systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS={address} -l {path} $launch")
    meta+=(--meta "dbus-broker=$(first_line dbus-broker --version)")
    pairs+=(dbus-broker:before dbus-broker:after)
else
    echo "dbus-broker-launch or systemd-socket-activate is not installed: leaving dbus-broker" \
        "out of the comparisons." >&2
fi
if command -v dbus-daemon > /dev/null; then
    brokers+=(--broker dbus-daemon "dbus-daemon --session --nofork --address={address}")
    meta+=(--meta "dbus-daemon=$(first_line dbus-daemon --version)")
    pairs+=(dbus-daemon:after)
else
    echo "dbus-daemon is not installed: leaving it out of the comparisons." >&2
fi

# Each comparison is added to the failures if it goes wrong, and the next one runs all the same.
# What they did write is packed up at the end.
failed=()
cd "$bench"
echo "== method calls (the benchmark): $rounds rounds" >&2
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
echo "== 100 callers sharing a connection, then 100 clients: $shared_rounds rounds" >&2
DBUS_BENCH_CLIENTS=100 python3 scripts/compare-brokers.py --bench "$bin/shared" \
    --rounds "$shared_rounds" --warmup "$warmup" --seed 34 --out "$out/shared.json" \
    "${meta[@]}" "${brokers[@]}" > "$out/shared.md" || failed+=(shared)
echo "== method calls with dicts of 100 variants (dicts): $rounds rounds" >&2
python3 scripts/compare-brokers.py --bench "$bin/dicts" --rounds "$rounds" \
    --warmup "$warmup" --seed 35 --out "$out/dicts.json" "${meta[@]}" "${brokers[@]}" \
    > "$out/dicts.md" || failed+=(dicts)

for workload in calls signals latency shared dicts; do
    [ -e "$out/$workload.json" ] || continue
    for pair in "${pairs[@]}"; do
        base=${pair%:*} cand=${pair#*:}
        name=$workload-$cand
        [ "$base" = before ] || name=$workload-$cand-vs-$base
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
