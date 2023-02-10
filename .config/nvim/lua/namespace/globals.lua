-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- PYTHON 2
-- Disable python2 support
vim.g.loaded_python_provider = 0
vim.g.python_host_skip_check = 1

-- PYTHON 3
vim.g.python3_host_skip_check = 1


-- Recommended by nvim-tree
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- NETRW
-- Disabled above but it's banner is really big and ugly
vim.g.netrw_banner = 0

-- LEADER
vim.g.mapleader = ' '
