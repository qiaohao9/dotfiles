if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'mrk21/yaml-vim'
Plug 'cespare/vim-toml'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()


" =====================
" Nerdtree Settings
" =====================
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>


syntax      on
colorscheme dracula

set number
set cursorline
set termguicolors
set noundofile
set nowrap
set nobackup
set noswapfile
set smartcase
set autoindent
set fileformat=unix
set textwidth=200
set tabstop=4
set shiftwidth=4
set encoding=utf-8
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


" ====================
" Html JavaScript CSS
" ====================
au BufNewFile,BufRead *.js, *.htm*, *.*css
  \ set tabstop=2
  \| set softtabstop=2
  \| set shiftwidth=2
  \| set expandtab


" ================
" Python Develop
" ================
au BufNewFile,BufRead *.py
  \ set textwidth=79
  \| set tabstop=4
  \| set softtabstop=4
  \| set shiftwidth=4
  \| set expandtab
