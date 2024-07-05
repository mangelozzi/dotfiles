-- Settings, refer to: https://github.com/TimUntersberger/neogit

local Plugin = {
    "NeogitOrg/neogit",
    dependencies = {"nvim-lua/plenary.nvim"},
    commit = 'c5e09bfcc18fa9ff',
    -- keys = {'<leader>i'},
}

Plugin.config = function()
    require("neogit").setup({
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        -- The time after which an output console is shown for slow running commands
        console_timeout = 5000,
        -- Automatically show console if a command takes more than console_timeout milliseconds
        -- If don't send to console, get lots of popups
        auto_show_console = true, -- Setting any section to `false` will make the section not render at all
        sections = {
            sequencer = {
                folded = false,
                hidden = false
            },
            untracked = {
                folded = true, -- By default fold untracked
                hidden = false
            },
            unstaged = {
                folded = false,
                hidden = false
            },
            staged = {
                folded = false,
                hidden = false
            },
            stashes = {
                folded = true,
                hidden = false
            },
            unpulled_upstream = {
                folded = true,
                hidden = false
            },
            unmerged_upstream = {
                folded = false,
                hidden = false
            },
            unpulled_pushRemote = {
                folded = true,
                hidden = false
            },
            unmerged_pushRemote = {
                folded = false,
                hidden = false
            },
            recent = {
                folded = true,
                hidden = false
            },
            rebase = {
                folded = true,
                hidden = false
            }
        },
        -- override/add mappings
        mappings = {
            finder = {
                ["<cr>"] = "Select",
                ["<c-c>"] = "Close",
                ["<esc>"] = "Close",
                ["<c-n>"] = "Next",
                ["<c-p>"] = "Previous",
                ["<down>"] = "Next",
                ["<up>"] = "Previous",
                ["<tab>"] = "MultiselectToggleNext",
                ["<s-tab>"] = "MultiselectTogglePrevious",
                ["<c-j>"] = "NOP"
            },
            -- Setting any of these to `false` will disable the mapping.
            popup = {
                ["?"] = "HelpPopup",
                ["A"] = false, -- "CherryPickPopup",
                ["d"] = "DiffPopup",
                ["M"] = false, -- "RemotePopup",
                ["P"] = false, -- "PushPopup",
                ["X"] = false, -- "ResetPopup",
                ["Z"] = false, -- "StashPopup",
                ["b"] = false, -- "BranchPopup",
                ["c"] = false, -- "CommitPopup",
                ["f"] = false, -- "FetchPopup",
                ["l"] = false, -- "LogPopup",
                ["m"] = false, -- "MergePopup",
                ["p"] = false, -- "PullPopup",
                ["r"] = false, -- "RebasePopup",
                ["v"] = false, -- "RevertPopup",
                ["w"] = false, -- "WorktreePopup",
            },
            status = {
                ["q"] = "Close",
                ["<ESC>"] = "Close", -- Michael
                ["I"] = false, -- "InitRepo",
                ["1"] = "Depth1",
                ["2"] = "Depth2",
                ["3"] = "Depth3",
                ["4"] = "Depth4",
                ["<tab>"] = "Toggle",
                ["x"] = "Discard",
                ["s"] = "Stage",
                ["S"] = false, -- "StageUnstaged",
                ["<c-s>"] = false, -- "StageAll",
                ["u"] = "Unstage",
                ["U"] = false, -- "UnstageStaged",
                ["$"] = "CommandHistory",
                ["<c-r>"] = "RefreshBuffer",
                ["<enter>"] = "GoToFile",
                ["o"] = "GoToFile", -- Michael
                ["<c-v>"] = "VSplitOpen", -- <--- USE THIS
                ["<c-x>"] = "SplitOpen", -- <--- USE THIS
                ["<c-t>"] = "TabOpen", -- "TabOpen",
                ["{"] = false, -- "GoToPreviousHunkHeader",
                ["}"] = false, -- "GoToNextHunkHeader",
                ["<c-p>"] = "GoToPreviousHunkHeader",
                ["<c-n>"] = "GoToNextHunkHeader"
            }
        }
    })
    -- KEY MAPS TO START NEOGIT
    -- Prefer '<leader>i' to '<leader>g' cause can open git review with one hand while drinking water with other

    -- Map <leader>g to opening neogit
    vim.keymap.set("n", "<leader>i", function() require('neogit').open({ kind = 'tab' }) end, {noremap = true, desc = "Neogit"})

    -- This does not work, using for DiffView instead
    -- vim.api.nvim_set_keymap('n', '<leader>I', ":lua require('neogit').open({ cwd='/home/michael/.config/' })<CR>", {noremap = true, desc = ""})
end

return Plugin
