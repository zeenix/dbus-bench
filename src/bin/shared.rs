//! The multi-client phases of dbus-bench's `some-changes` branch, on zbus 6, in the output format
//! of dbus-bench's client, so that scripts/compare-brokers.py can drive it: first one client
//! connection that `$DBUS_BENCH_CLIENTS` (100 by default) proxies share, each making 1000 calls,
//! with a 16 KiB byte array, through the bus, to the object that one service serves ("a single
//! client"), then as many client connections, each calling the object of a service of its own 1000
//! times ("simultaneous clients").
//!
//! Where the branch had each connection serve the object and call it too, each service and each
//! client has a connection of its own here, on a thread with a single-threaded runtime of its own,
//! as a process of its own would, so that neither holds the other up. A service has no well-known
//! name: its clients call it at its unique name, as the branch's connections called themselves.
//! Each of them has five files open, its socket and those of its runtime, so the second phase
//! needs room for ten for each client within the limit on open files (`ulimit -n`), which is often
//! 1024.

use std::{
    sync::mpsc,
    thread,
    time::{Duration, Instant},
};

use futures_util::future::try_join_all;
use serde::{Deserialize, Serialize};
use serde_bytes::Bytes;
use zbus::{names::OwnedUniqueName, Connection};
use zruntime::mpmc;

/// How many calls each proxy makes.
const CALLS: usize = 1000;

/// The path that each service serves the object at.
const PATH: &str = "/org/dbus2/benchmark";

/// Anything that goes wrong ends the run, so the errors need no more than their message. They are
/// `Send`, so that the thread of a service or a client can hand its error over.
type Result<T> = std::result::Result<T, Box<dyn std::error::Error + Send + Sync>>;

#[derive(Debug)]
struct Service;

#[zbus::interface(
    name = "org.dbus2.benchmark",
    proxy(default_path = "/org/dbus2/benchmark")
)]
impl Service {
    fn take_byte_array(&self, _bytes: ByteArray<'_>) {}
}

#[derive(Deserialize, Serialize, zbus::wire::Type)]
struct ByteArray<'a>(#[serde(borrow)] &'a Bytes);

fn main() -> Result<()> {
    let clients: usize = std::env::var("DBUS_BENCH_CLIENTS")
        .ok()
        .and_then(|n| n.parse().ok())
        .unwrap_or(100);
    let data = vec![0u8; 16 * 1024];

    // A single client connection, shared by `clients` proxies, which all call one service.
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

/// Runs a service, and on this thread, a client connection that `proxies` proxies share, each
/// calling the service `CALLS` times with `data` as the byte array.
///
/// Returns how long the calls took, from just before the proxies are made, once the service and
/// the client are connected, until the last of them is done.
fn shared(proxies: usize, data: &[u8]) -> Result<Duration> {
    thread::scope(|scope| {
        // Nothing is sent on this channel: dropping the sender, whichever way the scope is left,
        // closes it, which is what stops the service.
        let (stop, stopped) = mpmc::unbounded::<()>();
        let (ready, readiness) = mpsc::channel();
        let service = scope.spawn(move || serve(ready, stopped));
        let name = readiness
            .recv()
            .map_err(|_| "the service ended before it was ready")??;

        let elapsed = zbus::block_on(share(&name, proxies, data))?;
        drop(stop);
        service.join().map_err(|_| "the service panicked")??;

        Ok(elapsed)
    })
}

/// Connects a client, and has `proxies` proxies on its connection call the service at `name` at
/// once, `CALLS` times each, with `data` as the byte array.
///
/// Returns how long the calls took, from just before the proxies are made until the last of them
/// is done.
async fn share(name: &OwnedUniqueName, proxies: usize, data: &[u8]) -> Result<Duration> {
    let connection = Connection::session().await?;
    let before = Instant::now();
    try_join_all((0..proxies).map(|_| hammer(&connection, name, data))).await?;

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
/// serves the object, says on `ready` at which unique name, or why it could not, and goes on
/// serving it until `stopped` is closed.
fn serve(ready: mpsc::Sender<Result<OwnedUniqueName>>, stopped: mpmc::Receiver<()>) -> Result<()> {
    zbus::block_on(async {
        let connection = zbus::connection::Builder::session()
            .serve_at(PATH, Service)
            .build()
            .await;
        // The connection serves the object for as long as it is kept.
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
        let _ = ready.send(Ok(name));
        // As nothing is sent on the channel, this returns only once it is closed.
        let _ = stopped.recv().await;

        Ok(())
    })
}

/// A client, on a thread of its own, with a connection and a single-threaded runtime of its own:
/// calls the service at `name` `CALLS` times with `data` as the byte array.
fn call(name: &OwnedUniqueName, data: &[u8]) -> Result<()> {
    zbus::block_on(async {
        let connection = Connection::session().await?;

        hammer(&connection, name, data).await
    })
}

/// Makes `CALLS` calls, through the bus, from `connection` to the object of the service at `name`,
/// with `data` as the byte array.
async fn hammer(connection: &Connection, name: &OwnedUniqueName, data: &[u8]) -> Result<()> {
    let proxy = ServiceProxy::new(connection, name.clone()).await?;
    for _ in 0..CALLS {
        proxy.take_byte_array(ByteArray(Bytes::new(data))).await?;
    }

    Ok(())
}
