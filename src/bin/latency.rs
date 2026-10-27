//! Latency distributions of a D-Bus broker.
//!
//! Where `main.rs` and `fanout.rs` time whole phases, this times every message of three scenarios
//! like theirs, and prints the distributions of those times as one JSON object on the standard
//! output, and nothing else there:
//!
//! - `single_rtt`: the round trips of `SINGLE_CALLS` calls, one after the other, from a client to
//!   a service through the bus, as in `main.rs`, with a small payload.
//! - `multi_rtt`: the round trips of `MULTI_CALLS` calls from each of `MULTI_CLIENTS` such
//!   clients at once, each to a service of its own, with the payload of `main.rs`.
//! - `fanout_delivery`: how long each of `FANOUT_SIGNALS` signals, which one connection
//!   broadcasts back to back, takes to reach each of `FANOUT_SUBSCRIBERS` subscribers, as in
//!   `fanout.rs`: from just before the emitter builds it until the subscriber has taken it off
//!   its stream. The signals queue up behind each other in the broker, so the later ones wait
//!   longer. Those that a broker keeps the emitter from sending, by taking its signals off its
//!   socket slowly, wait before they are timed, though: how long the scenario takes is what tells
//!   how fast a broker gets the signals through.
//!
//! Each distribution has the number of samples, the seconds that the scenario took, and the mean,
//! the median (`p50`), the `p90`, the `p99`, the `p999` and the largest of the samples, in
//! microseconds. A percentile is the nearest-rank one: the sample at the rank that the fraction
//! of the samples ends at, rounded up, counting from the smallest.
//!
//! Each service and each client of the round trips, and each subscriber of `fanout_delivery`, runs
//! on a thread of its own, with a connection and a single-threaded runtime of its own, as a
//! process of its own would, like those of `main.rs` and `fanout.rs`: it takes each message off its
//! socket as soon as the broker has written it there, rather than when one thread for all of them
//! gets round to it, so that how long the messages wait is the broker's doing. The emitter has the
//! main thread to itself. The scenarios fail on a failed call, and on a signal that is lost or
//! arrives out of order, and the process exits without printing the object.

use std::{
    num::NonZeroUsize,
    sync::mpsc,
    thread,
    time::{Duration, Instant},
};

use futures_util::TryStreamExt;
use serde::{Deserialize, Serialize};
use serde_bytes::Bytes;
use zbus::{message::Type, Connection, MatchRule, MessageStream};
use zruntime::{lock::Barrier, mpmc};

/// How many calls `single_rtt` makes.
const SINGLE_CALLS: usize = 5_000;

/// How many bytes of payload the calls of `single_rtt` carry: a small one, so that the round
/// trip is that of the broker and not of copying the payload.
const SINGLE_PAYLOAD_LEN: usize = 64;

/// How many services `multi_rtt` calls at once, as many as `main.rs`.
const MULTI_CLIENTS: usize = 20;

/// How many calls `multi_rtt` makes on each service.
const MULTI_CALLS: usize = 1_000;

/// How many bytes of payload the calls of `multi_rtt` carry, as many as in `main.rs`.
const MULTI_PAYLOAD_LEN: usize = 16 * 1024;

/// How many signals `fanout_delivery` sends.
const FANOUT_SIGNALS: usize = 2_000;

/// How many subscribers receive the signals of `fanout_delivery`.
const FANOUT_SUBSCRIBERS: usize = 20;

/// How many bytes of payload the signals of `fanout_delivery` carry, as many as in `fanout.rs`.
const FANOUT_PAYLOAD_LEN: usize = 1024;

/// How many signals more than `FANOUT_SIGNALS` the queue of a subscriber's stream has room for.
///
/// zbus holds back the reader of a connection's socket whenever the stream of one of its match
/// rules is full. A queue for every signal, and this many to spare, rules that out, so that a
/// subscriber reads its socket as fast as the broker fills it.
const QUEUE_SPARE: usize = 16;

/// How long a scenario gets, connecting included, before the process gives up on it.
const SCENARIO_TIMEOUT: Duration = Duration::from_secs(120);

/// The exit status of a process that gave up on a scenario, as opposed to one that failed.
const TIMEOUT_EXIT_STATUS: i32 = 2;

/// The path that the service is at, and that the signals are emitted from.
const PATH: &str = "/org/dbus2/benchmark";

/// The interface of the signals of `fanout_delivery`.
const INTERFACE: &str = "org.dbus2.benchmark.Fanout";

/// The member of the signals of `fanout_delivery`.
const MEMBER: &str = "Delivery";

