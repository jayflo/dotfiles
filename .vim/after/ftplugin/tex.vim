augroup tex_after
    autocmd!
    autocmd BufWritePre <buffer> :%s/\(\\]\)\s\+$/\1/e
    autocmd FileType tex :NoMatchParen
augroup END
setlocal wrap nolist
" setlocal linebreak
setlocal formatoptions-=j
setlocal formatoptions+=t
setlocal formatoptions+=w
setlocal formatoptions+=a
setlocal foldtext=TexFoldText()
setlocal spell
setlocal nocursorline
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add

nnoremap <buffer> <leader>ll :silent! call Tex_RunLaTeX()<CR>
imap <buffer> <Tab> <Plug>IMAP_JumpForward
imap <buffer> <S-Tab> <Plug>IMAP_JumpBack
inoremap <buffer> <C-j> <C-w>j

function! TexFoldText()
    let l:line = matchstr(getline(v:foldstart),'^\S\{-}{\zs.\{-}\ze}')
    let l:newline = '['.string(v:foldend-v:foldstart).' lines] '.l:line
    return l:newline
endfunction
