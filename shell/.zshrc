[[ $- != *i* ]] && return

function exports () {
    export ZSH="$HOME/.oh-my-zsh"
    export EDITOR='nvim'
    # Shell scripts, rofi scripts, and bin.
    export PATH="$PATH:$HOME/.config/shell/scripts:$HOME/.config/rofi/scripts":$HOME/.local/bin
    export GITHUB="https://github.com/Momijie"
}
function zsh () {
    ZSH_THEME="satori"
    HISTSIZE=1000
    SAVEHIST=1000
    HISTFILE=~/.zhistory
    plugins=(git)
}

function sources () {
    source colors
    source $ZSH/oh-my-zsh.sh
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh

    for file in $(find ~/.config/shell/ -maxdepth 1 -type f); do
        source "$file"
    done
}

function neofetch_run () {
    LIVE_COUNTER=$(ps a | awk '{print $2}' | grep -vi "tty*" | uniq | wc -l);
    if [ $LIVE_COUNTER -eq 1 ]; then
        neofetch
    fi
}

function main () {
    exports
    zsh
    sources
    neofetch_run
}

main
