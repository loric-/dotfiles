" VIM Configuration 
" ———————————————————————————————

" General configurations
runtime settings/general.vim
" Keybindings and custom remaps
runtime settings/remaps.vim
" Fundamental bepo mappings
runtime settings/bepo.vim
" Plugins and plugins related configurations
runtime settings/plugins.vim

" Allow to add additional configuration without needing to commit
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
