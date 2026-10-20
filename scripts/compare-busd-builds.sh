#!/bin/bash
# Compares busd on Tokio, busd on zruntime, busd on zruntime with the experimental spin before
# sleeping (see results/2026-10-18-busd-dbus-daemon-xeon-4vcpu.md) and busd on zruntime with its
# busy polling (see results/2026-10-18-zruntime-busy-poll-xeon-4vcpu.md), along with dbus-daemon
# and dbus-broker, as far as they are installed. It measures them in three ways, one after the
# other, and packs what it finds into one archive:
#
# 1. Under load: the benchmark of this repository (one client, then 20 at once) against all of
#    them, using scripts/compare-brokers.py: results.md and results.json.
# 2. Under load on one CPU: the same, with the client and the brokers all on CPU 0, against the
#    busy polling (off, and at 20 microseconds) and the spin (at 20 microseconds), to see what
#    each costs when the work that a broker waits for needs the CPU it would spin on: one-cpu.md
#    and one-cpu.json.
# 3. Under light traffic: a client makes a method call every 1000 microseconds, or every 50, for a
#    few seconds, either to the bus itself or to a service of its own that the bus forwards the
#    call to, against the busy polling (off, at 20 and, for forwarded calls, at 50 microseconds)
#    and the spin (at 20). That measures what a broker costs when it has little to do: its CPU
#    time per call, how long the calls take, how often it sleeps and the energy that the CPU
#    packages use. The client and the script that runs it are in
#    results/2026-10-18-zruntime-busy-poll-xeon-4vcpu. The results are light-bus-1000,
#    light-forward-1000 and light-bus-50, each as .md and .json.
#
# It expects checkouts of busd and zruntime under $CHECKOUT (default: ~/checkout), laid out as on
# GitHub: $CHECKOUT/z-galaxy/busd and $CHECKOUT/z-galaxy/zruntime. They are left as they are,
# apart from fetching the commits measured if they lack them: each build is made from an export of
# its commit, under $WORK (default: /tmp/busd-bench), and is reused by the next run. The results
# go there too.
#
# Usage: scripts/compare-busd-builds.sh [ROUNDS]
#
# ROUNDS is the number of rounds of the first comparison (default: 15). The environment sets the
# others: ONE_CPU_ROUNDS is the number of rounds of the comparison on one CPU (default: 10),
# LIGHT_ROUNDS the number of rounds of each light-traffic test (default: 10) and LIGHT_SECS the
# number of seconds that each run of a light-traffic test lasts (default: 3).
#
# With the default rounds, a run takes about 7.5 minutes on a Ryzen 7 7840U laptop, once the builds
# are made: 1.5 minutes under load, 45 seconds on one CPU and 5 minutes for the light-traffic tests,
# as the run of results/2026-10-20-zbus-6-ryzen-7840u.md did. The first run makes the builds too,
# which took about 5 minutes on a 4-vCPU Xeon VM.
#
# The light-traffic tests record the energy that the CPU packages use while the client runs only
# where they can read the counters, /sys/class/powercap/*/energy_uj, which most systems let only
# root read; the tables say n/a for the energy otherwise. To open the counters up, run
# sudo chmod a+r /sys/class/powercap/*/energy_uj before the script: that lasts until the next
# reboot. A thread that polls keeps its CPU out of the deep idle states that save power, which the
# broker's CPU time does not show, and the energy does. A package counts the energy of everything
# that runs on it, so keep the machine otherwise idle.
set -euo pipefail

checkout=${CHECKOUT:-$HOME/checkout}
work=${WORK:-/tmp/busd-bench}
rounds=${1:-15}
one_cpu_rounds=${ONE_CPU_ROUNDS:-10}
light_rounds=${LIGHT_ROUNDS:-10}
light_secs=${LIGHT_SECS:-3}
bench=$(cd "$(dirname "$0")/.." && pwd)
busd=$checkout/z-galaxy/busd
zruntime=$checkout/z-galaxy/zruntime
spin_patch=$bench/results/2026-10-18-busd-dbus-daemon-xeon-4vcpu/patches/zruntime-spin.diff
# The change to busd that sets the busy polling, and the light-traffic test, are with the results
# of the busy polling.
busypoll_results=$bench/results/2026-10-18-zruntime-busy-poll-xeon-4vcpu
busypoll_patch=$busypoll_results/patches/busd-busy-poll.diff
light_client=$busypoll_results/light-client
light_measure=$busypoll_results/measure-light-traffic.py

