-- Install FZF on path by using ~/.config/install/utils.sh

-- let $FZF_DEFAULT_OPTS=' --color fg:#D8DEE9,bg:#2E3440,hl:#40a000,fg+:#D8DEE9,bg+:#434C5E,hl+:#60d000,pointer:#fF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'

-- Way more here: https://github.com/ibhagwan/fzf-lua#misc
-- See all config options here: https://github.com/ibhagwan/fzf-lua#default-options

--[[

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

--]]

local Plugin = {
    "ibhagwan/fzf-lua",
    commit = "b442569ab827",
    -- optional for icon support
    dependencies = {"nvim-tree/nvim-web-devicons"},
    build = "./install --bin",
}

Plugin.config = function()
    require("fzf-lua").setup {
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
                ["<M-f>"] = "preview-page-down", -- Like vim forwards
                ["<M-b>"] = "preview-page-up", -- Like vim backwards
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
                ["shift-down"] = "preview-page-down",
                ["shift-up"] = "preview-page-up"
            }
        },
        winopts = {
            height = 0.85, -- window height
            width = 0.90, -- window width
            preview = {
                horizontal = "right:50%" -- right|left:size
            }
        },
        files = {
            prompt = "Files >>> ",
            fd_opts =   "--type file --no-ignore"
                            -- Dirs
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
        }
    }

    -- Own
    -- Breakpoints
    vim.keymap.set("n", "<leader><S-DEL>", function()
            require("fzf-lua").lines({query = "debugger | breakpoint()", no_esc = true}) end,
        {noremap = true, silent = true, desc = "FZF breakpoints"}
    )

    -- Matches documentation listing

    -- Buffers and Files
    vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers, {noremap = true, silent = true, desc = "FZF (b)uffers"})
    vim.keymap.set("n", "<leader>f", require("fzf-lua").files, {noremap = true, silent = true, desc = "FZF (f)iles - cwd"})
    vim.keymap.set("n", "<leader>~", function() require("fzf-lua").files({cwd = "~"}) end, {noremap = true, silent = true, desc = "FZF files - home"})
    vim.keymap.set("n", "<leader>.", function() require("fzf-lua").files({cwd = "~/.config"}) end, {noremap = true, silent = true, desc = "FZF files - config (.)" })
    vim.keymap.set("n", "<leader>/", function() require("fzf-lua").files({cwd = ".."}) end, {noremap = true, silent = true, desc = "FZF files - parent dir (../)"})
    vim.keymap.set("n", "<leader>zh", require("fzf-lua").oldfiles, {noremap = true, silent = true, desc = "FZF (h)istory"})
    vim.keymap.set("n", "<leader>zq", require("fzf-lua").quickfix, {noremap = true, silent = true, desc = "FZF (q)uickfix"})
    vim.keymap.set("n", "<leader>zQ", require("fzf-lua").quickfix_stack, {noremap = true, silent = true, desc = "FZF (Q)uickfix stack"})
    vim.keymap.set("n", "<leader>zl", require("fzf-lua").lines, {noremap = true, silent = true, desc = "FZF (l)ines"})
    vim.keymap.set("n", "<leader>zb", require("fzf-lua").blines, {noremap = true, silent = true, desc = "FZF (b)uffer lines"})

    -- Search

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
