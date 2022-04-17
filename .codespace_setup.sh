echo 'typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet' >> ~/.zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
mkdir ~/bin
sh /workspaces/.codespaces/.persistedshare/dotfiles/bin/update-lf