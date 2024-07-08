local Plugin = {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
}

Plugin.config = function()
    require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
    })
end

return Plugin
