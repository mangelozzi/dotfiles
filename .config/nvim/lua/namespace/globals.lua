-- System Dependant variables
vim.g.is_win   = vim.fn.has('win32') or vim.fn.has('win64')
vim.g.is_linux = vim.fn.has('unix') and not vim.fn.has('macunix')
vim.g.is_mac   = vim.fn.has('macunix')


-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0


-- PYTHON 2
-- Disable python2 support
vim.g.loaded_python_provider = 0
vim.g.python_host_skip_check = 1

-- PYTHON 3
vim.g.python3_host_skip_check = 1

-- NETRW
-- Disabled above but it's banner is really big and ugly
vim.g.netrw_banner = 0

-- LEADER
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
