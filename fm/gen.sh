#!/usr/bin/env bash

set -e

# Paint
convert \
  -background White \
  -gravity Center \
  -pointsize 150 \
  -font 'Ubuntu-Sans-Medium' \
  label:'Part 2: flag\{c5ea1838b44bc323\}' \
  -rotate 270 \
  -extent x2300 \
  -background Black \
  -extent 256x \
  flag1.png