--[[
Config-less plugins. These are installed eagerly with vim.pack.

Drop the trailing `.nvim` from plugin names because the . messes up imports,
lua can use . or / for import hierarchy.
--]]

vim.pack.add({
    {
        src = "https://github.com/tpope/vim-repeat",
        name = "vim-repeat",
    },
})
vim.pack.add({
    {
        src = "https://github.com/tpope/vim-unimpaired",
        name = "vim-unimpaired",
    },
})
vim.pack.add({
    {
        src = "https://github.com/AndrewRadev/bufferize.vim",
        name = "bufferize.vim",
    },
})
vim.pack.add({
    {
        src = "https://github.com/inkarkat/vim-ingo-library",
        name = "vim-ingo-library",
    },
})
vim.pack.add({
    {
        src = "https://github.com/inkarkat/vim-SpellCheck",
        name = "vim-SpellCheck",
    },
})

--[[
    -- maybe messes up quickfix colors
    -- Allows one to easily align text
    vim.pack.add({
        {
            src = "https://github.com/junegunn/vim-easy-align",
            name = "vim-easy-align",
        },
    })

    -- COLORSCHEMES / THEMES
    vim.pack.add({
        {
            src = "https://github.com/sainnhe/gruvbox-material",
            name = "gruvbox-material",
        },
    })
--]]
