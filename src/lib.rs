//! What the clients and the services of the benchmark share: the method that they call and serve,
//! and the code that calls and serves it.
//!
//! They build their messages themselves, with the builders of `zbus::Message`, and send them with
//! `Connection::send`, rather than through proxies, the object server or `Connection::emit_signal`,
//! which set the sender of each message to the unique name of their connection. The clients leave
//! the sender out, as those of libdbus, GLib and sd-bus do, so that the bus has to set it, as it
//! must for most real clients. That goes for every message that is timed: the calls, the replies to
//! them and the signals. Only the traffic that sets a connection up goes through the API of zbus:
//! `Hello`, `RequestName` and `AddMatch`.

use std::{num::NonZeroU32, pin::pin};

use futures_util::{
    future::{select, Either},
    TryStreamExt,
};
use serde::{Deserialize, Serialize};
use serde_bytes::Bytes;
use zbus::{message::Type, names::BusName, Connection, Message, MessageStream};
use zruntime::mpmc;

/// The path that the services serve their interface at, and that the signals are emitted from.
pub const PATH: &str = "/org/dbus2/benchmark";

/// The interface of the method that the services serve.
pub const INTERFACE: &str = "org.dbus2.benchmark";

/// The method that the services serve: it takes a byte array, and replies with nothing.
pub const METHOD: &str = "TakeByteArray";

/// Anything that goes wrong ends the run, so the errors need no more than their message. They are
/// `Send`, so that the thread of a service or a client can hand its error over.
pub type Result<T> = std::result::Result<T, Box<dyn std::error::Error + Send + Sync>>;

/// A caller of the method of a service, on a connection that is its alone.
///
/// It makes a stream of the connection along with itself, before anything is sent, as a reply that
/// arrives before the stream exists is not delivered to it, and reads the reply to each call off
/// it. The messages that are not that reply, such as the signal that tells a new connection its
/// name, are skipped. So a connection that several callers shared would lose replies, as each
/// skipped those of the others.
pub struct Caller {
    /// The connection that the calls are sent on.
    connection: Connection,
    /// The service that is called.
    destination: BusName<'static>,
    /// The messages that the connection receives, among which are the replies.
    replies: MessageStream,
}

impl Caller {
    /// Makes a caller of the service at `destination` on `connection`.
    pub fn new<'d, D>(connection: Connection, destination: D) -> Result<Self>
    where
        D: TryInto<BusName<'d>>,
        D::Error: Into<zbus::Error>,
    {
        let replies = MessageStream::from(&connection);
        let destination = destination.try_into().map_err(Into::<zbus::Error>::into)?;

        Ok(Self {
            connection,
            destination: destination.into_owned(),
            replies,
        })
    }

    /// Calls the service with `data` as the byte array, and waits for the reply.
    ///
    /// Fails if the service replies with an error, or the connection closes first.
    pub async fn call(&mut self, data: &[u8]) -> Result<()> {
        let msg = call_message(&self.destination, data)?;
        let serial = msg.primary_header().serial_num();
        self.connection.send(&msg).await?;

        loop {
            let Some(msg) = self.replies.try_next().await? else {
                return Err("the connection closed before the reply came".into());
            };
            if replied_to(&msg) == Some(serial) {
                return check_reply(&msg);
            }
        }
    }
}

/// Serves the method on `connection` until `stopped` is closed, replying to each call that
/// `calls` yields.
///
/// `calls` is a stream of the connection that was made right after the connection was, so that it
/// has every call that the connection receives. The messages that are not calls are ignored. The
/// replies are sent as they are built, with no sender, for the bus to set. A call of anything but
/// the method gets an error for a reply.
///
/// Fails if `calls` ends first, or a call has a body that is not a byte array.
pub async fn serve(
    connection: &Connection,
    calls: MessageStream,
    stopped: mpmc::Receiver<()>,
) -> Result<()> {
    let serving = pin!(reply_to_calls(connection, calls));
    // As nothing is sent on the channel, this completes only once it is closed.
    let stopped = pin!(stopped.recv());

    match select(serving, stopped).await {
        Either::Left((served, _)) => served,
        Either::Right(_) => Ok(()),
    }
}

/// A call of the method, to `destination`, with `data` as the byte array.
///
/// It has no sender, for the bus to set.
pub fn call_message(destination: &BusName<'_>, data: &[u8]) -> Result<Message> {
    let msg = Message::method_call(PATH, METHOD)
        .destination(destination)
        .interface(INTERFACE)
        .build(&ByteArray(Bytes::new(data)))?;

    Ok(msg)
}

/// The serial number of the call that `msg` is the reply to, if it is a reply: a method return or
/// an error.
pub fn replied_to(msg: &Message) -> Option<NonZeroU32> {
    match msg.message_type() {
        Type::MethodReturn | Type::Error => msg.header().reply_serial(),
        _ => None,
    }
}

/// Checks that `reply`, a method return or an error, reports that its call succeeded.
///
/// Fails with the name of the error if it is one.
pub fn check_reply(reply: &Message) -> Result<()> {
    if reply.message_type() != Type::Error {
        return Ok(());
    }
    let header = reply.header();
    let name = header
        .error_name()
        .map_or("an error without a name", |name| name.as_str());

    Err(format!("the call failed with {name}").into())
}

/// Replies to each of the calls that `calls` yields, until it ends.
async fn reply_to_calls(connection: &Connection, mut calls: MessageStream) -> Result<()> {
    while let Some(msg) = calls.try_next().await? {
        if msg.message_type() != Type::MethodCall {
            continue;
        }
        let header = msg.header();
        let ours = header.path().is_some_and(|path| path.as_str() == PATH)
            && header
                .interface()
                .is_some_and(|interface| interface.as_str() == INTERFACE)
            && header
                .member()
                .is_some_and(|member| member.as_str() == METHOD);

        let reply = if ours {
            let body = msg.body();
            let _: ByteArray<'_> = body.deserialize()?;

            Message::method_return(&header).build(&())?
        } else {
            Message::error(&header, "org.freedesktop.DBus.Error.UnknownMethod")
                .build(&("Unknown method",))?
        };
        connection.send(&reply).await?;
    }

    Err("the connection closed while serving".into())
}

/// The byte array of a call, which a caller borrows from its data, and a service from the message
/// that carries it, rather than copy it.
///
/// As a struct with a single field, it has the D-Bus type of that field: an array of bytes.
#[derive(Deserialize, Serialize, zbus::wire::Type)]
struct ByteArray<'a>(#[serde(borrow)] &'a Bytes);