# The commits measured: the last commit of busd's main branch on Tokio; the port of busd to
# zruntime, which that branch has had since a982812, with the same code; zruntime 0.2.0, which the
# port runs on; and zruntime with the busy polling of z-galaxy/zruntime#52.
tokio_rev=840d728740fce72176c6151b433f6896c0a462d7
port_rev=0d2286266648e9f1b3729e01b17408ee4a03bfd7
zruntime_rev=cf3b321959f21428ae58e32e1a0bd1dd9edf4a9a
busypoll_rev=d91ca1b99da803fbd68a1611f6e6946771d534d4

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

# Turns the export of busd in the current directory into the build with the busy polling: the part
# of the patch $1 that changes busd's code, on the export of zruntime with the busy polling in $2.
# The other part of the patch points Cargo.toml at ../zruntime, which is not where that export is.
patch_busypoll() {
    git apply --include=src/bin/busd.rs "$1"
    use_zruntime "$2"
}

# Runs the light-traffic test: a client makes a method call every $2 microseconds for $light_secs
# seconds against each of the brokers $3... in turn, $light_rounds times over. $1 says where the
# calls go: "bus" to the bus itself, or "forward" to a service of the client's own, with the bus
# forwarding each call and its reply. A broker is LABEL=COMMAND, and a COMMAND sets variables
# through env. The table goes to $work/light-$1-$2.md and the runs to $work/light-$1-$2.json,
# which are added to the result files. A test that goes wrong is added to the failures, and the
# next one runs all the same.
light_traffic() {
    local mode=$1 interval=$2 name=light-$1-$2
    shift 2
    echo "Light traffic, MODE=$mode INTERVAL_US=$interval: $light_rounds rounds." >&2
    result_files+=("$name.json" "$name.md")
    if ! MODE=$mode INTERVAL_US=$interval SECS=$light_secs "$light_measure" \
        "$work/light-client-target/release/light-client" "$light_rounds" "$work/$name.json" \
        "$@" | tee "$work/$name.md"; then
        failed+=("the light-traffic test $name")
    fi
}

have "$busd" https://github.com/z-galaxy/busd main $tokio_rev
# The port is on busd's main branch, which a982812 merged it into, and on the branch of its pull
# request.
have "$busd" https://github.com/z-galaxy/busd main $port_rev 2> /dev/null ||
    have "$busd" https://github.com/zeenix/busd ccr-71f9417f-wbfql4 $port_rev
have "$zruntime" https://github.com/z-galaxy/zruntime refs/tags/zruntime-0.2.0 $zruntime_rev
# The busy polling is on the pull request, which is fetched by its ref: unlike the pull request's
# branch, the ref stays once the pull request is merged. Pushing to the pull request again moves
# the ref off this commit, though: pin the new head then.
have "$zruntime" https://github.com/z-galaxy/zruntime refs/pull/52/head $busypoll_rev

export_rev "$busd" $tokio_rev "$work/busd-tokio"
export_rev "$busd" $port_rev "$work/busd-zruntime"
export_rev "$zruntime" $zruntime_rev "$work/zruntime-spin" git apply "$spin_patch"
export_rev "$busd" $port_rev "$work/busd-spin" use_zruntime "$work/zruntime-spin"
export_rev "$zruntime" $busypoll_rev "$work/zruntime-busypoll"
export_rev "$busd" $port_rev "$work/busd-busypoll" patch_busypoll "$busypoll_patch" \
    "$work/zruntime-busypoll"

(cd "$work/busd-tokio" && cargo build --release --locked)
(cd "$work/busd-zruntime" && cargo build --release --locked)
# Not locked: the patch moves zruntime from crates.io to the patched export.
(cd "$work/busd-spin" && cargo build --release)
# Not locked either, for the same reason.
(cd "$work/busd-busypoll" && cargo build --release)
(cd "$bench" && cargo build --release --locked)
# The client of the light-traffic tests is a crate of its own, with its own lock file. Its target
# directory is under $work, so that the build leaves nothing in the repository.
(cd "$light_client" && CARGO_TARGET_DIR="$work/light-client-target" cargo build --release --locked)

spin_busd=$work/busd-spin/target/release/busd
busypoll_busd=$work/busd-busypoll/target/release/busd

