#! /bin/sh

function main () {
    killall -q polybar
    local desktop="$DESKTOP_SESSION"
    polybar --reload "mainbar-$desktop" -c ~/.config/polybar/config &
}
main
