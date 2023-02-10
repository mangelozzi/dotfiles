-- Go down a line, go to the start insert some text then escape
vim.keymap.set("n", "-", "Iprint('\\n-----------------------------------------------------')<CR><ESC>", {noremap = true, buffer = true})

-- Insert django style {% tag %}
vim.keymap.set("n", "<leader>t", "o{%  %}<Esc>hhi", {noremap = true, buffer = true})
