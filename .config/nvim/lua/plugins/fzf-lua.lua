-- Install FZF on path by using ~/.config/install/utils.sh

-- let $FZF_DEFAULT_OPTS=' --color fg:#D8DEE9,bg:#2E3440,hl:#40a000,fg+:#D8DEE9,bg+:#434C5E,hl+:#60d000,pointer:#fF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'

-- Way more here: https://github.com/ibhagwan/fzf-lua#misc
-- See all config options here: https://github.com/ibhagwan/fzf-lua#default-options

local Plugin = {
    "ibhagwan/fzf-lua",
    commit = "b442569ab827",
    -- optional for icon support
    dependencies = {"nvim-tree/nvim-web-devicons"}
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

    -- (B)uffers
    vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers, {noremap = true, silent = true, desc = "FZF buffers"})

    -- (F)iles
    -- cwd
    vim.keymap.set("n", "<leader>f", require("fzf-lua").files, {noremap = true, silent = true, desc = "FZF (f)iles - pwd"})
    -- home dir
    vim.keymap.set("n", "<leader>~", function() require("fzf-lua").files({cwd = "~"}) end, {noremap = true, silent = true, desc = "FZF files - home"})
    -- .config
    vim.keymap.set("n", "<leader>.", function() require("fzf-lua").files({cwd = "~/.config"}) end, {noremap = true, silent = true, desc = "FZF files - config (.)" })
    -- One dir up
    vim.keymap.set("n", "<leader>/", function() require("fzf-lua").files({cwd = ".."}) end, {noremap = true, silent = true, desc = "FZF files - parent dir (../)"})

    -- (L)ines
    vim.keymap.set("n", "<leader>zl", require("fzf-lua").lines, {noremap = true, silent = true, desc = "FZF (l)ines"})
    -- Breakpoints
    vim.keymap.set("n", "<leader><S-DEL>", function()
            require("fzf-lua").lines({query = "debugger | breakpoint()", no_esc = true})
        end,
        {noremap = true, silent = true, desc = "FZF breakpoints"}
    )

    -- (H)istory
    vim.keymap.set("n", "<leader>zh", require("fzf-lua").oldfiles, {noremap = true, silent = true, desc = "FZF (h)istory"})

    -- Help
    vim.keymap.set("n", "<leader>z?", require("fzf-lua").help_tags, {noremap = true, silent = true, desc = "FZF help"})

    -- (G)rep for search results
    vim.keymap.set("n", "<leader>zg", require("fzf-lua").live_grep, {noremap = true, silent = true, desc = "FZF (g)rep"})
    -- live grep (C)ontinue last search
    vim.keymap.set("n", "<leader>zc", require("fzf-lua").live_grep_resume, {noremap = true, silent = true, desc = "FZF (c)ontinue grep"})

    -- (R)g Grep first - then can search the grep result
    vim.keymap.set("n", "<leader>zr", require("fzf-lua").grep, {noremap = true, silent = true, desc = "FZF (r)g search"})

    -- cword grep
    vim.keymap.set("n", "<leader>zz", require("fzf-lua").grep_cword, {noremap = true, silent = true, desc = "FZF cword grep"})
    -- cWORD
    vim.keymap.set("n", "<leader>zZ", require("fzf-lua").grep_cWORD, {noremap = true, silent = true, desc = "FZF cWORD grep"})
end

return Plugin
