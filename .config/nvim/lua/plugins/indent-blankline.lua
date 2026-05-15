-- Adds vertical lines to indented blocks of code

vim.pack.add({
    {
        src = "https://github.com/lukas-reineke/indent-blankline.nvim",
        name = "indent-blankline.nvim",
    },
})

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
