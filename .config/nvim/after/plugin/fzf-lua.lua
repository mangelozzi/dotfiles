if not require("namespace.utils").get_is_installed("fzf-lua") then return end

-- let $FZF_DEFAULT_OPTS=' --color fg:#D8DEE9,bg:#2E3440,hl:#40a000,fg+:#D8DEE9,bg+:#434C5E,hl+:#60d000,pointer:#fF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'

-- Way more here: https://github.com/ibhagwan/fzf-lua#misc
-- See all config options here: https://github.com/ibhagwan/fzf-lua#default-options
require("fzf-lua").setup {
    fzf_opts = {
        -- ["--layout"] = "reverse-list",
        -- ["--border"] = "none"
    },
    keymap = {
        fzf = {
            -- fzf '--bind=' options
            ["esc"] = "abort",
            ["ctrl-u"] = "unix-line-discard",
            ["ctrl-f"] = "half-page-down",
            ["ctrl-b"] = "half-page-up",
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
    -- fzf '--color=' options (optional)
    fzf_colors = {
        -- Line
        ["fg"]          = { "fg", "FzfLine" },
        ["bg"]          = { "bg", "FzfLine" },
        ["hl"]          = { "fg", "FzfLineMatchedFg" },
        -- Selected Line
        ["fg+"]         = { "fg", "FzfSelectedLine" },
        ["bg+"]         = { "bg", "FzfSelectedLine" },
        ["hl+"]         = { "fg", "FzfSelectedLineMatchedFg" },
        -- Misc
        ["info"]        = { "fg", "FzfInfoFg" },
        ["prompt"]      = { "fg", "FzfPromptFg" },
        ["pointer"]     = { "fg", "FzfPointerFg" },
        ["marker"]      = { "fg", "FzfMarkerFg" },
        ["spinner"]     = { "fg", "FzfSpinnerFg" },
        ["header"]      = { "fg", "FzfHeaderFg" },
        ["gutter"]      = { "bg", "FzfGutterBg" },
    },
    -- hl = {
    --   normal         = 'Normal',        -- window normal color (fg+bg)
    --   border         = 'FloatBorder',   -- border color
    --   help_normal    = 'Normal',        -- <F1> window normal
    --   help_border    = 'FloatBorder',   -- <F1> window border
    --   -- Only used with the builtin previewer:
    --   cursor         = 'Cursor',        -- cursor highlight (grep/LSP matches)
    --   cursorline     = 'CursorLine',    -- cursor line
    --   cursorlinenr   = 'CursorLineNr',  -- cursor line number
    --   search         = 'IncSearch',     -- search matches (ctags|help)
    --   title          = 'Normal',        -- preview border title (file/buffer)
    --   -- Only used with 'winopts.preview.scrollbar = 'float'
    --   scrollfloat_e  = 'PmenuSbar',     -- scrollbar "empty" section highlight
    --   scrollfloat_f  = 'PmenuThumb',    -- scrollbar "full" section highlight
    --   -- Only used with 'winopts.preview.scrollbar = 'border'
    --   scrollborder_e = 'FloatBorder',   -- scrollbar "empty" section highlight
    --   scrollborder_f = 'FloatBorder',   -- scrollbar "full" section highlight
    -- },
    winopts = {
        height = 0.85,            -- window height
        width  = 0.90,            -- window width
        preview = {
            horizontal     = 'right:50%',     -- right|left:size
        },
    },
    files = {
        prompt = 'Files❯ ',
        fd_opts = "--type file --no-ignore -E '*__pycache__*' -E '*.jpg' -E '*.png' -E '*.zip' -E 'spike/*' -E '*.git' -E '*.min.css' -E '**/htmlcov/*' -E '**/static/*/wcapp/*.js'",
    },
    buffers = { prompt = 'Buffers❯ '},
    oldfiles = { prompt = 'History❯ '},
    lines = { prompt = 'Lines❯ '},
}


-- Line
vim.api.nvim_set_hl(0, "FzfLine",                   { fg="#d0d0d0", bg="#000000"}) -- Matched part of currently selected line
vim.api.nvim_set_hl(0, "FzfLineMatchedFg",          { fg="#00e000"}) -- Matched part of currently selected line
-- Selected Line
vim.api.nvim_set_hl(0, "FzfSelectedLine",           { fg="#ffffff", bg="#006000"}) -- Matched part of currently selected line
vim.api.nvim_set_hl(0, "FzfSelectedLineMatchedFg",  { fg="#00ff00" }) -- Matched part of currently selected line
-- Misc
vim.api.nvim_set_hl(0, "FzfPromptFg",               { fg="#ffff00"}) -- The surround angle brackets of > pattern < (fg only)
vim.api.nvim_set_hl(0, "FzfPointerFg",              { fg="#00ff00"}) -- > to select which file
vim.api.nvim_set_hl(0, "FzfInfoFg",                 { fg="#808080"}) -- Number of matchs to right of search
vim.api.nvim_set_hl(0, "FzfMarkerFg",               { bg="#404040"}) -- Column to right
vim.api.nvim_set_hl(0, "FzfSpinnerFg",              { fg="#ff0000"}) -- Like FzfPromptFg, but the "<" which it is pulling in searches, once found all matches will no longer apply
vim.api.nvim_set_hl(0, "FzfHeaderFg",               { fg="#ff0000"}) -- Matched part of currently selected line
vim.api.nvim_set_hl(0, "FzfGutterBg",               { bg="#404040"}) -- Left sign column bG


  -- key is the highlight group name
  -- value[1] is the setup/call arg option name
  -- value[2] is the default link if value[1] is undefined
-- vim.api.nvim_set_hl(0, "FzfLuaNormal",              { link="Normal" })
vim.api.nvim_set_hl(0, "FzfLuaBorder",              { fg="#606060" })
-- vim.api.nvim_set_hl(0, "FzfLuaCursor",              { fg = "#ff0000", bg="#00ffff" })
-- vim.api.nvim_set_hl(0, "FzfLuaCursorLine",          { fg = "#00ff00", bg="#ff00ff" })
-- vim.api.nvim_set_hl(0, "FzfLuaCursorLineNr",        { fg = "#0000ff", bg="#ffff00" })
-- vim.api.nvim_set_hl(0, "FzfLuaSearch",              { fg = "#ff0000", bg="#ff0000"})
vim.api.nvim_set_hl(0, "FzfLuaTitle",               { fg = "#ffffff"}) -- Preview title bar
-- vim.api.nvim_set_hl(0, "FzfLuaScrollBorderEmpty",   { fg = "#00ff00", bg="#ff0000" })
-- vim.api.nvim_set_hl(0, "FzfLuaScrollBorderFull",    { fg = "#00ff00", bg="#ff0000" })
-- vim.api.nvim_set_hl(0, "FzfLuaScrollFloatEmpty",    { fg = "#00ff00", bg="#ff0000" })
-- vim.api.nvim_set_hl(0, "FzfLuaScrollFloatFull",     { fg = "#00ff00", bg="#ff0000" })
-- vim.api.nvim_set_hl(0, "FzfLuaHelpNormal",          { fg = "#00ff00", bg="#ff0000" })
-- vim.api.nvim_set_hl(0, "FzfLuaHelpBorder",          { fg = "#00ff00", bg="#ff0000" })

-- (B)uffers
vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers, {noremap = true, silent = true})

-- (F)iles
vim.keymap.set("n", "<leader>f", require("fzf-lua").files, {noremap = true, silent = true})

-- (L)ines
vim.keymap.set("n", "<leader>zl", require("fzf-lua").lines, {noremap = true, silent = true})

-- (H)istory
vim.keymap.set("n", "<leader>zh", require("fzf-lua").oldfiles, {noremap = true, silent = true})

-- Help
vim.keymap.set("n", "<leader>z?", require("fzf-lua").help_tags, {noremap = true, silent = true})

-- (G)rep for search results
vim.keymap.set("n", "<leader>zg", require("fzf-lua").live_grep, {noremap = true, silent = true})
-- live grep (C)ontinue last search
vim.keymap.set("n", "<leader>zc", require("fzf-lua").live_grep_resume, {noremap = true, silent = true})

-- (R)g Grep first - then can search the grep result
vim.keymap.set("n", "<leader>zr", require("fzf-lua").grep, {noremap = true, silent = true})

-- cword grep
vim.keymap.set("n", "<leader>zz", require("fzf-lua").grep_cword, {noremap = true, silent = true})
-- cWORD
vim.keymap.set("n", "<leader>zZ", require("fzf-lua").grep_cWORD, {noremap = true, silent = true})
