-- The expanded version of ~/.config/nvim
if true then
    vim.g.nvim_path = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h")

    require("namespace/globals")  -- Globals variables/settings
    require("namespace/opt")      -- Set various vim options and related commands
    require("namespace/cmd")      -- Run various vim commands
    require("namespace/usercmd")  -- Create own user commands
    require("namespace/keymap")   -- Hotkey mappings
    require("namespace/autocmds") -- Auto commands
    require("namespace/colors")   -- Color theme, must be after 'opt', changes settings
    require("namespace/status")   -- Status line
    require("namespace/lazy")     -- Enable plugins - AFTER: keymap so correct leader used
    require("namespace/greeter")  -- Show a greeter
    -- require("namespace/startup")  -- Run this at start up
end
