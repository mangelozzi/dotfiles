-- VIM TALK (text objects and motions) ----------------------------------------

-- All, or whole buffer
-- Using nvim-various-textobjs.lua does not maintain the cursor position on copy all
vim.keymap.set("o", "A", require("namespace.utils").text_object_all, {desc = "entrie buffer object"})

-- Line Wise text objects (excludes the ending line char)
-- Using nvim-various-textobjs.lua instead
-- g_ means move to the last printable char of the line
vim.keymap.set({"x", "o"}, "il", ":<C-U>normal! ^vg_<CR>", {noremap = true, desc = "inner line text object"})
vim.keymap.set({"x", "o"}, "al", ":<C-U>normal! 0vg_<CR>", {noremap = true, desc = "a line text object"})

-- Navigate to the start/end of the inner text of a <tag>...</tag> set
vim.keymap.set("n", "[t", "vit<ESC>`<", {noremap = true, desc = "jump to start of tag inner"})
vim.keymap.set("n", "]t", "vit<ESC>`>", {noremap = true, desc = "jump to end of tag inner"})

-- Navigate to the start/end of the <tag>...</tag> set
vim.keymap.set("n", "[T", "vat<ESC>`<", {noremap = true, desc = "jump to start of tag outer"})
vim.keymap.set("n", "]T", "vat<ESC>`>", {noremap = true, desc = "jump to end of tag outer"})

-- Sort operator
-- TODO DOESNT WORK
-- vim.keymap.set({"n", "x"}, "gs", require("namespace.utils").sort_lines, {noremap = true, silent = true}) -- Replace builtin sleep operator

--[[

aa
dsafds
gf
cvc
vd
adf
sdf


--]]