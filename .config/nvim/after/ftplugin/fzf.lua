-- When aborting fzf in Neovim, <Esc> does not work, so fix it
vim.keymap.set('t', '<ESC>', '<c-\\><c-n>', { noremap = true, buffer = true })
