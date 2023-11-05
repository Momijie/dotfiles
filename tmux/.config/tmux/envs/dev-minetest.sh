#!/bin/bash
dev-minetest(){
    MINETEST_HOME="$HOME/Documents/dev-minetest"
    TMUX_SESSION="dev-minetest"
    TMUX_SOCKET="dev-minetest"

    is_session_running(){
        tmux -L $TMUX_SOCKET has-session -t $TMUX_SESSION > /dev/null 2>&1
    }

    if is_session_running; then
        echo "$TMUX_SESSION has a session running."
    else
        tmux -L $TMUX_SOCKET new-session -c $MINETEST_HOME -s $TMUX_SESSION -n Root -d
        tmux -L $TMUX_SOCKET new-window -c $MINETEST_HOME/minetest -t $TMUX_SESSION -n ls
        tmux -L $TMUX_SOCKET new-window -c $MINETEST_HOME -t $TMUX_SESSION -n  Etc
        tmux -L $TMUX_SOCKET send-keys -t $TMUX_SESSION:1 "tmux select-window -t 1 ; ; clear" Enter
    fi

    tmux -L $TMUX_SOCKET attach-session -t $TMUX_SESSION
}
