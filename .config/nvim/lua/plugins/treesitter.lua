-- To update a single treesitter parser:
--  :TSInstall python
-- To update all:
--  :TSUpdate
-- To update/sync all:
--  :TSUpdateSync

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name ~= "nvim-treesitter" then
            return
        end

        if ev.data.kind == "install" or ev.data.kind == "update" then
            vim.schedule(function()
                vim.cmd("TSUpdate")
            end)
        end
    end,
})

vim.pack.add {
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        name = "nvim-treesitter",
        version = "main",
    }
}

local treesitter_parsers = {
    "bash",
    "c",
    "css",
    "diff",
    "html",
    "htmldjango",
    "ini",
    "javascript",
    "jsonc",
    "lua",
    "python",
    "typescript",
}

require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install(treesitter_parsers)

vim.api.nvim_create_autocmd("FileType", {
    pattern = treesitter_parsers,
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
