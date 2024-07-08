--[[
Drop the trailing `.nvim` from plugin names because the . messes up the imports,
lua can use . or / for import heirarchy.
--]]


return {
    -- OPERATOR + MOTION + TEXT-OBJECT = AWESOME (VIM SPEAK LANGUAGE)
    {"wellle/targets.vim", lazy = false},
    {"tpope/vim-surround", lazy = false},
    {"tpope/vim-repeat", event = "InsertEnter"},

    {"tpope/vim-unimpaired"},
    {"AndrewRadev/bufferize.vim"},
    {
        "inkarkat/vim-SpellCheck",
        descr = "Spell check extras",
        dependencies = {"inkarkat/vim-ingo-library"}
    }
}

--[[
    -- maybe messes up quickfix colors
    -- Allows one to easily align text
    use("junegunn/vim-easy-align")

    -- COLORSCHEMES / THEMES
    use {
        "sainnhe/gruvbox-material",
    }

--]]
