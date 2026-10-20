# busd and a client that stops reading

Looked into on 2026-10-20, on the 4-vCPU VM of
[the benchmark on zbus 6](2026-10-20-zbus-6-xeon-4vcpu.md), with busd at a982812, the main branch
of z-galaxy/busd, on zbus 6.0.0 and zruntime 0.2.0, and the dbus-daemon 1.14.10 and dbus-broker 35
of Ubuntu 24.04.

## Summary

A client of busd that stops reading its socket stops the other clients too, and in the end the
whole bus, from the moment busd has a message for it that its socket cannot take, until the client
reads again or goes:

* With a client subscribed to the bus's own signals frozen (`gdbus monitor`, stopped with
  SIGSTOP), the bus stopped answering after 66 new clients had come and gone, each of them making
  the bus signal NameOwnerChanged as it came and as it went. Calls to the bus from new clients got
  no reply from then on, and neither did calls between two clients connected since before the
  freeze. Once the frozen client was let go, the bus answered again. dbus-daemon and dbus-broker
  answered all 1500 calls of the same test, and every call between the two clients.
* The phase of the `some-changes` branch where 100 clients share one connection, which serves the
  object that they all call, hung in the same way, against busd 0.5.0 (3 runs out of 3) and busd's
  main branch (1 run), with the client on zbus 4.3. That zbus stops reading its socket while it
  cannot write to it. On zbus 6, the client keeps reading, and the phase completed against busd's
  main branch in all 7 runs, with 20 clients and with 100.

The frozen client stands in for any client that reads nothing for a while: one stopped in a
debugger, or one whose process is blocked. From how busd forwards messages, one that only reads
more slowly than messages come in for it holds up those who send to it in the same way, for as
long as it lags, which these runs do not measure.

## How busd stalls

In busd at a982812:

1. Each connection has a task of its own,
   [`serve_peer`](https://github.com/z-galaxy/busd/blob/a982812/src/peers.rs#L189), that reads a
   message from it and forwards that message before it reads the next one:
   `self.send_msg(...).await` (peers.rs:220), which ends in `conn.send(&msg).await` (peers.rs:284).
   zbus 6's `Connection::send` returns once the kernel has taken the whole message, with no queue
   in between (zbus 6.0.0, src/connection/mod.rs:262 and src/connection/socket/mod.rs:381). So
   while a destination does not read, busd reads nothing more from those who send to it. Once
   zbus's socket reader has queued 64 messages from such a sender (`DEFAULT_MAX_QUEUED`,
   src/connection/mod.rs:52), it waits for room (src/connection/socket_reader.rs:97), and the
   sender's socket fills up in turn.
2. [`broadcast_msg`](https://github.com/z-galaxy/busd/blob/a982812/src/peers.rs#L293) holds the
   read locks of the name registry and of the peers (peers.rs:295-296) across its send
   to each peer that is interested in the signal. Once one of those sends waits, a new client waits
   for the write lock of the peers (`self.peers_mut().await`, peers.rs:59). zruntime's `RwLock`
   prefers writers: while a writer waits, new readers wait too (zruntime 0.2.0,
   src/lock/rwlock.rs:33). One of those readers is the lookup of every message's destination
   (peers.rs:277-282), so no message gets forwarded anymore, between any two clients.
3. The bus's own replies and signals all go out through the `serve_peer` task of the bus's own
   connection, so a signal that waits for one client holds up the replies to all the others,
   to `Hello` among them.
4. Nothing limits any of this: there is no queue for a destination to fill, and busd ignores the
   `<limit>` elements of its configuration (src/config/mod.rs:104-106). dbus-daemon and dbus-broker
   queue the messages for a client that does not read, within limits of their own, and go on
   reading from the others meanwhile.

The trace of busd (`RUST_LOG=busd=trace`) fits: the frozen client was a peer with match rules,
not a monitor, and the last thing that busd logged was a NameOwnerChanged broadcast that never
finished, after which new clients got no further than the point where `add` takes the write lock.

Doing what dbus-daemon and dbus-broker do would mean a queue per destination, which a task of its
own writes to the socket, so that the task that reads from a connection never waits on another
one's socket, with a limit on how much a queue may hold, and a rule for a client that goes over it.
Nor should a task wait on a socket while it holds a lock.

## The shared connection, on zbus 4.3 and on zbus 6

In the phase of the `some-changes` branch where 100 clients share one connection, that connection
both serves the object and makes the calls, so busd forwards every call and every reply back into
the connection that sent it. With the client on zbus 4.3, the client and busd stopped for good,
each with data of the other unread: about 215 KB on busd's side and 149 KB on the client's, against
busd 0.5.0. Neither used any CPU time from then on.

zbus 4.3 hands every method reply over through one broadcast channel of 8 messages
(`DEFAULT_MAX_METHOD_RETURN_QUEUED`, zbus 4.3.0, src/connection/mod.rs:46), which each call
subscribes to before it sends its message (src/connection/mod.rs:369-377). A call that waits to send
does not read the channel, so after 8 more replies the socket reader waits for room, and reads
nothing more from the socket. busd then waits for the client to read, and stops reading from it in
turn, as above. zbus 5.17.0 routes each reply to its call by serial instead, into a channel of its
own that the socket reader never waits on (zbus 6.0.0, src/connection/socket_reader.rs:72 and
src/connection/pending_method_calls.rs:25, 162; "Route method replies directly by serial" in its
changelog). So on zbus 6 the client keeps reading while it cannot write, and busd's sends to it go
through. The phase then took 3.3 to 3.7 s with 100 clients and 0.68 to 0.72 s with 20, against
busd's main branch, and 3.7 s with 100 clients against dbus-broker.

## Reproducing

[frozen-subscriber.sh](2026-10-20-busd-stalled-reader-xeon-4vcpu/frozen-subscriber.sh) runs the
test with the frozen client against one of the brokers. The calls between two clients connected all
along are those of [the pinger](2026-10-20-busd-stalled-reader-xeon-4vcpu/pinger), which calls a
service of its own on a second connection every 500 ms:

```sh
cd results/2026-10-20-busd-stalled-reader-xeon-4vcpu
(cd pinger && cargo build --release)
BUSD=/path/to/busd ./frozen-subscriber.sh busd
./frozen-subscriber.sh dbus-daemon
./frozen-subscriber.sh dbus-broker
```

On the VM:

```
busd: before the freeze, a call to the bus gets its reply
busd: 66 calls to the bus from new clients got their reply, then 2 did not
busd: in the next 4 s, 0 calls between long-lived clients got their reply, 2 did not
busd: once the frozen client is let go, a call to the bus gets its reply
dbus-daemon: before the freeze, a call to the bus gets its reply
dbus-daemon: 1500 calls to the bus from new clients got their reply, then 0 did not
dbus-daemon: in the next 4 s, 8 calls between long-lived clients got their reply, 0 did not
dbus-daemon: once the frozen client is let go, a call to the bus gets its reply
dbus-broker: before the freeze, a call to the bus gets its reply
dbus-broker: 1500 calls to the bus from new clients got their reply, then 0 did not
dbus-broker: in the next 4 s, 8 calls between long-lived clients got their reply, 0 did not
dbus-broker: once the frozen client is let go, a call to the bus gets its reply
```

How many new clients it takes before busd stops depends on how much the sockets take.
