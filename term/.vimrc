set nocompatible
set nobackup
set nowritebackup
set noswapfile

" Explorer settings
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'

" Set path
set path=.,**

" Search options
set grepprg=grep\ -RIin\ --exclude=tags\ $*\ 2>/dev/null

" Search with rg if available
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --no-ignore-vcs\ --glob\ '!tags'\ --no-heading\ $*\ 2>/dev/null
    set grepformat=%f:%l:%c:%m
endif

" Custom command to search silently and open quickfix
command! -nargs=+ -complete=file Grep
    \ execute 'silent grep! <args>' | redraw! | cwindow

set dir=/tmp
set backupdir=/tmp

set scrolloff=3    " 3 lines displayed around cursor for scroll

" No delay when exiting visual mode
set timeoutlen=1000 ttimeoutlen=0

set listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<,eol:$

set ignorecase     " Case insensitive
set wildignorecase " Autocomplete case insensitive
set smartcase      " Enable case sensitivity if search contains upper letter
set hidden         " Enable caching on buffer switch

" Autocompletion
set wildmenu
set wildmode=list:longest,full

set background=dark

set novisualbell   " Prevent bell
set noerrorbells   " Prevent bell

" Default tabs count parameters
set tabstop=4
set shiftwidth=4
set expandtab

" Split on the right
set splitright
set splitbelow

" Enable file types and indents
filetype on
filetype plugin on
filetype indent on
set autoindent
set smartindent

" Improve completion
set completeopt=longest,menuone

" Disable syntax color
syntax off

" Common behavior for backspace
set backspace=indent,eol,start

" Save with sudo
command! W w !sudo tee % > /dev/null

" Reset to basic colors
highlight SignColumn ctermbg=none
highlight Error ctermbg=none ctermfg=red
highlight Todo ctermbg=none ctermfg=red
highlight Pmenu ctermbg=white
highlight PmenuSel ctermbg=gray ctermfg=black

" Autoread file if changes
set autoread
set updatetime=500

" Trigger autoread when files changes on disk
augroup FileChanged
    au!
    autocmd FocusGained, BufEnter, CursorHold, CursorHoldI * if mode() != 'c' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

augroup Lsp
    au!

    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-lang',
        \ 'cmd': {server_info->['gopls']},
        \ 'whitelist': ['go'],
        \ })

    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'intelephense',
        \ 'cmd': {server_info->['intelephense', '--stdio']},
        \ 'initialization_options': {'storagePath': expand('~/.intelephense-db')},
        \ 'whitelist': ['php'],
        \ })

    autocmd FileType go,php setlocal omnifunc=lsp#complete
    autocmd FileType go,php nmap <buffer> <C-t> <plug>(lsp-definition)
    autocmd FileType go,php nmap <buffer> gd <plug>(lsp-hover)
    autocmd FileType go,php nmap <buffer> gr <plug>(lsp-references)
    autocmd FileType go,php nmap <buffer> <F2> <plug>(lsp-rename)

    " Format on save
    autocmd BufWritePre *.go
        \  let s:save = winsaveview()
        \| exe 'keepjumps %!goimports 2>/dev/null || cat /dev/stdin'
        \| call lsp#ui#vim#document_format()
        \| call winrestview(s:save)

augroup END

" Lsp variables
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_hint = {'text' : '✓'}
let g:lsp_signs_information = {'text' : 'ℹ'}
let g:lsp_highlights_enabled = 0
let g:lsp_textprop_enabled = 0

" Bepo mappings
runtime settings/bepo.vim

" Allow to add additional configuration without needing to commit
runtime settings/local.vim
