local Plugin = {
    "lukas-reineke/indent-blankline.nvim"
}

Plugin.config = function()
    -- Hi groups IblIndent, IblWhitespace, and IblScope must be defined before setup, because these colors are used for some TS groups
    require("ibl").setup { 
        scope = { 
            -- highlight = "_IndentBlanklineScope",
            show_start = false,
            show_end = false,
        },
        -- indent = {char = "|"},
        -- whitespace = {
        --     -- highlight = {"_IndentBlanklineWhitespace" },
        -- }
    }
end

return Plugin
