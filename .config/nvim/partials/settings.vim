if has('clipboard')
	if has('unnamedplus')
		set clipboard=unnamed,unnamedplus
	else
		set clipboard=unnamed
	endif
endif

set title
set number
set cursorline
set termguicolors

set incsearch
set smartcase
set ignorecase
set mouse=a
set showmatch
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽

set nostartofline
set noundofile
set noswapfile
set nobackup
set nowritebackup

set breakindent
set smartindent
set autoindent

set fileformat=unix
set fileencoding=utf-8

set tabstop=4
set shiftwidth=4
set expandtab
