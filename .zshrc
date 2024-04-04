# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git gh docker docker-compose)
source $ZSH/oh-my-zsh.sh

# wsl-only logic
if [[ "$(uname -r | grep -c microsoft)" -eq "1" ]]; then
    . $HOME/.zshrc_wsl
fi

# linux-only logic
if [[ "$(uname -v | grep -c Ubuntu)" -eq "1" ]]; then
    . $HOME/.zshrc_ubuntu
fi

# macos-only logic
if [[ "$(uname | grep -c Darwin)" -eq "1" ]]; then
    . $HOME/.zshrc_macos
fi

# go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# atak
export JAVA_HOME=/opt/jdk-17.0.9+9
export PATH=$PATH:$JAVA_HOME/bin 
export PATH=$PATH:/opt/android-studio/bin

# aliases
alias vim=nvim
alias v=nvim
alias python=python3
alias c=batcat
alias s=sudo
alias lg=lazygit
alias dl='curl -LJO'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias kzoom='pgrep zoom | xargs kill -9 && nohup zoom >/dev/null </dev/null 2>&1&!'

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

kport () {
    port=":$1"
    kill -9 $(lsof -t -i  $port )
}

# osler
alias osl='docker-compose -f local.yml run --rm django'
alias oslman='docker-compose -f local.yml run --rm django python manage.py'
alias oslup='docker-compose -f local.yml up'
alias lint='pre-commit run --show-diff-on-failure --color=always --all-files'

# work
alias dsql='docker-compose exec postgres psql -U postgres'
alias makeh='clear && make 2>&1 | head'
alias make="make -j$(( $(nproc) - 2))"
alias ports="ss -ltup"

# use docker compose if docker-compose isn't installed
if ! command -v docker-compose &> /dev/null
then
    alias docker-compose="docker compose"
fi

# create copy paste file used in .vimrc
touch $HOME/.vimbuffer

search() {
    grep -Ril "$@" .
}
ununzip() {
    unzip -Z -1 "$@" | xargs -I{} rm -r -v {}
}

# pull branch to latest without checking out locally
bgpull() {
    git fetch origin $@:$@
}

mergeto() {
    git fetch . HEAD:$@
}

myip() {
    ip addr | grep "inet " | grep -v host | grep -v docker |
    cut -f1 -d"/" | sed 's/(.*?)[0-9]//g' | awk -F ' ' '{print $2}'
}

pyclean () {
    find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete
}

alias gfix='git commit --amend --no-edit'
alias gpushu='git push -u origin HEAD'
alias dps="docker ps -a --format='table {{.Names}}\t{{.Image}}\t{{.Status}}'"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Append this line to ~/.zshrc to enable fzf keybindings for Zsh:
source /usr/share/doc/fzf/examples/key-bindings.zsh

# Append this line to ~/.zshrc to enable fuzzy auto-completion for Zsh:
source /usr/share/doc/fzf/examples/completion.zsh


export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
