local M = {}

function M.get_groups(p)
    return {
        RootFolder = { fg=p.directory_root },

        -- Refer to QuickFixLine in builtin.lua for the current select QF line
        qfFileName = { fg = p.red, bold = true },
        qfLineNr = { fg = p.yellow },
        qfSeparator = { fg = p.black },
        qfError = { fg = p.white, bg = p.isoerrorred, bold = true },
        _qfNormal       = { fg = '#ffffff', bg='#333300' },  -- Override default Normal
        _qfCursorLine   = { bg='#676700', bold = true },     -- The current cursor line highlighting, works!
        _qfLineNr       = { fg = '#ffff00', bg='#444400' },  -- Line number colour
        _qfCursorLineNr = { fg = '#000000', bg='#cccc00' },  -- Cursor line number colour

        Cursor = { reverse = true },
        HighlightOnYank = { fg = "#00ff00", bg="#008000"},
        VertSplit = { fg=p.vertsplit_fg, bg=p.vertsplit_bg,  nocombine = true },
        CursorIM = {link = "Cursor" },    -- Like Cursor, but used when in IME mode. *CursorIM*

        Noise = { fg=p.noise }, -- Unoffical common group

        -- MatchAdd
        _MatchWrongSpacing       = { bg = p.bg_visual_yellow }, -- If not a multiple of 4 spaces
        _MatchTrailingWhitespace = { bg = p.bg_visual_yellow }, -- Highlight trailing whitespace

        -- Folds
        -- Currently vim does not support matching text in a folded group yet!
        -- see https://github.com/neovim/neovim/issues/12649
        _FoldedLevel1   = { fg = p.purpleh, bg = p.purple_bg, bold = true, italic = true },
        _FoldedLevel2   = { fg = p.purple,  bg = p.purple_bg, bold = true, italic = true },
        _FoldedLevel3   = { fg = p.purplel, bg = p.purple_bg, bold = true, italic = true },
        _UnfoldedLevel1 = { fg = p.purpleh, bg = p.purple_bg, bold = true, italic = true },
        _UnfoldedLevel2 = { fg = p.purple,  bg = p.purple_bg, bold = true, italic = true },
        _UnfoldedLevel3 = { fg = p.purplel, bg = p.purple_bg, bold = true, italic = true },

        -- DIFFs (GIT)
        -- This might be for vim diff, notice DiffAdd vs DiffAdded
        -- Refer to michael_diff.vim for difftool diffs colour scheme
        -- Defined in Builtins group: DiffAdd, DiffDelete, DiffText, DiffChange

        -- DIFF HEADER
        -- Example of diff header:
        -- diffFile          diff --git a/src/base/management/commands/deploy.py b/src/base/management/commands/deploy.py
        -- diffIndexLine     index d99d485..685cd8a 100755
        -- diffNewFile       --- a/src/base/management/commands/deploy.py
        -- diffFile          +++ b/src/base/management/commands/deploy.py
        -- diffLine          @@ -29,18 +29,22 @@      diffSubname: class Command(BaseCommand):
        diffIndexLine        = { fg = '#808080' },
        diffNewFile          = { fg = '#D0D0D0', bold = true },
        diffFile             = { fg = '#808080' },
        diffLine             = { fg = '#808080' },
        diffSubname          = { fg = '#D0D0D0' },
        --Probably used for side by side diffs:
        --diffOnly
        --diffDiffer
        --diffBDiffer
        --diffIsA
        --diffCommon
        --diffOldFile
        --diffComment


        -- {{{1 MARKDOWN
        -- Set HTML then set here
        markdownHeadingDelimiter = { fg = '#008000', nocombine = true, bold = true },
        markdownH1               = { fg = '#0fff00', nocombine = true, bold = true, underline = true },
        markdownH2               = { fg = '#00e000', nocombine = true, bold = true, underline = true },
        markdownH3               = { fg = '#00d000', nocombine = true, underline = true },
        markdownH4               = { fg = '#00c000', nocombine = true, underline = true },
        --hi markdownH5           guifg=#00b000 guibg=NONE guisp=NONE gui=bold
        --hi markdownH6           guifg=#00a000 guibg=NONE guisp=NONE gui=bold
        --hi markdownListMarker   guifg=#ffff00 guibg=NONE guisp=NONE gui=bold
        --hi markdownOrderedMarker guifg=#ffff00 guibg=NONE guisp=NONE gui=bold
        --hi markdownBlockquote   guifg=#ffff00 guibg=NONE guisp=NONE gui=NONE
        markdownCodeBlock         = { fg = '#ffff90', nocombine = true, bold = true },
        markdownCode              = { fg = '#ffff90', nocombine = true, bold = true },
        markdownUrl               = { fg = '#a0c0ff', nocombine = true, underline = true },
        markdownUrlDelimiter      = { fg = '#6090c0', nocombine = true },
        markdownUrlTitle          = { fg = '#a0c0ff', nocombine = true, underline = true },
        markdownUrlTitleDelimiter = { fg = '#6090c0', nocombine = true },
        -- markdownValid  xxx cleared
        -- markdownLineStart xxx cleared
        -- markdownBlockquote xxx links to Comment
        -- markdownListMarker xxx links to htmlTagName
        -- markdownOrderedListMarker xxx links to markdownListMarker
        -- markdownRule   xxx links to PreProc
        -- markdownLineBreak xxx cleared
        -- markdownLinkText xxx links to htmlLink
        -- markdownItalic xxx links to htmlItalic
        -- markdownBold   xxx links to htmlBold
        -- markdownEscape xxx links to Special
        -- markdownError  xxx links to Error
        -- markdownHeadingRule xxx links to markdownRule
        -- markdownAutomaticLink xxx links to markdownUrl
        -- markdownHeadingDelimiter xxx gui=bold guifg=#008000
        -- markdownLinkDelimiter xxx cleared
        -- markdownIdDeclaration xxx links to Typedef
        -- markdownLinkTextDelimiter xxx cleared
        -- markdownLink   xxx cleared
        -- markdownId     xxx links to Type
        -- markdownIdDelimiter xxx links to markdownLinkDelimiter
        -- markdownItalicDelimiter xxx links to markdownItalic
        -- markdownBoldDelimiter xxx links to markdownBold
        -- markdownBoldItalicDelimiter xxx links to markdownBoldItalic
        -- markdownBoldItalic xxx links to htmlBoldItalic
        -- markdownCodeDelimiter xxx links to Delimiter
        -- markdownFootnote xxx links to Typedef
        -- markdownFootnoteDefinition xxx links to Typedef

        -- LSP
        LspDiagnosticsError                 = { fg = '#ffffff', bg = '#ff0000', nocombine = true },
        LspDiagnosticsErrorSign             = { link = 'LspDiagnosticsError' },
        LspDiagnosticsErrorFloating         = { link = 'LspDiagnosticsErrorguifg' },
        LspDiagnosticsWarning               = { fg = '#000000', bg = '#d0d000' , nocombine = true, italic = true },
        LspDiagnosticsWarningSign           = { link = 'LspDiagnosticsWarning' },
        LspDiagnosticsWarningFloating       = { link = 'LspDiagnosticsWarning' },
        LspDiagnosticsInformation           = { fg = '#ffffff', bg = '#0000ff', nocombine = true },
        LspDiagnosticsInformationSign       = { link = 'LspDiagnosticsInformation' },
        LspDiagnosticsInformationFloating   = { link = 'LspDiagnosticsInformation' },
        LspDiagnosticsHint                  = { fg = '#ffffff', bg = '#008800', nocombine = true },
        LspDiagnosticsHintSign              = { link = 'LspDiagnosticsHint' },
        LspDiagnosticsHintFloating          = { link = 'LspDiagnosticsHint' },
        LspReferenceText                    = { fg = '#ff0000', bg = '#888888', nocombine = true },
        LspReferenceRead                    = { fg = '#00ff00', bg = '#888888', nocombine = true },
        LspReferenceWrite                   = { fg = '#0000ff', bg = '#888888', nocombine = true },

    }
end

return M
