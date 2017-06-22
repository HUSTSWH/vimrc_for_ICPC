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
map <F9> :call CompileRun()<CR>
imap <F9> <Esc>:call CompileRun()<CR>
ab mp make_pair
ab pb push_back
ab pi pair<int, int>
ab rep for(int i=0; i<n; i++)
ab SONG #ifdef SONG<CR>puts("debug:");<CR><CR>puts("");#endif
ab header #include <cstdio><CR>#include <cstring><CR>#include <algorithm><CR>#include <functional><CR>#include <string><CR>#include <queue><CR>#include <stack><CR>#include <map><CR>#include <vector><CR>#include <list><CR>using namespace std;<CR><CR>
ab main int main()<CR>{<CR>return 0;<CR>}

set makeprg=g++\ %\ -Wall\ -g\ -o\ %<\ -DSONG

function! Run()
    echohl WarningMsg | echo " running..."
    silent echo "!(time ./%< <%<.in >%<.out)2>>%<.out"
    vsplit %<.in
    silent bel sview %<.out
    wincmd l
    redraw
    colo morning
endfunc

function! CompileRun()
    w
    only
"    !g++ % -Wall -g -o %< -DSONG 2>.error
    echohl WarningMsg | echo " compiling..."
    let v:statusmsg = ''
    silent make
    if empty(v:statusmsg)
        call Run()
    else
        bo cw
        wincmd k
        redraw
        colo morning
    endif
endfunc


