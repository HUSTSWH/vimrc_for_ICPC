set nocompatible
"set mouse=a
set backspace=start,eol,indent

syntax on
colorscheme slate
set number ruler hlsearch

set cindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

abbreviate mp make_pair
abbreviate pub push_back
abbreviate pi pair<int, int>
autocmd BufNewFile *.cpp 0r ~/head.cpp
autocmd BufNewFile *.py 0r ~/head.py
set makeprg=g++\ %\ -o%<\ -Wall\ -std=c++14\ -DLOCAL\ -g

nnoremap <F5> :silent call Test()<CR>
nnoremap <F9> :silent call Cmp()<CR>
nnoremap <F10> :silent call Run()<CR>
inoremap <F5> <Esc>:silent call Test()<CR>
inoremap <F9> <Esc>:silent call Cmp()<CR>
inoremap <F10> <Esc>:silent call Run()<CR>

nnoremap <F7> :call Py()<CR>
inoremap <F7> <Esc>:call Py()<CR>

function Py()
    write
    !python3 %
endfunc

function Set()
    if winnr('$')>1
        wincmd l
        wincmd k
        write
        wincmd t
        only
    endif
    write
endfunc

function Run()
    call Set()
    !(time ./%< <%<.in >%<.out)2>>%<.out
    belowright vsplit %<.in
    belowright sview %<.out
    wincmd t
    redraw!
endfunc

function Cmp()
    call Set()
    let v:statusmsg=''
    make
    if empty(v:statusmsg)
        call Run()
    else
        cwindow
        winc t
        redraw!
    endif
endfunc

function Test()
    set makeprg=g++\ %\ -o\ %<\ -Wall\ -std=c++14\ -O2
    call Cmp()
    set makeprg=g++\ %\ -o\ %<\ -Wall\ -std=c++14\ -DLOCAL\ -g
endfunc


