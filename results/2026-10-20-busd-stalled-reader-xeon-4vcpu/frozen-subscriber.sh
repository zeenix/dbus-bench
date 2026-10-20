#!/bin/bash
# Freezes a client of a broker that is subscribed to the bus's own signals: gdbus monitor, stopped
# with SIGSTOP, so that it reads nothing more from its socket. Then has short-lived clients connect
# to the broker, call the bus and go, which makes the bus signal NameOwnerChanged, to the frozen
# client too. Reports how many of those calls got their reply before they stopped getting one,
# whether calls between two clients connected since before the freeze (the pinger) still got
# theirs in the 4 seconds after that, and whether the bus answers again once the frozen client is
# let go.
#
# Usage: frozen-subscriber.sh busd|dbus-daemon|dbus-broker
#
# busd is the binary that $BUSD names (default: busd, from $PATH). Build the pinger first:
# `cargo build --release` in the pinger directory next to this script, or name a pinger binary in
# $PINGER. Needs gdbus (GLib), dbus-send (libdbus) and, for dbus-broker, systemd-socket-activate,
# as scripts/compare-brokers.py describes.
set -u

broker=${1:?usage: frozen-subscriber.sh busd|dbus-daemon|dbus-broker}
here=$(cd "$(dirname "$0")" && pwd)
pinger=${PINGER:-$here/pinger/target/release/pinger}
if [ ! -x "$pinger" ]; then
    echo "No pinger at $pinger: run cargo build --release in $here/pinger" >&2
    exit 1
fi

# A short path: D-Bus takes socket paths of up to 99 bytes.
dir=$(mktemp -d /tmp/frozen-XXXXXX)
sock=$dir/bus
case $broker in
busd) "${BUSD:-busd}" --address "unix:path=$sock" > "$dir/broker.log" 2>&1 & ;;
dbus-daemon)
    dbus-daemon --session --nofork --address="unix:path=$sock" > "$dir/broker.log" 2>&1 &
    ;;
dbus-broker)
    systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS="unix:path=$sock" -l "$sock" \
        dbus-broker-launch --scope user > "$dir/broker.log" 2>&1 &
    ;;
*)
    echo "Unknown broker: $broker" >&2
    exit 1
    ;;
esac
broker_pid=$!
monitor_pid=
pinger_pid=

cleanup() {
    if [ -n "$monitor_pid" ]; then
        kill -CONT "$monitor_pid" 2> /dev/null
        kill "$monitor_pid" 2> /dev/null
    fi
    if [ -n "$pinger_pid" ]; then
        kill "$pinger_pid" 2> /dev/null
    fi
    # dbus-broker's launcher runs the broker as a child of its own.
    pkill -INT -P "$broker_pid" 2> /dev/null
    kill -INT "$broker_pid" 2> /dev/null
    sleep 1
    pkill -KILL -P "$broker_pid" 2> /dev/null
    kill -KILL "$broker_pid" 2> /dev/null
    wait 2> /dev/null
    rm -rf "$dir"
}
trap cleanup EXIT

for _ in $(seq 100); do
    [ -S "$sock" ] && break
    sleep 0.1
done
export DBUS_SESSION_BUS_ADDRESS="unix:path=$sock"

# A call to the bus from a new client, which connects, says Hello, makes the call and goes: the bus
# signals NameOwnerChanged as it comes and as it goes.
call() {
    timeout 3 dbus-send --session --print-reply --reply-timeout=2000 \
        --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.GetId \
        > /dev/null 2>&1
}

"$pinger" > "$dir/pinger.log" 2>&1 &
pinger_pid=$!
gdbus monitor --session --dest org.freedesktop.DBus > /dev/null 2>&1 &
monitor_pid=$!
sleep 1
if call; then
    echo "$broker: before the freeze, a call to the bus gets its reply"
else
    echo "$broker: even before the freeze, a call to the bus gets no reply" >&2
    exit 1
fi

kill -STOP "$monitor_pid"
ok=0
failed=0
while [ $((ok + failed)) -lt 1500 ] && [ "$failed" -lt 2 ]; do
    if call; then
        ok=$((ok + 1))
    else
        failed=$((failed + 1))
    fi
done
echo "$broker: $ok calls to the bus from new clients got their reply, then $failed did not"

pinged=$(wc -l < "$dir/pinger.log")
sleep 4
after=$(tail -n +$((pinged + 1)) "$dir/pinger.log")
echo "$broker: in the next 4 s, $(grep -c 'reply after' <<< "$after") calls between long-lived" \
    "clients got their reply, $(grep -c 'no reply' <<< "$after") did not"

kill -CONT "$monitor_pid"
sleep 2
if call; then
    echo "$broker: once the frozen client is let go, a call to the bus gets its reply"
else
    echo "$broker: once the frozen client is let go, a call to the bus still gets no reply"
fi
