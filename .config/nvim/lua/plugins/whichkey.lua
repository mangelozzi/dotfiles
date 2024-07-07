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
    require("which-key").setup {
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
            -- gw = "Wrap lines2",
            -- gf = "Format text2",
        }
    }
    vim.keymap.set(
        "n",
        "<leader>?",
        function()
            vim.cmd("WhichKey")
        end,
        {noremap = true, desc = "Show which-key mappings"}
    )
end

return Plugin
