//! Signal throughput of a D-Bus broker.
//!
//! The counterpart of `main.rs` for signals: it connects to the bus named by
//! `$DBUS_SESSION_BUS_ADDRESS`, broadcasts signals through it and times how long they take to
//! arrive, in two phases. It prints the timing of each in the format that `main.rs` does, so
//! that `scripts/compare-brokers.py --bench target/release/fanout` can run it as it is:
//!
//! 1. A burst: one connection broadcasts `BURST_SIGNALS` signals back to back, and a second one,
//!    subscribed to them, receives all of them.
//! 2. A fan-out: one connection broadcasts `FANOUT_SIGNALS` signals back to back, and
//!    `SUBSCRIBERS` others, all subscribed to them, receive each one, so the broker delivers
//!    `SUBSCRIBERS` times as many signals as it is sent.
//!
//! Every signal carries its sequence number and `PAYLOAD_LEN` bytes of payload. A subscriber
//! checks that the numbers arrive as 0, 1, 2 and so on, so the run fails if the broker loses,
//! repeats or reorders a signal, and so it does if a D-Bus call fails. Like `main.rs`, it runs
//! on a single-threaded runtime: the emitter and the subscribers take turns on one thread.
//!
//! What a phase times is from just before the first signal is sent until the last subscriber has
//! received its last one. The connections are made and subscribed before that.

use std::{
    num::NonZeroUsize,
    sync::mpsc,
    time::{Duration, Instant},
};

use futures_util::{
    future::{try_join, try_join_all},
    TryStreamExt,
};
use serde_bytes::Bytes;
use zbus::{message::Type, Connection, MatchRule, MessageStream};

/// How many signals the burst sends.
///
/// A phase should take between 0.2 and 1.5 s: long enough to time to a fraction of a percent,
/// short enough to repeat many times. On a 4-vCPU Xeon VM, the burst takes about 0.5 s against
/// busd and against dbus-daemon, in the middle of that. The client alone is busy for about 0.45 s
/// of it, which is the least that any broker can take, so half as many signals would leave the
/// fastest of them close to 0.2 s.
const BURST_SIGNALS: usize = 40_000;

/// How many signals the fan-out sends, each of which is delivered to every subscriber.
///
/// That is `SUBSCRIBERS` times as many deliveries, 80000 of them, but a tenth of the signals sent,
/// which takes about as long as the burst: 0.5 s against busd and 0.7 s against dbus-daemon, on
/// the VM above. The client is busy for 0.45 s of it again, so fewer signals would bring the
/// fastest brokers close to 0.2 s here too.
const FANOUT_SIGNALS: usize = 4_000;

/// How many subscribers the fan-out has, as many as the simultaneous clients of `main.rs`.
const SUBSCRIBERS: usize = 20;

/// How many bytes of payload every signal carries.
const PAYLOAD_LEN: usize = 1024;

/// How many signals more than a phase sends the queue of a subscriber's stream has room for.
///
/// zbus holds back the reader of a connection's socket whenever the stream of one of its match
/// rules is full. A queue for every signal of the phase, and this many to spare, rules that out,
/// so that a subscriber reads its socket as fast as the broker fills it, whatever the order in
/// which the tasks of the runtime happen to run.
const QUEUE_SPARE: usize = 16;

/// How long a phase gets, connecting included, before the process gives up on it.
const PHASE_TIMEOUT: Duration = Duration::from_secs(120);

/// The exit status of a process that gave up on a phase, as opposed to one that failed.
const TIMEOUT_EXIT_STATUS: i32 = 2;

/// The path that the signals are emitted from.
const PATH: &str = "/org/dbus2/benchmark";

/// The interface of the signals.
const INTERFACE: &str = "org.dbus2.benchmark.Fanout";

/// Anything that goes wrong ends the run, so the errors need no more than their message.
type Result<T> = std::result::Result<T, Box<dyn std::error::Error>>;

#[tokio::main(flavor = "current_thread")]
async fn main() -> Result<()> {
    let data = vec![0u8; PAYLOAD_LEN];

    let burst = Phase::connect("burst", "Burst", 1, BURST_SIGNALS).await?;
    let elapsed = burst.run(&data).await?;
    // The fan-out is connected before the line below is printed, and not after, because
    // `scripts/compare-brokers.py` measures what the broker and the client use between the two
    // lines. This keeps the connecting of the fan-out out of it.
    let fanout = Phase::connect("fan-out", "Fanout", SUBSCRIBERS, FANOUT_SIGNALS).await?;
    println!("Hammering using a single client took {elapsed:?}");

    let elapsed = fanout.run(&data).await?;
    println!("Hammering using {SUBSCRIBERS} simultaneous clients took {elapsed:?}");

    Ok(())
}

