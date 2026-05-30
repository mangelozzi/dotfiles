-- IDENTATION
-- vim.cmd('filetype plugin on') -- Enable plugins (for newtrw), built in, comes with VIM (on is the default for Neovim)
vim.cmd('filetype indent off')

-- COLORS
vim.cmd('highlight SpecialKey ctermfg = 3')

-- BUILT IN PACKAGES (same on linux servers)

-- Cfilter (Quickfix window filtering, like global g/pattern/d )
-- :h cfilter-plugin
-- Example usage:
--   :cfilter /pattern/   " If theres a match will KEEP it in the quickfix window
--   :cfilter! /pattern/   " If there a match will REMOVE from quickfix window
vim.cmd('packadd cfilter')

-- Alias :Qa for :qa due to typo so often
vim.cmd('cabbrev Qa qa')

-- Dettach LSP from buffer
vim.api.nvim_create_user_command("LspStop", function()
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        vim.lsp.buf_detach_client(0, client.id)
    end
end, {})
