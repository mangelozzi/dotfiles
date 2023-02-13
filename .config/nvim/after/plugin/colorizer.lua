if not require("namespace.utils").get_is_installed("nvim-colorizer.lua") then return end

-- norcalli/nvim-colorizer.lua
-- Colour background
-- mode = foreground or background
require('colorizer').setup({}, {
    mode = 'background';
})
