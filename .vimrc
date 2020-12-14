" ================
" Set environments
" ================
set hidden
set title
set number
set cursorline
set termguicolors
set t_Co=256
" set mouse=a

set incsearch
set smartcase
set ignorecase
set showmatch

set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽

set noundofile
set noswapfile
set nobackup
set nowritebackup

set breakindent
set smartindent
set autoindent
set autowrite

set tabstop=4
set shiftwidth=4
set expandtab

set fileformat=unix
set fileencoding=utf-8
set termencoding=utf-8

set shortmess+=c
set signcolumn=yes
set nowrap

filetype    on
syntax      on

autocmd! BufNewFile, BufRead Dvcfile, *.dvc setfiletype yaml
au BufRead, BufNewFile *.yaml, *.json, *.yml, *.js, *.html, *.css set tabstop=2 | set shiftwidth=2
au BufRead, BufNewFile *.go,Makefile set noexpandtab
