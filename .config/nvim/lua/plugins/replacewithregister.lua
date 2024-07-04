-- REPLACE WITH REGISTER
-- https://github.com/vim-scripts/ReplaceWithRegister
-- https://www.youtube.com/watch?v=wlR5gYd6um0#t=26m49
-- [count]["x]gr{motion} = Replace {motion} text with the contents of register x.
--                         Especially when using the unnamed register, this is
--                         quicker than "_d{motion}P or "_c{motion}<C-R>"
-- [count]["x]grr        = Replace [count] lines with the contents of register x.
--                         To replace from the cursor position to the end of the
--                         line use ["x]gr$
-- {Visual}["x]gr        = Replace the selection with the contents of register x.
-- Use gr for the default go references, used by LSP
-- Mnemonic: TAB is like switch

local Plugin = {
    "vim-scripts/ReplaceWithRegister",
    keys = {"<leader>k", "<leader>kk", "<leader>K"},
}

Plugin.config = function()
    vim.keymap.set("n", "<leader>k", "<Plug>ReplaceWithRegisterOperator", {})
    vim.keymap.set("n", "<leader>kk", "Plug>ReplaceWithRegisterLine", {})
    vim.keymap.set("x", "<leader>k", "<Plug>ReplaceWithRegisterVisual", {})
    vim.keymap.set("n", "<leader>K", "<leader>k$", {})
end

return Plugin
