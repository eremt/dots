#!/bin/sh
setxkbmap -option caps:swapescape &

if command -v sxhkd 2>&1 /dev/null; then
  { sleep 1; sxhkd; } &
fi
if command -v dunst 2>&1 /dev/null; then
  dunst &
fi
if command -v redshift 2>&1 /dev/null; then
  redshift &
fi
