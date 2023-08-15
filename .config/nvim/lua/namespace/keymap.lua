--[[

Currently leader in nmap:
    a, b, c, d, e, g, m, o, p, q, u, v
    A, B, C, E, F, G, H, L, M, N, O, P, R, S, T, U, V, W, X, Y, Z
    0
    !@#$%^&*()_+
    []{}|\;,<>?

Example
vim.keymap.set("n", "<leader>a", ":Git blame<cr>", { noremap = true })
Multiple modes like this:
vim.keymap.set({"n", "x", "s"}, "<leader>a", ":Git blame<cr>", { noremap = true })

nvim_set_keymap - global mapping
nvim_buf_set_keymap - set a buffer-local mapping

Can show a list of mappings with :map
Useful to check no leader clashes
Note!!! Comments on a separate line.
CTRL (^) maps lower and uppercase to same key (by convention use lowercase)
Meta (M-?) can map lower and upper case words)

Practically available/free hotkeys
  Q (Ex mode) -> MAPPED: ^
  Z (First half of quick exit)
  ^c (Aborts pending command) (not good when SSH'ing)
  ^k -> MAPPED: Switch window
  ^l (small L, redraw screen) -> MAPPED: Switch window
  ^q (XON)
  ^s (XOFF) -> MAPPED: :save
  ,  (repeat last line search, reversing direct)
  # (always use *)

LEADER -> aeghijmqtuvwxy (g for git one day)
  j  - Comment, mneomoic (Jargon)
  k  - replace with register
  kk - replace with register line
  K  - replace with regsiter to end of line

Decided not to use Select mode
n - Normal Mode
o - Operator pending, e.g. "d..." waits for what to delete
c - Command mode
x - Visual mode
s - Select mode
v - Both visual and select mode
Map - Normal, visual, select, and operator pending
Map! - Insert & command mode
--]]
-- INIT -----------------------------------------------------------------------

-- When debugging just place the function in this file, then move it into utils.lua once debugged
local utils = require("namespace.utils")

-- ALL MODES ------------------------------------------------------------------

-- Escape
-- Occasionally have to press escape twice, might of been due to close Neogit mapping, ready if it wasnt...
-- vim.keymap.set('', '<ESC>', '<ESC><ESC>', { noremap = true })
-- vim.keymap.set('!', '<ESC>', '<ESC><ESC>', { noremap = true })

-- Save
vim.keymap.set({"", "!"}, "<C-s>", "<ESC>:w<CR>", {noremap = true})

-- Run the file
vim.keymap.set({"", "!"}, "<F5>", utils.run, {})

-- Autoformat the file
vim.keymap.set({"", "!"}, "<F6>", utils.format_code, {})

-- Insert a debugger breakpoint statement
vim.keymap.set({"", "!"}, "<F7>", utils.breakpoint, {})
vim.keymap.set("n", "<leader><DEL>", utils.breakpoint, {})

-- Copy the current filepath into the system clipboard
vim.keymap.set({"", "!"}, "<F8>", "<ESC>:let@+=@%<CR>", {})

-- Keyboard volume up and down and down to no operation
-- vim.keymap.set('', '<C-Space>', '<nop>', { noremap = true })
-- vim.keymap.set('!', '<C-Space>', '<nop>', { noremap = true })

-- NORMAL MODE ----------------------------------------------------------------

-- Productivity Enhancement
-- First delete space to left, then cut to end of line and paste on line above.
-- Hand for moving commends from aside to above.
-- TODO test if space to left, and if so they delete to the left.
-- vim.keymap.set('n', '<leader>D', 'hxDO<c-r>"', { noremap = true })

-- NORMALISH MODE -------------------------------------------------------------
-- Map ; to : for speed
vim.keymap.set({"n", "x"}, ";", ":", {noremap = true})

-- Make x/X not change the registers, i.e. uses the black hole register
-- Note: Use d/D to change the register
vim.keymap.set({"n", "x"}, "x", '"_x', {noremap = true})

-- Disable annoying ex mode (Type "visual" to exit)
-- Change it to the hard to reach ^
vim.keymap.set({"n", "x"}, "Q", "^", {noremap = true})

