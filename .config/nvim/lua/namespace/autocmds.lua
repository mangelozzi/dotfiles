-- :help api-autocmd

local utils = require("namespace.utils")

local NamespaceGroup = vim.api.nvim_create_augroup("NamespaceGroup", {clear = true})

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
            vim.cmd("messages clear")
            vim.cmd("source")
            print("File sourced after saving.")
            vim.fn.feedkeys("\\<CR>")
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

-- Set global variable with current git branch
vim.api.nvim_create_autocmd(
    "BufEnter",
    {
        desc = "Set the git branch for the status line",
        group = NamespaceGroup,
        callback = function()
            -- Update its buffer local variable every time swtiched too
            vim.b.current_git_branch = utils.get_git_branch()
        end
    }
)
