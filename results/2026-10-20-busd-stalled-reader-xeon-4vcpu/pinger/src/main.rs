//! Connects to the bus twice at startup, as a service and as its client, then calls the service
//! every 500 ms and prints, one line per call, how long its reply took or that none came within
//! 1 s. The connections are made once, so the calls only need the bus to forward them.
use std::time::{Duration, Instant};

struct Pong;

#[zbus::interface(name = "org.example.Pinger")]
impl Pong {
    fn ping(&self) {}
}

#[tokio::main(flavor = "current_thread")]
async fn main() -> zbus::Result<()> {
    let service = zbus::connection::Builder::session()
        .serve_at("/pinger", Pong)
        .build()
        .await?;
    let client = zbus::Connection::session().await?;
    let dest = service.unique_name().unwrap().to_owned();
    let started = Instant::now();
    loop {
        let before = Instant::now();
        let call = client.call_method(
            Some(dest.clone()),
            "/pinger",
            Some("org.example.Pinger"),
            "Ping",
            &(),
        );
        let at = started.elapsed().as_secs_f64();
        match tokio::time::timeout(Duration::from_secs(1), call).await {
            Ok(Ok(_)) => println!("{at:.1} s: reply after {:?}", before.elapsed()),
            Ok(Err(e)) => println!("{at:.1} s: error: {e}"),
            Err(_) => println!("{at:.1} s: no reply within 1 s"),
        }
        tokio::time::sleep(Duration::from_millis(500)).await;
    }
}
