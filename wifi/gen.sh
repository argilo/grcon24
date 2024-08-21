#!/usr/bin/env bash

set -e

# Paint
convert \
  -background White \
  -gravity Center \
  -pointsize 50 \
  -font 'Ubuntu-Sans-Medium' \
  label:'Part 1: flag\{fcf83c1e2b501dd4\}' \
  -rotate 270 \
  -extent x800 \
  -background White \
  -extent 64x \
  -flop \
  flag1.png

# Image file
qrencode -l H -s 2 -o rickroll.png 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'
convert \
  logo-373878867.png \
  rickroll.png \
  -geometry +1466+0 \
  -composite \
  -pointsize 10 \
  -fill '#181818' \
  -font 'Ubuntu-Sans-Medium' \
  -annotate +925+205 'Part 2: flag\{a80ce321aab12038\}' \
  -set comment 'Part 3: flag\{3aa46bc4c2541a31\}' \
  combined.png

grcc wifi_phy_paint_hier.grc
grcc wifi_gen.grc
./wifi_gen.py &
pid=$!
sleep 2
./packet_gen.py
sleep 2
kill $pid