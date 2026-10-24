#!/bin/bash
# A timed variant of ../../2026-10-20-busd-stalled-reader-xeon-4vcpu/frozen-subscriber.sh: starts K
# (1 by default) `gdbus monitor --dest org.freedesktop.DBus`, which subscribe to the bus's own
# signals, freezes them with SIGSTOP, then has N short-lived clients (dbus-send, GetId, with a 25 s
# reply timeout, so that a late reply still counts) call the bus one after the other, and records
# how long each call took. It reports the distribution of those times, the calls that took over
# 100 ms, what the broker logged about disconnecting the frozen clients, how many of them are still
# running once let go, and whether the bus still answers then.
#
# Usage: [K=N] frozen-timed.sh LABEL BUSD|dbus-broker|dbus-daemon CALLS
#
# $PINGER is the pinger of ../../2026-10-20-busd-stalled-reader-xeon-4vcpu/pinger, which calls a
# service of its own on a second connection every 500 ms. dbus-broker logs to journald, which
# fake-journald.py stands in for in a container without systemd: $JOURNAL is the file that it
# writes the entries to.
label=$1 broker=$2 n=${3:-1500}
: "${PINGER:?set PINGER to the pinger binary}"
dir=$(mktemp -d /tmp/frozen-XXXXXX)
sock=$dir/bus
journal_start=$(wc -l < "${JOURNAL:-/dev/null}" 2>/dev/null || echo 0)
if [ "$broker" = dbus-daemon ]; then
    dbus-daemon --session --nofork --address="unix:path=$sock" > "$dir/broker.log" 2>&1 &
elif [ "$broker" = dbus-broker ]; then
    systemd-socket-activate -E DBUS_SESSION_BUS_ADDRESS="unix:path=$sock" -l "$sock" \
        dbus-broker-launch --scope user > "$dir/broker.log" 2>&1 &
else
    RUST_LOG=busd=warn "$broker" --address "unix:path=$sock" > "$dir/broker.log" 2>&1 &
fi
bpid=$!
for _ in $(seq 100); do [ -S "$sock" ] && break; sleep 0.1; done
export DBUS_SESSION_BUS_ADDRESS="unix:path=$sock"
"$PINGER" > "$dir/pinger.log" 2>&1 & ppid=$!
mpids=""
for _ in $(seq "${K:-1}"); do
    gdbus monitor --session --dest org.freedesktop.DBus > /dev/null 2>&1 & mpids="$mpids $!"
done
sleep 1
kill -STOP $mpids
frozen=$(date +%s%N)
fails=0
for i in $(seq "$n"); do
    t0=$(date +%s%N)
    if ! dbus-send --session --print-reply --reply-timeout=25000 --dest=org.freedesktop.DBus \
        /org/freedesktop/DBus org.freedesktop.DBus.GetId > /dev/null 2>&1; then
        fails=$((fails + 1))
    fi
    t1=$(date +%s%N)
    echo "$i $(( (t0 - frozen) / 1000000 )) $(( (t1 - t0) / 1000000 ))" >> "$dir/calls"
done
done_at=$(date +%s%N)
kill -CONT $mpids; sleep 1
after=no
if dbus-send --session --print-reply --reply-timeout=2000 --dest=org.freedesktop.DBus \
    /org/freedesktop/DBus org.freedesktop.DBus.GetId > /dev/null 2>&1; then
    after=yes
fi
alive=$(for p in $mpids; do kill -0 "$p" 2>/dev/null && echo running || echo exited; done |
    sort | uniq -c | tr "\n" " ")
kill $ppid $mpids 2>/dev/null
pkill -INT -P $bpid 2>/dev/null; kill -INT $bpid; sleep 0.5
pkill -KILL -P $bpid 2>/dev/null; kill -KILL $bpid 2>/dev/null; wait 2>/dev/null
total=$(( (done_at - frozen) / 1000000 ))
python3 -I - "$dir/calls" "$label" "$fails" "$after" "$alive" "$total" <<'PY'
import sys
path, label, fails, after, alive, total = sys.argv[1:]
rows = [tuple(map(int, l.split())) for l in open(path)]
d = sorted(r[2] for r in rows)
q = lambda p: d[min(len(d) - 1, int(p * len(d)))]
slow = [(i, at, ms) for i, at, ms in rows if ms > 100]
print(f"{label}: {len(rows)} calls in {int(total)/1000:.1f} s, {fails} failed; "
      f"call ms p50 {q(.5)} p99 {q(.99)} max {d[-1]}")
print(f"{label}: calls over 100 ms (call#, ms after freeze, ms): "
      f"{slow[:6]}{' ...' if len(slow) > 6 else ''}")
print(f"{label}: after SIGCONT a call {'gets' if after == 'yes' else 'does NOT get'} its reply; "
      f"frozen monitors: {alive}")
PY
if [ -n "${JOURNAL:-}" ]; then
    tail -n +$((journal_start + 1)) "$JOURNAL" | grep -h "being disconnected\|exceeded its" |
        head -3 | sed "s/^/$label: dbus-broker log: /"
fi
grep -h "Disconnecting" "$dir/broker.log" | sed -E 's/\x1b\[[0-9;]*m//g' | cut -c1-160 |
    sed "s/^/$label: busd log: /"
grep -c "no reply" "$dir/pinger.log" | sed "s/^/$label: pinger calls without reply: /"
rm -rf "$dir"
