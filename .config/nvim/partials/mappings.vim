let mapleader=" "
set timeoutlen=501

" nerdtree
map <C-n> :NERDTreeToggle<CR>

" Move between windows
nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l

" Move from tabs
nnoremap <C-H> :tabprevious<CR>
nnoremap <C-L> :tabnext<CR>

" Auto Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Golang
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" NCM2
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <s-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC> 

" Ultisnips
let g:UltiSnipsJumpForwardTrigger       = '<c-k>'
let g:UltiSnipsJumpBackwardTrigger      = '<c-j>'

