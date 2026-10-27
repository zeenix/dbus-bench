#!/bin/bash
# Compares busd's main branch with busd checking the messages of its clients, along with
# dbus-broker and dbus-daemon, as far as they are installed:
#
# * before: busd's main branch, at 227254e, the merge of z-galaxy/busd#388: on zbus at 50c54bf, the
#   merge of z-galaxy/zbus#2083, and on zruntime at b3bd01d, the merge of z-galaxy/zruntime#60, as
#   its lock file has them;
# * after: the commit that AFTER_REV names, fd577a2 by default, the head of z-galaxy/busd#391: on
#   the same zruntime, and on zbus at 8cb16a2, the head of z-galaxy/zbus#2086. That zbus checks a
#   message that a connection receives as a whole, not only the fields of its header, and checks its
#   body against its signature where the connection asks for it, as after has the connection of
#   each client do. after also passes a reply or an error on only if it answers a call that waits
#   for one, and sets the sender of a message that a client leaves it out of with
#   `Message::with_sender`, which copies the bytes of the message with the field appended, rather
#   than building the message anew, as before does. The clients of this repository leave the
#   sender out of every message that is timed, as libdbus, GLib and sd-bus clients do, so that both
#   set it for each.
#
# after differs from before in zbus and in foldhash, which it adds, alone, as the script checks in
# their lock files. The clients of this repository build on the zbus and the zruntime that its own
# lock file has, those of before, whichever broker they run against.
#
# The comparisons that this script ran before, of the ways that busd sends what it forwards to a
# client (z-galaxy/busd#376, #382 and #383), of busd on later commits of zbus and zruntime, and of
# z-galaxy/busd#391 at 50bf523, before it set senders with `Message::with_sender`, are those of its
# commits, or of compare-dependency-updates.sh's, that the results of 2026-10-24 to 2026-10-27
# name.
#
# It runs the paired comparisons of results/2026-10-23-busd-zruntime-clock-ryzen-7840u.md between
# them, with each service and each client on a thread of its own: method calls, signals and
# latencies, and the connection that 100 callers share to call one service, then 100 services, each
# with a client of its own. Every round runs each broker once, in an order shuffled for each round,
# after WARMUP rounds that the tables leave out. It writes the tables (.md), the runs (.json) and
# the comparisons in pairs (.stats.md and .stats.json): after against before, before and after
# against dbus-broker, and after against dbus-daemon.
#
# It expects a checkout of busd under $CHECKOUT (default: ~/checkout), laid out as on GitHub:
# $CHECKOUT/z-galaxy/busd. That checkout, and the one of dbus-bench that this script is in, are left
# as they are, apart from fetching the commits measured, by their hashes, if they lack them: before
# from z-galaxy/busd, and after from z-galaxy/busd or else zeenix/busd. A short AFTER_REV, which a
# fetch cannot name, is looked for on the ccr-45bb0e6e-ik12zo branch: name a commit that the branch
# no longer has in full. Each build of busd is made from an export of its commit, under $WORK
# (default: /tmp/batched-sends-bench), and is reused by the next run. The clients of this repository
# are built in its checkout. The results go to $WORK/batched-sends-results-COMMIT, where COMMIT is
# the short hash of the after commit: each run empties it, and writes its results there, along with
# environment.txt, which notes the versions that the tables do not name. The archive is
# $WORK/batched-sends-results-COMMIT.tar.gz.
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
    echo "usage: scripts/compare-batched-sends.sh (the environment sets the rest:" \
        "see the top)" >&2
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

# The commits measured: busd's main branch, and busd checking the messages of its clients.
before_rev=227254e8bf912ff82f1f6852f4dfe5a98062eb6e
after_rev=${AFTER_REV:-fd577a2ca9aac53457ccbac34802264e8e2a4c67}

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

have "$busd" https://github.com/z-galaxy/busd main "$before_rev"
# The after commit is on z-galaxy/busd once it merges it from a branch of zeenix/busd.
git -C "$busd" cat-file -e "$after_rev^{commit}" 2>/dev/null ||
    git -C "$busd" fetch -q https://github.com/z-galaxy/busd "$after_rev" 2>/dev/null ||
    have "$busd" https://github.com/zeenix/busd ccr-45bb0e6e-ik12zo "$after_rev"
# AFTER_REV may be a short hash: the results name the full one.
after_rev=$(git -C "$busd" rev-parse --verify "$after_rev^{commit}")

export_rev "$busd" "$before_rev" "$work/busd-before"
export_rev "$busd" "$after_rev" "$work/busd-after"
# What before and after build on, as their lock files have it.
zbus_before=$(cd "$work/busd-before" && locked_rev zbus)
zbus_after=$(cd "$work/busd-after" && locked_rev zbus)
zruntime=$(cd "$work/busd-after" && locked_rev zruntime)
# after is to differ from before in zbus, and in the foldhash that it adds, alone.
lock_diff=$(diff <(cd "$work/busd-before" && locked_packages) \
    <(cd "$work/busd-after" && locked_packages) | grep '^[<>] ' | grep -v '^> "foldhash" ' ||
    true)
if [ -n "$lock_diff" ]; then
    echo "after was to differ from before in zbus and foldhash alone, but their lock files" \
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
for client in dbus-bench fanout latency shared; do
    cp "$bench/target/release/$client" "$bin/$client"
done

# What an earlier run of the same commit left in the results would end up in the archive, so each
# run starts afresh.
out=$work/batched-sends-results-${after_rev:0:7}
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
meta=(--meta "rustc=$(first_line rustc --version)" --meta "before=$before_rev"
    --meta "after=$after_rev" --meta "zbus-before=$zbus_before" --meta "zbus-after=$zbus_after"
    --meta "zruntime=$zruntime")
pairs=(before:after)
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

for workload in calls signals latency shared; do
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