# busypoll-off is the build with the busy polling, with the busy polling off: like busd-spin0 for
# the spin, it should measure as busd-zruntime does. busypoll20 polls for up to 20 microseconds
# before it sleeps. These two are in the comparison on one CPU as well.
busypoll_brokers=(
    --broker busypoll-off "$busypoll_busd --address {address}"
    --broker busypoll20 "ZRUNTIME_BUSY_POLL_US=20 $busypoll_busd --address {address}"
)
# busd-spin0 is the patched build with the spin off: it should measure as busd-zruntime does.
brokers=(
    --broker busd-tokio "$work/busd-tokio/target/release/busd --address {address}"
    --broker busd-zruntime "$work/busd-zruntime/target/release/busd --address {address}"
    --broker busd-spin0 "$work/busd-spin/target/release/busd --address {address}"
    --broker busd-spin20
    "ZRUNTIME_SPIN_US=20 $work/busd-spin/target/release/busd --address {address}"
    "${busypoll_brokers[@]}"
)
# The client is what limits the timings of the fastest brokers, so the results name the commit of
# this repository that it is built from, with -dirty after it where the checkout has changes that
# are not committed.
meta=(--meta "rustc=$(first_line rustc --version)" --meta "zruntime-busypoll=$busypoll_rev"
    --meta "dbus-bench=$(first_line git -C "$bench" describe --always --dirty --abbrev=40)")
# The comparison on one CPU has neither dbus-daemon nor dbus-broker in it, so it is told nothing
# of their versions.
one_cpu_meta=("${meta[@]}" --meta "taskset=-c 0")
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

# Each comparison and test below records its result files, and is added to the failures if it goes
# wrong: a run of the benchmark that fails, say. The next one runs all the same, and what they did
# record is packed up at the end.
result_files=()
failed=()

cd "$bench"
echo "Comparing the builds and brokers under load: $rounds rounds." >&2
result_files+=(results.json results.md)
if ! scripts/compare-brokers.py --bench target/release/dbus-bench --rounds "$rounds" \
    --out "$work/results.json" "${meta[@]}" "${brokers[@]}" | tee "$work/results.md"; then
    failed+=("the comparison under load")
fi

# The same again with the client and every broker on one CPU, for the builds that spin or poll
# before they sleep. A spin is a bet that the work a broker waits for turns up within microseconds.
# With more CPUs, the client works on another one meanwhile, and the bet can pay off. On one, the
# work that the broker waits for needs the CPU that the spin holds, so the spin catches nothing and
# delays that work by as long as it lasts. What that costs the busy polling, which spins only after
# short waits, and what it costs spin20, which spins before every sleep, is what this shows. The
# CPU list of taskset passes on to everything that compare-brokers.py starts.
echo "Comparing the busy polling and the spin on one CPU: $one_cpu_rounds rounds." >&2
result_files+=(one-cpu.json one-cpu.md)
if ! taskset -c 0 scripts/compare-brokers.py --bench target/release/dbus-bench \
    --rounds "$one_cpu_rounds" --out "$work/one-cpu.json" "${one_cpu_meta[@]}" \
    "${busypoll_brokers[@]}" \
    --broker spin20 "ZRUNTIME_SPIN_US=20 $spin_busd --address {address}" | tee "$work/one-cpu.md"
then
    failed+=("the comparison on one CPU")
fi

# The light-traffic tests: a client that calls the bus once in a while leaves a broker asleep most
# of the time. They measure what each build costs then, in CPU time, in latency and in energy: a
# spin before every sleep burns CPU time on the sleeps that it does not shorten, and the busy
# polling spins only after waits that were short. "off" is the build with the busy polling, with
# the busy polling off. The script of the tests wants a broker as LABEL=COMMAND, and the COMMAND to
# set variables through env.
light_off="off=$busypoll_busd --address {address}"
light_busypoll20="busypoll20=env ZRUNTIME_BUSY_POLL_US=20 $busypoll_busd --address {address}"
light_busypoll50="busypoll50=env ZRUNTIME_BUSY_POLL_US=50 $busypoll_busd --address {address}"
light_spin20="spin20=env ZRUNTIME_SPIN_US=20 $spin_busd --address {address}"
light_traffic bus 1000 "$light_off" "$light_busypoll20" "$light_spin20"
light_traffic forward 1000 "$light_off" "$light_busypoll20" "$light_busypoll50" "$light_spin20"
light_traffic bus 50 "$light_off" "$light_busypoll20" "$light_spin20"

# Only what was written: a test that failed early may have left no file behind.
written=()
for file in "${result_files[@]}"; do
    if [ -e "$work/$file" ]; then
        written+=("$file")
    fi
done
if [ ${#written[@]} -gt 0 ]; then
    (cd "$work" && tar -czf busd-bench-results.tar.gz "${written[@]}")
    echo "The results are in $work, as"
    printf '  %s\n' "${written[@]}"
    echo "and all of them are packed in $work/busd-bench-results.tar.gz."
fi
if [ ${#failed[@]} -gt 0 ]; then
    echo "These went wrong, so their results are incomplete or missing:" >&2
    printf '  %s\n' "${failed[@]}" >&2
    exit 1
fi
