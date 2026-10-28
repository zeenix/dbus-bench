#!/bin/bash
# Builds busd and measures it against dbus-broker and dbus-daemon, as far as they are installed, on
# every workload of this repository:
#
# * calls: the method calls of the benchmark, by one client and then by 20 at once;
# * signals: a burst of signals to one subscriber, then broadcasts to 20 (fanout);
# * latency: the round trips of method calls and the delays of the signals of a fan-out, through
#   scripts/compare-latency.py;
# * shared: 100 callers that share a connection to call one service, then 100 services, each with
#   a client of its own (shared, with DBUS_BENCH_CLIENTS=100);
# * dicts: the method calls of the benchmark, with a dict of dicts of 100 variants in all,
#   `a{sa{sv}}`, for their body.
#
# busd is the commit that BUSD_REV names (default: main), which is fetched from z-galaxy/busd:
# a branch, a tag, a full hash or a ref such as refs/pull/396/head, the head of a pull request. A
# commit that the checkout of busd has already can be named by its hash, long or short. With
# BASELINE_REV, another commit of busd, named the same ways, it measures that one too, as baseline,
# to tell what busd changes against it. Each builds on the dependencies that its own lock file has.
# The clients of this repository build on the zbus and the zruntime that its lock file has,
# whichever broker they run against.
#
# Every round runs each broker once, in an order shuffled for each round, after WARMUP rounds that
# the tables leave out. It writes the tables (.md) and the runs (.json) of each workload, and the
# comparisons in pairs (.stats.md and .stats.json) of busd against dbus-broker, dbus-daemon and
# baseline, as WORKLOAD-busd-vs-BROKER.
#
# It expects a checkout of busd under $CHECKOUT (default: ~/checkout), laid out as on GitHub:
# $CHECKOUT/z-galaxy/busd, which it clones if there is none. That checkout, and the one of
# dbus-bench that this script is in, are left as they are, apart from fetching the commits measured.
# Each build of busd is made from an export of its commit, under $WORK (default: /tmp/dbus-bench),
# and is reused by the next run of that commit. The clients of this repository are built in its
# checkout. The results go to $WORK/results-COMMIT, or $WORK/results-COMMIT-vs-BASELINE, where
# COMMIT and BASELINE are the short hashes of busd and baseline: each run empties it, and writes its
# results there, along with environment.txt, which notes the versions that the tables do not name.
# The archive is the same path with .tar.gz appended. scripts/pack-results.sh packs the raw results
# for the results directory.
#
# Usage: scripts/compare.sh
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
    echo "usage: scripts/compare.sh (the environment sets the rest: see the top)" >&2
    exit 2
fi

checkout=${CHECKOUT:-$HOME/checkout}
work=${WORK:-/tmp/dbus-bench}
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
busd_url=https://github.com/z-galaxy/busd

# The full hash of the commit $1 of busd: one that the checkout has already, if $1 is a hash of it,
# and else what z-galaxy/busd has under that name, fetched afresh, so that a branch is never stale.
resolve() {
    if [[ $1 =~ ^[0-9a-f]{7,40}$ ]] && git -C "$busd" cat-file -e "$1^{commit}" 2> /dev/null; then
        git -C "$busd" rev-parse "$1^{commit}"
        return
    fi
    git -C "$busd" fetch -q "$busd_url" "$1"
    git -C "$busd" rev-parse "FETCH_HEAD^{commit}"
}

# The first line that the command prints, whatever becomes of the command.
first_line() {
    "$@" 2> /dev/null | sed -n 1p || true
}

# Exports the commit $1 of busd to $work/busd-COMMIT, COMMIT being its short hash, and builds it
# there, unless the export is there already, in which case cargo builds whatever it lacks. The
# export is made under another name, which becomes its own once it is whole, so that a run that
# stops halfway leaves no export behind that the next run would take for a whole one.
build() {
    local dir=$work/busd-${1:0:7}
    if [ ! -d "$dir" ]; then
        rm -rf "$dir.new"
        mkdir -p "$dir.new"
        git -C "$busd" archive "$1" | tar -x -C "$dir.new"
        mv "$dir.new" "$dir"
    fi
    (cd "$dir" && cargo build --release --locked)
}

