--[[
- Install FZF on path by using ~/.config/install/utils.sh
- let $FZF_DEFAULT_OPTS=' --color fg:#D8DEE9,bg:#2E3440,hl:#40a000,fg+:#D8DEE9,bg+:#434C5E,hl+:#60d000,pointer:#fF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'
- Way more here: https://github.com/ibhagwan/fzf-lua#misc
- See all config options here: https://github.com/ibhagwan/fzf-lua#default-options
- Fzf-lua plugin author ibhagwan's configuration: https://github.com/ibhagwan/nvim-lua/blob/64812566ae22fac5eca742a46ad92a813b746bb9/lua/plugins/fzf-lua/setup.lua#L138-L141


Fzf-Lua's Grep + Fuzzy search combo is a superpower
https://www.reddit.com/r/neovim/comments/1dlfu4o/fzfluas_grep_fuzzy_search_combo_is_a_superpower

Being able to grep across an entire project is one thing, but then being able
to fuzzy find over the results feels like a superpower. Fzf-Lua let's you fuzzy
find the results of a grep by simply pressing ctrl-g. This is even more
powerful when you consider the fact that the fuzzy search: a) includes file
paths, allowing you to filter the results to a specific directory and b) lets
you exclude some results by using the ! opator, which also works on the file
paths and can be used to prune out multiple directories. This combo,
specifically grep + fzf, and being able to seamlessly switch between them just
by pressing ctrl-g, has saved me so much time and energy. Even working in a
very large codebase, I can still get a list of exactly what I need in a matter
of seconds, and in such a satisfying way. It feels like an essential searching
mechanism that every editor should have. I know a lot of editors have a grep
search, and they usually have a fuzzy finder for file searching too, but none
that I know of facilitate the combination of both. Particularly in such an
elegant way, within a single, unified, easily accessible view. I really
appreciate this plugin and u/iBhagwan for the great work.

The feature you’re talking about is one of my favorites and most used, it’s
even turbo charged when you use live_grep_glob (or set rg_glob=true) and then
search for a regex limited to specific files, I.e foo.*bar -- *.lua !*spec*
which means search for a line that has both foo AND bar inside lua files
excluding spec files (tests), then I ctrl-g to fuzzy for the fine tuning.


Q: How do you select files put them in the quick list? A: With the default
mappings: tab selects/deselects items, alt-a toggles selection of all, alt-q
sends selected to quick fix list but it’s not even required the default action
sends selection to quick fix if you selected multiple files.

https://github.com/ibhagwan/fzf-lua/discussions/1144
That said, fzf has useful binds for line editing, for example ctrl-w to delete last word, ctrl-u to clear the line, etc, see man Fzf for the full list.

--]]

local Plugin = {
    "ibhagwan/fzf-lua",
    commit = "b442569ab827",
    -- not lazy loaded so we can show oldfiles picker at startup
    -- optional for icon support
    dependencies = {"nvim-tree/nvim-web-devicons"},
    build = "./install --bin",
}

local fd_exclude = ""
    .. " -E '**/__pycache__'"
    .. " -E '**/temp' "
    .. " -E '**/spike' "
    .. " -E '**/htmlcov'"
    .. " -E '**/static/**/jsapp'"
    .. " -E '**/static/**/wcapp'"
    .. " -E '**/.angular'"
    .. " -E '**/node_modules'"
    -- File types
    .. " -E '*.jpg'"
    .. " -E '*.png'"
    .. " -E '*.zip'"
    .. " -E '*.git'"
    .. " -E '*.min.css'"
    .. " -E '*.min.js'"
-- --type file will not show symlinks
-- --follow will follow symlinks
local fd_dist_ignore= "--type file --type symlink --follow --no-ignore" .. fd_exclude .. " -E 'distros'"
local fd_distros_ignore= "--type file --no-ignore" .. fd_exclude

