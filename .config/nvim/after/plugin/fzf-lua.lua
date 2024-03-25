if not require("namespace.utils").get_is_installed("fzf-lua") then return end

-- let $FZF_DEFAULT_OPTS=' --color fg:#D8DEE9,bg:#2E3440,hl:#40a000,fg+:#D8DEE9,bg+:#434C5E,hl+:#60d000,pointer:#fF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B'

-- Way more here: https://github.com/ibhagwan/fzf-lua#misc
-- See all config options here: https://github.com/ibhagwan/fzf-lua#default-options
require("fzf-lua").setup {
    -- options are sent as `<left>=<right>`
    -- set to `false` to remove a flag
    -- set to '' for a non-value flag
    -- for raw args use `fzf_args` instead
    fzf_opts = {
        -- ["--layout"] = "reverse-list",
        -- ["--border"] = "none"
        ["--keep-right"] = "",  -- If a line is long, truncate the front of the line
        ["--tiebreak"] = "end",
    },
    -- fzf '--color=' options (optional)
    -- Sets the colors of FZF (not the colors of FZF-Lua interface
    -- Linked to the Hilight groups below
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
    keymap = {
        builtin = {
            -- Generally useing Alt... for preview
            ["<F1>"]        = "toggle-help",
            ["<F2>"]        = "toggle-fullscreen",
            -- Only valid with the 'builtin' previewer
            ["<M-w>"]       = "toggle-preview-wrap",  -- Mnemonic (W)rap
            ["<M-j>"]        = "toggle-preview",
            ["<M-k>"]        = "toggle-preview",
            -- Rotate preview clockwise/counter-clockwise
            ["<M-h>"]        = "toggle-preview-ccw",
            ["<M-l>"]        = "toggle-preview-cw",
            ["<M-f>"]       = "preview-page-down", -- Like vim forwards
            ["<M-b>"]       = "preview-page-up",  -- Like vim backwards
            ["<M-o>"]       = "preview-page-reset",  -- Mnemonic: (O)rigin
        },
        fzf = {
            -- WARNING: These completely REPLACE the existing bindings
            -- Custom
            ["esc"] = "abort",
            -- fzf '--bind=' options
            ["ctrl-z"]      = "abort",
            ["ctrl-u"]      = "unix-line-discard",
            ["ctrl-f"]      = "half-page-down",  -- Match list
            ["ctrl-b"]      = "half-page-up",  -- Match list
            ["ctrl-a"]      = "beginning-of-line",
            ["ctrl-e"]      = "end-of-line",
            ["alt-a"]       = "toggle-all",
            -- Only valid with fzf previewers (bat/cat/git/etc)
            ["f3"]          = "toggle-preview-wrap",
            ["f4"]          = "toggle-preview",
            ["shift-down"]  = "preview-page-down",
            ["shift-up"]    = "preview-page-up",
        },
    },
    winopts = {
        height = 0.85,            -- window height
        width  = 0.90,            -- window width
        preview = {
            horizontal     = 'right:50%',     -- right|left:size
        },
    },
    files = {
        prompt = 'Files >>> ',
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
    buffers = { prompt = 'Buffers >>> '}, -- Buffers❯
    oldfiles = { prompt = 'History >>> '},
    lines = { prompt = 'Lines >>> '},
    -- optional override of file extension icon colors
    -- available colors (terminal):
    --    clear, bold, black, red, green, yellow
    --    blue, magenta, cyan, grey, dark_grey, white
    file_icon_colors = {
        -- Does not seem to work for me
        ["sh"] = "green",
    },
}


-- Line
-- Sets the colors of FZF (not the colors of FZF-Lua interface
-- local bg = vim.api.nvim_get_hl_by_name('Normal', true).background
local bg = "#484800"
vim.api.nvim_set_hl(0, "FzfLine",                   { fg="#d0d0d0", bg=bg}) -- Matched part of currently selected line
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

local function get_fg(group)
    return vim.api.nvim_get_hl_by_name(group, true).foreground
end

-- Sets the colors of FZF-Lua (not the colors of Lua interface
-- key is the highlight group name
-- value[1] is the setup/call arg option name
-- value[2] is the default link if value[1] is undefined
vim.api.nvim_set_hl(0, "FzfLuaNormal",              { fg=get_fg("Normal"), bg=bg}) -- The float window background, the matches list, the uncoloured preview text
vim.api.nvim_set_hl(0, "FzfLuaBorder",              { fg=get_fg("FloatBorder"), bg=bg}) -- Border around float window
vim.api.nvim_set_hl(0, "FzfLuaCursor",              { link="Cursor"}) -- ?
vim.api.nvim_set_hl(0, "FzfLuaCursorLine",          { link="CursorLine"}) -- The selected line of the preview
vim.api.nvim_set_hl(0, "FzfLuaCursorLineNr",        { link="CursorLineNr"}) -- Cursor line number
vim.api.nvim_set_hl(0, "FzfLuaSearch",              { link="Search" }) -- The cursor in the right panel of the selected file
vim.api.nvim_set_hl(0, "FzfLuaTitle",               { fg=get_fg("Title"), bg=bg}) -- Preview title bar
vim.api.nvim_set_hl(0, "FzfLuaScrollBorderEmpty",   { fg=get_fg("FloatBorder"), bg=bg}) -- Panel on right, scroll bar - Especially when doing a lines search
vim.api.nvim_set_hl(0, "FzfLuaScrollBorderFull",    { fg=get_fg("FloatBorder"), bg=bg}) -- Panel on right, scroll bar
vim.api.nvim_set_hl(0, "FzfLuaScrollFloatEmpty",    { fg=get_fg("FloatBorder"), bg=bg}) -- Panel on right, scroll bar
vim.api.nvim_set_hl(0, "FzfLuaScrollFloatFull",     { fg=get_fg("FloatBorder"), bg=bg}) -- Panel on right, scroll bar
vim.api.nvim_set_hl(0, "FzfLuaHelpNormal",          { fg=get_fg("Normal"), bg=bg}) -- Press <F1> to show the help window
vim.api.nvim_set_hl(0, "FzfLuaHelpBorder",          { fg=get_fg("FloatBorder"), bg=bg}) -- ?

-- (B)uffers
vim.keymap.set("n", "<leader><leader>", require("fzf-lua").buffers, {noremap = true, silent = true})

-- (F)iles
-- cwd
vim.keymap.set("n", "<leader>f", require("fzf-lua").files, {noremap = true, silent = true})
-- home dir
vim.keymap.set("n", "<leader>~", function() require("fzf-lua").files({ cwd = "~" }) end, {noremap = true, silent = true})
-- .config
vim.keymap.set("n", "<leader>.", function() require("fzf-lua").files({ cwd = "~/.config" }) end, {noremap = true, silent = true})
-- One dir up
vim.keymap.set("n", "<leader>/", function() require("fzf-lua").files({ cwd = ".." }) end, {noremap = true, silent = true})

-- (L)ines
vim.keymap.set("n", "<leader>zl", require("fzf-lua").lines, {noremap = true, silent = true})
-- Breakpoints
vim.keymap.set("n", "<leader><S-DEL>", 
    function() 
        require("fzf-lua").lines({query="debugger | breakpoint()", no_esc=true}) 
    end, 
    {noremap = true, silent = true}
)

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
