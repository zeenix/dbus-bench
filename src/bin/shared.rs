//! The multi-client phases of dbus-bench's `some-changes` branch, on zbus 6, in the output format
//! of dbus-bench's client, so that scripts/compare-brokers.py can drive it: first one connection
//! that serves the object and that `$DBUS_BENCH_CLIENTS` (100 by default) proxies share, each
//! making 1000 calls to it, with a 16 KiB byte array, through the bus ("a single client"), then as
//! many connections, each serving the object and calling it 1000 times ("simultaneous clients").
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

#[derive(Deserialize, Serialize, zbus::wire::Type)]
struct ByteArray<'a>(#[serde(borrow)] &'a Bytes);

#[tokio::main(flavor = "current_thread")]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let clients: usize = std::env::var("DBUS_BENCH_CLIENTS")
        .ok()
        .and_then(|n| n.parse().ok())
        .unwrap_or(100);
    let data = vec![0u8; 16 * 1024];

    // A single client connection, which serves the object, shared by `clients` proxies.
    let conn = serving().await?;
    let before = std::time::Instant::now();
    futures_util::future::try_join_all((0..clients).map(|_| hammer(&conn, &data))).await?;
    println!(
        "Hammering using a single client took {:?}",
        before.elapsed()
    );

    // `clients` connections, each serving the object and calling it.
    let before = std::time::Instant::now();
    futures_util::future::try_join_all((0..clients).map(|_| async {
        let conn = serving().await?;
        hammer(&conn, &data).await
    }))
    .await?;
    println!(
        "Hammering using {clients} simultaneous clients took {:?}",
        before.elapsed()
    );

    Ok(())
}

async fn serving() -> zbus::Result<zbus::Connection> {
    zbus::connection::Builder::session()
        .serve_at("/org/dbus2/benchmark", Service)
        .build()
        .await
}

/// Make 1000 calls, through the bus, to the object that `conn` serves.
async fn hammer(conn: &zbus::Connection, data: &[u8]) -> zbus::Result<()> {
    let name = conn.unique_name().unwrap().to_owned();
    let proxy = ServiceProxy::new(conn, name).await?;
    for _ in 0..1000 {
        proxy.take_byte_array(ByteArray(Bytes::new(data))).await?;
    }

    Ok(())
}