-- :h yy = If you like "Y" to work from the cursor to the end of line (which is
-- more logical, but not Vi-compatible) use ":map Y y$".
vim.keymap.set({"n", "x"}, "Y", "y$", {noremap = true})

-- Disable highlighting
vim.keymap.set({"n", "x"}, "<leader>h", ":noh<CR>", {noremap = true})

-- Map backspace to other buffer
-- Note!!! Using recursive version so will recurse to <ESC> when in the
-- quickfix window
vim.keymap.set({"n", "x"}, "<BS>", "<C-^>", {})

-- When pressing star, don't jump to the next match
-- Set highlight search to trigger the highlighting which sometimes doesnt
-- appear otherwise.
-- After highlighting print how many matches there are with a search with 'n'
-- "m" to mark the current position to " register, then `" to jump back there
-- afterwards.
-- Also copy the word to the search register (happens natively, but adds range?)
vim.keymap.set(
    {"n", "x"},
    "*",
    [[m""1yiw<ESC>: let @/ = @1<CR>:set hlsearch<CR>:%s/<C-R>///gn<CR>`"]],
    {noremap = true, silent = true}
)
-- vim.keymap.set({'n', 'x'}, '#', 'm""1yiw<ESC>: let @/ = @1<CR>:set hlsearch<CR>:%s/<C-R>?//gn<CR>`"', { noremap = true, silent = true })

-- Swap to single/double/back quotes with <leader>' or <leader>" or <leader>` respectively.
vim.keymap.set({"n", "x"}, [[<leader>']], [[:s/[`"]/'/g<CR>:noh<CR>]], {noremap = true, silent = true})
vim.keymap.set({"n", "x"}, [[<leader>"]], [[:s/['`]/"/g<CR>:noh<CR>]], {noremap = true, silent = true})
vim.keymap.set({"n", "x"}, [[<leader>`]], [[:s/['"]/`/g<CR>:noh<CR>]], {noremap = true, silent = true})

-- Swap to underscore/dash with <leader>_ or <leader>-
vim.keymap.set({"n", "x"}, "<leader>_", ":s/-/_/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>-", ":s/_/-/g<CR>:noh<CR>", {noremap = true})
-- vim.keymap.set({'n', 'x'}, '<leader>_', ':s/-/_/g<CR>:noh<CR>', { noremap = true })
-- vim.keymap.set({'n', 'x'}, '<leader>-', ':s/_/-/g<CR>:noh<CR>', { noremap = true })

-- Swap numbers to given number, excl zeros
vim.keymap.set({"n", "x"}, "<leader>1", ":s/[1-9]/1/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>2", ":s/[1-9]/2/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>3", ":s/[1-9]/3/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>4", ":s/[1-9]/4/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>5", ":s/[1-9]/5/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>6", ":s/[1-9]/6/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>7", ":s/[1-9]/7/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>8", ":s/[1-9]/8/g<CR>:noh<CR>", {noremap = true})
vim.keymap.set({"n", "x"}, "<leader>9", ":s/[1-9]/9/g<CR>:noh<CR>", {noremap = true})

-- Easier split navigations
vim.keymap.set({"n", "x"}, "<C-h>", "<C-W><C-h>", {noremap = true})
vim.keymap.set({"n", "x"}, "<C-j>", "<C-W><C-j>", {noremap = true})
vim.keymap.set({"n", "x"}, "<C-k>", "<C-W><C-k>", {noremap = true}) -- Careful of conflict with LSP (implemented in LSP section)
vim.keymap.set({"n", "x"}, "<C-l>", "<C-W><C-l>", {noremap = true})

-- Prefer <C-G> to print full path, can see relative path in status bar anyways
vim.keymap.set({"n", "x"}, "<C-g>", "3<C-g>", {noremap = true})

-- If dont execute leader command, perform no operation instead of move one char to the right
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set({"n", "x"}, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({"n", "x"}, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Insert django style {% tag %}
-- <C-m> = <CR>
-- vim.keymap.set({"n", "x"}, '<leader>b', "o{%  %}<Esc>hhi", { noremap = true })  -- Mnemonic: (B)lock
-- vim.keymap.set({"n", "x"}, '<leader>n', "o{#  #}<Esc>hhi", { noremap = true })  -- Mnemonic: (N)o ... i.e. commented out
-- vim.keymap.set({"n", "x"}, '<leader>m', "o{{  }}<Esc>hhi", { noremap = true })  -- Mnemonic: A m has lots of vertical lines like {{}}
vim.keymap.set("i", '<M-b>', "{%  %}<Esc>hhi", { noremap = true })  -- Mnemonic: (B)lock
vim.keymap.set("i", '<M-c>', "{#  #}<Esc>hhi", { noremap = true })  -- Mnemonic: (C)omment
vim.keymap.set("i", '<M-v>', "{{  }}<Esc>hhi", { noremap = true })  -- Mnemonic: (V)ariable

-- nmap <F7> <cmd>call myal#PrintHiGroup()<CR>

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

-- MAP! -----------------------------------------------------------------------

-- Left/Right arrow backspace and delete
-- <C-u> - Natively supports delete to beginning of line
-- <C-h> - Natively is <Backspace>
vim.keymap.set("!", "<C-l>", "<DEL>", {noremap = true})
vim.keymap.set("!", "<C-a>", "<HOME>", {noremap = true})

-- " Easier insert mode paste
-- vim.keymap.set("!", '<C-r>;', '<C-r>"', { noremap = true })

-- Meta (Alt) Productivity Enhancement
-- Move line up and down (Uses the :m Ex command)
-- Refer to: https://vim.fandom.com/wiki/Moving_lines_up_or_down
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", {})
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", {})
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<CR>==gi", {})
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<CR>==gi", {})
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", {})

-- Duplicate line and keep cursor in same column position in the new line (uses the :t Ex command)
vim.keymap.set("", "<M-K>", ":t.<CR>k", {noremap = true})
vim.keymap.set("", "<M-J>", ":t-1<CR>j", {noremap = true})

-- map <expr> <M-c> myal#SetupAlignToColumn(v:count)


-- <F2> Reload vim config
vim.keymap.set({"", "!"}, "<F2>", "<ESC>:source $MYVIMRC<CR>", {noremap = true})

-- <F3> Open VIM RC file and change local pwd to it
vim.keymap.set({"", "!"}, "<F3>", "<ESC><cmd>e $MYVIMRC<CR> :lcd %:p:h<CR>", {noremap = true})

-- <F4> Close Buffer Keep window
-- Close the current buffer, but keep the window open
vim.keymap.set({"", "!"}, "<F4>", utils.close_buffer_keep_window, { noremap = true})

-- <S-F4> Close all buffer
-- Close all safe buffers, then just work through not safe to close buffers
vim.keymap.set({"", "!"}, "<S-F4>", utils.close_all_buffers, { noremap = true})


-- Run the current buffer with a sensible app, e.g. python or Chrome etc
-- Mnemonic use F5 in webpage a lot, use F5 to launch current file in chrome
-- map  <F5>      :call myal#Run()<CR>
-- map! <F5> <ESC>:call myal#Run()<CR>

-- Run some other feature related to the file type
-- map  <F7>      :call myal#Other()<CR>
-- map! <F7> <ESC>:call myal#Other()<CR>
--
-- Change PWD for the current window to that of the current buffer head.
-- https://dmerej.info/blog/post/vim-cwd-and-neovim/
-- map  <F8>      <cmd>lcd %:h<CR>
-- map! <F8> <ESC><cmd>lcd %:h<CR>
--
-- " Switch to previous buffer, then open the file that was showing in a new tab
-- " and cd into the head of the file
-- map  <F8>      <cmd>call myal#ConvertBufferToNewTab()<CR>
-- map! <F8> <ESC><cmd>call myal#ConvertBufferToNewTab()<CR>
--
-- <F9> to <F12> QUICK INSERTS -------------------------------------------------
-- To paste the current filename, use "%p
--
-- DATETIME - Echo it in normal mode, insert it in insert mode.
-- map  <F9> :echo 'Current date/time is ' . strftime('%Y-%m-%d %T')<CR>
-- map! <F9> <C-R>=strftime('%Y-%m-%d %T')<CR>
--
-- Highlight Test
-- map  <F12> :source $VIMRUNTIME/syntax/hitest.vim<CR>
--
-- {{{2 Visual mode
-- v = select and visual mode, x = visual, s = select (mouse)
-- s mode = allows one to select with the mouse, then type any printable
--          character to replace the selection and start typing. Unfortunately
--          this means any hotkeys setup in v-mode will override which keys
--          actually perform this behaviour.
--          DECISION: Ignore select mode, use c to change a selection. Map
--                    hotkeys in v-mode so same behaviour if using the mouse or
--                    keyboard to make a selection.
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

-- COMMAND MODE ---------------------------------------------------------------
-- Make it more bash like
-- If wish to implement more functionality (requiring functions), refer to:
-- https://github.com/houtsnip/vim-emacscommandline/blob/master/plugin/emacscommandline.vim

-- Delete word before cursor (natively supported)
-- <C-w>

-- Backspace (natively supported)
-- <C-h>

-- Goto line start / end
-- <C-e> -> natively supported goto line end
-- <C-a> -> natively supported goto line start

-- Move one character forwards/backwards
-- cnoremap <C-B>		<Left>
-- cnoremap <C-F>		<Right>  -- <C-f> is to bring up the command history

-- Delete character under cursor
vim.keymap.set("c", "<C-d>", "<DEL>", {noremap = true})

-- Recall Next/Previous command-line
-- Natively supported
-- <C-p>    <Up>
-- <C-n>    <Down>

-- Move back/forward one one word
vim.keymap.set("c", "<M-b>", "<S-Left>", {noremap = true})
vim.keymap.set("c", "<M-f>", "<S-Right>", {noremap = true})

-- Delete from cursor to line start/end
-- C-u (natively supported deleting to line start)
vim.keymap.set("c", "<C-k>", "<C-\\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>", {noremap = true})

-- In command mode, if there are no more characters to the right of the cursor
-- when delete is pressed, it starts to behave like backspace. Disable this.
vim.keymap.set("c", "<DEL>", utils.delete_to_right_only, { expr = true})

-- VIM TALK (text objects and motions) ----------------------------------------

-- All, or whole buffer
vim.keymap.set("o", "A", utils.text_object_all, {})

-- Line Wise text objects (excludes the ending line char)
-- g_ means move to the last printable char of the line
vim.keymap.set({"x", "o"}, "il", ":<C-U>normal! ^vg_<CR>", {noremap = true})
vim.keymap.set({"x", "o"}, "al", ":<C-U>normal! 0vg_<CR>", {noremap = true})

-- Navigate to the start/end of the inner text of a <tag>...</tag> set
vim.keymap.set("n", "[t", "vit<ESC>`<", {noremap = true})
vim.keymap.set("n", "]t", "vit<ESC>`>", {noremap = true})

-- Navigate to the start/end of the <tag>...</tag> set
vim.keymap.set("n", "[T", "vat<ESC>`<", {noremap = true})
vim.keymap.set("n", "]T", "vat<ESC>`>", {noremap = true})

-- Sort operator
vim.keymap.set({"n", "x"}, "<leader>s", utils.sort_lines, {silent = true})

-- TODO NO WORKING SO WELL
-- Rename tag - csst - from: https://stackoverflow.com/questions/16340037/change-html-tag-in-vim-but-keeping-the-attributes-surround
-- Mneomonic - W for Web tag
vim.keymap.set({"n", "x"}, "<leader>w", function() vim.fn.feedkeys("cstt") end, {noremap = true})


-- " {{{2 Insert
--
-- " Set paste then nopaste automatically when working with system registers
-- inoremap <C-R>* <C-O>:set paste<CR><C-R>*<C-O>:set nopaste<cr>
-- inoremap <C-R>+ <C-O>:set paste<CR><C-R>+<C-O>:set nopaste<cr>
-- inoremap <C-SPACE> _


-- " Print the highlight group under the cursor, and which group it links to.
-- function! SynGroup()
--     let l:s = synID(line('.'), col('.'), 1)
--     echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
-- endfun
-- command! SynGroup call SynGroup()
