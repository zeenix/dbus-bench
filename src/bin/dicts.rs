//! Method calls with dicts of variants for a body, through a D-Bus broker.
//!
//! It connects to the bus named by `$DBUS_SESSION_BUS_ADDRESS` and times method calls through it,
//! in two phases, printing the timing of each:
//!
//! 1. A service, at a well-known name of its own, and a client that calls it through that name
//!    `CALLS` times, one call after the other, with the same dicts for the body of each, so that
//!    each call and its reply go through the broker.
//! 2. `PAIRS` such services and clients at once.
//!
//! The body is a dict of dicts of variants, `a{sa{sv}}`: `INTERFACES` interfaces, each with
//! `PROPERTIES` properties, which is how `GetManagedObjects` and `InterfacesAdded` carry the
//! properties of each object. A broker checks the body of each message against its signature, which
//! costs far more for a dict of variants, as each variant has a signature of its own to check
//! before its value can be, than for a byte array, which takes no more than its length. This
//! workload measures that: `dbus-bench` makes the same calls with a byte array. The service replies
//! without reading the body, so that the timings are the broker's as far as they can be.
//!
//! Each service and each client runs on a thread of its own, with a connection and a
//! single-threaded runtime of its own, as a process of its own would, so that neither holds the
//! other up: a client sends its next call as soon as the reply to the last one comes, and a
//! service replies as soon as a call comes. What a phase times is from just before its first
//! service connects until its last service is gone, connecting included.
//!
//! The calls and the replies are built by hand and have no sender, for the bus to set: `src/lib.rs`
//! says why.

use std::{collections::BTreeMap, sync::mpsc, thread, time::Instant};

use dbus_bench::{Caller, Result, DICTS_METHOD};
use zbus::{DynamicType, MessageStream, Variant};
use zruntime::mpmc;

/// How many calls each client makes.
const CALLS: usize = 1000;

/// How many services and clients the second phase runs at once.
const PAIRS: usize = 20;

/// How many interfaces the dicts of each call have.
const INTERFACES: u32 = 10;

/// How many properties each interface of the dicts has, each of which is a variant.
const PROPERTIES: u32 = 10;

fn main() -> Result<()> {
    let dicts = dicts();
    // The signature follows from the types of the dicts. Checking it here, once, keeps a change of
    // them from having the broker check bodies of another signature than this workload is about.
    assert_eq!(dicts.signature().to_string(), "a{sa{sv}}");

    let before = Instant::now();
    hammer(
        &["org.dbus2.benchmark.dicts.SingleClient".to_string()],
        &dicts,
    )?;
    let elapsed = before.elapsed();
    println!("Hammering using a single client took {elapsed:?}");

    let names: Vec<_> = (0..PAIRS)
        .map(|i| format!("org.dbus2.benchmark.dicts.MultiClient{i}"))
        .collect();
    let before = Instant::now();
    hammer(&names, &dicts)?;
    let elapsed = before.elapsed();
    println!("Hammering using {PAIRS} simultaneous clients took {elapsed:?}");

    Ok(())
}

/// Runs a service at each of `names`, and a client that calls it `CALLS` times with `dicts` as the
/// body, and returns once all the clients are done and all the services are gone.
///
/// The clients start once all the services own their names, and the services stop once the
/// clients are done, or one of them failed.
fn hammer(names: &[String], dicts: &Dicts) -> Result<()> {
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
            .map(|name| scope.spawn(move || call(name, dicts)))
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
/// owns `name`, says on `ready` whether it could, and goes on replying to the calls of its methods
/// until `stopped` is closed.
fn serve(name: &str, ready: mpsc::Sender<Result<()>>, stopped: mpmc::Receiver<()>) -> Result<()> {
    zbus::block_on(async {
        // The name is the service's by the time that `build` returns, as it waits for the bus to
        // reply to `RequestName`.
        let connection = zbus::connection::Builder::session()
            .name(name)
            .build()
            .await;
        let connection = match connection {
            Ok(connection) => connection,
            Err(e) => {
                // The thread that waits for the services gives up on the first that fails, with
                // its error.
                let _ = ready.send(Err(e.into()));

                return Err("the service could not connect".into());
            }
        };
        // The stream exists before the service is ready, and so before the first call is sent.
        let calls = MessageStream::from(&connection);
        let _ = ready.send(Ok(()));

        dbus_bench::serve(&connection, calls, stopped).await
    })
}

/// A client, on a thread of its own, with a connection and a single-threaded runtime of its own:
/// calls the service at `name` `CALLS` times, one call after the other, with `dicts` as the body.
fn call(name: &str, dicts: &Dicts) -> Result<()> {
    zbus::block_on(async {
        let connection = zbus::Connection::session().await?;
        let mut caller = Caller::new(connection, name)?;
        for _ in 0..CALLS {
            caller.call_with(DICTS_METHOD, dicts).await?;
        }

        Ok(())
    })
}

/// The body of each call: the properties of an object, by the name of their interface.
type Dicts = BTreeMap<String, BTreeMap<String, Variant<'static>>>;

/// Makes the dicts of `INTERFACES` interfaces of `PROPERTIES` properties each, ordered by name, so
/// that every run sends the same bytes.
fn dicts() -> Dicts {
    (0..INTERFACES)
        .map(|i| {
            let properties = (0..PROPERTIES)
                .map(|j| (format!("Property{j}"), property(i, j)))
                .collect();

            (format!("org.dbus2.benchmark.Interface{i}"), properties)
        })
        .collect()
}

/// The value of property `j` of interface `i`, which cycles through four types, as the properties
/// of real objects mix them: a number, a string, a boolean and an array of strings.
fn property(i: u32, j: u32) -> Variant<'static> {
    match j % 4 {
        0 => (i * PROPERTIES + j).into(),
        1 => format!("value {i}.{j}").into(),
        2 => (i < INTERFACES / 2).into(),
        _ => (0..3)
            .map(|k| format!("item {i}.{j}.{k}"))
            .collect::<Vec<_>>()
            .into(),
    }
}
