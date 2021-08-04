export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"
plugins=(git gh)
source $ZSH/oh-my-zsh.sh

# wsl-only logic
if [[ "$(uname -r | grep -c microsoft)" -eq "1" ]]; then
    . $HOME/.zshrc_wsl
fi

# linux-only logic
if [[ "$(uname -v | grep -c Ubuntu)" -eq "1" ]]; then
    . $HOME/.zshrc_ubuntu
fi

# go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# aliases
alias pip=pip3
alias python=python3
alias c=batcat
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dl='curl -LJO'

PATH=$PATH:~/bin:~/.local/bin
export EDITOR=vim
export VISUAL=$EDITOR
export GIT_EDITOR=$EDITOR

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

# osler
alias osl='docker-compose -f local.yml run --rm django'
alias oslman='docker-compose -f local.yml run --rm django python manage.py'
alias oslup='docker-compose -f local.yml up'
alias lint='pre-commit run --show-diff-on-failure --color=always --all-files'

# work
alias dsql='docker-compose exec postgres psql -U postgres'
alias makeh='clear && make 2>&1 | head'
alias make="make -j 8"

# create copy paste file used in .vimrc
touch $HOME/.vimbuffer

function search() {
    grep -Ril "$@" .
}
