-- :help api-autocmd

local utils = require("namespace.utils")

local NamespaceGroup = vim.api.nvim_create_augroup("Namespace", {clear = true})

local no_trim_fts = {
    ["markdown"] = true
}
local function strip_whitespace_handler(opts)
    local ft = vim.bo[opts.buf].filetype
    if not no_trim_fts[ft] then
        utils.strip_whitespace()
    end
end

vim.api.nvim_create_autocmd(
    "BufWritePre",
    {
        desc = "Strip whitespace before save on all filetypes except markdown files",
        group = NamespaceGroup,
        callback = strip_whitespace_handler
    }
)

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        desc = "Source the lua/vim file after saving.",
        group = NamespaceGroup,
        pattern = {"*.lua", "*.vim"},
        callback = function()
            vim.cmd("source")
            print("File sourced after saving.")
        end
    }
)

-- https://github.com/wbthomason/packer.nvim#quickstart
-- You can configure Neovim to automatically run :PackerCompile whenever plugins.lua is updated
vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        desc = "Run packer sync/compile after editing plugins.lua file",
        group = NamespaceGroup,
        pattern = "plugins.lua",
        callback = function()
            vim.cmd("PackerCompile")
            vim.cmd("PackerSync")
        end
    }
)

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        callback = function()
            vim.highlight.on_yank {timeout = 150, higroup = "HighlightOnYank"}
        end,
        group = NamespaceGroup,
        pattern = "*"
    }
)
