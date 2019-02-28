call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'         " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin' " NerdTree git plugin
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'scrooloose/nerdcommenter'        " Quick to comment
  let g:NERDSpaceDelims            = 1 " Add spaces after comment delimiters by default
  let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
  let g:NERDCommentEmptyLines      = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDToggleCheckAllLines    = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not

Plug 'vim-airline/vim-airline'                " Nvim status line
  let g:airline#extensions#tabline#enabled = 1 " Show tab

Plug 'ncm2/ncm2'                                   " Completion
Plug 'roxma/nvim-yarp'
  autocmd BufEnter * call ncm2#enable_for_buffer() " enable ncm2 for all buffers
  set completeopt=noinsert,menuone,noselect        " :help Ncm2PopupOpen for more information
Plug 'ncm2/ncm2-bufword'                           " Vim Buffer
Plug 'ncm2/ncm2-path'                              " Path
Plug 'ncm2/ncm2-cssomni'                           " CSS
Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}      " JavaScript
Plug 'ncm2/ncm2-jedi'                              " Python

Plug 'yggdroot/indentline'
  let g:indentLine_conceallevel = 1
  let g:indentLine_char_list    = ['|', '¦', '┆', '┊']

Plug 'dracula/vim', { 'as': 'dracula' }            " Theme for dracula
Plug 'jiangmiao/auto-pairs'                        " Paris
Plug 'mrk21/yaml-vim'                              " YAML for nvim
Plug 'junegunn/vim-easy-align'                     " Auto Align
Plug 'cespare/vim-toml'                            " TOML for nvim
Plug 'elzr/vim-json'                               " JSON for nvim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " Golang
call plug#end()

syntax  on
colorscheme dracula
