-- IDENTATION
-- vim.cmd('filetype plugin on') -- Enable plugins (for newtrw), built in, comes with VIM (on is the default for Neovim)
vim.cmd('filetype indent off')

-- COLORS
vim.cmd('highlight SpecialKey ctermfg = 3')

-- GUI COMPUTER
vim.cmd('behave xterm')

-- BUILT IN PACKAGES (same on linux servers)

-- Cfilter (Quickfix window filtering, like global g/pattern/d )
-- :h cfilter-plugin
-- Example usage:
--   :cfilter /pattern/   " If theres a match will KEEP it in the quickfix window
--   :cfilter! /pattern/   " If there a match will REMOVE from quickfix window
vim.cmd('packadd cfilter')
