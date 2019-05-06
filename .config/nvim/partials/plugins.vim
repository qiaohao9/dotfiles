if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }          " Theme for dracula
Plug 'scrooloose/nerdtree'
    autocmd vimenter * NERDTree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


Plug 'ncm2/ncm2'
Plug 'Shougo/neco-syntax'
Plug 'roxma/nvim-yarp'
    set completeopt=noinsert,menuone,noselect
    set shortmess+=c
    autocmd BufEnter * call ncm2#enable_for_buffer()

Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-syntax'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-cssomni'
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}

Plug 'vim-airline/vim-airline'                   " Nvim status line
    let g:airline#extensions#tabline#enabled = 1 " Show tab
Plug 'yggdroot/indentline'
    let g:indentLine_conceallevel = 1
    let g:indentLine_char_list    = ['|', '¦', '┆', '┊']
Plug 'lervag/vimtex'
    set conceallevel=1
    let g:tex_flavor           = 'latex'
    let g:vimtex_view_method   = 'zathura'
    let g:vimtex_quickfix_mode = 0
    let g:tex_conceal          = 'abdmg'
Plug 'sirver/ultisnips'
    inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')
    let g:UltiSnipsExpandTrigger            = "<Plug>(ultisnips_expand)"
    let g:UltiSnipsJumpForwardTrigger       = '<c-k>'
    let g:UltiSnipsJumpBackwardTrigger      = '<c-j>'
    let g:UltiSnipsRemoveSelectModeMappings = 0
    let g:UltiSnipsSnippetDirectories       = [$HOME.'/.config/nvim/UltiSnips']
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Golang
    let g:go_list_type                = "quickfix"
    let g:go_fmt_command              = "goimports"
    let g:go_def_mode                 = 'godef'
    let g:go_auto_type_info           = 1
    let g:go_highlight_types          = 1
    let g:go_highlight_extra_types    = 1
    let g:go_highlight_operators      = 1
    let g:go_highlight_fields         = 1
    let g:go_highlight_functions      = 1
    let g:go_highlight_function_calls = 1
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
Plug 'jiangmiao/auto-pairs'                        " Paris
Plug 'junegunn/vim-easy-align'                     " Auto Align
call plug#end()

syntax  on
colorscheme dracula

