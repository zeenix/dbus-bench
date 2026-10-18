use serde_bytes::ByteBuf;
use zbus::Connection;

#[derive(Debug)]
struct Service;

#[zbus::interface(name = "org.dbus2.benchmark")]
impl Service {
    fn take_byte_array(&self, _bytes: &serde_bytes::Bytes) {}
}

#[zbus::proxy(
    name = "org.dbus2.benchmark",
    default_path = "/org/dbus2/benchmark",
    gen_blocking = false
)]
trait Service {
    fn take_byte_array(&self, _msg: &ByteBuf) -> zbus::Result<()>;
}

#[tokio::main(flavor = "current_thread")]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let data = ByteBuf::from(vec![0u8; 16 * 1024]);

    let before = std::time::Instant::now();
    hammer(&data, None).await?;
    let elapsed = before.elapsed();
    println!("Hammering using a single client took {:?}", elapsed);

    let before = std::time::Instant::now();
    hammer_multi(&data, None).await?;
    let elapsed = before.elapsed();
    println!(
        "Hammering using 100 simultaneous clients took {:?}",
        elapsed
    );
    let conn = zbus::connection::Builder::session()?
        .serve_at("/org/dbus2/benchmark", Service)?
        .build()
        .await?;
    let before = std::time::Instant::now();
    hammer_multi(&data, Some(&conn)).await?;
    let elapsed = before.elapsed();
    println!(
        "Hammering using 100 simultaneous clients while sharing the same connection took {:?}",
        elapsed
    );

    Ok(())
}

async fn hammer(data: &ByteBuf, conn: Option<&Connection>) -> zbus::Result<()> {
    let conn = match conn {
        Some(c) => c.clone(),
        None => {
            zbus::connection::Builder::session()?
                .serve_at("/org/dbus2/benchmark", Service)?
                .build()
                .await?
        }
    };

    let proxy = ServiceProxy::new(&conn, conn.unique_name().unwrap().clone()).await?;
    for _ in 0..1000 {
        proxy.take_byte_array(data).await?;
    }
    drop(proxy);

    Ok(())
}

async fn hammer_multi(data: &ByteBuf, conn: Option<&Connection>) -> zbus::Result<()> {
    futures_util::future::try_join_all((0..100).map(|_| hammer(data, conn)))
        .await
        .map(|_| ())
}
