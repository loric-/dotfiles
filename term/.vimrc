"
" General
"

set nocompatible

" Explorer settings
let g:netrw_liststyle=3
let g:netrw_localrmdir='rm -r'

set grepprg=grep\ -RIin\ --exclude=tags\ $*\ 2>/dev/null

set dir=/tmp
set backupdir=/tmp

set scrolloff=3    " 3 lines displayed around cursor for scroll

" No delay when exiting visual mode
set timeoutlen=1000 ttimeoutlen=0

set listchars=tab:>-,nbsp:.,trail:.,extends:>,precedes:<,eol:$

set ignorecase     " Case insensitive
set wildignorecase " Autocomplete case insensitive
set smartcase      " Enable case sensitivity if search contains upper letter
set incsearch      " Highlight search result while inputing
set hlsearch       " Highlight search results
set wildmenu       " Show possible completions on command line
set hidden         " Enable caching on buffer switch
set copyindent     " Preserve space/tab combination from previous line
set preserveindent " Preserve space/tab combination of current line when changing indent

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

" Disable syntax color
syntax off

" Common behavior for backspace
set backspace=indent,eol,start

" Autoread file if changes
set autoread
set updatetime=1000

"
" Remaps
"

" Save with sudo
command! W w !sudo tee % > /dev/null

"
" Plugin configurations
"

let g:go_fmt_command = "goimports"
let g:go_def_mapping_enabled = 0
let g:go_info_mode = "guru"
if has("autocmd")
    autocmd FileType go nmap <C-t> <Plug>(go-def)
    autocmd FileType go nmap g<C-t> <Plug>(go-def-pop)
endif

"
" Other
"

" Fundamental bepo mappings
runtime settings/bepo.vim

" Allow to add additional configuration without needing to commit
runtime settings/local.vim
