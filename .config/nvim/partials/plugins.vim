if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -Flo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/jenegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'              " NerdTree
Plug 'Xuyuanp/nerdtree-git-plugin'      " NerdTree git plugin
	nnoremap <Leader>ft :NERDTreeToggle<CR>
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

Plug 'junegunn/vim-easy-align'          " Auto Align
	xmap ga <Plug>(EasyAlign)
	nmap ga <Plug>(EasyAlign)

Plug 'vim-airline/vim-airline'          " Nvim status line
	let g:airline#extensions#tabline#enabled = 1

Plug 'dracula/vim', { 'as': 'dracula' } " Theme for dracula
Plug 'jiangmiao/auto-pairs'             " Paris
Plug 'mrk21/yaml-vim'   " YAML for nvim
Plug 'cespare/vim-toml' " TOML for nvim
Plug 'elzr/vim-json'    " JSON for nvim
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }  " Golang
call plug#end()

syntax      on
colorscheme dracula

