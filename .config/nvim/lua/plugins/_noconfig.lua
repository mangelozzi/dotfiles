--[[
Drop the trailing `.nvim` from plugin names because the . messes up the imports,
lua can use . or / for import heirarchy.

Plugin.cond = false, -- like enabled but does not uninstall the plugin

--]]
return {
    -- OPERATOR + MOTION + TEXT-OBJECT = AWESOME (VIM SPEAK LANGUAGE)
    {"wellle/targets.vim"},
    {"tpope/vim-repeat"},
    {"tpope/vim-unimpaired"},
    {"AndrewRadev/bufferize.vim"},
    {
        "whatyouhide/vim-textobj-xmlattr",
        dependencies = {"kana/vim-textobj-user"}
    },
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
