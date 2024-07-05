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
-- <C-a> -> NOT natively supported goto line start
vim.keymap.set("c", "<C-a>", "<HOME>", {noremap = true})

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
-- <C-u> (natively supported deleting to line start)
vim.keymap.set("c", "<C-k>", "<C-\\>estrpart(getcmdline(), 0, getcmdpos() - 1)<CR>", {noremap = true})

-- Left/Right arrow backspace and delete
vim.keymap.set("c", "<C-l>", "<DEL>", {noremap = true})

-- In command mode, if there are no more characters to the right of the cursor
-- when delete is pressed, it starts to behave like backspace. Disable this.
vim.keymap.set("c", "<DEL>", require("namespace.utils").delete_to_right_only, { expr = true})
