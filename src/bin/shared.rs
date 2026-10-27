//! The multi-client phases of dbus-bench's `some-changes` branch, on zbus 6, in the output format
//! of dbus-bench's client, so that scripts/compare-brokers.py can drive it: first one client
//! connection that `$DBUS_BENCH_CLIENTS` (100 by default) callers share, each making 1000 calls,
//! with a 16 KiB byte array, through the bus, to the method that one service serves ("a single
//! client"), then as many client connections, each calling the method of a service of its own 1000
//! times ("simultaneous clients").
//!
//! Where the branch had each connection serve the object and call it too, each service and each
//! client has a connection of its own here, on a thread with a single-threaded runtime of its own,
//! as a process of its own would, so that neither holds the other up. A service has no well-known
//! name: its clients call it at its unique name, as the branch's connections called themselves.
//! Each of them has five files open, its socket and those of its runtime, so the second phase
//! needs room for ten for each client within the limit on open files (`ulimit -n`), which is often
//! 1024.
//!
//! The replies to the calls of the callers that share a connection all come back on it. A task on
//! the runtime of the thread reads them off a stream of the connection, and hands each to the
//! caller whose call it answers, as told by the serial number of the call. The calls and the
//! replies have no sender, for the bus to set, as `src/lib.rs` says.

use std::{
    collections::HashMap,
    num::{NonZeroU32, NonZeroUsize},
    sync::{mpsc, Arc, Mutex},
    thread,
    time::{Duration, Instant},
};

use dbus_bench::{Caller, Result};
use futures_util::{future::try_join_all, TryStreamExt};
use zbus::{
    names::{BusName, OwnedUniqueName},
    Connection, Message, MessageStream,
};
use zruntime::{mpmc, Shared, Task};

/// How many calls each caller makes.
const CALLS: usize = 1000;

/// How many replies more than there are callers the queue of the shared connection's stream has
/// room for.
///
/// zbus holds back the reader of a connection's socket whenever the queue of one of its streams is
/// full. A queue for the reply of every caller, and this many to spare, rules that out, so that
/// the replies are read off the socket as fast as the broker writes them, whether or not the task
/// that hands them to the callers has had its turn.
const QUEUE_SPARE: usize = 16;

/// The callers that wait for a reply, by the serial number of their call, each with the sender on
/// which the reply is handed to it.
///
/// The task that hands out the replies has to be `Send`, as `zruntime::spawn` requires. It runs on
/// the thread of the callers all the same, so the lock is never contended.
type Pending = Arc<Mutex<HashMap<NonZeroU32, mpmc::Sender<Message>>>>;

/// What is expected of the lock of a `Pending`: it is held only to insert, remove or clear an
/// entry, which cannot panic, so it is never poisoned.
const UNPOISONED: &str = "nothing panics while it holds the lock";

fn main() -> Result<()> {
    let clients: usize = std::env::var("DBUS_BENCH_CLIENTS")
        .ok()
        .and_then(|n| n.parse().ok())
        .unwrap_or(100);
    let data = vec![0u8; 16 * 1024];

    // A single client connection, shared by `clients` callers, which all call one service.
    let elapsed = shared(clients, &data)?;
    println!("Hammering using a single client took {elapsed:?}");

    // `clients` client connections, each calling a service of its own.
    let before = Instant::now();
    pairs(clients, &data)?;
    println!(
        "Hammering using {clients} simultaneous clients took {:?}",
        before.elapsed()
    );

    Ok(())
}

/// Runs a service, and on this thread, a client connection that `callers` callers share, each
/// calling the service `CALLS` times with `data` as the byte array.
///
/// Returns how long the calls took, from just before the callers start, once the service and the
/// client are connected, until the last of them is done.
fn shared(callers: usize, data: &[u8]) -> Result<Duration> {
    thread::scope(|scope| {
        // Nothing is sent on this channel: dropping the sender, whichever way the scope is left,
        // closes it, which is what stops the service.
        let (stop, stopped) = mpmc::unbounded::<()>();
        let (ready, readiness) = mpsc::channel();
        let service = scope.spawn(move || serve(ready, stopped));
        let name = readiness
            .recv()
            .map_err(|_| "the service ended before it was ready")??;

        let elapsed = zbus::block_on(share(&name, callers, data))?;
        drop(stop);
        service.join().map_err(|_| "the service panicked")??;

        Ok(elapsed)
    })
}

/// Connects a client, and has `callers` callers on its connection call the service at `name` at
/// once, `CALLS` times each, with `data` as the byte array.
///
/// Returns how long the calls took, from just before the callers start until the last of them is
/// done.
async fn share(name: &OwnedUniqueName, callers: usize, data: &[u8]) -> Result<Duration> {
    let connection = Connection::session().await?;
    let shared = SharedConnection::new(connection, name, callers);
    let before = Instant::now();
    try_join_all((0..callers).map(|_| hammer(&shared, data))).await?;

    Ok(before.elapsed())
}

