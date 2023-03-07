require("nvim-treesitter.configs").setup {
    highlight = {
        -- ...
    },
    -- ...
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
        foo = {},
    }
}

vim.api.nvim_set_hl(0, 'rainbowcol1', { fg = "#ffffff", bold = false}) -- bold white
vim.api.nvim_set_hl(0, 'rainbowcol2', { fg = "#a0ffff", bold = false}) -- blueish
vim.api.nvim_set_hl(0, 'rainbowcol3', { fg = "#80ff80", bold = false}) -- greenish
vim.api.nvim_set_hl(0, 'rainbowcol4', { fg = "#ffc0c0", bold = false}) -- redish
vim.api.nvim_set_hl(0, 'rainbowcol5', { fg = "#ffff40", bold = false}) -- yellowish
vim.api.nvim_set_hl(0, 'rainbowcol6', { fg = "#c0c0c0", bold = false}) -- gray
vim.api.nvim_set_hl(0, 'rainbowcol7', { fg = "#c0c000", bold = false}) -- brown

local testlevel1 = {
    testlevel2 = {
        testlevel3 = {
            testlevel4 = {
                testlevel5 = {
                    testlevel6 = {
                        testlevel7 = {
                            foo = 1,
                        }
                    }
                }
            }
        }
    }
}
