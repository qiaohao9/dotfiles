if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'         " NerdTree
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'scrooloose/nerdcommenter'        " Quick to comment
  let g:NERDSpaceDelims            = 1 " Add spaces after comment delimiters by default
  let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
  let g:NERDCommentEmptyLines      = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDToggleCheckAllLines    = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not

Plug 'vim-airline/vim-airline'                 " Nvim status line
  let g:airline#extensions#tabline#enabled = 1 " Show tab

Plug 'yggdroot/indentline'
  let g:indentLine_conceallevel = 1
  let g:indentLine_char_list    = ['|', '¦', '┆', '┊']

Plug 'dracula/vim', { 'as': 'dracula' }            " Theme for dracula
Plug 'jiangmiao/auto-pairs'                        " Paris
Plug 'mrk21/yaml-vim'                              " YAML for nvim
Plug 'junegunn/vim-easy-align'                     " Auto Align
Plug 'cespare/vim-toml'                            " TOML for nvim
Plug 'elzr/vim-json'                               " JSON for nvim
call plug#end()

syntax  on
colorscheme dracula
