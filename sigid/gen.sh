#!/usr/bin/env bash

grcc pagerserver.grc
./pagerserver.py --filename sigid3.sigmf-data --offset 37500 &
pid=$!
sleep 5
echo pocsag1200 0 929287500 alpha 31337 `echo "flag{74d74b540b070f16ed30c607bfbe0905}" | xxd -ps -c 200` | nc -q 1 localhost 52001
kill $pid

grcc pagerserver.grc
./pagerserver.py --filename sigid4.sigmf-data --offset 62500 &
pid=$!
sleep 5
echo flex 0 929312500 alpha 424242 `echo "flag{0511696e30d8a1b3329db1bc8e5057e5}" | xxd -ps -c 200` | nc -q 1 localhost 52001
kill $pid

grcc m17_packet.grc
echo -en "\x05flag{a591743aff8edb92425d9541bdcff8e3}\x00" | m17-packet-encode -S VE3IRR/W4 -D KA0XTT -C 0 -n 40 -f -o packet_symbols.f32
cat <(dd if=/dev/zero bs=4 count=192) packet_symbols.f32 <(dd if=/dev/zero bs=4 count=192) > packet_symbols_padded.f32
# cat packet_symbols.f32 | m17-packet-decode -c
./m17_packet.py

grcc m17_voice.grc
sox m17_flag.wav -r 8000 -t raw - | m17-mod -S VE3IRR/W4 -s > voice_symbols.s8
cat <(dd if=/dev/zero bs=1 count=192) voice_symbols.s8 <(dd if=/dev/zero bs=1 count=192) > voice_symbols_padded.s8
./m17_voice.py