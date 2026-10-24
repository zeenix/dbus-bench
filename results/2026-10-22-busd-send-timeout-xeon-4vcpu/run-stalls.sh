#!/bin/bash
# The runs with clients that stop reading, of this directory, against busd's builds and
# dbus-broker. Their inputs come from the environment:
#   BIN      the directory of the binaries: busd-baseline, busd-timeout, busd-revert and
#            busd-read-ahead, and dbus-bench-zbus43, the zbus 4.3 client of the `some-changes`
#            branch. scripts/compare-send-timeout.sh builds them and runs this script.
#   PINGER   the pinger
#   OUT      the directory to write the logs to
#   JOURNAL  optional: the file that stalls/fake-journald.py writes dbus-broker's log to. On a
#            machine without systemd, dbus-broker-launch fails unless that script runs, to stand in
#            for journald. Without this file, the logs have none of dbus-broker's lines about the
#            clients that it disconnects, and count none.
# The runs against dbus-broker are left out unless dbus-broker-launch and systemd-socket-activate
# are installed, and the test with frozen subscribers unless gdbus and dbus-send are. That test
# makes FROZEN_CALLS_K1 calls (default: 1500) with one frozen subscriber, and FROZEN_CALLS_K3
# (default: 600) with two or three. SHARED_REPEATS (default: 3) is how many times each run of the
# shared connection with 100 proxies or fewer repeats.
set -u
: "${BIN:?}" "${PINGER:?}" "${OUT:?}"
JOURNAL=${JOURNAL:-}
FROZEN_CALLS_K1=${FROZEN_CALLS_K1:-1500}
FROZEN_CALLS_K3=${FROZEN_CALLS_K3:-600}
SHARED_REPEATS=${SHARED_REPEATS:-3}
export PINGER JOURNAL
stalls=$(dirname "$0")/stalls
mkdir -p "$OUT"
broker() { case $1 in dbus-broker) echo dbus-broker ;; *) echo "$BIN/busd-$1" ;; esac; }

# dbus-broker only runs under its launcher, which takes its socket from systemd's socket
# activation (see scripts/compare-brokers.py).
dbus_broker=(dbus-broker)
if ! command -v dbus-broker-launch > /dev/null ||
    ! command -v systemd-socket-activate > /dev/null; then
    echo "dbus-broker-launch or systemd-socket-activate is not installed: leaving dbus-broker" \
        "out of the runs." >&2
    dbus_broker=()
fi

# Subscribers of the bus's own signals that stop reading, while new clients call the bus. They are
# gdbus monitors, and the clients that call the bus run dbus-send.
if command -v gdbus > /dev/null && command -v dbus-send > /dev/null; then
    {
        for b in baseline timeout "${dbus_broker[@]}"; do
            K=1 "$stalls/frozen-timed.sh" "$b K=1" "$(broker "$b")" "$FROZEN_CALLS_K1"
        done
        for k in 2 3; do
            K=$k "$stalls/frozen-timed.sh" "timeout K=$k" "$(broker timeout)" "$FROZEN_CALLS_K3"
        done
        for b in baseline "${dbus_broker[@]}"; do
            K=3 "$stalls/frozen-timed.sh" "$b K=3" "$(broker "$b")" "$FROZEN_CALLS_K3"
        done
    } 2>&1 | tee "$OUT/frozen.log"
else
    echo "gdbus or dbus-send is not installed: leaving out the test with frozen subscribers." >&2
fi

# The zbus 4.3 client of the `some-changes` branch: all of it, then the phase where the proxies
# share one connection alone, by the number of proxies.
{
    for b in baseline timeout revert "${dbus_broker[@]}"; do
        "$stalls/shared-phase.sh" "$b whole client" "$(broker "$b")" \
            "$BIN/dbus-bench-zbus43" 1 60
    done
    export DBUS_BENCH_SHARED_ONLY=1
    for n in 100 96 92 88; do
        DBUS_BENCH_CLIENTS=$n "$stalls/shared-phase.sh" "timeout n=$n" \
            "$(broker timeout)" "$BIN/dbus-bench-zbus43" "$SHARED_REPEATS"
    done
    for b in baseline "${dbus_broker[@]}"; do
        DBUS_BENCH_CLIENTS=100 "$stalls/shared-phase.sh" "$b n=100" "$(broker "$b")" \
            "$BIN/dbus-bench-zbus43" "$SHARED_REPEATS"
        DBUS_BENCH_CLIENTS=200 "$stalls/shared-phase.sh" "$b n=200" "$(broker "$b")" \
            "$BIN/dbus-bench-zbus43" 1
    done
} 2>&1 | tee "$OUT/shared-zbus43.log"

# The same phase, against the time limit with more read-ahead (read-ahead.diff).
{
    export DBUS_BENCH_SHARED_ONLY=1
    for q in 64 128 256 1024; do
        BUSD_MAX_QUEUED=$q DBUS_BENCH_CLIENTS=100 "$stalls/shared-phase.sh" "read-ahead $q n=100" \
            "$BIN/busd-read-ahead" "$BIN/dbus-bench-zbus43" "$SHARED_REPEATS"
    done
    for q in 256 1024; do
        for n in 200 300; do
            BUSD_MAX_QUEUED=$q DBUS_BENCH_CLIENTS=$n "$stalls/shared-phase.sh" \
                "read-ahead $q n=$n" "$BIN/busd-read-ahead" "$BIN/dbus-bench-zbus43" 2
        done
    done
} 2>&1 | tee "$OUT/read-ahead-zbus43.log"