/// Anything that goes wrong ends the run, so the errors need no more than their message. They are
/// `Send`, so that the thread of a subscriber can hand its error over.
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
    let single_rtt = single_rtt()?;
    let multi_rtt = multi_rtt()?;
    let fanout_delivery = zbus::block_on(fanout_delivery())?;

    println!(
        "{{\"single_rtt\": {}, \"multi_rtt\": {}, \"fanout_delivery\": {}}}",
        single_rtt.to_json(),
        multi_rtt.to_json(),
        fanout_delivery.to_json(),
    );

    Ok(())
}

/// The scenario `single_rtt`: calls from one client to its service, one after the other.
fn single_rtt() -> Result<Stats> {
    let _watchdog = Watchdog::start("single_rtt");
    let data = vec![0u8; SINGLE_PAYLOAD_LEN];

    round_trips(
        &["org.dbus2.benchmark.SingleClient".to_string()],
        &data,
        SINGLE_CALLS,
    )
}

/// The scenario `multi_rtt`: calls from many clients, each to a service of its own, at the same
/// time.
fn multi_rtt() -> Result<Stats> {
    let _watchdog = Watchdog::start("multi_rtt");
    let data = vec![0u8; MULTI_PAYLOAD_LEN];
    let names: Vec<_> = (0..MULTI_CLIENTS)
        .map(|i| format!("org.dbus2.benchmark.MultiClient{i}"))
        .collect();

    round_trips(&names, &data, MULTI_CALLS)
}

/// Runs a service at each of `names`, and a client that calls it `calls` times, one call after the
/// other, with `data` as the byte array, and times the calls.
///
/// The clients start calling together, once all of them have connected and all the services own
/// their names, and the services stop once the clients are done, or one of them failed. How long
/// the scenario took is from when the first client started calling until the last reply came.
fn round_trips(names: &[String], data: &[u8], calls: usize) -> Result<Stats> {
    let start = Barrier::new(names.len());

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

        let start = &start;
        let clients: Vec<_> = names
            .iter()
            .map(|name| scope.spawn(move || client(name, data, calls, start)))
            .collect();
        let mut done = Vec::with_capacity(clients.len());
        for client in clients {
            done.push(client.join().map_err(|_| "a client panicked")??);
        }
        drop(stop);
        for service in services {
            service.join().map_err(|_| "a service panicked")??;
        }

        let started = done.iter().map(|calls| calls.started).min();
        let finished = done.iter().map(|calls| calls.finished).max();
        let (Some(started), Some(finished)) = (started, finished) else {
            return Err("there was no client".into());
        };
        let round_trips = done.into_iter().flat_map(|calls| calls.round_trips);

        Ok(Stats::new(
            round_trips.collect(),
            finished.duration_since(started),
        ))
    })
}

/// The scenario `fanout_delivery`: signals from one emitter to many subscribers.
async fn fanout_delivery() -> Result<Stats> {
    let _watchdog = Watchdog::start("fanout_delivery");
    let data = vec![0u8; FANOUT_PAYLOAD_LEN];
    let rule = MatchRule::builder()
        .msg_type(Type::Signal)
        .interface(INTERFACE)
        .member(MEMBER)
        .build()?;
    let queue = NonZeroUsize::new(FANOUT_SIGNALS + QUEUE_SPARE).expect("room for the spare");

    let emitter = zbus::connection::Builder::session().build().await?;
    let (subscribed, subscriptions) = mpsc::channel();
    let subscribers: Vec<_> = (0..FANOUT_SUBSCRIBERS)
        .map(|_| {
            let rule = rule.clone();
            let subscribed = subscribed.clone();
            std::thread::spawn(move || subscriber(rule, queue, subscribed))
        })
        .collect();
    drop(subscribed);
    // Each subscribes before any signal is sent: the bus has registered the match rule by the
    // time that `for_match_rule` returns, as it waits for the bus to reply to `AddMatch`.
    for _ in 0..FANOUT_SUBSCRIBERS {
        subscriptions
            .recv()
            .map_err(|_| "a subscriber ended before it subscribed")??;
    }

    // The signals carry the time they were sent at as a number of nanoseconds since this.
    let epoch = Instant::now();
    emit(&emitter, &data, epoch).await?;
    let mut delays = Vec::with_capacity(FANOUT_SIGNALS * FANOUT_SUBSCRIBERS);
    let mut last = epoch;
    for subscriber in subscribers {
        let received = subscriber.join().map_err(|_| "a subscriber panicked")??;
        for (seq, (sent, taken)) in received.into_iter().enumerate() {
            let Some(delay) = nanos(taken.duration_since(epoch)).checked_sub(sent) else {
                return Err(format!("signal {seq} arrived before it was sent").into());
            };
            delays.push(delay);
            last = last.max(taken);
        }
    }

    Ok(Stats::new(delays, last.duration_since(epoch)))
}

