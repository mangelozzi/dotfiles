local Plugin = {
    "jinh0/eyeliner.nvim"
}

Plugin.config = function()
    require("eyeliner").setup(
        {
            highlight_on_key = true, -- show highlights only after keypress
            dim = true -- dim all other characters if set to true (required highlight_on_key to be true)
        }
    )
end

return Plugin
