#!/bin/bash
# The runs with clients that stop reading, of this directory, against busd's builds and
# dbus-broker. $BIN is the directory of the binaries, which the .md next to this directory says how
# to build, $PINGER the pinger, $JOURNAL the file that stalls/fake-journald.py writes dbus-broker's
# log to, and $OUT the directory to write the logs to.
set -u
: "${BIN:?}" "${PINGER:?}" "${JOURNAL:?}" "${OUT:?}"
export PINGER JOURNAL
stalls=$(dirname "$0")/stalls
mkdir -p "$OUT"
broker() { case $1 in dbus-broker) echo dbus-broker ;; *) echo "$BIN/busd-$1" ;; esac; }
label() { case $1 in dbus-broker) echo dbus-broker ;; *) echo "${1%-*}" ;; esac; }

# Subscribers of the bus's own signals that stop reading, while new clients call the bus.
{
    for b in baseline-0c52e9c timeout-8d57e20 dbus-broker; do
        K=1 "$stalls/frozen-timed.sh" "$(label $b) K=1" "$(broker $b)" 1500
    done
    for k in 2 3; do
        K=$k "$stalls/frozen-timed.sh" "timeout K=$k" "$(broker timeout-8d57e20)" 600
    done
    for b in baseline-0c52e9c dbus-broker; do
        K=3 "$stalls/frozen-timed.sh" "$(label $b) K=3" "$(broker $b)" 600
    done
} 2>&1 | tee "$OUT/frozen.log"

# The zbus 4.3 client of the `some-changes` branch: all of it, then the phase where the proxies
# share one connection alone, by the number of proxies.
{
    for b in baseline-0c52e9c timeout-8d57e20 revert-41407f0 dbus-broker; do
        "$stalls/shared-phase.sh" "$(label $b) whole client" "$(broker $b)" \
            "$BIN/dbus-bench-zbus43" 1 60
    done
    export DBUS_BENCH_SHARED_ONLY=1
    for n in 100 96 92 88; do
        DBUS_BENCH_CLIENTS=$n "$stalls/shared-phase.sh" "timeout n=$n" \
            "$(broker timeout-8d57e20)" "$BIN/dbus-bench-zbus43" 3
    done
    for b in baseline-0c52e9c dbus-broker; do
        DBUS_BENCH_CLIENTS=100 "$stalls/shared-phase.sh" "$(label $b) n=100" "$(broker $b)" \
            "$BIN/dbus-bench-zbus43" 3
        DBUS_BENCH_CLIENTS=200 "$stalls/shared-phase.sh" "$(label $b) n=200" "$(broker $b)" \
            "$BIN/dbus-bench-zbus43" 1
    done
} 2>&1 | tee "$OUT/shared-zbus43.log"

# The same phase, against the time limit with more read-ahead (read-ahead.diff).
{
    export DBUS_BENCH_SHARED_ONLY=1
    for q in 64 128 256 1024; do
        BUSD_MAX_QUEUED=$q DBUS_BENCH_CLIENTS=100 "$stalls/shared-phase.sh" "read-ahead $q n=100" \
            "$BIN/busd-read-ahead" "$BIN/dbus-bench-zbus43" 3
    done
    for q in 256 1024; do
        for n in 200 300; do
            BUSD_MAX_QUEUED=$q DBUS_BENCH_CLIENTS=$n "$stalls/shared-phase.sh" \
                "read-ahead $q n=$n" "$BIN/busd-read-ahead" "$BIN/dbus-bench-zbus43" 2
        done
    done
} 2>&1 | tee "$OUT/read-ahead-zbus43.log"
