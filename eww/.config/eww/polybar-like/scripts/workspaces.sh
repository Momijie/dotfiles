#!/bin/sh

# Checks if a list ($1) contains an element ($2)
contains() {
    for e in $1; do
        [ "$e" -eq "$2" ] && echo 1 && return
    done
    echo 0
}

print_workspaces() {
    buf=""
    desktops=$(bspc query -D --names)
    focused_desktop=$(bspc query -D -d focused --names)
    occupied_desktops=$(bspc query -D -d .occupied --names)
    urgent_desktops=$(bspc query -D -d .urgent --names)
    japanese_numbers=("一" "二" "三" "四" "五" "六" "七" "八" "九" "十")
    for d in $desktops; do
        if [ "$(contains "$focused_desktop" "$d")" -eq 1 ]; then
            ws=$d
            icon="${japanese_numbers[$d-1]}"
            class="focused"
        elif [ "$(contains "$occupied_desktops" "$d")" -eq 1 ]; then
            ws=$d
            icon="${japanese_numbers[$d-1]}"
            class="occupied"
        elif [ "$(contains "$urgent_desktops" "$d")" -eq 1 ]; then
            ws=$d
            icon="${japanese_numbers[$d-1]}"
            class="urgent"
        else
            ws=$d
            icon="${japanese_numbers[$d-1]}"
            class="empty"
        fi

        buf="$buf (eventbox :cursor \"hand\" (button :class \"$class\" :onclick \"bspc desktop -f $ws\" \"$icon\"))"
    done

    echo "(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true $buf)"
}

# Listen to bspwm changes
print_workspaces
bspc subscribe desktop node_transfer | while read -r _ ; do
    print_workspaces
done
