-- :help api-autocmd

local utils = require("namespace.utils")

local augroup = vim.api.nvim_create_augroup
local NamespaceGroup = augroup("Namespace", {})

local no_trim_fts = {
    ["markdown"] = true,
}
local function strip_whitespace_handler(opts)
    local ft = vim.bo[opts.buf].filetype
    if not no_trim_fts[ft] then
        utils.strip_whitespace()
    end
end

vim.api.nvim_create_autocmd(
    "BufWritePre", {
        desc = 'Strip whitespace before save on all filetypes except markdown files',
        group = NamespaceGroup,
        callback = strip_whitespace_handler,
    }
)

-- https://github.com/wbthomason/packer.nvim#quickstart
-- You can configure Neovim to automatically run :PackerCompile whenever plugins.lua is updated
-- Not working
-- vim.cmd([[
--   augroup NameSpace
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerCompile | PackerSync
--   augroup end
-- ]])
