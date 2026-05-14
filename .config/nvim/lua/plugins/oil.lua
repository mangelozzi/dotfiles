

vim.pack.add({
    {
        src = "https://github.com/nvim-tree/nvim-web-devicons",
        name = "nvim-web-devicons",
    },
})
vim.pack.add({
    {
        src = "https://github.com/stevearc/oil.nvim",
        name = "oil.nvim",
    },
})
require("oil").setup {
    -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
    -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
    default_file_explorer = true,
    win_options = {
        wrap = true,
        colorcolumn = "",
    },
    -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
    delete_to_trash = true,
    -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
    skip_confirm_for_simple_edits = true,
    view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- Sort file names in a more intuitive order for humans. Is less performant,
        -- so you may want to set to false if you work with large directories.
        natural_order = true,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, _)
            -- vim.startswith(name, ".")
            return name == ".." or name == ".git" or name == "__pycache__"
        end
    },
    float = {
        padding = 2,
        max_width = 120,
        -- max_height = 0
    },
    use_default_keymaps = false,
    keymaps = {
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        -- (:help prompt_save_on_select_new_entry)
        -- prompt_save_on_select_new_entry = true, -- this is the default
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        -- ["g?"] = { "actions.show_help", mode = "n" },
        ["?"] = { "actions.show_help", mode = "n", desc = "This help" }, -- changed from g?
        ["<CR>"] = "actions.select",
        ["o"] = "actions.select", -- Mike added
        ["<leader>v"] = { "actions.select", opts = { vertical = true }, desc = "Split (V)ertically" },
        ["<leader>h"] = { "actions.select", opts = { horizontal = true }, desc = "Split (H)ertically" },
        -- ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        -- ["<C-c>"] = { "actions.close", mode = "n" },
        ["<esc>"] = { "actions.close", mode = "n", desc = "Close" }, -- Mike
        -- ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n", desc = "Parent" },
        ["_"] = { "actions.open_cwd", mode = "n", desc = "Open CWD" },
        ["`"] = { "actions.cd", mode = "n", desc="CD" },
        -- ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n", desc = "Change sort" },
        ["gx"] = { "actions.open_external", desc = "Open external" },
        ["g."] = { "actions.toggle_hidden", mode = "n", desc = "Toggle hidden" },
        -- ["g\\"] = { "actions.toggle_trash", mode = "n", desc="Toggle Trash" },
    }
}

-- IN CURRENT WINDOW
vim.keymap.set("n", "<leader>o", function()
    require("oil").open()
end, {noremap = true, desc = "Oil"})
-- FLOAT WINDOW
vim.keymap.set("n", "<leader>O", function()
    require("oil").toggle_float()
end, {noremap = true, desc = "Oil"})
-- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