# The version of the package $1 that the lock file in the current directory has, with the
# repository and the commit of git that it is at, where it comes from git, or its versions, if it
# has several.
locked() {
    awk -v name="\"$1\"" '
        function add() {
            if (n == name) all = all (all ? " and " : "") v (s ~ /^"git\+/ ? " " s : "")
        }
        /^\[\[package\]\]$/ { add(); n = v = s = "" }
        $1 == "name" { n = $3 } $1 == "version" { v = $3 } $1 == "source" { s = $3 }
        END { add(); print all }' Cargo.lock | tr -d '"' | sed 's|git+\([^?#]*\)[^#]*#|\1 at |g'
}

if [ ! -d "$busd" ]; then
    git clone -q "$busd_url" "$busd"
fi
busd_rev=$(resolve "${BUSD_REV:-main}")
builds=(busd)
revs=("$busd_rev")
out=$work/results-${busd_rev:0:7}
if [ -n "${BASELINE_REV:-}" ]; then
    baseline_rev=$(resolve "$BASELINE_REV")
    builds+=(baseline)
    revs+=("$baseline_rev")
    out+=-vs-${baseline_rev:0:7}
fi
for rev in "${revs[@]}"; do
    build "$rev"
done
(cd "$bench" && cargo build --release --locked)

# The scripts want the binaries in one directory, under these names.
bin=$work/bin
mkdir -p "$bin"
for i in "${!builds[@]}"; do
    cp "$work/busd-${revs[$i]:0:7}/target/release/busd" "$bin/${builds[$i]}"
done
for client in dbus-bench fanout latency shared dicts; do
    cp "$bench/target/release/$client" "$bin/$client"
done

# What an earlier run of the same commits left in the results would end up in the archive, so each
# run starts afresh.
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
    echo "clients: zbus $(cd "$bench" && locked zbus), zruntime $(cd "$bench" && locked zruntime)"
    for i in "${!builds[@]}"; do
        dir=$work/busd-${revs[$i]:0:7}
        echo "${builds[$i]}: ${revs[$i]}, zbus $(cd "$dir" && locked zbus), zruntime $(cd "$dir" &&
            locked zruntime)"
    done
    echo "dbus-broker: $(first_line dbus-broker --version)"
    echo "dbus-daemon: $(first_line dbus-daemon --version)"
} > "$out/environment.txt"

# busd logs why it disconnects a client at its debug level, and nothing at that level while it
# forwards messages, so the log that a failed run shows names the cause, at no cost to the others.
brokers=()
meta=(--meta "rustc=$(first_line rustc --version)")
for i in "${!builds[@]}"; do
    brokers+=(--broker "${builds[$i]}" "RUST_LOG=busd=debug $bin/${builds[$i]} --address {address}")
    meta+=(--meta "${builds[$i]}=${revs[$i]}")
done
pairs=()
if [ ${#builds[@]} -gt 1 ]; then
    pairs+=(baseline)
fi
# dbus-broker runs only under its launcher, which takes its socket from systemd's socket activation
# and connects to the bus that $DBUS_SESSION_BUS_ADDRESS names, the one it launches here rather
# than the desktop's: see scripts/compare-brokers.py.
if command -v dbus-broker-launch > /dev/null && command -v systemd-socket-activate > /dev/null; then
    launch="dbus-broker-launch --scope user"
    brokers+=(--broker dbus-broker
        "systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS={address} -l {path} $launch")
    meta+=(--meta "dbus-broker=$(first_line dbus-broker --version)")
    pairs+=(dbus-broker)
else
    echo "dbus-broker-launch or systemd-socket-activate is not installed: leaving dbus-broker" \
        "out of the comparisons." >&2
fi
if command -v dbus-daemon > /dev/null; then
    brokers+=(--broker dbus-daemon "dbus-daemon --session --nofork --address={address}")
    meta+=(--meta "dbus-daemon=$(first_line dbus-daemon --version)")
    pairs+=(dbus-daemon)
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
    for base in "${pairs[@]}"; do
        name=$workload-busd-vs-$base
        python3 scripts/paired-stats.py "$out/$workload.json" --baseline "$base" \
            --candidate busd --json "$out/$name.stats.json" > "$out/$name.stats.md" ||
            failed+=("the comparison of busd against $base on $workload")
    done
done

(cd "$out" && tar -czf "$archive" -- *)
echo "The results are in $out, and all of them are packed in $archive."
if [ ${#failed[@]} -gt 0 ]; then
    echo "These went wrong, so their results are incomplete or missing:" >&2
    printf '  %s\n' "${failed[@]}" >&2
    exit 1
fi