/// A subscriber of `fanout_delivery`, on a thread of its own, with a single-threaded runtime of its
/// own: subscribes to the signals that `rule` matches, says on `subscribed` whether it did, and
/// receives the signals.
///
/// Returns, for each signal, the time that it carries and when it was taken off the stream.
fn subscriber(
    rule: MatchRule<'static>,
    queue: NonZeroUsize,
    subscribed: mpsc::Sender<Result<()>>,
) -> Result<Vec<(u64, Instant)>> {
    zbus::block_on(async {
        let mut stream = match subscribe(&rule, queue).await {
            Ok(stream) => stream,
            Err(e) => {
                // The thread that waits for the subscribers gives up on the first that fails, with
                // its error.
                let _ = subscribed.send(Err(e));

                return Err("the subscriber could not subscribe".into());
            }
        };
        let _ = subscribed.send(Ok(()));

        receive(&mut stream).await
    })
}

/// A service of the round trips, on a thread of its own, with a connection and a single-threaded
/// runtime of its own: serves its interface at `name`, says on `ready` whether it could, and goes on
/// serving it until `stopped` is closed.
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

/// A client of the round trips, on a thread of its own, with a connection and a single-threaded
/// runtime of its own: connects, waits at `start` until the other clients have too, and calls the
/// service at `name` `calls` times, one call after the other, with `data` as the byte array.
fn client(name: &str, data: &[u8], calls: usize, start: &Barrier) -> Result<Calls> {
    zbus::block_on(async {
        let proxy = connect(name).await;
        // It arrives whether it connected or not, so that the others do not wait for good for one
        // that failed.
        start.wait().await;
        let proxy = proxy?;

        let started = Instant::now();
        let mut round_trips = Vec::with_capacity(calls);
        for _ in 0..calls {
            let before = Instant::now();
            proxy.take_byte_array(ByteArray(Bytes::new(data))).await?;
            round_trips.push(nanos(before.elapsed()));
        }

        Ok(Calls {
            round_trips,
            started,
            finished: Instant::now(),
        })
    })
}

/// The calls that a client of the round trips made.
struct Calls {
    /// How long each call took, from sending it until the reply came, in nanoseconds.
    round_trips: Vec<u64>,
    /// When the client started calling.
    started: Instant,
    /// When the reply to its last call came.
    finished: Instant,
}

/// Connects a client, and makes a proxy to the service at `name` on its connection, which the proxy
/// keeps open.
async fn connect(name: &str) -> Result<ServiceProxy<'_>> {
    let connection = zbus::Connection::session().await?;

    Ok(ServiceProxy::new(&connection, name).await?)
}

/// Connects a subscriber, and subscribes it to the signals that `rule` matches.
async fn subscribe(rule: &MatchRule<'_>, queue: NonZeroUsize) -> Result<MessageStream> {
    let conn = zbus::connection::Builder::session().build().await?;

    Ok(MessageStream::for_match_rule(rule.clone(), &conn, Some(queue)).await?)
}

/// Broadcasts the signals of `fanout_delivery`.
///
/// Each carries its sequence number, the time at which this started to build it, in nanoseconds
/// since `epoch`, and `data` as payload, which is borrowed, rather than copied into the signal
/// first, as the byte array of a call is in `main.rs`.
async fn emit(conn: &Connection, data: &[u8], epoch: Instant) -> Result<()> {
    let payload = Bytes::new(data);
    for seq in 0..FANOUT_SIGNALS as u64 {
        let sent = nanos(epoch.elapsed());
        conn.emit_signal(None::<&str>, PATH, INTERFACE, MEMBER, &(seq, sent, payload))
            .await?;
    }

    Ok(())
}

