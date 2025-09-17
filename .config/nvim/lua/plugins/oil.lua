local Plugin = {
    "stevearc/oil.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"}
    -- cmd = "Oil",
    -- keys = {"<leader>O"},
}

Plugin.config = function()
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
        keymaps = {
            ["<C-c>"] = false, -- disable this default mapping
            ["<esc>"] = "actions.close",
        }
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        -- (:help prompt_save_on_select_new_entry)
        -- prompt_save_on_select_new_entry = true, -- this is the default
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
    }

    vim.keymap.set("n", "<leader>O", function()
        require("oil").toggle_float()
        -- require("oil").open()
    end, {noremap = true, desc = "Oil"})

    -- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

end

return Plugin
