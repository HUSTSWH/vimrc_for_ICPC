set nocompatible
syntax on
colo morning
set nu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set cindent
set ruler
set expandtab
set backspace=indent,eol,start
ab mp make_pair
ab pb push_back
ab pi pair<int, int>
ab rep for(int i=0; i<n; i++)
au BufNewFile *.cpp 0r ~/.header

set makeprg=g++\ %\ -Wall\ -g\ -o\ %<\ -DSONG
map <F9> :sil call CompileRun()<CR>
imap <F9> <Esc><F9>
map <F10> :sil call Run()<CR>
imap <F10> <Esc><F10>
function! Run()
    !(time ./%< <%<.in >%<.out)2>>%<.out
    bel vs %<.in
    bel sv %<.out
    winc h
    redr
    colo morning
endfunc
function! CompileRun()
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
        colo morning
    endif
endfunc
