" ====[ NeoBundle ]====

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'airblade/vim-gitgutter'
Plugin 'gmarik/Vundle.vim'
Plugin 'jayflo/vim-skip'
Plugin 'jcf/vim-latex'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/unite.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
" Plugin 'Raimondi/delimitMate'

call vundle#end()
filetype plugin indent on

" ====[ Mappings ]====
" {{{
let mapleader=","
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>r :%s///g<left><left><left>

" Normal Mode
nnoremap : ;
nnoremap ; :
nnoremap n nzz
nnoremap N Nzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <silent> zd mIo<ESC>`I:delmarks I<CR>
nnoremap <silent> zu mIO<ESC>`I:delmarks I<CR>
nnoremap <SPACE> za
nnoremap j gj
nnoremap k gk
nnoremap <silent> <BS> :nohl<CR>:redraw<CR>
nnoremap Q @q
nnoremap Y y$

" Insert Mode
inoremap <silent> jj <ESC>:w<CR>

" Command Mode
cnoremap w!! w !sudo tee > /dev/null %
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" Visual Mode
vnoremap : ;
vnoremap ; :
vnoremap <C-r> <ESC>:%s/<C-r>=GetVisual()<CR>/
" }}}
" ====[ General Settings ]====
" {{{
let s:on_windows = has('win16') || has('win32') || has('win64')

" compatibility
set nocompatible
" moving around, searching and patterns
set nostartofline
set incsearch
set ignorecase
set smartcase
" displaying text
set scrolloff=8
set nowrap
set display=lastline
set fillchars=stl:-,vert:\|,fold:\ ,diff:-
set lazyredraw
set list
if &listchars ==# 'eol:$'
  set listchars=tab:»\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set number
set numberwidth=1
" syntax, highlighting and spelling
set background=dark
syntax enable
set nocursorline
call matchadd('ColorColumn', '\%81v', 100)
" multiple windows
set laststatus=2
set statusline=
set statusline+=%1*b%n%<%2*%f\ %3*%r%1*%m%*
set statusline+=%=
set statusline+=%-15(\ %1*%l%4*/%L%*,%c%V\ %)%-8(\ %1*%P%*\ %)%-8(\ %1*%Y%*\ %)
set hidden
set splitbelow
set splitright
" terminal
set ttyfast
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set t_Co=256
set noerrorbells
set visualbell
set t_vb=
" using the mouse
set mouse=a
set mousehide
" GUI
set guicursor+=n-i-ci-c:block-Cursor-blinkon850-blinkoff250
set guicursor+=ve:ver50-Cursor
set guicursor+=o:hor50-Cursor
set guicursor+=v-r-cr:hor20-Cursor
set guicursor+=sm:block-Cursor-blinkwait175-blinkoff150-blinkon175
set guifont=Monaco\ 12
set guioptions=ac
" messages and info
set shortmess+=Ia
set showcmd
set showmode
set ruler
" editing text
set undolevels=5000
set textwidth=80
set backspace=2
set backspace=indent,eol,start
set formatoptions-=t
set formatoptions+=r
set formatoptions+=l
set formatoptions+=j
set pumheight=7
augroup ft_autocomplete
    autocmd!
    autocmd FileType c setlocal omnifunc=ccomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END
" tabs and indenting
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set shiftround
set expandtab
set autoindent
set smartindent
" folding
set foldtext='\ \ +'.string(v:foldend-v:foldstart).'\ lines'
set foldmethod=marker
" reading and writing files
set fileformats=unix,dos,mac
set backup
set undofile
if s:on_windows
    set undodir=~/vimfiles/undo//
    set backupdir=~/vimfiles/backup//
else
    set undodir=~/.vim/undo//
    set backupdir=~/.vim/backup//
endif
set autoread
" the swap file
set noswapfile
set updatetime=500
" command line editing
set wildmode=list:longest,full
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.psd
set wildignore+=*.o,*.obj,*/.git,*.rbc,*.class,*/.svn,*.beam
set wildignore+=*.pdf,*.dvi
set wildmenu
" multi-byte characters
set encoding=utf-8
setglobal fileencoding=utf-8
" various
set viminfo=h,'50,<10000,s1000,/1000,:1000
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END
" }}}
" ====[ Colorscheme ]====
" {{{
colorscheme solarized
hi StatusLine ctermfg=8 ctermbg=10
hi StatusLineNC ctermfg=8 ctermbg=12
hi LineNr ctermfg=10 ctermbg=0
hi CursorLineNr ctermfg=4 ctermbg=0
hi Folded cterm=bold ctermbg=8 ctermfg=13
hi FoldedLineNr ctermbg=0
hi SignColumn ctermbg=8
hi ColorColumn ctermbg=0
hi SpellBad ctermfg=5 ctermbg=0 cterm=none
hi SpecialKey ctermfg=10 ctermbg=8 cterm=none
"statusline colors
hi User1 ctermfg=4
hi User2 ctermfg=15
hi User3 ctermfg=1
hi User4 ctermfg=10
" }}}
" ====[ Plugin Options ]====
" {{{
" Delimitmate
augroup sourceDelimeters
    autocmd!
    autocmd FileType javascript,c let b:delimitMate_expand_cr = 2
    autocmd FileType javascript,c let b:delimitMate_jump_expansion = 1
augroup END
let delimitMate_excluded_ft = "tex"

" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async', 'ignore_pattern',
            \ '\.local\/*\|\.config\/google*\|.vim/undo\|.vim/bundle\|.cache*\|node_modules\|bower_components\|fonts')
nnoremap <silent><leader>f :Unite -silent -start-insert file_rec/async:!:/home/jayflo/<CR>
nnoremap <silent><leader>s :Unite -silent -quick-match buffer<CR>
nnoremap <silent><Leader>y :Unite -silent history/yank<CR>

" Gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_realtime = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '+ '
let g:gitgutter_sign_removed = '--'
hi GitGutterAdd ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=1

" Neocomplete
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#data_directory = '~/.cache/neocomplete'
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
endfunction

" Latex-suite
set grepprg=grep\ -nH\ $*
let g:Tex_CompileRule_dvi='latex --src-specials --interaction=nonstopmode $*'
let g:Tex_CompileRule_pdf="pdflatex -file-line-error -synctex=1 -interaction=nonstopmode $*"
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats = "pdf,dvi"
let g:tex_flavor='latex'
let g:Tex_FoldedCommands=''
let g:Tex_FoldedEnvironments='abstract,vita'
let g:Tex_FoldedMisc=''
let g:Tex_FoldedSections='chapter,%%fakesection,section,subsection'
let g:Tex_ViewRule_dvi='okular --unique'
let g:Tex_ViewRule_pdf='okular --unique'
" }}}
" ====[ Functions ]====
" {{{
function! EscapeString (string)
    let string = a:string
    let string = escape(string, '^$.*\/~[]')
    let string = substitute(string, '\n', '\\n', 'g')
    return string
endfunction

function! GetVisual() range
    let reg_save = getreg('"')
    let regtype_save = getregtype('"')
    let cb_save = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', reg_save, regtype_save)
    let &clipboard = cb_save
    let escaped_selection = EscapeString(selection)
    return escaped_selection
endfunction
" }}}