/// A phase of the benchmark, connected and subscribed: an emitter and the subscribers that
/// receive the signals it sends.
struct Phase {
    /// The member of the signals of this phase.
    member: &'static str,
    /// How many signals the emitter sends, and each subscriber receives.
    signals: usize,
    /// The connection that sends the signals. It stays open until the phase is over, so that the
    /// broker never sees the sender go while signals from it are still on their way.
    emitter: Connection,
    /// The streams of the subscribers, each of which keeps the connection it reads open.
    subscribers: Vec<MessageStream>,
    /// Ends the process if the phase takes too long, unless it is over by then and drops this.
    _watchdog: Watchdog,
}

impl Phase {
    /// Connects an emitter and `subscribers` subscribers, and subscribes the latter to the
    /// signals of `member`, of which the phase will send `signals`.
    async fn connect(
        name: &'static str,
        member: &'static str,
        subscribers: usize,
        signals: usize,
    ) -> Result<Self> {
        let watchdog = Watchdog::start(name);
        let rule = MatchRule::builder()
            .msg_type(Type::Signal)
            .interface(INTERFACE)
            .member(member)
            .build()?;
        let queue = NonZeroUsize::new(signals + QUEUE_SPARE).expect("room for the spare signals");

        let emitter = zbus::connection::Builder::session().build().await?;
        // Each subscribes before any signal is sent: the bus has registered the match rule by the
        // time that `for_match_rule` returns, as it waits for the bus to reply to `AddMatch`.
        let subscribers = try_join_all((0..subscribers).map(|_| subscribe(&rule, queue))).await?;

        Ok(Self {
            member,
            signals,
            emitter,
            subscribers,
            _watchdog: watchdog,
        })
    }

    /// Sends the signals while the subscribers receive them, and returns how long that took.
    async fn run(mut self, data: &[u8]) -> Result<Duration> {
        let signals = self.signals;

        let before = Instant::now();
        // The subscribers read while the emitter sends, and either failing ends the phase at
        // once, rather than leaving the other to wait for what will not come.
        try_join(
            emit(&self.emitter, self.member, signals, data),
            try_join_all(
                self.subscribers
                    .iter_mut()
                    .map(|stream| receive(stream, signals)),
            ),
        )
        .await?;

        Ok(before.elapsed())
    }
}

/// Connects a subscriber, and subscribes it to the signals that `rule` matches.
async fn subscribe(rule: &MatchRule<'_>, queue: NonZeroUsize) -> Result<MessageStream> {
    let conn = zbus::connection::Builder::session().build().await?;

    Ok(MessageStream::for_match_rule(rule.clone(), &conn, Some(queue)).await?)
}

/// Broadcasts `count` signals of `member`, each with its sequence number and `data` as payload.
///
/// The payload is borrowed by every signal, rather than copied into it first, as the byte array
/// of a call is in `main.rs`.
async fn emit(conn: &Connection, member: &str, count: usize, data: &[u8]) -> Result<()> {
    let payload = Bytes::new(data);
    for seq in 0..count as u64 {
        conn.emit_signal(None::<&str>, PATH, INTERFACE, member, &(seq, payload))
            .await?;
    }

    Ok(())
}

/// Receives `count` signals from `stream`, and checks that they arrive in order and intact.
async fn receive(stream: &mut MessageStream, count: usize) -> Result<()> {
    for expected in 0..count as u64 {
        let Some(msg) = stream.try_next().await? else {
            return Err(format!("the stream ended after {expected} of {count} signals").into());
        };
        let body = msg.body();
        let (seq, payload): (u64, &Bytes) = body.deserialize()?;

        if seq != expected {
            return Err(format!("signal {seq} arrived where signal {expected} was due").into());
        }
        if payload.len() != PAYLOAD_LEN {
            let len = payload.len();
            return Err(format!("signal {seq} carried {len} bytes, not {PAYLOAD_LEN}").into());
        }
    }

    Ok(())
}

/// Ends the process, with `TIMEOUT_EXIT_STATUS`, if it is not dropped within `PHASE_TIMEOUT`.
///
/// A broker that loses a signal leaves a subscriber waiting for it for good. Only the `rt` and
/// `macros` features of Tokio are on, so there is no timer to give up with, but a thread of its
/// own can.
struct Watchdog {
    /// Dropping this is what calls the watchdog off.
    _disarm: mpsc::Sender<()>,
}

impl Watchdog {
    /// Starts watching the phase `phase`.
    fn start(phase: &'static str) -> Self {
        let (disarm, disarmed) = mpsc::channel();
        std::thread::spawn(move || {
            if let Err(mpsc::RecvTimeoutError::Timeout) = disarmed.recv_timeout(PHASE_TIMEOUT) {
                eprintln!("the {phase} phase did not finish within {PHASE_TIMEOUT:?}");
                std::process::exit(TIMEOUT_EXIT_STATUS);
            }
        });

        Self { _disarm: disarm }
    }
}
