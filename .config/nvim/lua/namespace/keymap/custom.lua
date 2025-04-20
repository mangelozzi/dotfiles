-- Save
vim.keymap.set({"", "!"}, "<C-s>", "<ESC>:w!<CR>", {noremap = true, desc = "Save"})

-- Copy / Paste
-- vim.keymap.set({"n"}, "<M-v>", "<C-v>", {noremap = true, desc = "Visual block mode"})

-- Map dash to other buffer
-- Note!!! Using recursive version so will recurse to <ESC> when in the
-- quickfix window
vim.keymap.set({"n", "x"}, "-", "<C-^>", { noremap = false, desc = "Jump to alternate buffer" })
vim.keymap.set({"n", "x"}, "<bs>", "<C-^>", { noremap = false, desc = "Jump to alternate buffer" })

-- Map ; to : for speed
-- vim.keymap.set({"n", "x"}, ";", ":", {noremap = true, desc = "Command mode"})

-- Make x/X not change the registers, i.e. uses the black hole register
-- Note: Use d/D to change the register
-- Note the `xp` swap letters is mapped to `<leader>x`
vim.keymap.set({"n", "x"}, "x", '"_x', {noremap = true, desc = "Delete char"})
vim.keymap.set({"n", "x"}, "x", '"_x', {noremap = true, desc = "Delete char"})

-- Change record macro to "Q", so it runs "q" (so can use q for line start)
vim.keymap.set({"n", "x"}, "Q", "q", {noremap = true, desc = "Record macro"})
-- Change q to the hard to reach ^
vim.keymap.set({"n", "o", "x"}, "q", "^", {noremap = true, desc = "Line start"})

-- :h yy = If you like "Y" to work from the cursor to the end of line (which is
-- more logical, but not Vi-compatible) use ":map Y y$".
vim.keymap.set({"n", "x"}, "Y", "y$", {noremap = true, desc = "Yank to end of line"})

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
    {noremap = true, silent = true, desc = "Search word under cursor"}
)
-- vim.keymap.set({'n', 'x'}, '#', 'm""1yiw<ESC>: let @/ = @1<CR>:set hlsearch<CR>:%s/<C-R>?//gn<CR>`"', { noremap = true, silent = true })

-- Easier split navigations
vim.keymap.set({ "n", "x" }, "<C-h>", "<C-W><C-h>", { noremap = true, desc = "Cursor to left window" })
vim.keymap.set({ "n", "x" }, "<C-j>", "<C-W><C-j>", { noremap = true, desc = "Cursor to down window" })
vim.keymap.set({ "n", "x" }, "<C-k>", "<C-W><C-k>", { noremap = true, desc = "Cursor to up window" }) -- Careful of conflict with LSP (implemented in LSP section)
vim.keymap.set({ "n", "x" }, "<C-l>", "<C-W><C-l>", { noremap = true, desc = "Cursor to right window" })

-- Prefer <C-G> to print full path, can see relative path in status bar anyways
vim.keymap.set({"n", "x"}, "<C-g>", "3<C-g>", {noremap = true, desc = "Print full path"})

-- Remap for dealing with word wrap
vim.keymap.set({"n", "x"}, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Cursor up a visual line" })
vim.keymap.set({"n", "x"}, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Cursor down a visual line" })

-- center movements on screen
vim.keymap.set("n", "J", "mzJ`z", { noremap = true, desc = "Join lines, keep cursor position" })
vim.keymap.set("n", "n", "nzv", { noremap = true, desc = "Next search" }) -- This is better when having many folds.
vim.keymap.set("n", "N", "Nzv", { noremap = true, desc = "Previous search" }) -- This is better when having many folds.

-- Meta (Alt) Productivity Enhancement ----------------------------------------

-- Move line up and down (Uses the :m Ex command)
-- Refer to: https://vim.fandom.com/wiki/Moving_lines_up_or_down
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { noremap = true, desc = "Move selected lines down"})
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { noremap = true, desc = "Move selected lines up"})
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "Move selected lines down"})
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { noremap = true, desc = "Move selected lines up"})

-- Duplicate line and keep cursor in same column position in the new line (uses the :t Ex command)
vim.keymap.set("", "<M-K>", ":t.<CR>k", { noremap = true, desc = "Duplicate line above" })
vim.keymap.set("", "<M-J>", ":t-1<CR>j", { noremap = true, desc = "Duplicate line below" })

-- Increase buffer size with alt-arrows
-- Tend to use <count><C-w>| rather
vim.keymap.set("n", "<M-Up>", ":resize -2<CR>", { noremap = true, desc = "Decrease buffer size" })
vim.keymap.set("n", "<M-Down>", ":resize +2<CR>", { noremap = true, desc = "Increase buffer size" })
vim.keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", { noremap = true, desc = "Decrease buffer size" })
vim.keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", { noremap = true, desc = "Increase buffer size" })

vim.keymap.set("n", '<M-B>', "i{%  %}<Esc>hhi", { noremap = true, desc ="Django (B)lock" })
vim.keymap.set("n", '<M-C>', "i{#  #}<Esc>hhi", { noremap = true, desc ="Django (C)omment" })
vim.keymap.set("n", '<M-V>', "i{{  }}<Esc>hhi", { noremap = true, desc ="Django (V)ariable" })
