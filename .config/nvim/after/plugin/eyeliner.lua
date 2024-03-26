if not require("namespace.utils").get_is_installed("eyeliner.nvim") then return end

require('eyeliner').setup({
    highlight_on_key = true, -- show highlights only after keypress
    dim = true              -- dim all other characters if set to true (required highlight_on_key to be true)
})
