-- Settings, refer to: https://github.com/NeogitOrg/neogit
-- Force version update with
--  :lua vim.pack.update({ "neogit" }, { force = true })

vim.pack.add {
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    {
        src = "https://github.com/NeogitOrg/neogit",
        version = "99326a1310fb2d61",
    },
}

require("neogit").setup({
    -- Set to false because I want to be responsible for ALL keymappings.
    -- This prevents Neogit from stealing normal Vim motions like j/k, {, }, etc.
    use_default_keymaps = false,

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
            hidden = false,
        },
        untracked = {
            folded = true, -- By default fold untracked
            hidden = false,
        },
        unstaged = {
            folded = false,
            hidden = false,
        },
        staged = {
            folded = false,
            hidden = false,
        },
        stashes = {
            folded = true,
            hidden = false,
        },
        unpulled_upstream = {
            folded = true,
            hidden = false,
        },
        unmerged_upstream = {
            folded = false,
            hidden = false,
        },
        unpulled_pushRemote = {
            folded = true,
            hidden = false,
        },
        unmerged_pushRemote = {
            folded = false,
            hidden = false,
        },
        recent = {
            folded = true,
            hidden = false,
        },
        rebase = {
            folded = true,
            hidden = false,
        },
    },

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
            ["<c-j>"] = "NOP",
        },

        popup = {
            ["?"] = "HelpPopup",
            ["i"] = "DiffPopup",
        },

        status = {
            ["q"] = "Close",
            ["<esc>"] = "Close", -- Michael
            ["1"] = "Depth1",
            ["2"] = "Depth2",
            ["3"] = "Depth3",
            ["4"] = "Depth4",
            ["<tab>"] = "Toggle",
            ["d"] = "Discard", -- Was "x", but "x" in nim-tree is cut, and delete is "d", make same as delete in tree
            ["s"] = "Stage",
            ["u"] = "Unstage",
            ["$"] = "CommandHistory",
            ["<c-r>"] = "RefreshBuffer",
            ["<enter>"] = "GoToFile",
            ["o"] = "GoToFile", -- Michael
            ["<c-v>"] = "VSplitOpen", -- <--- Same as Fzf-lua
            ["<c-s>"] = "SplitOpen", -- <--- Same as Fzf-lua
            ["<c-t>"] = "TabOpen", -- "TabOpen"
            ["<c-p>"] = "GoToPreviousHunkHeader",
            ["<c-n>"] = "GoToNextHunkHeader",
        },

        commit_editor = {
            ["q"] = "Close",
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
        },

        commit_editor_I = {
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
        },

        rebase_editor = {
            ["q"] = "Close",
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
        },

        rebase_editor_I = {
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
        },

        commit_view = {},

        refs_view = {},
    },
})

-- KEY MAPS TO START NEOGIT
local function open_neogit_on_current_buffer()
    local function cursor_to_line(patterns)
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

        for _, pattern in ipairs(patterns) do
            local escaped_pattern = string.gsub(pattern, "[%p]", "%%%1")

            for i, line in ipairs(lines) do
                if line:match(escaped_pattern) then
                    vim.api.nvim_win_set_cursor(0, { i, 0 }) -- If pattern is found, move the cursor to the matching line
                    return true
                end
            end
        end

        return false
    end

    local function line_after_cursor_starts_with_atat()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local next_line_nr = cursor_pos[1] + 1
        local total_lines = vim.api.nvim_buf_line_count(0)

        if next_line_nr > total_lines then
            return false
        end

        local next_line = vim.api.nvim_buf_get_lines(0, next_line_nr - 1, next_line_nr, false)[1]
        return vim.startswith(next_line, "@@")
    end

    local function open_callback(file_patterns)
        if not cursor_to_line(file_patterns) then
            return
        end

        if not line_after_cursor_starts_with_atat() then
            -- Send a tab to open the file
            local keys = vim.api.nvim_replace_termcodes("<tab>", true, false, true)
            vim.api.nvim_feedkeys(keys, "i", false) -- Is insert mode!!

            vim.defer_fn(function()
                cursor_to_line(file_patterns)
            end, 20)
        end
    end

    local filename = vim.api.nvim_buf_get_name(0)

    if filename == "" then
        require("neogit").open({ kind = "tab" })
        return
    end

    local git_root = assert(vim.fs.root(filename, ".git"), "Could not find git root for current buffer")
    local file_rel = assert(vim.fs.relpath(git_root, filename), "Could not make current buffer path relative to git root")
    local cwd_rel = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")

    local group = vim.api.nvim_create_augroup("MyNeogitGroup", { clear = true })

    vim.api.nvim_create_autocmd("User", {
        desc = "A temp autocmd to open neogit on current buffer",
        pattern = "NeogitStatusRefreshed",
        group = group,
        once = true,
        callback = function()
            vim.defer_fn(function()
                -- Neogit needs time to settle, or else detecting next line is incorrect
                open_callback({ file_rel, cwd_rel })
            end, 50)
        end,
    })

    require("neogit").open({
        kind = "tab",
        cwd = git_root,
    })
end

-- Use <leader>g as a prefix for bunch of other git related commands, this keep fast
vim.keymap.set("n", "<leader>j", function()
    open_neogit_on_current_buffer()
end, { noremap = true, desc = "Neogit buffer" })

vim.keymap.set("n", "<leader>J", function()
    require("neogit").open({ kind = "tab" })
end, { noremap = true, desc = "Neogit" })
