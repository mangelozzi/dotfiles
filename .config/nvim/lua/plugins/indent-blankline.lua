--[[
Indent-blankline (| marks for indentation)

Hilight Groups:
    IblIndent       = Not active bars
    IblWhitespace   = Whitespace between bars? Usefull if coloring BG color
    IblScope        = Active bars

--


local Plugin = {
    "lukas-reineke/indent-blankline.nvim",
    -- dependencies = {
    --     "HiPhish/rainbow-delimiters.nvim",
    --     "nvim-treesitter/nvim-treesitter"
    -- }
}

-- local rainbow_delimiters_plugin = require('plugins/rainbow-delimiters')


Plugin.config = function()
    -- Hi groups IblIndent, IblWhitespace, and IblScope must be defined before setup, because these colors are used for some TS groups
    print('111')
    -- vim.print(rainbow_delimiters_plugin.highlights)
    print('222')
    -- local hooks = require "ibl.hooks"
    -- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    --     vim.api.nvim_set_hl(0, "rainbowcol1", { fg = "#fefefe" })
    --     vim.api.nvim_set_hl(0, "rainbowcol2", { fg = "#ffc0c0" })
    --     vim.api.nvim_set_hl(0, "rainbowcol3", { fg = "#ffff40" })
    --     vim.api.nvim_set_hl(0, "rainbowcol4", { fg = "#80ff80" })
    --     vim.api.nvim_set_hl(0, "rainbowcol5", { fg = "#c0c0c0" })
    --     vim.api.nvim_set_hl(0, "rainbowcol6", { fg = "#e0c000" })
    --     vim.api.nvim_set_hl(0, "rainbowcol7", { fg = "#808fff" })
    -- end)
    require("ibl").setup {
        scope = {
            show_start = false,
            show_end = false,
            -- highlight = rainbow_delimiters_plugin.highlights,
            -- highlight = -- Exposed so can be used by indent-blankline.nvim
            --     {
            --     'rainbowcol1',
            --     'rainbowcol2',
            --     'rainbowcol3',
            --     'rainbowcol4',
            --     'rainbowcol5',
            --     'rainbowcol6',
            --     'rainbowcol7',
            -- },
        },

        -- indent = {char = "|"},
        -- whitespace = {
        --     -- highlight = {"_IndentBlanklineWhitespace" },
        -- }
    }
    -- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return Plugin

    --]]


local Plugin = {
    "lukas-reineke/indent-blankline.nvim"
}

Plugin.config = function()
    -- Hi groups IblIndent, IblWhitespace, and IblScope must be defined before setup, because these colors are used for some TS groups
    require("ibl").setup { 
        scope = { 
            highlight = {
                'rainbowDelimiter1',
                'rainbowDelimiter2',
                'rainbowDelimiter3',
                'rainbowDelimiter4',
                'rainbowDelimiter5',
                'rainbowDelimiter6',
                'rainbowDelimiter7',
            },
            show_start = false,
            show_end = false,

        },
        indent = {
            -- char = "|",
            highlight = {
                'rainbowIndent1',
                'rainbowIndent2',
                'rainbowIndent3',
                'rainbowIndent4',
                'rainbowIndent5',
                'rainbowIndent6',
                'rainbowIndent7',
            },

        },
        -- whitespace = {
        --     -- highlight = {"_IndentBlanklineWhitespace" },
        -- }
    }
end

return Plugin