/// Runs `pairs` services, and a client for each, which calls it `CALLS` times with `data` as the
/// byte array, and returns once all the clients are done and all the services are gone.
///
/// The clients start once all the services are connected, and the services stop once the clients
/// are done, or one of them failed.
fn pairs(pairs: usize, data: &[u8]) -> Result<()> {
    thread::scope(|scope| {
        // Nothing is sent on this channel: dropping the sender, whichever way the scope is left,
        // closes it, which is what stops the services.
        let (stop, stopped) = mpmc::unbounded::<()>();
        let (ready, readiness) = mpsc::channel();
        let services: Vec<_> = (0..pairs)
            .map(|_| {
                let ready = ready.clone();
                let stopped = stopped.clone();
                scope.spawn(move || serve(ready, stopped))
            })
            .collect();
        drop(ready);
        let mut names = Vec::with_capacity(services.len());
        for _ in 0..services.len() {
            let name = readiness
                .recv()
                .map_err(|_| "a service ended before it was ready")??;
            names.push(name);
        }

        let clients: Vec<_> = names
            .into_iter()
            .map(|name| scope.spawn(move || call(&name, data)))
            .collect();
        for client in clients {
            client.join().map_err(|_| "a client panicked")??;
        }
        drop(stop);
        for service in services {
            service.join().map_err(|_| "a service panicked")??;
        }

        Ok(())
    })
}

/// A service, on a thread of its own, with a connection and a single-threaded runtime of its own:
/// replies to the calls of its method, says on `ready` at which unique name, or why it could not,
/// and goes on replying to them until `stopped` is closed.
fn serve(ready: mpsc::Sender<Result<OwnedUniqueName>>, stopped: mpmc::Receiver<()>) -> Result<()> {
    zbus::block_on(async {
        let connection = zbus::connection::Builder::session().build().await;
        let connection = match connection {
            Ok(connection) => connection,
            Err(e) => {
                // The thread that waits for the services gives up on the first that fails, with
                // its error.
                let _ = ready.send(Err(e.into()));

                return Err("the service could not connect".into());
            }
        };
        let name = connection
            .unique_name()
            .expect("a connection to a bus has a unique name")
            .clone();
        // The stream exists before the service is ready, and so before the first call is sent.
        let calls = MessageStream::from(&connection);
        let _ = ready.send(Ok(name));

        dbus_bench::serve(&connection, calls, stopped).await
    })
}

/// A client, on a thread of its own, with a connection and a single-threaded runtime of its own:
/// calls the service at `name` `CALLS` times with `data` as the byte array.
fn call(name: &OwnedUniqueName, data: &[u8]) -> Result<()> {
    zbus::block_on(async {
        let connection = Connection::session().await?;
        let mut caller = Caller::new(connection, name)?;
        for _ in 0..CALLS {
            caller.call(data).await?;
        }

        Ok(())
    })
}

/// Makes `CALLS` calls, through the bus, on the shared connection to the service that it calls,
/// with `data` as the byte array.
async fn hammer(shared: &SharedConnection, data: &[u8]) -> Result<()> {
    for _ in 0..CALLS {
        shared.call(data).await?;
    }

    Ok(())
}

/// A client connection that many callers share, and what hands the replies that come back on it
/// to the callers.
struct SharedConnection {
    /// The connection that the calls are sent on.
    connection: Connection,
    /// The service that is called.
    destination: BusName<'static>,
    /// The callers that wait for a reply.
    pending: Pending,
    /// The task that hands the replies to the callers, which ends once this is dropped.
    _dispatcher: Task<(), Shared>,
}

impl SharedConnection {
    /// Makes a connection of `callers` callers of the service at `name` out of `connection`.
    fn new(connection: Connection, name: &OwnedUniqueName, callers: usize) -> Self {
        // The stream exists before the first call is sent, as a reply that arrives before it does
        // is not delivered to it.
        let mut replies = MessageStream::from(&connection);
        let queue = NonZeroUsize::new(callers + QUEUE_SPARE).expect("room for the spare replies");
        replies.set_max_queued(queue);
        let pending = Pending::default();
        let dispatcher = zruntime::spawn(dispatch(replies, pending.clone()));

        Self {
            connection,
            destination: BusName::from(name).into_owned(),
            pending,
            _dispatcher: dispatcher,
        }
    }

    /// Calls the service with `data` as the byte array, and waits for the reply.
    ///
    /// Fails if the service replies with an error, or the connection closes first.
    async fn call(&self, data: &[u8]) -> Result<()> {
        let msg = dbus_bench::call_message(&self.destination, data)?;
        let (reply_to, reply) = mpmc::bounded(NonZeroUsize::MIN);
        // The caller is entered before the call is sent, and not after: the reply could be handed
        // out as soon as the call is on its way, and be lost for want of a caller to hand it to.
        let serial = msg.primary_header().serial_num();
        self.pending
            .lock()
            .expect(UNPOISONED)
            .insert(serial, reply_to);
        self.connection.send(&msg).await?;

        let reply = reply
            .recv()
            .await
            .map_err(|_| "the connection closed before the reply came")?;

        dbus_bench::check_reply(&reply)
    }
}

/// Hands each reply that `replies` yields to the caller in `pending` that waits for it, until the
/// stream ends or fails.
///
/// Then the callers that still wait are failed, by dropping what they wait on.
async fn dispatch(mut replies: MessageStream, pending: Pending) {
    while let Ok(Some(msg)) = replies.try_next().await {
        let Some(serial) = dbus_bench::replied_to(&msg) else {
            continue;
        };
        let Some(reply_to) = pending.lock().expect(UNPOISONED).remove(&serial) else {
            continue;
        };
        // The channel has room for the one reply that its caller waits for, and a caller that
        // gave up has nothing to hand it to.
        let _ = reply_to.try_send(msg);
    }
    pending.lock().expect(UNPOISONED).clear();
}
