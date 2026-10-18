#!/bin/bash
# Compares busd on Tokio, busd on zruntime and busd on zruntime with the experimental spin before
# sleeping (see results/2026-10-18-busd-dbus-daemon-xeon-4vcpu.md), along with dbus-daemon, using
# scripts/compare-brokers.py.
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
port_rev=f0444f994898644f617bb4260d63678eeb119d0c
zruntime_rev=cf3b321959f21428ae58e32e1a0bd1dd9edf4a9a

# Makes sure that the repository $1 has the commit $4, by fetching $3 from $2 if it lacks it.
have() {
    git -C "$1" cat-file -e "$4^{commit}" 2>/dev/null || git -C "$1" fetch -q "$2" "$3"
    git -C "$1" cat-file -e "$4^{commit}"
}

# Exports the commit $2 of the repository $1 to the directory $3, unless it is there already.
export_rev() {
    if [ ! -d "$3" ]; then
        mkdir -p "$3"
        git -C "$1" archive "$2" | tar -x -C "$3"
    fi
}

have "$busd" https://github.com/z-galaxy/busd main $tokio_rev
have "$busd" https://github.com/zeenix/busd ccr-71f9417f-wbfql4 $port_rev
have "$zruntime" https://github.com/z-galaxy/zruntime refs/tags/zruntime-0.2.0 $zruntime_rev

export_rev "$busd" $tokio_rev "$work/busd-tokio"
export_rev "$busd" $port_rev "$work/busd-zruntime"
if [ ! -d "$work/zruntime-spin" ]; then
    export_rev "$zruntime" $zruntime_rev "$work/zruntime-spin"
    (cd "$work/zruntime-spin" && git apply "$spin_patch")
fi
if [ ! -d "$work/busd-spin" ]; then
    export_rev "$busd" $port_rev "$work/busd-spin"
    printf '\n[patch.crates-io]\nzruntime = { path = "%s" }\n' "$work/zruntime-spin" \
        >> "$work/busd-spin/Cargo.toml"
fi

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
if command -v dbus-daemon > /dev/null; then
    brokers+=(--broker dbus-daemon "dbus-daemon --session --nofork --address={address}")
else
    echo "dbus-daemon is not installed: leaving it out of the comparison." >&2
fi

cd "$bench"
scripts/compare-brokers.py --bench target/release/dbus-bench --rounds "$rounds" \
    --out "$work/results.json" "${brokers[@]}" | tee "$work/results.md"
echo "The results are in $work/results.md and $work/results.json."
