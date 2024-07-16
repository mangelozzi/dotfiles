--[[
Check any conflicting keymaps that will prevent triggering WhichKey:
:checkhealth which-key

--]]


local Plugin = {
    "folke/which-key.nvim",
    event = "VeryLazy",
    -- cond = false,
    init = function()
        vim.o.timeout = true
        -- vim.o.timeoutlen = 300 -- default is 1000
    end
}

Plugin.config = function()
    local wk = require("which-key")
    wk.setup {
        preset = "modern",
        delay = vim.o.timeoutlen,
        plugins = {
            marks = false, -- cant set them on a delay
            registers = false, -- cant set them on a delay
        },
        win = {
            height = {min = 4, max = 42} -- min and max height of the columns
        },
        icons = {
            rules = false,
        },
        modes = {
            x = false,
        },
        -- triggers_nowait = {
        --     -- marks
        --     -- "`",
        --     -- "'",
        --     -- "g`",
        --     -- "g'",
        --     -- registers
        --     -- '"',
        --     -- "<c-r>",
        --     -- spelling
        --     "z="
        -- },
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
    wk.add({
        -- Wrap text (built in) - default is gq, but requires textwidth to be none zero, built in, but does not show up in which key by default
        { "gw", desc = "Wrap text"},
    })
end

return Plugin
