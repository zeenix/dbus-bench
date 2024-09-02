use serde_bytes::ByteBuf;

#[derive(Debug)]
struct Service;

#[zbus::interface(
    name = "org.dbus2.benchmark",
)]
impl Service {
    fn take_byte_array(&self, _msg: ByteBuf) {}
}

#[zbus::proxy(
    name = "org.dbus2.benchmark",
    default_path = "/org/dbus2/benchmark",
    gen_blocking = false,
)]
trait Service {
    fn take_byte_array(&self, _msg: &ByteBuf) -> zbus::Result<()>;
}

#[tokio::main(flavor = "current_thread")]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let data = ByteBuf::from(vec![0u8; 16 * 1024]);

    let before = std::time::Instant::now();
    hammer("org.dbus2.benchmark.SingleClient".to_string(), &data).await?;
    let elapsed = before.elapsed();
    println!("Hammering using a single client took {:?}", elapsed);

    let before = std::time::Instant::now();
    hammer_multi("org.dbus2.benchmark.MultiClient".to_string(), &data).await?;
    let elapsed = before.elapsed();
    println!("Hammering using 20 simultaneous clients took {:?}", elapsed);

    Ok(())
}

async fn hammer(name: String, data: &ByteBuf) -> zbus::Result<()> {
    let conn = zbus::connection::Builder::session()?
        .serve_at("/org/dbus2/benchmark", Service)?
        .name(name.clone())?
        .build()
        .await?;

    let proxy = ServiceProxy::new(&conn, name).await?;
    for _ in 0..1000 {
        proxy.take_byte_array(data).await?;
    }

    Ok(())
}

async fn hammer_multi(name: String, data: &ByteBuf) -> zbus::Result<()> {
    futures_util::future::try_join_all((0..20).map(|i| {
        let name = format!("{name}{i}");
        hammer(name, data)
    }))
    .await
    .map(|_| ())
}
