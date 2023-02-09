-- Example
-- vim.keymap.set("n", "<leader>a", ":Git blame<cr>", { noremap = true })
-- Multiple modes like this:
-- vim.keymap.set({"n", "x", "s"}, "<leader>a", ":Git blame<cr>", { noremap = true })

-- nvim_set_keymap - global mapping
-- nvim_buf_set_keymap - set a buffer-local mapping

-- Can show a list of mappings with :map
-- Useful to check no leader clashes
-- Note!!! Comments on a separate line.
-- CTRL (^) maps lower and uppercase to same key (by convention use lowercase)
-- Meta (M-?) can map lower and upper case words)

-- Practically available/free hotkeys
--   Q (Ex mode) -> MAPPED: ^
--   Z (First half of quick exit)
--   ^c (Aborts pending command) (not good when SSH'ing)
--   ^k -> MAPPED: Switch window
--   ^l (small L, redraw screen) -> MAPPED: Switch window
--   ^q (XON)
--   ^s (XOFF) -> MAPPED: :save
--   ,  (repeat last line search, reversing direct)
--   # (always use *)

-- LEADER -> aeghijmqtuvwxy (g for git one day)
--   j  - Comment, mneomoic (Jargon)
--   k  - replace with register
--   kk - replace with register line
--   K  - replace with regsiter to end of line

-- LEADER
vim.g.mapleader = ' '

-- ALL MODES

-- CTRL+S to save
vim.keymap.set('', '<C-s>', ':w<CR>', { noremap = true })
vim.keymap.set('!', '<C-s>', '<ESC>:w<CR>', { noremap = true })

-- MAP (normal/visual/select/operator pending)

-- Map ; to : for speed
vim.keymap.set('', ';', ':', { noremap = true })

-- Make x/X not change the registers, i.e. uses the black hole register
-- Note: Use d/D to change the register
vim.keymap.set('', 'x', '"_x', { noremap = true })

-- Keyboard volume up and down and down to no operation
-- vim.keymap.set('', '<C-Space>', '<nop>', { noremap = true })
-- vim.keymap.set('!', '<C-Space>', '<nop>', { noremap = true })

-- Disable annoying ex mode (Type "visual" to exit)
-- Change it to the hard to reach ^
vim.keymap.set('', 'Q', '^', { noremap = true })

-- :h yy = If you like "Y" to work from the cursor to the end of line (which is
-- more logical, but not Vi-compatible) use ":map Y y$".
vim.keymap.set("", "Y", "y$", { noremap = true })


-- Map backspace to other buffer
-- Note!!! Using recursive version so will recurse to <ESC> when in the
-- quickfix window
vim.keymap.set('', '<BS>', '<C-^>', { noremap = true })

-- When pressing star, don't jump to the next match
-- Set highlight search to trigger the highlighting which sometimes doesnt
-- appear otherwise.
-- After highlighting print how many matches there are with a search with 'n'
-- "m" to mark the current position to " register, then `" to jump back there
-- afterwards.
-- Also copy the word to the search register (happens natively, but adds range?)
vim.keymap.set('n', '*', [[m""1yiw<ESC>: let @/ = @1<CR>:set hlsearch<CR>:%s/<C-R>///gn<CR>`"]], { noremap = true, silent = true })
-- vim.keymap.set('n', '#', 'm""1yiw<ESC>: let @/ = @1<CR>:set hlsearch<CR>:%s/<C-R>?//gn<CR>`"', { noremap = true, silent = true })

-- Swap to single/double/back quotes with <leader>' or <leader>" or <leader>` respectively.
vim.keymap.set('n', [[<leader>']], [[:s/[`"]/'/g<CR>:noh<CR>]], { noremap = true })
vim.keymap.set('n', [[<leader>"]], [[:s/['`]/"/g<CR>:noh<CR>]], { noremap = true })
vim.keymap.set("n", [[<leader>"]], [[:s/[""]/"/g<CR>:noh<CR>]], { noremap = true })


-- Swap to underscore/dash with <leader>_ or <leader>-
vim.keymap.set('', '<leader>_', ':s/-/_/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('', '<leader>-', ':s/_/-/g<CR>:noh<CR>', { noremap = true })
-- vim.keymap.set('x', '<leader>_', ':s/-/_/g<CR>:noh<CR>', { noremap = true })
-- vim.keymap.set('x', '<leader>-', ':s/_/-/g<CR>:noh<CR>', { noremap = true })

-- Swap numbers to given number, excl zeros
vim.keymap.set('n', '<leader>1', ':s/[1-9]/1/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>2', ':s/[1-9]/2/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>3', ':s/[1-9]/3/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>4', ':s/[1-9]/4/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>5', ':s/[1-9]/5/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>6', ':s/[1-9]/6/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>7', ':s/[1-9]/7/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>8', ':s/[1-9]/8/g<CR>:noh<CR>', { noremap = true })
vim.keymap.set('n', '<leader>9', ':s/[1-9]/9/g<CR>:noh<CR>', { noremap = true })

-- Easier split navigations
vim.keymap.set('', '<C-h>', '<C-W><C-h>', { noremap = true })
vim.keymap.set('', '<C-j>', '<C-W><C-j>', { noremap = true })
vim.keymap.set('', '<C-k>', '<C-W><C-k>', { noremap = true }) -- Careful of conflict with LSP (implemented in LSP section)
vim.keymap.set('', '<C-l>', '<C-W><C-l>', { noremap = true })

-- Prefer <C-G> to print full path, can see relative path in status bar anyways
vim.keymap.set('', '<C-g>', '3<C-g>', { noremap = true })

-- nmap <F7> <cmd>call myal#PrintHiGroup()<CR>
-- " Disable highlighting
-- map <LEADER>h :noh<CR>
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
--
--
-- " {{{2 Map! (noremap!)
--
-- " Left/Right arrow backspace and delete
-- " <C-u> - Natively supports delete to beginning of line
-- " <C-h> - Natively is <Backspace>
-- noremap! <C-l> <Del>
-- noremap! <C-a> <Home>
--
-- " Easier insert mode paste
-- noremap! <C-R>; <C-R>"
--
-- " {{{2 Productivity Enhancement
-- " First delete space to left, then cut to end of line and paste on line above.
-- " Hand for moving commends from aside to above.
-- " TODO test if space to left, and if so they delete to the left.
-- nmap <leader>D hxDO<c-r>"
--
-- Meta (Alt) Productivity Enhancement
-- " Move line up and down (must be remap, to use VIM unimpaired)
-- Refer to: https://vim.fandom.com/wiki/Moving_lines_up_or_down
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', {})
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', {})
vim.keymap.set('i', '<M-j>', '<Esc>:m .+1<CR>==gi', {})
vim.keymap.set('i', '<M-k>', '<Esc>:m .-2<CR>==gi', {})
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", {})
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", {})

-- Duplicate line and keep cursor in same column position in the new line
vim.keymap.set('', '<M-K>', ':t.<CR>k', { noremap = true })
vim.keymap.set('', '<M-J>', ':t-1<CR>j', { noremap = true })

-- map <expr> <M-c> myal#SetupAlignToColumn(v:count)
--
-- noremap <leader><DEL> <cmd>call myal#Breakpoint()<CR>
-- noremap <leader><S-DEL> <cmd>Lines 'breakpoint()<CR>
--
-- " {{{2 Insert
--
-- " Set paste then nopaste automatically when working with system registers
-- inoremap <C-R>* <C-O>:set paste<CR><C-R>*<C-O>:set nopaste<cr>
-- inoremap <C-R>+ <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<cr>
-- inoremap <C-SPACE> _
-- " {{{2 Function keys
-- " <F1> to <F8> COMMON ACTIONS -------------------------------------------------
-- " <F1> ESCAPE If I hit <F1> it was a mistake because I was reaching for <ESC>
-- map  <F1> <ESC>
-- map! <F1> <ESC>
--
-- " <F2> is reseved for auto completion rename

-- <F2> Reload vim config
vim.keymap.set('', '<F2>', ':source $MYVIMRC<CR>', { noremap = true })
vim.keymap.set('!', '<F2>', '<ESC>:source $MYVIMRC<CR>', { noremap = true })

-- <F3> Open VIM RC file and change local pwd to it
vim.keymap.set('', '<F3>', '<cmd>e $MYVIMRC<CR> :lcd %:p:h<CR>', { noremap = true })
vim.keymap.set('!', '<F3>', '<ESC><cmd>e $MYVIMRC<CR> :lcd %:p:h<CR>', { noremap = true })

-- " <F4> CLOSE BUFFER
-- " Same as buffer delete, however if its the last none help or empty buffer,
-- " then quit.
-- map  <F4>      <cmd>call myal#DeleteCurBufferNotCloseWindow()<CR>
-- map! <F4> <ESC><cmd>call myal#DeleteCurBufferNotCloseWindow()<CR>
--
-- " Run the current buffer with a sensible app, e.g. python or Chrome etc
-- " Mnemonic use F5 in webpage a lot, use F5 to launch current file in chrome
-- map  <F5>      :call myal#Run()<CR>
-- map! <F5> <ESC>:call myal#Run()<CR>
--
-- " Run code through an auto formatter
-- map  <F6>      :call myal#Format()<CR>
-- map! <F6> <ESC>:call myal#Format()<CR>
--
-- " Run some other feature related to the file type
-- " map  <F7>      :call myal#Other()<CR>
-- " map! <F7> <ESC>:call myal#Other()<CR>
--
-- " Change PWD for the current window to that of the current buffer head.
-- " https://dmerej.info/blog/post/vim-cwd-and-neovim/
-- " map  <F8>      <cmd>lcd %:h<CR>
-- " map! <F8> <ESC><cmd>lcd %:h<CR>
--
-- " " Switch to previous buffer, then open the file that was showing in a new tab
-- " " and cd into the head of the file
-- " map  <F8>      <cmd>call myal#ConvertBufferToNewTab()<CR>
-- " map! <F8> <ESC><cmd>call myal#ConvertBufferToNewTab()<CR>
--
-- " <F9> to <F12> QUICK INSERTS -------------------------------------------------
-- " To paste the current filename, use "%p
--
-- " DATETIME - Echo it in normal mode, insert it in insert mode.
-- " map  <F9> :echo 'Current date/time is ' . strftime('%Y-%m-%d %T')<CR>
-- " map! <F9> <C-R>=strftime('%Y-%m-%d %T')<CR>
--
-- " Highlight Test
-- map  <F12> :source $VIMRUNTIME/syntax/hitest.vim<CR>
--
-- " {{{2 Visual mode
-- " v = select and visual mode, x = visual, s = select (mouse)
-- " s mode = allows one to select with the mouse, then type any printable
-- "          character to replace the selection and start typing. Unfortunately
-- "          this means any hotkeys setup in v-mode will override which keys
-- "          actually perform this behaviour.
-- "          DECISION: Ignore select mode, use c to change a selection. Map
-- "                    hotkeys in v-mode so same behaviour if using the mouse or
-- "                    keyboard to make a selection.
--
-- " Move a block of text with SHIFT+arrows
-- " https://vim.fandomcom/w.iki/Drag_words_with_Ctrl-left/right
-- xnoremap <S-Right>  pgvloxlo
-- xnoremap <S-left>   hPgvhxoho
-- xnoremap <S-Down>   jPgvjxojo
-- xnoremap <S-Up>     xkPgvkoko
--
-- " vv to visual select to end of line without select the $
-- vnoremap v $h
--
-- " swap the words `light` and `dark` in visual range, useful for light/dark
-- " theme dev.
-- " vnoremap <leader>s :s/dark/zzz/ge<CR>gv:s/light/dark/ge<CR>gv:s/zzz/light/ge<CR>
--
-- " Sometimes in visual mode when trying to run commands with leader, exit vmode first
-- vmap <leader> <ESC><ESC><leader>
--
-- " " {{{2 Searching & replacing
-- " " https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m48s
-- " " He uses a plugin to achieve this.
-- " " Mapped with visual mode so that can use the mouse and press *
-- " " In visual mode press * to search for the current selected region y = yank visual range into the " buffer
-- " "   / = start search
-- " "   \V = very NO magic
-- " "   <C-R> = CTRL+R to paste from " buffer
-- " "   escape = escape the / and \ which are the only none literals in no magic
-- " xnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>
-- " xnoremap # y?\V<C-R>=escape(@",'/\')<CR><CR>
--
-- " " https://www.youtube.com/watch?v=fP_ckZ30gbs&t=07m36s
-- " " Press * to search for the term under the cursor or a visual selection and
-- " " then press a key below to replace all instances of it in the current file.
-- " noremap <Leader>rr :%s///g<Left><Left>
-- " noremap <Leader>rc :%s///gc<Left><Left><Left>
--
-- " " xnoremap <Leader>rc :s///gc<Left><Left><Left>
-- " " https://www.youtube.com/watch?v=fP_ckZ30gbs&t=10m25s
-- " " Similar to above, but in visual mode search within current selected region
-- " " for the previously search term. No need to add the '<,'> as it will be auto
-- " " added.
-- " xnoremap <Leader>rr :s///g<Left><Left>
-- " xnoremap <Leader>rc :s///gc<Left><Left><Left>
--
-- " " Speed substitue whole file
-- " noremap <leader>/ :%s//g<Left><Left>
-- " " Speed substitue line
-- " noremap <leader>? :s//g<Left><Left>
--
-- " " Speed substitue visual mode
-- " xnoremap <leader>/ :s//g<Left><Left>
-- " xnoremap <leader>? :s//g<Left><Left>
--
--
-- " " {{{2 Popup Menu
-- " inoremap <expr> <C-J> pumvisible() ? "\<C-n>" : "\<C-J>"
-- " inoremap <expr> <C-K> pumvisible() ? "\<C-p>" : "\<C-K>"
-- " " Allow remap for rgflow <CR> in insert mode.
-- " imap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<Cr>"
--
-- " " Use <Tab> and <S-Tab> to navigate through popup menu
-- " inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
--
-- " {{{2 Copy & paste
-- " Copy to system clipboard
-- " xnoremap  <leader>y  "+y
-- " nnoremap  <leader>Y  "+yg_
-- " nnoremap  <leader>y  "+y
-- " nnoremap  <leader>yy  "+yy
--
-- " " Paste from clipboard
-- " nnoremap <leader>p "+p
-- " nnoremap <leader>P "+P
-- " xnoremap <leader>p "+p
-- " xnoremap <leader>P "+P
--
-- " Paste from last copied
-- nnoremap <leader>p "0p
-- nnoremap <leader>P "0P
--
-- " {{{2 Terminal mode
-- " <ESC> to exit terminal-mode:
-- " Require <C-\><C-N> to escape the terminal
-- " Require <C-C> to escape FZF in Windows
-- tnoremap <ESC> <C-C><C-\><C-n>
-- tnoremap <C-C> <C-C><C-\><C-n>
-- tnoremap <C-]> <C-C><C-\><C-n>
--
--
-- " {{{2 Command mode
-- "   Make it more bash like
-- " If wish to implement more functionality (requiring functions), refer to:
-- " https://github.com/houtsnip/vim-emacscommandline/blob/master/plugin/emacscommandline.vim
--
-- " Delete word before cursor (natively supported)
-- " C-W
--
-- " Backspace (natively supported)
-- " ^H
--
-- " Goto line start / end
-- " C-E -> natively supported goto line end
-- cnoremap <C-A>		<Home>
-- "cnoremap <C-E>         <End>
--
-- " Move one character forwards/backwards
-- cnoremap <C-B>		<Left>
-- cnoremap <C-F>		<Right>
--
-- " Delete character under cursor
-- cnoremap <C-D>		<Del>
--
-- " Recall Next/Previous command-line
-- cnoremap <C-P>		<Up>
-- cnoremap <C-N>		<Down>
--
-- " Move back/forward one one word
-- cnoremap <M-b>	        <S-Left>
-- cnoremap <M-f>	        <S-Right>
--
-- " Delete from cursor to line start/end
-- " C-u (natively supported deleting to line start)
-- cnoremap <C-k> <C-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>
--
-- " In command mode, if there are no more character to the right of the cursor
-- " when delete is pressed, it starts to behave like backspace. Disable this.
-- cnoremap <expr> <Del> getcmdpos() <= strlen(getcmdline()) ? "\<Del>" : ""
--
-- " Rip grep in files, use <cword> under the cursor as starting point
-- " nnoremap <leader>rg :call myal#SearchInFiles('n')<Cr>
-- " Rip grep in files, use visual selection as starting point
-- " xnoremap <leader>rg :<C-U>call myal#SearchInFiles(visualmode())<Cr>



-- VIM TALK (text objects and motions)
-- Create text-object `A` which operates on the whole buffer (i.e. All)
-- Keeps the cursor position in the same position
-- function! TextObjectAll()
--     let g:restore_position = winsaveview()
--     normal! ggVG
--     if index(['c','d'], v:operator) == -1
--         call feedkeys("\<Plug>(RestoreView)")
--     end
-- endfunction
-- onoremap A :<C-U>call TextObjectAll()<CR>
-- nnoremap <silent> <Plug>(RestoreView) :call winrestview(g:restore_position)<CR>
-- " Disabled A in visual mode, cause use A to append at the end of selection.
-- xnoremap <leader>A :<C-U>normal! ggVG<CR>
--
-- " Line Wise text objects (excludes the ending line char)
-- " g_ means move to the last printable char of the line
-- onoremap il :<C-U>normal! ^vg_<CR>
-- onoremap al :<C-U>normal! 0vg_<CR>
-- xnoremap il :<C-U>normal! ^vg_<CR>
-- xnoremap al :<C-U>normal! 0vg_<CR>
--
-- " Navigate to the start/end of the inner text
-- nnoremap [t vit<ESC>`<
-- nnoremap ]t vit<ESC>`>
-- " Navigate to the start/end of the <tag>...</tag> set
-- nnoremap [T vat<ESC>`<
-- nnoremap ]T vat<ESC>`>
--
-- " Sort operator
-- nnoremap <silent> <leader>s :<C-u>set operatorfunc=myal#SortLinesOpFunc<CR>g@
--
-- " }}}2 End subsectiones
