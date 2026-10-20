use serde::{Deserialize, Serialize};
use serde_bytes::Bytes;

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

#[tokio::main(flavor = "current_thread")]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let before = std::time::Instant::now();
    hammer("org.dbus2.benchmark.SingleClient".to_string()).await?;
    let elapsed = before.elapsed();
    println!("Hammering using a single client took {:?}", elapsed);

    let before = std::time::Instant::now();
    hammer_multi("org.dbus2.benchmark.MultiClient".to_string()).await?;
    let elapsed = before.elapsed();
    println!("Hammering using 20 simultaneous clients took {:?}", elapsed);

    Ok(())
}

async fn hammer(name: String) -> zbus::Result<()> {
    let conn = zbus::connection::Builder::session()
        .serve_at("/org/dbus2/benchmark", Service)
        .name(name.clone())
        .build()
        .await?;

    let proxy = ServiceProxy::new(&conn, name).await?;
    for _ in 0..1000 {
        let data = vec![0u8; 16 * 1024];
        proxy.take_byte_array(ByteArray(Bytes::new(&data))).await?;
    }

    Ok(())
}

async fn hammer_multi(name: String) -> zbus::Result<()> {
    futures_util::future::try_join_all((0..20).map(|i| {
        let name = format!("{name}{i}");
        hammer(name)
    }))
    .await
    .map(|_| ())
}
