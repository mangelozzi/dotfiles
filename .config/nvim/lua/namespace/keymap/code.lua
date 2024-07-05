-- Insert django style {% tag %}
-- <C-m> = <CR>
vim.keymap.set("i", '<M-b>', "{%  %}<Esc>hhi", { noremap = true, desc ="Django (B)lock" })
vim.keymap.set("i", '<M-c>', "{#  #}<Esc>hhi", { noremap = true, desc ="Django (C)omment" })
vim.keymap.set("i", '<M-v>', "{{  }}<Esc>hhi", { noremap = true, desc ="Django (V)ariable" })

-- Insert a debugger breakpoint statement
vim.keymap.set("n", "<leader><DEL>", require("namespace/utils").breakpoint, {noremap = true, desc = "Insert breakpoint"})

-- TODO NO WORKING SO WELL
-- Rename tag - csst - from: https://stackoverflow.com/questions/16340037/change-html-tag-in-vim-but-keeping-the-attributes-surround
-- Mneomonic - W for Web tag
vim.keymap.set({"n", "x"}, "<leader>w", function() vim.fn.feedkeys("cstt") end, {noremap = true, desc = "Rename HTML tag"})

-- Escape html entities <>'"{} to &lt;&gt;&quot;&lbrace;&rbrace;
vim.keymap.set("v", "<leader><", function() require("namespace/utils").escape_html_visual_selection() end, {noremap = true, desc = "Escape html entities"})
vim.keymap.set("v", "<leader>>", function() require("namespace/utils").escape_html_visual_selection() end, {noremap = true, desc = "Escape html entities"})
