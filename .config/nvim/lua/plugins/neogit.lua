-- Settings, refer to: https://github.com/TimUntersberger/neogit

local Plugin = {
    "NeogitOrg/neogit",
    dependencies = {"nvim-lua/plenary.nvim"},
    commit = 'c5e09bfcc18fa9ff', -- older faithful, when open repo in browser broke stuff
    -- keys = {'<leader>i'},
    event = "VeryLazy",
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
                -- ["<c-s>"] = false, -- "StageAll",
                ["u"] = "Unstage",
                ["U"] = false, -- "UnstageStaged",
                ["$"] = "CommandHistory",
                ["<c-r>"] = "RefreshBuffer",
                ["<enter>"] = "GoToFile",
                ["o"] = "GoToFile", -- Michael
                ["<c-v>"] = "VSplitOpen", -- <--- Same as Fzf-lua
                ["<c-s>"] = "SplitOpen", -- <--- Same as Fzf-lua
                ["<c-t>"] = "TabOpen", -- "TabOpen",
                ["{"] = false, -- "GoToPreviousHunkHeader",
                ["}"] = false, -- "GoToNextHunkHeader",
                ["<c-p>"] = "GoToPreviousHunkHeader",
                ["<c-n>"] = "GoToNextHunkHeader"
            }
        }
    })

    -- KEY MAPS TO START NEOGIT

    local function open_neogit_on_current_buffer()
        local function cursor_to_line(pattern)
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local esccaped_pattern = string.gsub(pattern, "[%p]", "%%%1")
            for i, line in ipairs(lines) do
                if line:match(esccaped_pattern) then
                    vim.api.nvim_win_set_cursor(0, {i, 0}) -- If pattern is found, move the cursor to the matching line
                    return
                end
            end
        end

        local function open_callback(augroup_id, file_rel)
            vim.api.nvim_del_augroup_by_id(augroup_id)
            -- Send a tab to open the file
            local keys = vim.api.nvim_replace_termcodes('<tab>',true,false,true)
            vim.api.nvim_feedkeys(keys,'i',false) -- Is insert mode!!
            cursor_to_line(file_rel)
        end

        local filename = vim.api.nvim_buf_get_name(0)
        if (filename ~= "") then
            local file_rel = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
            -- local escaped_file = vim.fn.escape(file_rel, '\\/.*$^~[]')
            local MyNeogitGroup = vim.api.nvim_create_augroup("MyNeogitGroup", {clear = true})
            vim.api.nvim_create_autocmd(
                "User",
                {
                    desc = "A temp autocmd to open neogit on current buffer",
                    pattern = "NeogitStatusRefreshed",
                    group = MyNeogitGroup,
                    callback = function()
                        open_callback(MyNeogitGroup, file_rel)
                    end
                }
            )
        end
        require('neogit').open({kind = 'tab'})
    end

    -- Use <leader>g as a prefix for bunch of other git related commands, this keep fast
    vim.keymap.set("n", "<leader>i", function() open_neogit_on_current_buffer() end, {noremap = true, desc = "Neogit buffer"})
    vim.keymap.set("n", "<leader>I", function() require('neogit').open({ kind = 'tab' }) end, {noremap = true, desc = "Neogit"})

end

return Plugin
