" Bepo related configurations
" ———————————————————————————————

" Variable to hold the enable status
let g:bepo = 0

nmap <F4> :call ToggleBepo()<CR>
nmap <F5> :call BepoStatus()<CR>

function Bepo(enable)
    let g:bepo = a:enable

    " Use é and è
    if a:enable
        noremap é w
        noremap É W
        noremap è ^
        noremap È 0
    else
        unmap é
        unmap É
        unmap è
        unmap È
    endif

    " Remap text objects with é
    if a:enable
        onoremap aé aw
        onoremap aÉ aW
        onoremap ié iw
        onoremap iÉ iW
        vnoremap aé aw
        vnoremap aÉ aW
        vnoremap ié iw
        vnoremap iÉ iW
    else
        ounmap aé
        ounmap aÉ
        ounmap ié
        ounmap iÉ
        vunmap aé
        vunmap aÉ
        vunmap ié
        vunmap iÉ
    endif

    " Use w for windows manipulations
    if a:enable
        noremap <C-w>C <C-w>H
        noremap <C-w>T <C-W>J
        noremap <C-w>S <C-W>K
        noremap <C-w>R <C-w>L

        noremap <C-w>t <C-w>j
        noremap <C-w>s <C-w>k
        noremap <C-w>c <C-w>h
        noremap <C-w>r <C-w>l

        noremap <C-w>- <C-w>s
        noremap <C-w>/ <C-w>v
    else
        unmap <C-w>C
        unmap <C-w>T
        unmap <C-w>S
        unmap <C-w>R

        unmap <C-w>t
        unmap <C-w>s
        unmap <C-w>c
        unmap <C-w>r

        unmap <C-w>-
        unmap <C-w>/
    endif

    " hjkl -> ctsr
    if a:enable
        noremap c h
        noremap r l
        noremap t j
        noremap s k
        noremap C H
        noremap R L
        noremap T J
        noremap S K
        noremap zs zk
        noremap zt zj
    else
        unmap c
        unmap r
        unmap t
        unmap s
        unmap C
        unmap R
        unmap T
        unmap S
        unmap zs
        unmap zt
    endif

    " hjkl <- ctsr
    if a:enable
        noremap j t
        noremap J T
        noremap l c
        noremap L C
        noremap h r
        noremap H R
        noremap k s
        noremap K S
        noremap ]k ]s
        noremap [k [s
    else
        unmap j
        unmap J
        unmap l
        unmap L
        unmap h
        unmap H
        unmap k
        unmap K
        unmap ]k
        unmap [k
    endif

    " Remap g keymaps
    if a:enable
        noremap gs gk
        noremap gt gj
        noremap gb gT
        noremap gé gt
        noremap gB :exe "silent! tabfirst"<CR>
        noremap gÉ :exe "silent! tablast"<CR>
        noremap g" g0
    else
        unmap gs
        unmap gt
        unmap gb
        unmap gé
        unmap gB
        unmap gÉ
        unmap g"
    endif

    " Move around in code
    if a:enable
        nmap «« [[
        nmap »» ]]
    else
        unmap ««
        unmap »»
    endif

    " Remap jump to/from tags
    if a:enable
        nnoremap <C-t> g<C-]>
        nnoremap g<C-t> <C-t>
    else
        nunmap <C-t>
        nunmap g<C-t>
    endif


    " Autocmd
    if has("autocmd")
        " Ex file explorer
        if a:enable
            autocmd filetype netrw call ExBepo()
        else
            autocmd! filetype netrw
        endif
    endif

endfunction

" Remap when in Ex file explorer
function ExBepo()
    noremap <buffer> t j
    noremap <buffer> s k
    noremap <buffer> k s
endfunction

function ToggleBepo()
    if g:bepo == 0 
        call Bepo(1)
        echo "Bepo has been enabled"
    else
        call Bepo(0)
        echo "Bepo has been disabled"
    endif
endfunction

function BepoStatus()
    if g:bepo == 0 
        echo "Bepo is disabled"
    else
        echo "Bepo is enabled"
    endif
endfunction

" Activate bepo by default
call Bepo(1)
