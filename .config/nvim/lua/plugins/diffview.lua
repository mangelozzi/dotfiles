local Plugin = {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
}
Plugin.config = function()
    require('diffview').setup({
        keymaps = {
            view = {
                -- The `view` bindings are active in the diff buffers, only when the current
                -- tabpage is a Diffview.
                -- { "n", "<ESC>",      actions.close,                      { desc = "Open the diff for the next file" } },
                {"n", "<ESC>", function()
                        vim.cmd("DiffviewClose")
                    end, {desc = "Close it"}}
            },
            file_panel = {
                -- The source code window
                {"n", "h", require("diffview.actions").close_fold, {desc = "Collapse fold"}},
                {"n", "zc", require("diffview.actions").close_fold, {desc = "Collapse fold"}},
                {"n", "za", require("diffview.actions").toggle_fold, {desc = "Toggle fold"}},
                {"n", "zR", require("diffview.actions").open_all_folds, {desc = "Expand all folds"}},
                {"n", "zM", require("diffview.actions").close_all_folds, {desc = "Collapse all folds"}}
            },
            file_history_panel = {
                {"n", "<ESC>", function()
                        vim.cmd("DiffviewClose")
                    end, {desc = "Close it"}}
            }
        }
    })
    local function custom_open_diffview()
        -- The filepath will change, so have to by dynamically calculated on each call
        local raw_path = vim.fn.expand("%:p")
        -- Resolve symlinks
        local utils = require("namespace.utils")
        local file = utils.get_return_value("realpath " .. raw_path)
        local is_git_file = os.execute("git ls-files --error-unmatch " .. file) == 0
        if is_git_file then
            local is_changed = os.execute("git diff --exit-code " .. file) ~= 0
            if is_changed then
                -- local git_file_path = utils.get_return_value('git ls-files ' .. file)
                print("DIFF:", file)
                vim.cmd("DiffviewOpen -- " .. file)
                -- Refer to :h diffview-config-view.x.layout
                -- local actions = require("diffview.actions")
                local actions = require("diffview.actions")
                actions.toggle_files()
            else
                print("NO CHANGES:", file)
            end
        else
            print("NOT IN GIT:", file)
        end
    end

    -- Dont show edited files on left
    vim.keymap.set({"n", "x"}, "<leader>gd", custom_open_diffview, {noremap = true, desc = "(D)iffview open"})

    -- This is the standard open
    -- vim.keymap.set({'n', 'x'}, '<leader>I', function() vim.cmd('DiffviewOpen') end, { noremap = true} )

    -- Show a history of current file
    vim.keymap.set( {"n", "x"}, "<leader>gf", function() vim.cmd("DiffviewFileHistory %") end, {noremap = true, desc = "Diffview (f)ile history"})
    -- Show a history of changed files
    vim.keymap.set( {"n", "x"}, "<leader>gh", function() vim.cmd("DiffviewFileHistory") end, {noremap = true, desc = "Diffview (h)istory"})
end

return Plugin
