syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set relativenumber

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" run :PlugInstall to get plugins "
"call plug#begin('~/.vim/plugged')
"call plug#end()

set background=dark


" sudow - save with sudo when in readonly mode
cnoremap sudow w !sudo tee % >/dev/null


