-- TITLECASE
-- https://github.com/christoomey/vim-titlecase
-- https://www.youtube.com/watch?v=wlR5gYd6um0#t=27m40
-- Create operator to title case over a range
-- gT = Title case
-- gTT = Title case the whole line
-- e.g. "foo bar" -> "Foo Bar"
-- gT used for switching buffers, disable default hotkeys with:
-- Menomic h = heading

local Plugin = {
    "christoomey/vim-titlecase",
    keys = {
        {"<leader>gh", "<leader>gH"}
    },
    init = function()
        -- Require to set it before plug loads
        vim.g.titlecase_map_keys = 0
    end
}

Plugin.config = function()
    vim.keymap.set({"n", "x"}, "gh", "<Plug>Titlecase", {noremap = true})
    vim.keymap.set({"n", "x"}, "gH", "<Plug>TitlecaseLine", {noremap = true})
end

return Plugin
