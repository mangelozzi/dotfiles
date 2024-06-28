-- Own status line theme colors
local M = {}

local directory = '#ffff00'

function M.get_palette(p)
    return {
        directory = '#ffff00',
        directory_open = '#ffff00',
        directory_closed = '#d0ca50',
        directory_empty = '#c0c0c0',
        directory_root = '#00ff00',
    }
end

function M.get_groups(p)
    return {
        -- Vim-Brightest
        _VimBrightest = { bg=p.bg_diff_blue },

        -- Rainbow Delimiters
        rainbowcol1 = { fg = "#ffffff", bold = false }, -- bold white
        rainbowcol2 = { fg = "#a0ffff", bold = false }, -- blueish
        rainbowcol3 = { fg = "#80ff80", bold = false }, -- greenish
        rainbowcol4 = { fg = "#ffc0c0", bold = false }, -- redish
        rainbowcol5 = { fg = "#ffff40", bold = false }, -- yellowish
        rainbowcol6 = { fg = "#c0c0c0", bold = false }, -- gray
        rainbowcol7 = { fg = "#c0c000", bold = false }, -- brown

        -- Nvim Tree
        NvimTreeRootFolder = { link="RootFolder" },
        NvimTreeFolderIcon = { fg=p.directory_closed },
        NvimTreeOpenedFolderIcon = { fg=p.directory_open },
        NvimTreeClosedFolderIcon = { fg=p.directory_closed },

        NvimTreeFolderName = { fg=p.directory_closed },
        NvimTreeEmptyFolderName = { fg=p.directory_empty },
        NvimTreeOpenedFolderName = { fg=p.directory_open },
        NvimTreeClosedFolderName = { fg=p.directory_closed },

        -- Highlight color if buffer modified
        NvimTreeModifiedFile = {fg="#ff0000", bg="#500000" },
        NvimTreeOpenedFile = {fg="#00e000" },
        NvimTreeFileIcon = {fg="#ffffff"},  -- If the file icon does not have an associated color, use this default color
        NvimTreeNormal = {link="Normal" },  -- Normal lines

        NvimTreeLiveFilterPrefix = {fg="#ffa000", bg="#303030" },  -- The filter prefix
        NvimTreeLiveFilterValue = {fg="#ff0000", bg="#300000" },  -- The filter inputted value

        NvimTreeSpecialFile = {fg="#e0ffe0", bg="#103010" },  -- README.md etc, brighly very light green
        NvimTreeIndentMarker = {fg="#c0c0c0" },  -- Sign before the dirs
        NvimTreeBookmark = {fg="#00ff00" },  -- Marking icon when selecting multiple files

        -- NeoGit - Don't know  if there are doing anything

        NeogitNotificationInfo = {fg = p.blue },
        NeogitNotificationWarning = {fg = p.yellow },
        NeogitNotificationError = {fg = p.red },

        -- NeogitDiffAddHighlight = { link = "DiffAdd"},
        -- NeogitDiffDeleteHighlight = { link = "DiffChange"},

        NeogitDiffAddHighlight = {fg = "#80ff80", bg = "#404040"},
        NeogitDiffDeleteHighlight = {fg = "#ff0000", bg = "#404040"},
        NeogitDiffContextHighlight = {fg = "#ffffff", bg = "#404040"},

        NeogitHunkHeader = {fg = p.fg0, bg = p.bg3, bold = true},
        NeogitHunkHeaderHighlight = {fg = p.fg1, bg = p.bg5, bold = true},


        -- Line
        -- Sets the colors of FZF (not the colors of FZF-Lua interface
        -- local bg = vim.api.nvim_get_hl_by_name('Normal', true).background
        -- local bg = "#484800"
        -- FzfLine =                   { fg="#d0d0d0", bg=bg}, -- Matched part of currently selected line
        -- FzfLineMatchedFg =          { fg="#00e000"}, -- Matched part of currently selected line
        -- -- Selected Line
        FzfSelectedLine =              { bg=p.bg_visual_green, bold = true }, -- Matched part of currently selected line
        -- FzfSelectedLineMatchedFg =  { fg="#00ff00" }, -- Matched part of currently selected line
        -- -- Misc
        -- FzfPromptFg =               { fg="#ffff00"}, -- The surround angle brackets of > pattern < (fg only)
        FzfPointerFg =                 { fg=p.yellow }, -- > to select which file
        -- FzfInfoFg =                 { fg="#808080"}, -- Number of matchs to right of search
        -- FzfMarkerFg =               { bg="#404040"}, -- Column to right
        -- FzfSpinnerFg =              { fg="#ff0000"}, -- Like FzfPromptFg, but the "<" which it is pulling in searches, once found all matches will no longer apply
        -- FzfHeaderFg =               { fg="#ff0000"}, -- Matched part of currently selected line
        FzfGutterBg =                  { link = "Normal" }, -- Left sign column bG
        --
        -- local function get_fg(group)
        --     return vim.api.nvim_get_hl_by_name(group, true).foreground
        -- end
        --
        -- -- Sets the colors of FZF-Lua (not the colors of Lua interface
        -- -- key is the highlight group name
        -- -- value[1] is the setup/call arg option name
        -- -- value[2] is the default link if value[1] is undefined
        -- FzfLuaNormal =              { fg=get_fg("Normal"), bg=bg}, -- The float window background, the matches list, the uncoloured preview text
        -- FzfLuaBorder =              { fg=get_fg("FloatBorder"), bg=bg}, -- Border around float window
        -- FzfLuaCursor =              { link="Cursor"}, -- ?
        -- FzfLuaCursorLine =          { link="CursorLine"}, -- The selected line of the preview
        -- FzfLuaCursorLineNr =        { link="CursorLineNr"}, -- Cursor line number
        -- FzfLuaSearch =              { link="Search" }, -- The cursor in the right panel of the selected file
        -- FzfLuaTitle =               { fg=get_fg("Title"), bg=bg}, -- Preview title bar
        -- FzfLuaScrollBorderEmpty =   { fg=get_fg("FloatBorder"), bg=bg}, -- Panel on right, scroll bar - Especially when doing a lines search
        -- FzfLuaScrollBorderFull =    { fg=get_fg("FloatBorder"), bg=bg}, -- Panel on right, scroll bar
        -- FzfLuaScrollFloatEmpty =    { fg=get_fg("FloatBorder"), bg=bg}, -- Panel on right, scroll bar
        -- FzfLuaScrollFloatFull =     { fg=get_fg("FloatBorder"), bg=bg}, -- Panel on right, scroll bar
        -- FzfLuaHelpNormal =          { fg=get_fg("Normal"), bg=bg}, -- Press <F1> to show the help window
        -- FzfLuaHelpBorder =          { fg=get_fg("FloatBorder"), bg=bg}, -- ?
    }
end

return M
