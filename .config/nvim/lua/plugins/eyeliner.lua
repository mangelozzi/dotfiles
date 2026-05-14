vim.pack.add {
    {
        src = "https://github.com/jinh0/eyeliner.nvim",
        name = "eyeliner.nvim"
    }
}

require("eyeliner").setup(
    {
        highlight_on_key = true, -- show highlights only after keypress
        dim = true -- dim all other characters if set to true (required highlight_on_key to be true)
    }
)
