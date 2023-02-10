source ~/.vimrc

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


let mapleader = ' '

set nobackup
set nowritebackup

" ================
" Vim-plug plugins
" ================
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
    let g:NERDCreateDefaultMappings = 0
    let g:NERDSpaceDelims = 1
    let g:NERDCompactSexyComs = 1
    let g:NERDDefaultAlign = 'left'
    let g:NERDAltDelims_java = 1
    let g:NERDCommentEmptyLines = 1
    let g:NERDTrimTrailingWhitespace = 1
    let g:NERDToggleCheckAllLines = 1

    let s:uname = system('uname -s')
    if s:uname == 'Linux'
        nnoremap <silent> <c-_> <Plug>NERDCommenterToggle<CR>
        vnoremap <silent> <c-_> <Plug>NERDCommenterToggle<CR>gv
    else
        nnoremap <silent> <c-/> <Plug>NERDCommenterToggle<CR>
        vnoremap <silent> <c-/> <Plug>NERDCommenterToggle<CR>gv
    endif

Plug 'scrooloose/nerdtree'
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
    let g:NERDTreeDirArrowExpandable = '+'
    let g:NERDTreeDirArrowCollapsible = '-'
    let g:NERDTreeHidden = 1

    nnoremap <c-n> :NERDTreeToggle<CR>

    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
    " autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


Plug 'vim-airline/vim-airline'
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#buffer_nr_show = 0
    let g:airline#extensions#tabline#formatter = 'default'
    " let g:airline_symbols.linenr = "CL"
    " let g:airline_symbols.maxlinenr = "ML"
    let g:airline_symbols.whitespace = "|"
    let g:airline_symbols.branch = "BR"
    let g:airline_symbols.readonly = "RO"

Plug 'yggdroot/indentline'
    let g:indentLine_conceallevel = 1
    let g:indentLine_char_list    = ['|', '¦', '┆', '┊']



Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = ['coc-go', 'coc-pyright', 'coc-rust-analyzer', 'coc-git']
    nmap <silent> <leader>gd <Plug>(coc-definition)
    nmap <silent> <leader>gi <Plug>(coc-implementation)
    nmap <silent> <leader>gr <Plug>(coc-references)
    nmap <silent> <leader>fc <Plug>(coc-format-selected)
    xmap <silent> <leader>fc <Plug>(coc-format-selected)
    nmap <silent> <leader>rn <Plug>(coc-rename)
    nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>
    nnoremap <silent> [g <Plug>(coc-diagnostic-pre)
    nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif
    inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
    inoremap <silent><expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
          call CocActionAsync('doHover')
        else
          execute '!' . &keywordprg . " " . expand('<cword>')
        endif
    endfunction

    function! CheckBackspace() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    function! ShowDocumentation()
        if CocAction('hasProvider', 'hover')
          call CocActionAsync('doHover')
        else
          call feedkeys('K', 'in')
        endif
    endfunction

Plug 'dense-analysis/ale'
    let g:ale_set_highlights = 1
    let g:ale_set_quickfix = 1
    let g:ale_echo_msg_error_str = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_lint_on_enter = 1

    nmap sp <Plug>(ale_previous_wrap)
    nmap sn <Plug>(ale_next_wrap)

Plug 'easymotion/vim-easymotion'
    nmap ss <Plug>(easymotion-s2)

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
    map <leader>f :Files<CR>
    map <leader>b :Buffers<CR>
    map <leader>r :Ag<CR>
    let g:fzf_action = { 'ctrl-e': 'edit' }

Plug 'junegunn/vim-easy-align'
    xmap ga <Plug>(EasyAlign)
    nmap ga <Plug>(EasyAlign)

Plug 'tpope/vim-surround'
Plug 'psliwka/vim-smoothie'
Plug 'farmergreg/vim-lastplace'
Plug 'arcticicestudio/nord-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'machakann/vim-highlightedyank'

call plug#end()

colorscheme nord


nmap <leader>1 :b 1<CR>
nmap <leader>2 :b 2<CR>
nmap <leader>3 :b 3<CR>
nmap <leader>4 :b 4<CR>
nmap <leader>5 :b 5<CR>
nmap <leader>6 :b 6<CR>
nmap <leader>7 :b 7<CR>
nmap <leader>8 :b 8<CR>
nmap <leader>9 :b 9<CR>
nmap <leader>q :bd<CR>

nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
