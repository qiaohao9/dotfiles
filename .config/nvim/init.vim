" ======================
" Auto download vim-plug
" ======================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ========================
" Vim Copy-Paste to System
" ========================
if has('clipboard')
    if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
    else
        set clipboard=unnamed
    endif
endif

" ================
" Set environments
" ================
set hidden
set title
set number
set cursorline
set termguicolors
set mouse=a

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

" ================
" Vim-plug plugins
" ================
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
    autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
Plug 'vim-airline/vim-airline'                   " Nvim status line
    let g:airline#extensions#tabline#enabled = 1 " Show tab
Plug 'yggdroot/indentline'
    let g:indentLine_conceallevel = 1
    let g:indentLine_char_list    = ['|', '¦', '┆', '┊']

Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Golang
    let g:go_list_type                = 'quickfix'
    let g:go_fmt_command              = 'goimports'
    let g:go_def_mode                 = 'godef'
    let g:go_term_mode                = 'split'
    let g:go_term_height              = 5
    let g:go_doc_max_height           = 40
    let g:go_auto_type_info           = 1
    let g:go_highlight_types          = 1
    let g:go_highlight_extra_types    = 1
    let g:go_highlight_operators      = 1
    let g:go_highlight_fields         = 1
    let g:go_highlight_functions      = 1
    let g:go_highlight_function_calls = 1
    let g:go_def_mapping_enabled      = 0
    let g:go_doc_keywordprg_enabled   = 0
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
Plug 'SirVer/ultisnips'
   let g:UltiSnipsRemoveSelectModeMappings = 0
   let g:UltiSnipsSnippetDirectories       = [$HOME.'/.config/nvim/UltiSnips']
Plug 'honza/vim-snippets'

Plug 'lervag/vimtex'
    set conceallevel=1
    let g:tex_flavor           = 'latex'
    let g:vimtex_quickfix_mode = 0
    let g:tex_conceal          = 'abdmg'
Plug 'arcticicestudio/nord-vim', {'as': 'nord'} " Theme for Nord
    let g:nord_italic_comments = 1
    let g:nord_uniform_status_lines = 1
    let g:nord_bold_vertical_split_line = 1

Plug 'dracula/vim', { 'as': 'dracula' }         " Theme for dracula
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'                     " Paris
Plug 'junegunn/vim-easy-align'                  " Auto Align
Plug 'thirtythreeforty/lessspace.vim'
call plug#end()

filetype on
syntax on
colorscheme nord

" ====================
" Mapping keys binding
" ====================
let mapleader = ' '
map <c-n> :NERDTreeToggle<CR>

" Move between windows
nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l

" Auto Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
