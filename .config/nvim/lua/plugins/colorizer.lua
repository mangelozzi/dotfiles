-- Color Hex codes with the color

return {
    "norcalli/nvim-colorizer.lua",
    cmd = "ColorizerAttachToBuffer",
    config = function()
        require("colorizer").setup(
            {},
            -- The 2nd setup arg is for default options
            {
                mode = "background" -- by default color the background
            }
        )
    end
}
