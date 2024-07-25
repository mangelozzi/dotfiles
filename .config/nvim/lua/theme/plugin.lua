-- Own status line theme colors
local calc = require("theme.calc")

local M = {}

local directory = '#ffff00'

function M.get_palette(p, style)
    return {
        directory = '#ffff00',
        directory_open = '#ffff00',
        directory_closed = '#d0ca50',
        directory_empty = '#c0c0c0',
    }
end

local rainbow1 = "#fefefe" -- bold white
local rainbow2 = "#ffc0c0" -- redish
local rainbow3 = "#ffff40" -- yellowish
local rainbow4 = "#80ff80" -- greenish
local rainbow5 = "#c0c0c0" -- gray
local rainbow6 = "#e0c000" -- brown
local rainbow7 = "#808fff" -- blueish

function M.get_groups(p)
    return {
        -- Vim-Brightest
        _VimBrightest = { bg="#500050" },

        -- Indent-blankline (| marks for indentation)
        IblIndent = { fg = "#2a2a2a" }, -- Not active bars
        -- IblWhitespace = { fg = "#00ff00" }, -- Whitespace between bars? Usefull if coloring BG color
        IblScope = { fg = "#404040" }, -- Active bars

        -- -- Git Conflict
        -- GitConflictCurrent       = {bg = "#6d9088", bold = true},
        -- GitConflictCurrentLabel  = {bg = "#aee6d9"},
        -- GitConflictIncoming      = {bg = "#2f3220", bold = true},
        -- GitConflictIncomingLabel = {bg = "#4b5033"},
        -- GitConflictAncestor      = {bg = "#68217a", bold = true},
        -- GitConflictAncestorLabel = {bg = "#a634c3"},

        -- Git Conflict
        GitConflictCurrent       = {bg = "#5d7068", bold = true},
        GitConflictCurrentLabel  = {bg = p.blue},
        GitConflictIncoming      = {bg = "#2f3220", bold = true},
        GitConflictIncomingLabel = {bg = "#4b5033"},
        GitConflictAncestor      = {bg = "#68217a", bold = true},
        GitConflictAncestorLabel = {bg = p.purple},


        -- Rainbow Delimiters - Lowercase cause my own highilight group
        rainbowDelimiter1 = { fg = rainbow1, bold = false },
        rainbowDelimiter2 = { fg = rainbow2, bold = false },
        rainbowDelimiter3 = { fg = rainbow3, bold = false },
        rainbowDelimiter4 = { fg = rainbow4, bold = false },
        rainbowDelimiter5 = { fg = rainbow5, bold = false },
        rainbowDelimiter6 = { fg = rainbow6, bold = false },
        rainbowDelimiter7 = { fg = rainbow7, bold = false },

        -- Indent blankline
        -- Rainbow Delimiters - Lowercase cause my own highilight group
        rainbowIndent1 = { fg = calc.adjust_color(rainbow1, 0.15, 0.3), bold = false },
        rainbowIndent2 = { fg = calc.adjust_color(rainbow2, 0.15, 0.3), bold = false },
        rainbowIndent3 = { fg = calc.adjust_color(rainbow3, 0.15, 0.4), bold = false },
        rainbowIndent4 = { fg = calc.adjust_color(rainbow4, 0.15, 0.35), bold = false },
        rainbowIndent5 = { fg = calc.adjust_color(rainbow5, 0.15, 0.4), bold = false },
        rainbowIndent6 = { fg = calc.adjust_color(rainbow6, 0.15, 0.6), bold = false },
        rainbowIndent7 = { fg = calc.adjust_color(rainbow7, 0.15, 0.6), bold = false },

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
        NvimTreeFileIcon = {fg="#fefefe"},  -- If the file icon does not have an associated color, use this default color
        NvimTreeNormal = {link="Normal" },  -- Normal lines

        NvimTreeLiveFilterPrefix = {fg="#ffa000", bg="#303030" },  -- The filter prefix
        NvimTreeLiveFilterValue = {fg="#ff0000", bg="#300000" },  -- The filter inputted value

        NvimTreeSpecialFile = {fg="#e0ffe0", bg="#103010" },  -- README.md etc, brighly very light green
        NvimTreeIndentMarker = {fg="#c0c0c0" },  -- Sign before the dirs
        NvimTreeBookmark = {fg="#00ff00" },  -- Marking icon when selecting multiple files

        -- NeoGit

        NeogitGraphYellow = { fg = p.yellow },
        NeogitGraphPurple = { fg = p.purple },
        NeogitGraphCyan = { fg = p.aqua },
        NeogitGraphWhite = { fg = p.fg0 },
        NeogitGraphGreen = { fg = p.green },
        NeogitGraphGray = { fg = p.grey0 },

        NeogitDiffDelete = { fg = p.red, },
        NeogitDiffAdd  = { fg = p.green },
        NeogitDiffContext = { link = "Normal" },

        -- The whole hunk you currently are on
        NeogitDiffDeleteHighlight = { fg = p.red, bg = p.bg_diff_red },
        NeogitDiffAddHighlight = { fg = p.green, bg = p.bg_diff_green },
        NeogitDiffContextHighlight = { link = "CursorLine" },
        NeogitCursorLine = { link = "CursorLine", bold = true },

        NeogitHunkHeader = {fg = p.fg0, bg = p.bg3, bold = true},
        NeogitHunkHeaderHighlight = {fg = p.fg1, bg = p.bg5, bold = true},

        NeogitNotificationInfo = {fg = p.blue },
        NeogitNotificationWarning = {fg = p.yellow },
        NeogitNotificationError = {fg = p.red },

        -- NeogitBranch   xxx cterm=bold gui=bold guifg=#e392cc
        -- NeogitBranchHead xxx cterm=bold,underline gui=bold,underline guifg=#e392cc
        -- NeogitChangeAdded xxx cterm=bold,italic gui=bold,italic guifg=#6ebf22
        -- NeogitChangeBothModified xxx cterm=bold,italic gui=bold,italic guifg=#d46cb7
        -- NeogitChangeCopied xxx cterm=bold,italic gui=bold,italic guifg=#abab00
        -- NeogitChangeDeleted xxx cterm=bold,italic gui=bold,italic guifg=#ae9c7d
        -- NeogitChangeModified xxx cterm=bold,italic gui=bold,italic guifg=#ba78a7
        -- NeogitChangeNewFile xxx cterm=bold,italic gui=bold,italic guifg=#6ebf22
        -- NeogitChangeRenamed xxx cterm=bold,italic gui=bold,italic guifg=#ad6e7f
        -- NeogitChangeUpdated xxx cterm=bold,italic gui=bold,italic guifg=#83b5d4
        -- NeogitCommandCodeError xxx links to Error
        -- NeogitCommandCodeNormal xxx links to String
        -- NeogitCommandText xxx links to Comment
        -- NeogitCommandTime xxx links to Comment
        -- NeogitCommitMessage xxx cleared
        -- NeogitCommitViewDescription xxx links to String
        -- NeogitCommitViewHeader xxx guifg=#32302f guibg=#abab00
        -- NeogitDiffAddRegion xxx cleared
        -- NeogitDiffDeleteRegion xxx cleared
        -- NeogitDiffHeader xxx cterm=bold gui=bold guifg=#e392cc guibg=#494746
        -- NeogitDiffHeaderHighlight xxx cterm=bold gui=bold guifg=#9edaff guibg=#494746
        -- NeogitFilePath xxx cterm=italic gui=italic guifg=#e392cc
        -- NeogitFold     xxx cleared
        -- NeogitGraphAuthor xxx guifg=#9edaff
        -- NeogitGraphBlue xxx guifg=#e392cc
        -- NeogitGraphBoldBlue xxx cterm=bold gui=bold guifg=#e392cc
        -- NeogitGraphBoldCyan xxx cterm=bold gui=bold guifg=#d0d000
        -- NeogitGraphBoldGray xxx cterm=bold gui=bold guifg=#848382
        -- NeogitGraphBoldGreen xxx cterm=bold gui=bold guifg=#86e929
        -- NeogitGraphBoldPurple xxx cterm=bold gui=bold guifg=#d3869b
        -- NeogitGraphBoldRed xxx cterm=bold gui=bold guifg=#d4be98
        -- NeogitGraphBoldWhite xxx cterm=bold gui=bold
        -- NeogitGraphBoldYellow xxx cterm=bold gui=bold guifg=#ff82dc
        -- NeogitGraphOrange xxx guifg=#9edaff
        -- NeogitGraphRed xxx guifg=#d4be98
        -- NeogitHeadRegion xxx cleared
        -- NeogitMergeRegion xxx cleared
        -- NeogitObjectId xxx links to Comment
        -- NeogitPicking  xxx links to NeogitSectionHeader
        -- NeogitPickingRegion xxx cleared
        -- NeogitPopupActionDisabled xxx links to Comment
        -- NeogitPopupActionKey xxx guifg=#d3869b
        -- NeogitPopupBold xxx cterm=bold gui=bold
        -- NeogitPopupBranchName xxx links to String
        -- NeogitPopupConfigDisabled xxx links to Comment
        -- NeogitPopupConfigEnabled xxx links to SpecialChar
        -- NeogitPopupConfigKey xxx guifg=#d3869b
        -- NeogitPopupOptionDisabled xxx links to Comment
        -- NeogitPopupOptionEnabled xxx links to SpecialChar
        -- NeogitPopupOptionKey xxx guifg=#d3869b
        -- NeogitPopupSectionTitle xxx links to Function
        -- NeogitPopupSwitchDisabled xxx links to Comment
        -- NeogitPopupSwitchEnabled xxx links to SpecialChar
        -- NeogitPopupSwitchKey xxx guifg=#d3869b
        -- NeogitPushRegion xxx cleared
        -- NeogitRebaseDone xxx links to Comment
        -- NeogitRebasing xxx links to NeogitSectionHeader
        -- NeogitRebasingRegion xxx cleared
        -- NeogitRecentcommits xxx links to NeogitSectionHeader
        -- NeogitRecentcommitsRegion xxx cleared
        -- NeogitRemote   xxx cterm=bold gui=bold guifg=#86e929
        -- NeogitReverting xxx links to NeogitSectionHeader
        -- NeogitRevertingRegion xxx cleared
        -- NeogitSectionHeader xxx cterm=bold gui=bold guifg=#ad6e7f
        -- NeogitSignatureBad xxx links to NeogitGraphBoldRed
        -- NeogitSignatureGood xxx links to NeogitGraphGreen
        -- NeogitSignatureGoodExpired xxx links to NeogitGraphOrange
        -- NeogitSignatureGoodExpiredKey xxx links to NeogitGraphYellow
        -- NeogitSignatureGoodRevokedKey xxx links to NeogitGraphRed
        -- NeogitSignatureGoodUnknown xxx links to NeogitGraphBlue
        -- NeogitSignatureMissing xxx links to NeogitGraphPurple
        -- NeogitSignatureNone xxx links to Comment
        -- NeogitStagedchanges xxx links to NeogitSectionHeader
        -- NeogitStagedchangesRegion xxx cleared
        -- NeogitStash    xxx links to Comment
        -- NeogitStashes  xxx links to NeogitSectionHeader
        -- NeogitStashesRegion xxx cleared
        -- NeogitTagDistance xxx guifg=#d0d000
        -- NeogitTagName  xxx guifg=#ff82dc
        -- NeogitTagRegion xxx cleared
        -- NeogitUnmergedInto xxx cterm=bold gui=bold guifg=#ad6e7f
        -- NeogitUnmergedIntoRegion xxx cleared
        -- NeogitUnmergedchanges xxx links to NeogitSectionHeader
        -- NeogitUnmergedchangesRegion xxx cleared
        -- NeogitUnpulledFrom xxx cterm=bold gui=bold guifg=#ad6e7f
        -- NeogitUnpulledFromRegion xxx cleared
        -- NeogitUnpulledchanges xxx links to NeogitSectionHeader
        -- NeogitUnpulledchangesRegion xxx cleared
        -- NeogitUnpushedTo xxx cterm=bold gui=bold guifg=#ad6e7f
        -- NeogitUnpushedToRegion xxx cleared
        -- NeogitUnstagedchanges xxx links to NeogitSectionHeader
        -- NeogitUnstagedchangesRegion xxx cleared
        -- NeogitUntrackedfiles xxx links to NeogitSectionHeader
        -- NeogitUntrackedfilesRegion xxx cleared

        -- FZF-Lua

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
