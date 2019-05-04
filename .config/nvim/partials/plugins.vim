if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }        " Theme for dracula
Plug 'vim-airline/vim-airline'                 " Nvim status line
    let g:airline#extensions#tabline#enabled = 1 " Show tab
Plug 'yggdroot/indentline'
    let g:indentLine_conceallevel = 1
    let g:indentLine_char_list    = ['|', '¦', '┆', '┊']
Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
    set conceallevel=1
    let g:tex_conceal='abdmg'
Plug 'sirver/ultisnips'
    let g:UltiSnipsExpandTrigger = '<tab>'
    let g:UltiSnipsJumpForwardTrigger = '<tab>'
    let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
    let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/UltiSnips']

Plug 'jiangmiao/auto-pairs'                        " Paris
Plug 'junegunn/vim-easy-align'                     " Auto Align
call plug#end()

syntax  on
colorscheme dracula

