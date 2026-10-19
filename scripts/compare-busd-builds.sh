#!/bin/bash
# Compares busd on Tokio, busd on zruntime and busd on zruntime with the experimental spin before
# sleeping (see results/2026-10-18-busd-dbus-daemon-xeon-4vcpu.md), along with dbus-daemon and
# dbus-broker, as far as they are installed, using scripts/compare-brokers.py.
#
# It expects checkouts of busd and zruntime under $CHECKOUT (default: ~/checkout), laid out as on
# GitHub: $CHECKOUT/z-galaxy/busd and $CHECKOUT/z-galaxy/zruntime. They are left as they are,
# apart from fetching the commits measured if they lack them: each build is made from an export of
# its commit, under $WORK (default: /tmp/busd-bench), and is reused by the next run. The results
# go there too.
#
# Usage: scripts/compare-busd-builds.sh [ROUNDS]
set -euo pipefail

checkout=${CHECKOUT:-$HOME/checkout}
work=${WORK:-/tmp/busd-bench}
rounds=${1:-15}
bench=$(cd "$(dirname "$0")/.." && pwd)
busd=$checkout/z-galaxy/busd
zruntime=$checkout/z-galaxy/zruntime
spin_patch=$bench/results/2026-10-18-busd-dbus-daemon-xeon-4vcpu/patches/zruntime-spin.diff

# The commits measured: busd's main branch, on Tokio; the port of busd to zruntime; and zruntime
# 0.2.0, which the port runs on.
tokio_rev=840d728740fce72176c6151b433f6896c0a462d7
port_rev=0d2286266648e9f1b3729e01b17408ee4a03bfd7
zruntime_rev=cf3b321959f21428ae58e32e1a0bd1dd9edf4a9a

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

# Has the export of busd in the current directory build against the export of zruntime in $1.
use_zruntime() {
    printf '\n[patch.crates-io]\nzruntime = { path = "%s" }\n' "$1" >> Cargo.toml
}

have "$busd" https://github.com/z-galaxy/busd main $tokio_rev
# The port is on the branch of its pull request, and on busd's main branch once that is merged.
have "$busd" https://github.com/z-galaxy/busd main $port_rev 2> /dev/null ||
    have "$busd" https://github.com/zeenix/busd ccr-71f9417f-wbfql4 $port_rev
have "$zruntime" https://github.com/z-galaxy/zruntime refs/tags/zruntime-0.2.0 $zruntime_rev

export_rev "$busd" $tokio_rev "$work/busd-tokio"
export_rev "$busd" $port_rev "$work/busd-zruntime"
export_rev "$zruntime" $zruntime_rev "$work/zruntime-spin" git apply "$spin_patch"
export_rev "$busd" $port_rev "$work/busd-spin" use_zruntime "$work/zruntime-spin"

(cd "$work/busd-tokio" && cargo build --release --locked)
(cd "$work/busd-zruntime" && cargo build --release --locked)
# Not locked: the patch moves zruntime from crates.io to the patched export.
(cd "$work/busd-spin" && cargo build --release)
(cd "$bench" && cargo build --release --locked)

# busd-spin0 is the patched build with the spin off: it should measure as busd-zruntime does.
brokers=(
    --broker busd-tokio "$work/busd-tokio/target/release/busd --address {address}"
    --broker busd-zruntime "$work/busd-zruntime/target/release/busd --address {address}"
    --broker busd-spin0 "$work/busd-spin/target/release/busd --address {address}"
    --broker busd-spin20
    "ZRUNTIME_SPIN_US=20 $work/busd-spin/target/release/busd --address {address}"
)
meta=(--meta "rustc=$(first_line rustc --version)")
if command -v dbus-daemon > /dev/null; then
    brokers+=(--broker dbus-daemon "dbus-daemon --session --nofork --address={address}")
    meta+=(--meta "dbus-daemon=$(first_line dbus-daemon --version)")
else
    echo "dbus-daemon is not installed: leaving it out of the comparison." >&2
fi
# dbus-broker runs only under its launcher, which takes its socket from systemd's socket activation
# and connects to the bus that $DBUS_SESSION_BUS_ADDRESS names, the one it launches here rather
# than the desktop's: see scripts/compare-brokers.py.
if command -v dbus-broker-launch > /dev/null && command -v systemd-socket-activate > /dev/null; then
    launch="dbus-broker-launch --scope user"
    brokers+=(--broker dbus-broker
        "systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS={address} -l {path} $launch")
    meta+=(--meta "dbus-broker=$(first_line dbus-broker --version)")
else
    echo "dbus-broker is not installed: leaving it out of the comparison." >&2
fi

cd "$bench"
scripts/compare-brokers.py --bench target/release/dbus-bench --rounds "$rounds" \
    --out "$work/results.json" "${meta[@]}" "${brokers[@]}" | tee "$work/results.md"
echo "The results are in $work/results.md and $work/results.json."
