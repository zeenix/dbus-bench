//! Makes a method call through the bus at `$DBUS_SESSION_BUS_ADDRESS` once every `INTERVAL_US`
//! microseconds for `SECS` seconds, and prints how many calls it made. With `MODE=bus` (the
//! default), the calls are to the bus itself (`GetId`); with `MODE=forward`, they are to a service
//! on a second connection of this process, which the bus forwards each call and reply between.
use std::time::{Duration, Instant};

struct Pinger;

#[zbus::interface(name = "org.zbus.IdleClient")]
impl Pinger {
    fn ping(&self) {}
}

fn main() -> zbus::Result<()> {
    let interval_us: u64 = std::env::var("INTERVAL_US").map_or(1000, |v| v.parse().unwrap());
    let secs: u64 = std::env::var("SECS").map_or(5, |v| v.parse().unwrap());
    let forward = std::env::var("MODE").is_ok_and(|v| v == "forward");

    zruntime::block_on(async {
        let conn = zbus::Connection::session().await?;
        let _service = if forward {
            Some(
                zbus::connection::Builder::session()
                    .name("org.zbus.IdleClient")
                    .serve_at("/org/zbus/IdleClient", Pinger)
                    .build()
                    .await?,
            )
        } else {
            None
        };
        let rt = zruntime::SharedRuntime::current()?;
        let proxy = zbus::fdo::DBusProxy::new(&conn).await?;
        let mut interval = rt.interval(Duration::from_micros(interval_us));
        let deadline = Instant::now() + Duration::from_secs(secs);
        let mut calls = 0u64;
        while Instant::now() < deadline {
            interval.tick().await;
            if forward {
                conn.call_method(
                    Some("org.zbus.IdleClient"),
                    "/org/zbus/IdleClient",
                    Some("org.zbus.IdleClient"),
                    "Ping",
                    &(),
                )
                .await?;
            } else {
                proxy.get_id().await?;
            }
            calls += 1;
        }
        println!("{calls}");

        Ok(())
    })
}
