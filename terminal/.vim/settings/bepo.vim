" Bepo related configurations
" ———————————————————————————————

" Variable to hold the enable status
let g:bepo = 0

nmap <F4> :call ToggleBepo()<CR>

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
        noremap w <C-w>
        noremap W <C-w><C-w>

        noremap wt <C-w>j
        noremap ws <C-w>k
        noremap wc <C-w>h
        noremap wr <C-w>l
        noremap wo <C-w>o

        noremap wC <C-w><
        noremap wT <C-W>-
        noremap wS <C-W>+
        noremap wR <C-w>>

        noremap w- :split<CR>
        noremap wb :vsplit<CR>
    else
        unmap w
        unmap W

        unmap wt
        unmap ws
        unmap wc
        unmap wr
        unmap wo

        unmap wC
        unmap wT
        unmap wS
        unmap wR

        unmap w-
        unmap wb
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

" Activate bepo by default
call Bepo(1)
