-- VIM TALK (text objects and motions) ----------------------------------------

-- All, or whole buffer
-- Using nvim-various-textobjs.lua does not maintain the cursor position on copy all
vim.keymap.set("o", "A", function() require("namespace.utils").text_object("normal! ggVG") end, {desc = "Entire buffer object"})

-- Line Wise text objects (excludes the ending line char)
-- Using nvim-various-textobjs.lua instead
-- g_ means move to the last printable char of the line
vim.keymap.set({"x", "o"}, "il", function() require("namespace.utils").text_object("normal! ^vg_") end, {noremap = true, desc = "Inner (l)ine text object"})
vim.keymap.set({"x", "o"}, "al", function() require("namespace.utils").text_object("normal! 0vg_") end, {noremap = true, desc = "A (l)ine text object"})


-- Navigate to the start/end of the inner text of a <tag>...</tag> set
vim.keymap.set("n", "[t", "vit<ESC>`<", {noremap = true, desc = "Jump to start of tag inner"})
vim.keymap.set("n", "]t", "vit<ESC>`>", {noremap = true, desc = "Jump to end of tag inner"})

-- Navigate to the start/end of the <tag>...</tag> set
vim.keymap.set("n", "[T", "vat<ESC>`<", {noremap = true, desc = "Jump to start of tag outer"})
vim.keymap.set("n", "]T", "vat<ESC>`>", {noremap = true, desc = "Jump to end of tag outer"})