/// Receives the signals of `fanout_delivery` from `stream`, checking that they arrive in order.
///
/// Returns, for each, the time that it carries, in nanoseconds since the emitter's epoch, and when
/// the stream gave it up.
async fn receive(stream: &mut MessageStream) -> Result<Vec<(u64, Instant)>> {
    let mut received = Vec::with_capacity(FANOUT_SIGNALS);
    for expected in 0..FANOUT_SIGNALS as u64 {
        let msg = stream.try_next().await?;
        // Taken before anything else is done with the signal, so as to count only the delivery.
        let taken = Instant::now();
        let Some(msg) = msg else {
            let count = FANOUT_SIGNALS;
            return Err(format!("the stream ended after {expected} of {count} signals").into());
        };
        let body = msg.body();
        let (seq, sent, payload): (u64, u64, &Bytes) = body.deserialize()?;

        if seq != expected {
            return Err(format!("signal {seq} arrived where signal {expected} was due").into());
        }
        if payload.len() != FANOUT_PAYLOAD_LEN {
            let len = payload.len();
            return Err(
                format!("signal {seq} carried {len} bytes, not {FANOUT_PAYLOAD_LEN}").into(),
            );
        }
        received.push((sent, taken));
    }

    Ok(received)
}

/// The nanoseconds in `duration`.
fn nanos(duration: Duration) -> u64 {
    u64::try_from(duration.as_nanos()).expect("a duration of less than 584 years")
}

/// The distribution of the samples of a scenario.
struct Stats {
    /// How many samples there are.
    count: usize,
    /// How long the scenario took, in seconds.
    elapsed_s: f64,
    /// The mean of the samples, in microseconds.
    mean_us: f64,
    /// The median of the samples, in microseconds.
    p50_us: f64,
    /// The 90th percentile of the samples, in microseconds.
    p90_us: f64,
    /// The 99th percentile of the samples, in microseconds.
    p99_us: f64,
    /// The 99.9th percentile of the samples, in microseconds.
    p999_us: f64,
    /// The largest of the samples, in microseconds.
    max_us: f64,
}

impl Stats {
    /// The distribution of `samples`, in nanoseconds, of a scenario that took `elapsed`.
    fn new(mut samples: Vec<u64>, elapsed: Duration) -> Self {
        samples.sort_unstable();
        let count = samples.len();
        let total: u128 = samples.iter().map(|&sample| u128::from(sample)).sum();
        let us = |ns: u64| ns as f64 / 1000.0;

        Self {
            count,
            elapsed_s: elapsed.as_secs_f64(),
            mean_us: total as f64 / count as f64 / 1000.0,
            p50_us: us(percentile(&samples, 500)),
            p90_us: us(percentile(&samples, 900)),
            p99_us: us(percentile(&samples, 990)),
            p999_us: us(percentile(&samples, 999)),
            max_us: us(samples[count - 1]),
        }
    }

    /// The distribution as a JSON object.
    fn to_json(&self) -> String {
        format!(
            "{{\"count\": {}, \"elapsed_s\": {:.6}, \"mean_us\": {:.3}, \"p50_us\": {:.3}, \
             \"p90_us\": {:.3}, \"p99_us\": {:.3}, \"p999_us\": {:.3}, \"max_us\": {:.3}}}",
            self.count,
            self.elapsed_s,
            self.mean_us,
            self.p50_us,
            self.p90_us,
            self.p99_us,
            self.p999_us,
            self.max_us,
        )
    }
}

/// The nearest-rank percentile of `sorted`, at `permille` thousandths of the way through them.
///
/// That is the sample at the rank that `permille` thousandths of their number comes to, rounded
/// up, counting from 1 for the smallest. It is worked out in whole numbers, which a fraction of
/// a float could get wrong by one at the boundaries.
fn percentile(sorted: &[u64], permille: usize) -> u64 {
    let rank = (permille * sorted.len())
        .div_ceil(1000)
        .clamp(1, sorted.len());

    sorted[rank - 1]
}

/// Ends the process, with `TIMEOUT_EXIT_STATUS`, if it is not dropped within `SCENARIO_TIMEOUT`.
///
/// A broker that loses a message leaves a client waiting for it for good. The wait can be one that
/// blocks a thread, such as that for the thread of a client or a subscriber to end, which no timer
/// of a runtime could cut short, but a thread of its own can. It says so on the standard error, as
/// the standard output is for the object only.
struct Watchdog {
    /// Dropping this is what calls the watchdog off.
    _disarm: mpsc::Sender<()>,
}

impl Watchdog {
    /// Starts watching the scenario `scenario`.
    fn start(scenario: &'static str) -> Self {
        let (disarm, disarmed) = mpsc::channel();
        std::thread::spawn(move || {
            if let Err(mpsc::RecvTimeoutError::Timeout) = disarmed.recv_timeout(SCENARIO_TIMEOUT) {
                eprintln!("{scenario} did not finish within {SCENARIO_TIMEOUT:?}");
                std::process::exit(TIMEOUT_EXIT_STATUS);
            }
        });

        Self { _disarm: disarm }
    }
}
