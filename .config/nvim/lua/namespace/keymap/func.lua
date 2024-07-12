-- FUNCTION KEYS ---

-- <F1> Vim help on cword
vim.keymap.set({"", "!"}, "<F1>", "<ESC>:h <C-R><C-W><CR>", { noremap = true, desc = "Vim help on cword"})

-- <F2> Reload vim config
vim.keymap.set({"", "!"}, "<F2>", require("namespace.utils").reload_config, { noremap = true, desc = "Reload config"})

-- <F4> Force quit (not save any changes)
vim.keymap.set({"", "!"}, "<F4>", '<ESC><ESC>q<ESC><ESC>:qa!<CR>', { noremap = true, desc = "Force quit"})

-- OS xdg-open the current file
vim.keymap.set({"", "!"}, "<F5>", require("namespace.utils").run, {noremap = true, desc = "XDG-Open file"})

-- Autoformat the file
vim.keymap.set({"", "!"}, "<F6>", require("namespace.utils").format_code, {noremap = true, desc = "Autoformat the file"})

-- Copy the current filepath into the system clipboard
vim.keymap.set({"", "!"}, "<F7>", [[<ESC>:let @+=expand('%:p')<CR>:echo 'F7 - Copied ABSOLUTE file path'<CR>]], { noremap = true, desc = "Copy ABSOLUTE file path"})

-- Copy the current filepath into the system clipboard
vim.keymap.set({"", "!"}, "<F8>", "<ESC>:let@+=@%<CR>:echo 'F8 - Copied RELATIVE file path'<CR>", { noremap = true, desc = "Copy RELATIVE file path"})
