-- :help api-autocmd

local ThemeGroup = vim.api.nvim_create_augroup("ThemeGroup", {clear = true})

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
    group = ThemeGroup,
    pattern = "*",
    desc = "Enable cursorline on entering relevant buffers",
    command = "setlocal cursorline",
})

vim.api.nvim_create_autocmd("WinLeave", {
    group = ThemeGroup,
    pattern = "*",
    desc = "Disable cursorline on leaving window",
    command = "setlocal nocursorline",
})

vim.api.nvim_create_autocmd("InsertEnter", {
    group = ThemeGroup,
    pattern = "*",
    desc = "Change CursorLine highlight on entering insert mode",
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLine", { link = "cursorline" })
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    group = ThemeGroup,
    pattern = "*",
    desc = "Revert CursorLine highlight on leaving insert mode",
    callback = function()
        vim.api.nvim_set_hl(0, "CursorLine", { link = "cursorline_insert" })
    end,
})

-- vim.api.nvim_create_autocmd(
--     "BufWritePost",
--     {
--         desc = "Update the color theme after saving, for tweaking colors in realtime",
--         group = ThemeGroup,
--         pattern = {"*.lua"},
--         callback = function()
--             require("theme/init").reload_colors()
--             print("Colours reloaded")
--         end
--     }
-- )
