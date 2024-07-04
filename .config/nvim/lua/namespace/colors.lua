vim.cmd.colorscheme('theme_hard')

vim.keymap.set({"", "!"}, '<M-1>', function() vim.cmd.colorscheme('theme_soft')   end, { noremap = true, silent = true })
vim.keymap.set({"", "!"}, '<M-2>', function() vim.cmd.colorscheme('theme_medium') end, { noremap = true, silent = true })
vim.keymap.set({"", "!"}, '<M-3>', function() vim.cmd.colorscheme('theme_hard')   end, { noremap = true, silent = true })
