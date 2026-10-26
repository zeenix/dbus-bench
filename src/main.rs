//! Method calls through a D-Bus broker.
//!
//! It connects to the bus named by `$DBUS_SESSION_BUS_ADDRESS` and times method calls through it,
//! in two phases, printing the timing of each:
//!
//! 1. A service, at a well-known name of its own, and a client that calls it through that name
//!    `CALLS` times, one call after the other, with `PAYLOAD_LEN` bytes of payload, so that each
//!    call and its reply go through the broker.
//! 2. `PAIRS` such services and clients at once.
//!
//! Each service and each client runs on a thread of its own, with a connection and a
//! single-threaded runtime of its own, as a process of its own would, so that neither holds the
//! other up: a client sends its next call as soon as the reply to the last one comes, and a
//! service replies as soon as a call comes. What a phase times is from just before its first
//! service connects until its last service is gone, connecting included.

use std::{sync::mpsc, thread, time::Instant};

use serde::{Deserialize, Serialize};
use serde_bytes::Bytes;
use zruntime::mpmc;

/// How many calls each client makes.
const CALLS: usize = 1000;

/// How many services and clients the second phase runs at once.
const PAIRS: usize = 20;

/// How many bytes of payload each call carries.
const PAYLOAD_LEN: usize = 16 * 1024;

/// The path that each service serves its interface at.
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

/// The byte array of a call, borrowed from the message that carries it.
///
/// An argument of type `&T`, other than `&str`, is deserialized into a `T` that the method then
/// borrows, which would copy the array out of the message. A type that holds the reference itself
/// is deserialized as it is, and as a struct with a single field, it has the D-Bus type of that
/// field: an array of bytes.
#[derive(Deserialize, Serialize, zbus::wire::Type)]
struct ByteArray<'a>(#[serde(borrow)] &'a Bytes);

fn main() -> Result<()> {
    let data = vec![0u8; PAYLOAD_LEN];

    let before = Instant::now();
    hammer(&["org.dbus2.benchmark.SingleClient".to_string()], &data)?;
    let elapsed = before.elapsed();
    println!("Hammering using a single client took {elapsed:?}");

    let names: Vec<_> = (0..PAIRS)
        .map(|i| format!("org.dbus2.benchmark.MultiClient{i}"))
        .collect();
    let before = Instant::now();
    hammer(&names, &data)?;
    let elapsed = before.elapsed();
    println!("Hammering using {PAIRS} simultaneous clients took {elapsed:?}");

    Ok(())
}

/// Runs a service at each of `names`, and a client that calls it `CALLS` times with `data` as the
/// byte array, and returns once all the clients are done and all the services are gone.
///
/// The clients start once all the services own their names, and the services stop once the
/// clients are done, or one of them failed.
fn hammer(names: &[String], data: &[u8]) -> Result<()> {
    thread::scope(|scope| {
        // Nothing is sent on this channel: dropping the sender, whichever way the scope is left,
        // closes it, which is what stops the services.
        let (stop, stopped) = mpmc::unbounded::<()>();
        let (ready, readiness) = mpsc::channel();
        let services: Vec<_> = names
            .iter()
            .map(|name| {
                let ready = ready.clone();
                let stopped = stopped.clone();
                scope.spawn(move || serve(name, ready, stopped))
            })
            .collect();
        drop(ready);
        for _ in 0..services.len() {
            readiness
                .recv()
                .map_err(|_| "a service ended before it was ready")??;
        }

        let clients: Vec<_> = names
            .iter()
            .map(|name| scope.spawn(move || call(name, data)))
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
/// serves its interface at `name`, says on `ready` whether it could, and goes on serving it until
/// `stopped` is closed.
fn serve(name: &str, ready: mpsc::Sender<Result<()>>, stopped: mpmc::Receiver<()>) -> Result<()> {
    zbus::block_on(async {
        // The name is the service's by the time that `build` returns, as it waits for the bus to
        // reply to `RequestName`.
        let connection = zbus::connection::Builder::session()
            .serve_at(PATH, Service)
            .name(name)
            .build()
            .await;
        // The connection serves the interface for as long as it is kept.
        let _connection = match connection {
            Ok(connection) => connection,
            Err(e) => {
                // The thread that waits for the services gives up on the first that fails, with
                // its error.
                let _ = ready.send(Err(e.into()));

                return Err("the service could not connect".into());
            }
        };
        let _ = ready.send(Ok(()));
        // As nothing is sent on the channel, this returns only once it is closed.
        let _ = stopped.recv().await;

        Ok(())
    })
}

/// A client, on a thread of its own, with a connection and a single-threaded runtime of its own:
/// calls the service at `name` `CALLS` times, one call after the other, with `data` as the byte
/// array.
fn call(name: &str, data: &[u8]) -> Result<()> {
    zbus::block_on(async {
        let connection = zbus::Connection::session().await?;
        let proxy = ServiceProxy::new(&connection, name).await?;
        for _ in 0..CALLS {
            proxy.take_byte_array(ByteArray(Bytes::new(data))).await?;
        }

        Ok(())
    })
}
