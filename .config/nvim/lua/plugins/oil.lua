local Plugin = {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Oil",
    keys = {"<leader>O"},
}

Plugin.config = function()
    require("oil").setup({
        skip_confirm_for_simple_edits = true,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        -- (:help prompt_save_on_select_new_entry)
        prompt_save_on_select_new_entry = true, -- this is the default
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        -- keymaps = {
        --     ["g?"] = "actions.show_help",
        --     ["<CR>"] = "actions.select",
        --     ["<C-s>"] = "actions.select_vsplit",
        --     ["<C-h>"] = "actions.select_split",
        --     ["<C-t>"] = "actions.select_tab",
        --     ["<C-p>"] = "actions.preview",
        --     ["<C-c>"] = "actions.close",
        --     ["<C-l>"] = "actions.refresh",
        --     ["-"] = "actions.parent",
        --     ["_"] = "actions.open_cwd",
        --     ["`"] = "actions.cd",
        --     ["~"] = "actions.tcd",
        --     ["gs"] = "actions.change_sort",
        --     ["gx"] = "actions.open_external",
        --     ["g."] = "actions.toggle_hidden",
        --     ["g\\"] = "actions.toggle_trash"
        -- },
        -- Configuration for the floating keymaps help window
    })

    print('set oil commands')
    vim.keymap.set("n", "<leader>O", function() require("oil").toggle_float() end, {noremap = true, desc = "Oil"})
    -- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

return Plugin
