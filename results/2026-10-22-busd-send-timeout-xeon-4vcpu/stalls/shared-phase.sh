#!/bin/bash
# Runs a client of the benchmark against a fresh broker, REPEATS times, and prints, for each run,
# the client's exit status, how long it ran, how many clients the broker logged that it
# disconnected, and the client's output. If the client still runs after 15 s, it also prints the
# queues of the unix sockets of the broker and of the client: a deadlock shows as data that neither
# side reads.
#
# Usage: shared-phase.sh LABEL BUSD|dbus-broker CLIENT [REPEATS [LIMIT_SECS]]
#
# For the zbus 4.3 client of the `some-changes` branch, with zbus43-clients.diff applied,
# DBUS_BENCH_SHARED_ONLY=1 runs the phase where the proxies share one connection alone, and
# DBUS_BENCH_CLIENTS sets how many proxies there are (100 by default). $JOURNAL is as in
# frozen-timed.sh.
label=$1 broker=$2 client=$3 repeats=${4:-1} limit=${5:-60}
descendants() { for c in $(pgrep -P "$1"); do echo "$c"; descendants "$c"; done; }
for r in $(seq "$repeats"); do
    dir=$(mktemp -d /tmp/shared-XXXXXX)
    sock=$dir/bus
    journal_start=$(wc -l < "${JOURNAL:-/dev/null}" 2>/dev/null || echo 0)
    if [ "$broker" = dbus-broker ]; then
        systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS="unix:path=$sock" -l "$sock" \
            dbus-broker-launch --scope user > "$dir/broker.log" 2>&1 &
    else
        RUST_LOG=busd=warn "$broker" --address "unix:path=$sock" > "$dir/broker.log" 2>&1 &
    fi
    bpid=$!
    for _ in $(seq 100); do [ -S "$sock" ] && break; sleep 0.05; done
    start=$(date +%s%N)
    DBUS_SESSION_BUS_ADDRESS="unix:path=$sock" timeout "$limit" "$client" > "$dir/client.out" 2>&1 &
    cpid=$!
    for _ in $(seq 150); do kill -0 $cpid 2>/dev/null || break; sleep 0.1; done
    if kill -0 $cpid 2>/dev/null; then
        pids=$(echo $bpid $(descendants $bpid) $(descendants $cpid) | tr ' ' '|')
        echo "$label run=$r: after 15 s the client still runs; unix sockets (Recv-Q Send-Q):"
        ss -xp 2>/dev/null | grep -E "pid=($pids)," | awk '{print $3, $4, $NF}' | sort | uniq -c |
            sort -rn | head -6 | sed 's/^/    /'
    fi
    wait $cpid; rc=$?
    end=$(date +%s%N)
    if [ "$broker" = dbus-broker ]; then
        disc=$(tail -n +$((journal_start + 1)) "${JOURNAL:-/dev/null}" 2>/dev/null |
            grep -c "being disconnected")
    else
        disc=$(grep -c "Disconnecting" "$dir/broker.log")
    fi
    pkill -INT -P $bpid 2>/dev/null; kill -INT $bpid; sleep 0.3
    pkill -KILL -P $bpid 2>/dev/null; kill -KILL $bpid 2>/dev/null; wait $bpid 2>/dev/null
    echo "$label run=$r exit=$rc wall=$(( (end - start) / 1000000 ))ms disconnects=$disc"
    head -5 "$dir/client.out" | cut -c1-140 | sed 's/^/    /'
    rm -rf "$dir"
done
