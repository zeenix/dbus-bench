"""A stand-in for journald's native socket, for dbus-broker-launch in a container without
systemd: it takes the log entries sent to /run/systemd/journal/socket and appends their MESSAGE
field to the file named on the command line, one entry per line."""
import array
import os
import socket
import struct
import sys

PATH = "/run/systemd/journal/socket"


def fields(data):
    """The fields of an entry of the native journal protocol, as (name, value) pairs."""
    pos = 0
    while pos < len(data):
        end = data.find(b"\n", pos)
        if end < 0:
            end = len(data)
        line = data[pos:end]
        if b"=" in line:
            name, _, value = line.partition(b"=")
            yield name, value
            pos = end + 1
        elif not line or end + 9 > len(data):
            # An empty line, or the end of the entry.
            pos = end + 1
        else:
            # A binary field: the name, a newline, a 64-bit little-endian length, the value and a
            # newline.
            size = struct.unpack_from("<Q", data, end + 1)[0]
            start = end + 9
            yield line, data[start:start + size]
            pos = start + size + 1


os.makedirs(os.path.dirname(PATH), exist_ok=True)
try:
    os.unlink(PATH)
except FileNotFoundError:
    pass
sock = socket.socket(socket.AF_UNIX, socket.SOCK_DGRAM)
sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 8 * 1024 * 1024)
sock.bind(PATH)
with open(sys.argv[1], "a", buffering=1, encoding="utf-8") as out:
    while True:
        data, ancdata, _, _ = sock.recvmsg(1 << 20, socket.CMSG_SPACE(64 * 4))
        for level, kind, cdata in ancdata:
            if level == socket.SOL_SOCKET and kind == socket.SCM_RIGHTS:
                fds = array.array("i")
                fds.frombytes(cdata[: len(cdata) - len(cdata) % fds.itemsize])
                for fd in fds:
                    # An entry too big for a datagram comes in a memfd.
                    with os.fdopen(fd, "rb") as f:
                        data = f.read()
        try:
            for name, value in fields(data):
                if name == b"MESSAGE":
                    out.write(value.decode("utf-8", "replace").replace("\n", " ") + "\n")
        except (struct.error, ValueError) as e:
            out.write(f"(unparsed entry of {len(data)} bytes: {e})\n")
