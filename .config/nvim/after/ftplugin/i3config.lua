vim.opt_local.iskeyword:append {'-', '$', '+'}

local i3Group = vim.api.nvim_create_augroup("i3Group", {clear = true})

vim.api.nvim_create_autocmd(
    "BufWritePost",
    {
        desc = "Restart i3 after adjusting the config",
        group = i3Group,
        pattern = "**/i3/config",
        callback = function()
            vim.cmd("!i3 restart")
        end,
    }
)
