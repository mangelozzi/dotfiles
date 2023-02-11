-- When aborting fzf in Neovim, <Esc> does not work, so fix it
vim.keymap.set('t', '<ESC>', '<C-w><C-c>', { noremap= true, buffer = true })