Plugin.config = function()
    local fzf = require('fzf-lua')
    local actions = fzf.actions

    fzf.setup {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        -- set to '' for a non-value flag
        -- for raw args use `fzf_args` instead
        fzf_opts = {
            -- ["--layout"] = "reverse-list",
            -- ["--border"] = "none"
            ["--keep-right"] = "", -- If a line is long, truncate the front of the line
            ["--tiebreak"] = "end"
        },
        -- fzf '--color=' options (optional)
        -- Sets the colors of FZF (not the colors of FZF-Lua interface
        -- Linked to the Hilight groups below
        fzf_colors = {
            -- Line
            ["fg"] = {"fg", "FzfLine"},
            ["bg"] = {"bg", "FzfLine"},
            ["hl"] = {"fg", "FzfLineMatchedFg"},
            -- Selected Line
            ["fg+"] = {"fg", "FzfSelectedLine"},
            ["bg+"] = {"bg", "FzfSelectedLine"},
            ["hl+"] = {"fg", "FzfSelectedLineMatchedFg"},
            -- Misc
            ["info"] = {"fg", "FzfInfoFg"},
            ["prompt"] = {"fg", "FzfPromptFg"},
            ["pointer"] = {"fg", "FzfPointerFg"},
            ["marker"] = {"fg", "FzfMarkerFg"},
            ["spinner"] = {"fg", "FzfSpinnerFg"},
            ["header"] = {"fg", "FzfHeaderFg"},
            ["gutter"] = {"bg", "FzfGutterBg"}
        },
        keymap = {
            builtin = {
                -- Generally useing Alt... for preview
                ["<F1>"] = "toggle-help",
                ["<F2>"] = "toggle-fullscreen",
                -- Only valid with the 'builtin' previewer
                ["<M-w>"] = "toggle-preview-wrap", -- Mnemonic (W)rap
                ["<M-j>"] = "toggle-preview",
                ["<M-k>"] = "toggle-preview",
                -- Rotate preview clockwise/counter-clockwise
                ["<M-h>"] = "toggle-preview-ccw",
                ["<M-l>"] = "toggle-preview-cw",
                ["<M-n>"] = "preview-page-down", -- Easy to switch between pick/previewer scrolling with just ctrl->alt
                ["<M-p>"] = "preview-page-up",
                ["<M-o>"] = "preview-page-reset" -- Mnemonic: (O)rigin
            },
            fzf = {
                -- WARNING: These completely REPLACE the existing bindings
                -- Custom
                ["esc"] = "abort",
                -- fzf '--bind=' options
                ["ctrl-z"] = "abort",
                ["ctrl-u"] = "unix-line-discard",
                ["ctrl-f"] = "half-page-down", -- Match list
                ["ctrl-b"] = "half-page-up", -- Match list
                ["ctrl-a"] = "beginning-of-line",
                ["ctrl-e"] = "end-of-line",
                ["alt-a"] = "toggle-all",
                -- Only valid with fzf previewers (bat/cat/git/etc)
                ["f3"] = "toggle-preview-wrap",
                ["f4"] = "toggle-preview",
                ["alt-n"] = "preview-page-down",
                ["alt-p"] = "preview-page-up"
            }
        },
        winopts = {
            height = 0.85, -- window height
            width = 0.96, -- window width
            preview = {
                horizontal = "right:50%" -- right|left:size
            }
        },
        files = {
            fd_opts = fd_dist_ignore,
        },
        buffers = {prompt = "Buffers >>> "}, -- Buffers❯
        oldfiles = {prompt = "History >>> "},
        lines = {prompt = "Lines >>> "},
        -- optional override of file extension icon colors
        -- available colors (terminal):
        --    clear, bold, black, red, green, yellow
        --    blue, magenta, cyan, grey, dark_grey, white
        file_icon_colors = {
            -- Does not seem to work for me
            ["sh"] = "green"
        },
        actions = {
            buffers = {
                -- providers that inherit these actions: buffers, tabs, lines, blines
                -- Preserve existing
                ["default"]     = actions.buf_edit,
                ["ctrl-s"]      = actions.buf_split, -- Made Neogit match this
                ["ctrl-v"]      = actions.buf_vsplit, -- Made Neogit match this
                ["ctrl-t"]      = actions.buf_tabedit,
                -- When on :buffers, pressing <Ctrl-Space> will resume with files
                ["Ctrl-space"]  = function(_, opts) fzf.files({ query=opts.last_query, cwd=opts.cwd }) end, -- _ = sel
                ["Ctrl-h"]      = function(_, opts) fzf.oldfiles({ query=opts.last_query, cwd=opts.cwd }) end, -- _ = sel
            },
            --
            files = {
                -- providers that inherit these actions: files, git_files, git_status, grep, lsp oldfiles, quickfix, loclist, tags, btags args
                -- Preserve existing
                ["default"]     = actions.file_edit_or_qf,
                ["ctrl-s"]      = actions.file_split,
                ["ctrl-v"]      = actions.file_vsplit,
                ["ctrl-t"]      = actions.file_tabedit,
                ["alt-q"]       = actions.file_sel_to_qf,
                ["alt-l"]       = actions.file_sel_to_ll,
                -- When on :files, pressing <Ctrl-Space> will resume with buffers
                ["Ctrl-space"]  = function(_, opts) -- _ = sel
                    local current_picker = opts.__INFO.fnc
                    if current_picker == "oldfiles" then
                        -- Change to files if was on old files
                        fzf.files({ query=opts.last_query, cwd=opts.cwd })
                    elseif current_picker == "files" then
                        -- Change to buffers if was on old files
                        fzf.buffers({ query=opts.last_query, cwd=opts.cwd })
                    end
                end,
                ["Ctrl-h"]      = function(_, opts) fzf.oldfiles({ query=opts.last_query, cwd=opts.cwd }) end, -- _ = sel
            },
        },
        previewers = {
            bat = { args = "--color=always --style=default" },
            builtin = {
                title_fnamemodify = function(s) return s end, -- Show the whole path not just the title
                -- ueberzug_scaler   = "cover",
                extensions        = {
                    -- by default the filename is added as last argument
                    -- if required, use `{file}` for argument positioning
                    -- ["gif"]  = img_prev_bin,
                    -- ["png"]  = img_prev_bin,
                    -- ["jpg"]  = img_prev_bin,
                    -- ["jpeg"] = img_prev_bin,
                    ["svg"]  = { "chafa" },
                }
            }
        }
    }
    -- Own
    -- Breakpoints
    vim.keymap.set("n", "<leader><S-DEL>",
        function()
            -- leading dash mean literal match to the word, or else on long lines it finds the words due to fuzzyness
            require("fzf-lua").lines({
                query = "'debugger | 'breakpoint()",
                rg_opts = "--glob '*.js' --glob '*.py'",  -- limit to JS and Python files
                no_esc = true,
            })
        end,
        {noremap = true, silent = true, desc = "FZF breakpoints"}
    )

    -- Matches documentation listing

    -- Buffers and Files
    vim.keymap.set("n", ";", require("fzf-lua").buffers, {noremap = true, silent = true, desc = "FZF (b)uffers"})
    vim.keymap.set("n", "<leader>f", require("fzf-lua").files, {noremap = true, silent = true, desc = "FZF (f)iles - cwd"})
    vim.keymap.set("n", "<leader>F", function() require("fzf-lua").files({
        fd_opts = fd_distros_ignore,
    }) end, {noremap = true, silent = true, desc = "FZF (f)iles - cwd"})
    vim.keymap.set("n", "<leader>~", function() require("fzf-lua").files({cwd = "~"}) end, {noremap = true, silent = true, desc = "FZF files - home"})
    vim.keymap.set("n", "<leader>.", function() require("fzf-lua").files({cwd = "~/.config"}) end, {noremap = true, silent = true, desc = "FZF files - config (.)" })
    vim.keymap.set("n", "<leader>/", function() require("fzf-lua").files({cwd = ".."}) end, {noremap = true, silent = true, desc = "FZF files - parent dir (../)"})
    vim.keymap.set("n", "<leader>zh", require("fzf-lua").oldfiles, {noremap = true, silent = true, desc = "FZF (h)istory"})
    vim.keymap.set("n", "<leader>zq", require("fzf-lua").quickfix, {noremap = true, silent = true, desc = "FZF (q)uickfix"})
    vim.keymap.set("n", "<leader>zQ", require("fzf-lua").quickfix_stack, {noremap = true, silent = true, desc = "FZF (Q)uickfix stack"})
    vim.keymap.set("n", "<leader>zl", require("fzf-lua").lines, {noremap = true, silent = true, desc = "FZF (l)ines"})
    vim.keymap.set("n", "<leader>zb", require("fzf-lua").blines, {noremap = true, silent = true, desc = "FZF (b)uffer lines"})

    -- Search

    -- (G)it - <leader>g...
    vim.keymap.set("n", "<leader>gc", require("fzf-lua").git_commits, {noremap = true, silent = true, desc = "Git FZF (C)ommits"})
    vim.keymap.set("n", "<leader>gb", require("fzf-lua").git_bcommits, {noremap = true, silent = true, desc = "Git FZF (B)commits"})
    vim.keymap.set("n", "<leader>gs", require("fzf-lua").git_status, {noremap = true, silent = true, desc = "Git FZF (S)tatus"})


    -- (G)rep for search results
    vim.keymap.set("n", "<leader>zg", require("fzf-lua").live_grep, {noremap = true, silent = true, desc = "FZF (g)rep"})
    vim.keymap.set("n", "<leader>z*", require("fzf-lua").live_grep_glob, {noremap = true, silent = true, desc = "FZF grep Glob"})
    -- live grep (C)ontinue last search
    vim.keymap.set("n", "<leader>zG", require("fzf-lua").live_grep_resume, {noremap = true, silent = true, desc = "FZF continue (G)rep"})

    -- (R)g Grep first - then can search the grep result
    vim.keymap.set("n", "<leader>zr", require("fzf-lua").grep, {noremap = true, silent = true, desc = "FZF (r)g search"})

    -- cword grep
    vim.keymap.set("n", "<leader>zw", require("fzf-lua").grep_cword, {noremap = true, silent = true, desc = "FZF c(w)ord grep"})
    -- cWORD
    vim.keymap.set("n", "<leader>zW", require("fzf-lua").grep_cWORD, {noremap = true, silent = true, desc = "FZF c(W)ORD grep"})

    -- Misc
    vim.keymap.set("n", "<leader>zz", require("fzf-lua").builtin, {noremap = true, silent = true, desc = "FZF F(Z)F builtin"})
    vim.keymap.set("n", "<leader>zc", require("fzf-lua").resume, {noremap = true, silent = true, desc = "FZF (c)ontinue"})
    vim.keymap.set("n", "<leader>zn", require("fzf-lua").commands, {noremap = true, silent = true, desc = "FZF (n)eovim commands"})
    vim.keymap.set("n", "<leader>z:", require("fzf-lua").command_history, {noremap = true, silent = true, desc = "FZF command history"})
    vim.keymap.set("n", "<leader>zo", require("fzf-lua").colorschemes, {noremap = true, silent = true, desc = "FZF c(o)lorscheme"})
    vim.keymap.set("n", "<leader>zi", require("fzf-lua").highlights, {noremap = true, silent = true, desc = "FZF h(i)ghlight groups"})
    vim.keymap.set("n", "<leader>z?", require("fzf-lua").help_tags, {noremap = true, silent = true, desc = "FZF help"})
    vim.keymap.set("n", "<leader>zm", require("fzf-lua").marks, {noremap = true, silent = true, desc = "FZF :(m)arks"})
    vim.keymap.set("n", "<leader>zj", require("fzf-lua").jumps, {noremap = true, silent = true, desc = "FZF :(j)umps"})
    vim.keymap.set("n", "<leader>zC", require("fzf-lua").changes, {noremap = true, silent = true, desc = "FZF :(C)hanges"})
    vim.keymap.set("n", "<leader>z@", require("fzf-lua").registers, {noremap = true, silent = true, desc = "FZF :reg"})
    vim.keymap.set("n", "<leader>zt", require("fzf-lua").tags, {noremap = true, silent = true, desc = "FZF :(t)ags"})
    vim.keymap.set("n", "<leader>zk", require("fzf-lua").keymaps, {noremap = true, silent = true, desc = "FZF (k)eymaps"})
    vim.keymap.set("n", "<leader>zF", require("fzf-lua").filetypes, {noremap = true, silent = true, desc = "FZF (F)iletypes"})
    vim.keymap.set("n", "<leader>zs", require("fzf-lua").spell_suggest, {noremap = true, silent = true, desc = "FZF (s)pelling suggestions"})

end

return Plugin
