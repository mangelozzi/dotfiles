-- Refer to :h diffview-config-view.x.layout
local actions = require("diffview.actions")
require("diffview").setup({
    enhanced_diff_hl = false, -- See |diffview-config-enhanced_diff_hl|
    use_icons = true,         -- Requires nvim-web-devicons
    show_help_hints = true,   -- Show hints for how to open the help panel
    watch_index = true,       -- Update views and index buffers when the git index changes.
    icons = {                 -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
    },
    hooks = { -- See ':h diffview-config-hooks'
        view_opened = function()
            -- Hide the files panel
            require("diffview.actions").toggle_files()
        end,
    },
    keymaps = {
        view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            -- { "n", "<ESC>",      actions.close,                      { desc = "Open the diff for the next file" } },
            { "n", "<ESC>", function() vim.cmd('tabclose') end,                      { desc = "Open the diff for the next file" } },
        },
    },
})

local function custom_open_diffview()
    -- The filepath will change, so have to by dynamically calculated on each call
    local raw_path = vim.fn.expand('%:p')
    -- Resolve symlinks
    local utils = require('namespace.utils')
    local file = utils.get_return_value('realpath ' .. raw_path)
    local is_git_file = os.execute('git ls-files --error-unmatch '.. file) == 0
    if is_git_file then
        local is_changed = os.execute('git diff --exit-code ' .. file) ~= 0
        if is_changed then
            -- local git_file_path = utils.get_return_value('git ls-files ' .. file)
            print("DIFF:", file)
            vim.cmd('DiffviewOpen -- ' .. file)
        else
            print("NO CHANGES:", file)
        end
    else
        print("NOT IN GIT:", file)
    end
end
vim.keymap.set({'n', 'x'}, '<leader>I', custom_open_diffview, { noremap = true} )
