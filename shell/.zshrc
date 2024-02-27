[[ $- != *i* ]] && return

function zsh () {
    ZSH_THEME="satori"
    HISTSIZE=1000
    SAVEHIST=1000
    HISTFILE=~/.zhistory
    plugins=(git z)
}

function sources () {
    source $ZSH/oh-my-zsh.sh
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
    source ~/.zshalias
    #for file in $(find ~/.config/shell/ -maxdepth 1 -type f); do
    #    source "$file"
    #done

    if [ -d $HOME/.config/tmux/envs/ ];then
        for file in $(find $HOME/.config/tmux/envs/ -maxdepth 1 -type f); do
            source "$file"
        done
    fi
}

function neofetch_run () {
    LIVE_COUNTER=$(ps a | awk '{print $2}' | grep -vi "tty*" | uniq | wc -l);
    if [ $LIVE_COUNTER -eq 1 ]; then
        neofetch
    fi
}

function main () {
    zsh
    sources
    neofetch_run
}

main
