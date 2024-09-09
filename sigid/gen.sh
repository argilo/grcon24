#!/usr/bin/env bash

grcc m17_packet.grc
echo -en "\x05flag{a591743aff8edb92425d9541bdcff8e3}\x00" | m17-packet-encode -S VE3IRR/W4 -D ALL -C 0 -n 40 -f -o packet_symbols.f32
cat <(dd if=/dev/zero bs=4 count=192) packet_symbols.f32 <(dd if=/dev/zero bs=4 count=192) > packet_symbols_padded.f32
# cat packet_symbols.f32 | m17-packet-decode -c
./m17_packet.py

grcc m17_voice.grc
sox m17_flag.wav -r 8000 -t raw - | m17-mod -S VE3IRR/W4 -s > voice_symbols.s8
cat <(dd if=/dev/zero bs=1 count=192) voice_symbols.s8 <(dd if=/dev/zero bs=1 count=192) > voice_symbols_padded.s8
./m17_voice.py