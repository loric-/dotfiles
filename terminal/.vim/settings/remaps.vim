" Custom Remaps
" ———————————————————————————————

" Remap <C-c> in visual for visual block
vnoremap <C-c> <Esc>
inoremap <C-c> <Esc>

" Remap exit terminal in neovim
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" Easily save
noremap <C-s> :w!<CR>

" Primary buffer copy paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Save with sudo
command! W w !sudo tee % > /dev/null

" Fold
nnoremap <leader><space> za
vnoremap <leader><space> zf

" Buffer shortcuts
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

" Remove highlight (<C-/> works as well)
nnoremap <C-_> :set hlsearch!<CR>

" Autocomplete remaps
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
inoremap <expr><CR> pumvisible() ? "\<C-y><Esc>" : "\<CR>"
inoremap <expr><Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr><c-c> pumvisible() ? "\<C-e>" : "\<c-c>"
