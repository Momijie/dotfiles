#!/bin/sh

direction="$1"

if [ "$direction" = "up" ]; then
    bspc desktop -f next
elif [ "$direction" = "down" ]; then
    bspc desktop -f prev
fi
