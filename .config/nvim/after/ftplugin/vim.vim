setlocal foldmethod=marker
setlocal foldcolumn=1

" If less than 300 lines then no folding
if line('$') < 300
    setlocal foldlevel=99
else
    setlocal foldlevel=1
endif
