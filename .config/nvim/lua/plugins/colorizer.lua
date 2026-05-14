-- Color Hex codes with the color
vim.pack.add {
    {
        src = "https://github.com/norcalli/nvim-colorizer.lua",
        name = "nvim-colorizer.lua"
    }
}

require("colorizer").setup(
    {},
    -- The 2nd setup arg is for default options
    {
        mode = "background" -- by default color the background
    }
)
