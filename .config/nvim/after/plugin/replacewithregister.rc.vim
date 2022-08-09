" REPLACE WITH REGISTER
" https://github.com/vim-scripts/ReplaceWithRegister
" https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m49
" [count]["x]gr{motion} = Replace {motion} text with the contents of register x.
"                         Especially when using the unnamed register, this is
"                         quicker than "_d{motion}P or "_c{motion}<C-R>"
" [count]["x]grr        = Replace [count] lines with the contents of register x.
"                         To replace from the cursor position to the end of the
"                         line use ["x]gr$
" {Visual}["x]gr        = Replace the selection with the contents of register x.
" Use gr for the default go references, used by LSP
" Mnemonic: TAB is like switch
nmap <leader>k  <Plug>ReplaceWithRegisterOperator
nmap <leader>kk <Plug>ReplaceWithRegisterLine
xmap <leader>k  <Plug>ReplaceWithRegisterVisual
nmap <leader>K  <leader>k$

