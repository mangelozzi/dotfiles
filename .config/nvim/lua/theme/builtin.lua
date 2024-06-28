-- BUILTIN GROUPS (:help highlight-groups)

local M = {}

function M.get_groups(p)
    return {
        ColorColumn = {fg = nil, bg = p.bg2}, -- Used for the columns set with 'colorcolumn'.
        Conceal = {fg = p.bg5, bg = nil}, -- Placeholder characters substituted for concealed
        CurSearch = {link = "IncSearch"}, -- Current match for the last search pattern (see 'hlsearch').
        -- Cursor    	-- Character under the cursor.
        lCursor = {link = "Cursor" },    	-- Character under the cursor when |language-mapping| is used (see 'guicursor').
        CursorColumn = {fg = nil, bg = p.bg1}, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine = {fg = nil, bg = p.bg1}, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
        Directory = {fg = p.fg1, bg = nil}, -- Directory names (and other special names in listings).
        DiffAdd = {fg = nil, bg = p.bg_diff_green}, -- Diff mode: Added line. |diff.txt|
        DiffChange = {fg = nil, bg = p.bg_diff_blue}, -- Diff mode: Changed line. |diff.txt|
        DiffDelete = {fg = nil, bg = p.bg_diff_red}, -- Diff mode: Deleted line. |diff.txt|
        DiffText = {fg = p.bg0, bg = p.blue}, -- Diff mode: Changed text within a changed line. |diff.txt|
        EndOfBuffer = {fg = nil, bg = p.bg_dim}, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
        -- TermCursor = { fg=nil, bg=nil },   -- Cursor in a focused terminal.
        -- TermCursorNC = { fg=nil, bg=nil },   -- Cursor in an unfocused terminal.
        ErrorMsg = {fg = p.red, bg = nil}, -- Error messages on the command line.
        -- WinSeparator = { fg=nil, bg=nil },   -- Separators between window splits.
        Folded = {fg = p.grey1, bg = nil}, -- Line used for closed folds.
        FoldColumn = {fg = nil, bg = p.bg5}, -- 'foldcolumn'
        SignColumn = {fg = p.fg0, bg = nil}, -- Column where |signs| are displayed.
        IncSearch = {fg = p.bg0, bg = p.bg_red}, -- 'incsearch' highlighting; also used for the text replaced with ":s///c".
        Substitute = {fg = p.bg0, bg = p.yellow}, -- |:substitute| replacement text highlighting.
        LineNr = {fg = p.grey0, bg = nil}, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        -- LineNrAbove = { fg=nil, bg=nil },   -- Line number for when the 'relativenumber' option is set, above the cursor line.
        -- LineNrBelow = { fg=nil, bg=nil },   -- Line number for when the 'relativenumber' option is set, below the cursor line.
        CursorLineNr = {fg = p.green, bg = p.bg1}, -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
        -- CursorLineFold = { fg=nil, bg=nil },   -- Like FoldColumn when 'cursorline' is set for the cursor line.
        -- CursorLineSign = { fg=nil, bg=nil },   -- Like SignColumn when 'cursorline' is set for the cursor line.
        MatchParen = {fg = nil, bg = p.bg3}, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        ModeMsg = {fg = p.fg0, bg = nil, bold = true}, -- 'showmode' message (e.g., "-- INSERT --").
        MsgArea = { fg=nil, bg=nil },   -- Area for messages and command-line, see also 'cmdheight'.
        MsgSeparator = { fg=bg2, bg=nil, bold = true },   -- Separator for scrolled messages |msgsep|.
        MoreMsg = {fg = p.yellow, bg = nil, bold = true}, -- |more-prompt|
        NonText = {fg = p.bg5, bg = nil}, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Normal = {fg = p.fg0, bg = p.bg0}, -- = {fg = "#e0e0e0", bg = "#606000"}, -- Normal text.
        NormalFloat = {fg = p.fg1, bg = p.bg3}, -- = {fg = "#e0e0e0", bg = "#303000"}, -- Normal text in floating windows.
        FloatBorder = {fg = p.grey1, bg = p.bg3}, -- Border of floating windows.
        FloatTitle = {fg = p.orange, bg = p.bg3, bold = true}, -- Title of floating windows.
        -- FloatFooter = { fg=nil, bg=nil },   -- Footer of floating windows.
        NormalNC = {fg = p.fg0, bg = nil}, -- Normal text in non-current windows.
        Pmenu = {fg = p.fg1, bg = p.bg3}, -- Popup menu: Normal item.
        PmenuSel = {fg = p.bg3, bg = p.bg_green}, -- Popup menu: Selected item.
        PmenuKind = {fg = p.green, bg = p.bg3}, -- Popup menu: Normal item "kind".
        -- PmenuKindSel = { fg=nil, bg=nil },   -- Popup menu: Selected item "kind".
        PmenuExtra = {fg = p.grey2, bg = p.bg3}, -- Popup menu: Normal item "extra text".
        -- PmenuExtraSel = { fg=nil, bg=nil },   -- Popup menu: Selected item "extra text".
        PmenuSbar = {fg = nil, bg = p.bg3}, -- Popup menu: Scrollbar.
        PmenuThumb = {fg = nil, bg = p.grey0}, -- Popup menu: Thumb of the scrollbar.
        -- PmenuMatch = { fg=nil, bg=nil },   -- Popup menu: Matched text in normal item.
        -- PmenuMatchSel = { fg=nil, bg=nil },   -- Popup menu: Matched text in selected item.
        Question = {fg = p.yellow, bg = nil}, -- |hit-enter| prompt and yes/no questions.
        QuickFixLine = {fg = p.purple, bg = nil, bold = true}, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        Search = {fg = p.bg0, bg = p.bg_green}, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
        SnippetTabstop = {fg = nil, bg = nil}, -- Tabstops in snippets. |vim.snippet|
        SpecialKey = {fg = p.bg5, bg = nil}, -- Unprintable characters: Text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
        SpellBad = {fg = nil, bg = nil, undercurl = true, sp =p.red}, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        SpellCap = {fg = nil, bg = nil, undercurl = true, sp =p.blue}, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        SpellLocal = {fg = nil, bg = nil, undercurl = true, sp =p.aqua}, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        SpellRare = {fg = nil, bg = nil, undercurl = true, sp =p.purple}, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
        -- StatusLine = { fg=nil, bg=nil },   -- Status line of current window.
        -- StatusLineNC = { fg=nil, bg=nil },   -- Status lines of not-current windows.
        -- StatusLineTerm = { fg=nil, bg=nil },   -- Status line of |terminal| window.
        -- StatusLineTermNC = { fg=nil, bg=nil },   -- Status line of non-current |terminal| windows.
        TabLine = {fg = p.fg3, bg = p.bg_statusline3}, -- Tab pages line, not active tab page label.
        TabLineFill = {fg = p.fg1, bg = nil}, -- Tab pages line, where there are no labels.
        TabLineSel = {fg = p.bg0, bg = nil}, -- Tab pages line, active tab page label.
        Title = {fg = p.orange, bg = nil, bold = true}, -- Titles for output from ":set all", ":autocmd" etc.
        Visual = {fg = nil, bg = p.bg3}, -- Visual mode selection.
        VisualNOS = { link = 'Visual'}, -- Visual mode selection when vim is "Not Owning the Selection".
        WarningMsg = {fg = p.yellow, bg = nil, bold = true}, -- Warning messages.
        Whitespace = {fg = p.bg5, bg = nil}, --   "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
        WildMenu = {link = "PmenuSel"}, -- Current match in 'wildmenu' completion.
        WinBar = {fg = p.grey2, bg = nil, bold = true}, -- Window bar of current window.
        WinBarNC = {fg = p.grey1, bg = nil} -- Window bar of not-current windows.
    }
end

return M
