" Custom Remaps
" ———————————————————————————————

" Remap esc to avoid delay
imap <Esc> <C-c>

" Save and quit shortcuts
noremap w :w!<CR>
noremap q :q!<CR>
noremap <Leader>q :qa!<CR>

" Primary buffer copy paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Remap jump to/from tags
nnoremap <C-t> <C-]>
nnoremap g<C-t> <C-t>

" Save with sudo
command! W w !sudo tee % > /dev/null

" Fold
nnoremap <leader><space> za
vnoremap <leader><space> zf

" Buffer shortcuts
nnoremap e :e#<CR>
nnoremap n :bnext<CR>
nnoremap p :bprev<CR>
nnoremap d :bd!<CR>

" Remaper la gestion des fenêtres
" ———————————————————————————————
noremap t <C-w>j
noremap s <C-w>k
noremap c <C-w>h
noremap r <C-w>l
noremap o <C-w>o
noremap - :split<CR>
noremap b :vsplit<CR>
