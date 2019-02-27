let mapleader=" "
set timeoutlen=500

" NerdTree hook
nnoremap <Leader>ft :NERDTreeToggle<CR>

"" Move between windows
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

" Switch buffers
nnoremap <Leader>bp :bprev<Return>
nnoremap <Leader>bn :bnext<Return>

" Auto Align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

