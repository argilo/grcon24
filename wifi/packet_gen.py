#!/usr/bin/env python3

import socket
import time
from scapy.all import LLC, SNAP, IP, UDP, Raw

GNURADIO_IP = "127.0.0.1"
GNURADIO_PORT = 52001

IP_SRC = "10.42.0.1"
IP_DST = "10.42.0.126"

UDP_SPORT = 52743
UDP_DPORT = 1234

PACKET_COUNT = 800
INTERVAL = 0.03


with open("combined.png", "rb") as f:
    image_data = f.read()

chunk_size = -(len(image_data) // -PACKET_COUNT)
payloads = [image_data[start:start+chunk_size] for start in range(0, len(image_data), chunk_size)]

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

for identifier, payload in enumerate(payloads, start=0x0e3a):
    time.sleep(INTERVAL)
    packet = (
        LLC()
        / SNAP()
        / IP(src=IP_SRC, dst=IP_DST, id=identifier, flags="DF")
        / UDP(sport=UDP_SPORT, dport=UDP_DPORT)
        / Raw(load=payload)
    )
    packet_bytes = bytes(packet)
    print(packet_bytes.hex())
    sock.sendto(packet_bytes, (GNURADIO_IP, GNURADIO_PORT))
