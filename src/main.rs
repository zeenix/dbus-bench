use serde_bytes::ByteBuf;

#[derive(Debug)]
struct Service;

#[zbus::interface(
    name = "org.dbus2.benchmark",
    proxy(gen_blocking = false, default_path = "/org/dbus2/benchmark")
)]
impl Service {
    fn take_byte_array(&self, _msg: ByteBuf) {}
}

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
    let conn = zbus::connection::Builder::session()?
        .serve_at("/org/dbus2/benchmark", Service)?
        .name(name.clone())?
        .build()
        .await?;

    let proxy = ServiceProxy::new(&conn, name).await?;
    for _ in 0..1000 {
        let data = vec![0u8; 16 * 1024];
        proxy.take_byte_array(ByteBuf::from(data)).await?;
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
