export ZSH="/home/brian/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(git gh)
source $ZSH/oh-my-zsh.sh

#vim mode with esc
#set -o vi

# go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# aliases
alias clip=clip.exe
alias xclip=clip.exe
alias cls=clear
alias pip=pip3
alias python=python3
alias open=wsl-open
alias c=batcat
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dl='curl -LJO'

export WIN="/mnt/c/Users/brian"
alias cdh='cd $WIN'
alias cduas='cd /mnt/c/Users/brian/uas'

PATH=$PATH:~/bin:~/.local/bin
EDITOR=vim

# fix wsl not going to ~ on launch
if [ "$(pwd)" = '/mnt/c/Users/brian' ]; then
    cd ~
fi

# use ctrl+e to edit command in vim buffer
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

alias osl='docker-compose -f local.yml run --rm django'
alias oslman='docker-compose -f local.yml run --rm django python manage.py'
alias oslup='docker-compose -f local.yml up'
alias lint='pre-commit run --show-diff-on-failure --color=always --all-files'

touch $HOME/.vimbuffer

function search() {
    grep -Ril "$@" .
}
