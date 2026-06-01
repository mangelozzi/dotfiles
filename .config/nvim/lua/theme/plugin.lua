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
        -- GitConflictIncoming      = {bg = "#2f3220", bold = true},
        GitConflictIncoming      = {bg = "#5f5220", bold = true},
        GitConflictIncomingLabel = {bg = "#6b6033"},
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

        NeogitDiffContext = { link = "Normal" }, -- Unchanged/context diff lines, usually should stay quiet

        -- The little label to the left before the file path
        NeogitChangeAdded    = { fg = p.green,  bg = p.bg_diff_green,   bold = true, italic = true }, -- The added/new-file label at the left of a file row
        NeogitChangeNewFile  = { fg = p.green,  bg = p.bg_diff_green,   bold = true, italic = true }, -- The new file label at the left of a file row
        NeogitChangeDeleted  = { fg = p.red,    bg = p.bg_diff_red,     bold = true, italic = true }, -- The deleted label at the left of a file row
        NeogitChangeModified = { fg = '#ffffff',bg = p.blue,            bold = false, italic = true}, -- The modified label at the left of a file row
        NeogitChangeUpdated  = { fg = '#ffffff',bg = p.blue,            bold = false, italic = true}, -- The updated label at the left of a file row
        NeogitChangeCopied   = { fg = p.yellow, bg = p.bg5,             bold = true, italic = true }, -- The copied label at the left of a file row
        NeogitChangeRenamed  = { fg = p.yellow, bg = p.bg5,             bold = true, italic = true }, -- The renamed label at the left of a file row
        NeogitChangeUnmerged = { fg = p.bg1,    bg = p.orange,          bold = true, italic = true }, -- The unmerged/conflict label at the left of a file row

        NeogitHunkHeader          = { fg = p.grey2, bg = p.bg2 },       -- Hunk header lines, the @@ lines
        NeogitHunkHeaderHighlight = { fg = p.fg0, bg = p.bg3 },         -- Hunk header when that hunk is the current context
        NeogitHunkHeaderCursor    = { fg = p.yellow,   bg = p.bg3 },    -- Exact cursor line when cursor is on a hunk header

        -- Inline changes, the actual part of the line that changes, very poppy
        NeogitDiffAddInline    = { fg = '#30ff00', bg = '#407000'},
        NeogitDiffDeleteInline = { fg = '#ff0000',   bg = '#702020'},

        -- More general changes/not inline
        NeogitDiffDelete = { fg = p.red }, -- Deleted diff lines, the lines starting with -
        NeogitDiffAdd    = { fg = p.green }, -- Added diff lines, the lines starting with +
        -- As above but current Hunk
        NeogitDiffDeleteHighlight = { bold = true},
        NeogitDiffAddHighlight    = { bold = true},
        -- As above but on current line
        NeogitDiffDeleteCursor = { bg = p.bg_diff_red },
        NeogitDiffAddCursor    = { bg = p.bg_diff_green },

        NeogitGraphYellow = { fg = p.yellow }, -- Used in log graph view for yellow git graph lines
        NeogitGraphPurple = { fg = p.purple }, -- Used in log graph view for purple git graph lines
        NeogitGraphCyan = { fg = p.aqua }, -- Used in log graph view for cyan git graph lines
        NeogitGraphWhite = { fg = p.fg0 }, -- Used in log graph view for white/default git graph lines
        NeogitGraphGreen = { fg = p.green }, -- Used in log graph view for green git graph lines
        NeogitGraphGray = { fg = p.grey0 }, -- Used in log graph view for grey git graph lines

        NeogitNotificationInfo = { fg = p.blue }, -- Neogit info notification text
        NeogitNotificationWarning = { fg = p.yellow }, -- Neogit warning notification text
        NeogitNotificationError = { fg = p.red }, -- Neogit error notification text

        --[[ FROM built in help
        STATUS BUFFER
        NeogitNormal                Normal text
        NeogitFloat                 Normal text when using a floating window
        NeogitFloatBorder           Border wen using a floating window
        NeogitBranch                Local branches
        NeogitBranchHead            Accent highlight for current HEAD in LogBuffer
        NeogitRemote                Remote branches
        NeogitObjectId              Object's SHA hash
        NeogitStash                 Stash name
        NeogitFold                  Folded text highlight
        NeogitFoldColumn            Column where folds are displayed
        NeogitSignColumn            Column where signs are displayed
        NeogitRebaseDone            Current position within rebase
        NeogitTagName               Closest Tag name
        NeogitTagDistance           Number of commits between the tag and HEAD
        NeogitStatusHEAD            The left text in the HEAD section

        STATUS BUFFER SECTION HEADERS
        NeogitSectionHeader
        NeogitUnpushedTo            Linked to NeogitSectionHeader
        NeogitUnmergedInto          ^
        NeogitUnpulledFrom          ^
        NeogitUntrackedfiles        ^
        NeogitUnstagedchanges       ^
        NeogitUnmergedchanges       ^
        NeogitUnpushedchanges       ^
        NeogitUnpulledchanges       ^
        NeogitRecentcommits         ^
        NeogitStagedchanges         ^
        NeogitStashes               ^
        NeogitRebasing              ^
        NeogitReverting             ^
        NeogitPicking               ^
        NeogitMerging               ^
        NeogitBisecting             ^
        NeogitSectionHeaderCount    The number, for sections with a number.

        STATUS BUFFER FILE
        Applied to the label on the left of filenames. These highlight groups are not
        used directly, but linked to by other groups:

        NeogitChangeModified
        NeogitChangeAdded
        NeogitChangeDeleted
        NeogitChangeRenamed
        NeogitChangeUpdated
        NeogitChangeCopied
        NeogitChangeNewFile
        NeogitChangeUnmerged

        SIGNS FOR LINE HIGHLIGHTING
        Used to highlight different sections of the status buffer or commit buffer.

        NeogitHunkHeader
        NeogitDiffContext
        NeogitDiffAdd
        NeogitDiffDelete
        NeogitDiffHeader
        NeogitActiveItem            Highlight of current commit-ish open

        SIGNS FOR LINE HIGHLIGHTING CURRENT CONTEXT
        These are essentially an accented version of the above highlight groups. Only
        applies to the current context the cursor is within.

        The "Cursor" suffix applies only to the Cursor line

        NeogitHunkHeaderHighlight
        NeogitDiffContextHighlight
        NeogitDiffAddHighlight
        NeogitDiffDeleteHighlight
        NeogitDiffHeaderHighlight
        NeogitHunkHeaderCursor
        NeogitDiffContextCursor
        NeogitDiffAddCursor
        NeogitDiffDeleteCursor
        NeogitDiffHeaderCursor

        INLINE DIFF
        Groups for showing word-level diff in a hunk

        NeogitDiffAddInline
        NeogitDiffDeleteInline

        COMMIT BUFFER
        NeogitFilePath              Applied to filepath
        NeogitCommitViewHeader      Applied to header of Commit View

        LOG VIEW BUFFER
        NeogitGraphAuthor           Applied to the commit's author in graph view
        NeogitGraphBlack            Used when --colors is enabled for graph
        NeogitGraphBoldBlack
        NeogitGraphRed
        NeogitGraphBoldRed
        NeogitGraphGreen
        NeogitGraphBoldGreen
        NeogitGraphYellow
        NeogitGraphBoldYellow
        NeogitGraphBlue
        NeogitGraphBoldBlue
        NeogitGraphPurple
        NeogitGraphBoldPurple
        NeogitGraphCyan
        NeogitGraphBoldCyan
        NeogitGraphWhite
        NeogitGraphBoldWhite
        NeogitGraphGray
        NeogitGraphBoldGray
        NeogitGraphOrange

        NeogitSignatureGood        For highlighting the commit hash when
        NeogitSignatureBad         --show-signature is passed
        NeogitSignatureMissing
        NeogitSignatureNone
        NeogitSignatureGoodUnknown
        NeogitSignatureGoodExpired
        NeogitSignatureGoodExpiredKey
        NeogitSignatureGoodRevokedKey

        POPUPS
        NeogitPopupSectionTitle    Applied to all section headers
        NeogitPopupBranchName      Applied to the current branch name for emphasis
        NeogitPopupBold            Applied on "@{upstream}" and "pushRemote" for
                                emphasis (but less emphasis than BranchName)

        NeogitPopupSwitchKey       Applied to the key that will toggle switch
        NeogitPopupSwitchEnabled   Applied to the flag if enabled
        NeogitPopupSwitchDisabled  Applied to the flag if disabled

        NeogitPopupOptionKey       Applied to the key that will trigger option
        NeogitPopupOptionEnabled   Applied if option is set
        NeogitPopupOptionDisabled  Applied if option has no value

        NeogitPopupConfigKey       Applied to the key that triggers config
        NeogitPopupConfigEnabled   Applied to enabled config value
        NeogitPopupConfigDisabled  Applied to config without value

        NeogitPopupActionKey       Applied to key that triggers function
        NeogitPopupActionDisabled  Applied to key when function is unimplemented

        COMMAND HISTORY BUFFER
        NeogitCommandText          Git command that was run
        NeogitCommandTime          Execution time
        NeogitCommandCodeNormal    Applied to a successful command's exit status (0)
        NeogitCommandCodeError     When command exits with non-zero status

        COMMIT SELECT BUFFER
        NeogitFloatHeader          Foreground/Background for header text at top of win
        NeogitFloatHeaderHighlight Emphasized text in header
        --]]


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
