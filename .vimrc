set nocompatible
syntax on
colo desert
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent
set ruler
set expandtab
set backspace=indent,eol,start
ab mp make_pair
ab pub push_back
ab pi pair<int, int>
au BufNewFile *.cpp 0r ~/.header
set makeprg=g++\ %\ -Wall\ -o\ %<\ -DSONG

map <F5> :sil call Test()<CR>
map <F9> :sil call Cmp()<CR>
map <F10> :sil call Run()<CR>
imap <F5> <Esc><F5>
imap <F9> <Esc><F9>
imap <F10> <Esc><F10>

function Set()
    winc l
    winc k
    w
    winc h
    w
    only
endfunc
function Run()
    call Set()
    !(time ./%< <%<.in >%<.out)2>>%<.out
    bel vs %<.in
    bel sv %<.out
    winc h
    colo desert
endfunc
function Cmp()
    call Set()
    let v:statusmsg=''
    make
    if empty(v:statusmsg)
        call Run()
    else
        cw
        winc k
        colo desert
    endif
endfunc

function Test()
    set makeprg=g++\ %\ -Wall\ -o\ %<\ -O2
    call Cmp()
    set makeprg=g++\ %\ -Wall\ -o\ %<\ -DSONG
endfunc