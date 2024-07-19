
-- " This function sets up the opfunc so it can be repeated with a dot.
-- " Align to Column works by moving the next none whitespace character to the
-- " desired columned. e.g. 32<hotkey> will align the next none whitespace
-- " character to column 32. Then press dot to repeat the operation.
-- function! myal#SetupAlignToColumn(col)
--     if v:count != 0
--         let w:myal_align_col = v:count
--     endif
--     set opfunc=myal#AlignToColumn
--     return 'g@l'
-- endfunction
-- function! myal#AlignToColumn(motion)
--     " Get cursor to just before next none space
--     let reg_backup_value = getreg('z')    " Backup the contents of the unnamed register
--     let reg_backup_type = getregtype('z')      " Save the type of the register as well
--     let l:winview = winsaveview()
--     let cmd = 'normal wh'.w:myal_align_col.'a'."\<SPACE>\<ESC>".'"zd'.(w:myal_align_col - 1).'|'
--     exe cmd
--     call winrestview(l:winview)
--     call setreg('z', reg_backup_value, reg_backup_value) " Restore register
--     normal j
-- endfunction


-- Commenting - Built in Neovim comments, by default is gc - see :help commenting
-- gc comment/uncomment
-- gcc comment/uncomment line
-- gcgc uncoment a continous block of lines
-- gcO comment above
-- gcO comment below
-- gcA comment append

--
-- " MACROS
--
-- " Python variable to dict (repeatable with dot)
-- " Dict form: 'foo' : 'bar',
-- " Var form:    foo = 'bar'
-- nnoremap <expr> <leader>{ myal#PythonVar2Dict()
-- nnoremap <expr> <leader>} myal#PythonVar2Dict()
-- " " Python dict to variable (repeatable with dot)
-- nnoremap <expr> <leader>= myal#PythonDict2Var()

-- Escape
-- Occasionally have to press escape twice, might of been due to close Neogit mapping, ready if it wasnt...
-- vim.keymap.set('', '<ESC>', '<ESC><ESC>', { noremap = true })
-- vim.keymap.set('!', '<ESC>', '<ESC><ESC>', { noremap = true })

-- Keyboard volume up and down and down to no operation
-- vim.keymap.set('', '<C-Space>', '<nop>', { noremap = true })
-- vim.keymap.set('!', '<C-Space>', '<nop>', { noremap = true })

-- VISUAL 

--
-- Move a block of text with SHIFT+arrows
-- https://vim.fandomcom/w.iki/Drag_words_with_Ctrl-left/right
-- xnoremap <S-Right>  pgvloxlo
-- xnoremap <S-left>   hPgvhxoho
-- xnoremap <S-Down>   jPgvjxojo
-- xnoremap <S-Up>     xkPgvkoko
--
-- vv to visual select to end of line without select the $
-- vnoremap v $h
--
-- swap the words `light` and `dark` in visual range, useful for light/dark
-- theme dev.
-- vnoremap <leader>s :s/dark/zzz/ge<CR>gv:s/light/dark/ge<CR>gv:s/zzz/light/ge<CR>
--
-- Sometimes in visual mode when trying to run commands with leader, exit vmode first
-- vmap <leader> <ESC><ESC><leader>
--
-- " {{{2 Searching & replacing
-- " https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m48s
-- " He uses a plugin to achieve this.
-- " Mapped with visual mode so that can use the mouse and press *
-- " In visual mode press * to search for the current selected region y = yank visual range into the " buffer
-- "   / = start search
-- "   \V = very NO magic
-- "   <C-R> = CTRL+R to paste from " buffer
-- "   escape = escape the / and \ which are the only none literals in no magic
-- xnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
-- xnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>
--
-- " https://www.youtube.com/watch?v=fP_ckZ30gbs&t=07m36s
-- " Press * to search for the term under the cursor or a visual selection and
-- " then press a key below to replace all instances of it in the current file.
-- noremap <Leader>rr :%s///g<Left><Left>
-- noremap <Leader>rc :%s///gc<Left><Left><Left>
--
-- " xnoremap <Leader>rc :s///gc<Left><Left><Left>
-- " https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m25s
-- " Similar to above, but in visual mode search within current selected region
-- " for the previously search term. No need to add the '<,'> as it will be auto
-- " added.
-- xnoremap <Leader>rr :s///g<Left><Left>
-- xnoremap <Leader>rc :s///gc<Left><Left><Left>
--
-- " Speed substitue whole file
-- noremap <leader>/ :%s//g<Left><Left>
-- " Speed substitue line
-- noremap <leader>? :s//g<Left><Left>
--
-- " Speed substitue visual mode
-- xnoremap <leader>/ :s//g<Left><Left>
-- xnoremap <leader>? :s//g<Left><Left>
--
--
-- " {{{2 Popup Menu
-- inoremap <expr> <C-J> pumvisible() ? "\<C-n>" : "\<C-J>"
-- inoremap <expr> <C-K> pumvisible() ? "\<C-p>" : "\<C-K>"
-- " Allow remap for rgflow <CR> in insert mode.
-- imap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<Cr>"
--
-- " Use <Tab> and <S-Tab> to navigate through popup menu
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
--
-- {{{2 Copy & paste
-- Copy to system clipboard
-- xnoremap  <leader>y  "+y
-- nnoremap  <leader>Y  "+yg_
-- nnoremap  <leader>y  "+y
-- nnoremap  <leader>yy  "+yy
--
-- " Paste from clipboard
-- nnoremap <leader>p "+p
-- nnoremap <leader>P "+P
-- xnoremap <leader>p "+p
-- xnoremap <leader>P "+P
--
-- Paste from last copied
-- nnoremap <leader>p "0p
-- nnoremap <leader>P "0P
--
-- {{{2 Terminal mode
-- <ESC> to exit terminal-mode:
-- Require <C-\><C-N> to escape the terminal
-- Require <C-C> to escape FZF in Windows
-- tnoremap <ESC> <C-C><C-\><C-n>
-- tnoremap <C-C> <C-C><C-\><C-n>
-- tnoremap <C-]> <C-C><C-\><C-n>

-- " Easier insert mode paste
-- vim.keymap.set("!", '<C-r>;', '<C-r>"', { noremap = true })

-- map <expr> <M-c> myal#SetupAlignToColumn(v:count)

