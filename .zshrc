export ZSH="/home/brian/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(git)
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

alias cdh='cd /mnt/c/Users/brian'
alias cduas='cd /mnt/c/Users/brian/uas'

PATH=$PATH:~/bin:~/.local/bin
EDITOR=vim

# fix wsl not going to ~ on launch
if [ "$(pwd)" = '/mnt/c/Users/brian' ]; then
    cd ~
fi


alias osl='docker-compose -f local.yml run --rm django'
alias oslman='docker-compose -f local.yml run --rm django python manage.py'
alias oslup='docker-compose -f local.yml up'
alias lint='pre-commit run --show-diff-on-failure --color=always --all-files'


function search() {
    grep -Ril "$@" .
}
