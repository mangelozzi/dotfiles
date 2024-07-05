require("namespace/globals")  -- Globals variables/settings
require("namespace/opt")      -- Set various vim options and related commands
require("namespace/cmd")      -- Run various vim commands
require("namespace/usercmd")  -- Create own user commands
require("namespace/keymap")   -- Hotkey mappings
require("namespace/autocmds") -- Auto commands
require("namespace/colors")   -- Color theme, must be after 'opt', changes settings
require("namespace/status")   -- Status line
require("namespace/lazy")     -- Enable plugins - AFTER: keymap so correct leader used
