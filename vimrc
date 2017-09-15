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
ab rep for(int i=0; i<n; i++)
au BufNewFile *.cpp 0r ~/.header

map <F9> :sil call DebugRun()<CR>
imap <F9> <Esc><F9>
map <F10> :sil call Run()<CR>
imap <F10> <Esc><F10>
map <F5> :sil call TestRun()<CR>
imap <F5> <Esc><F5>

function! Run()
    winc l
    winc k
    w
    winc h
    w
    only
    !(time ./%< <%<.in >%<.out)2>>%<.out
    bel vs %<.in
    bel sv %<.out
    winc h
    redr
    colo desert
endfunc

function! CompileRun()
    winc l
    winc k
    w
    winc h
    w
    only
    let v:statusmsg = ''
    make
    if empty(v:statusmsg)
        call Run()
    else
        cw
        winc k
        redr
        colo desert
    endif
endfunc

function! DebugRun()
    set makeprg=g++\ %\ -Wall\ -g\ -o\ %<\ -DSONG
    call CompileRun()
endfunc

function! TestRun()
    set makeprg=g++\ %\ -Wall\ -O2\ -o\ %<
    call CompileRun()
endfunc
