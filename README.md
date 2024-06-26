# D-Bus Broker Benchmarking

This repository attempts to benchmark the performance of D-Bus brokers. It make simple method calls
to its own service, using a single and multiple simultaneous service & client pairs. Each pair share
the same connection.

## Running the benchmark

Simple run `cargo run` in the root of the repository. This will benchmark the existing session bus
(assuming one is available). If you want to benchmark a different bus, you can set the
`DBUS_SESSION_BUS_ADDRESS` environment variable like this:

```sh
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus cargo run
```

## Results

Here are the results obtained on my machine (AMD Ryzen 7 7840U w/ 8 cores & 16 threads, 64 GB RAM):

| Broker        |      Version      | Single connection (seconds) | 20 connections (seconds) |
|---------------|-------------------|-----------------------------|--------------------------|
| [dbus-broker] | 36                |        0.417053             |        6.757665          |
| [dbus-daemon] | 1.14.10           |        0.439600             |        6.491848          |
| [busd]        | 0.3.1<sup>1</sup> |        0.433934             |        6.666954          |

**Note**: If you run the benchmark on your machine, make sure that `busd` is built in release mode
(`cargo run --release` if you build+run it yourself from the source).

1: Actually, git main branch (commit 14ec6693) on 2024-06-23.

[dbus-broker]: https://github.com/bus1/dbus-broker
[dbus-daemon]: https://gitlab.freedesktop.org/dbus/dbus
[busd]: https://github.com/dbus2/busd
