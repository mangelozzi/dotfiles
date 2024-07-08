--[[
Check any conflicting keymaps that will prevent triggering WhichKey:
:checkhealth which-key

--]]


local Plugin = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        -- vim.o.timeoutlen = 300 -- default is 1000
    end
}

Plugin.config = function()
    local wk = require("which-key")
    wk.setup {
        layout = {
            height = {min = 4, max = 42} -- min and max height of the columns
        },
        triggers_nowait = {
            -- marks
            -- "`",
            -- "'",
            -- "g`",
            -- "g'",
            -- registers
            -- '"',
            -- "<c-r>",
            -- spelling
            "z="
        },
        operators = {
            -- Doesnt work, see: https://github.com/folke/which-key.nvim/issues/623
        },
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            -- ["<space>"] = "SPC",
            -- ["<cr>"] = "RET",
            -- ["<tab>"] = "TAB",
        },
    }
    vim.keymap.set(
        "n",
        "<leader>?",
        function()
            vim.cmd("WhichKey")
        end,
        {noremap = true, desc = "Show which-key mappings"}
    )
    -- Register own mappings
    wk.register({
        -- Wrap text (built in) - default is gq, but requires textwidth to be none zero, built in, but does not show up in which key by default
        gw = "Wrap text", 
    })
end

return Plugin
