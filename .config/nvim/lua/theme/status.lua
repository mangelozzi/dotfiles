-- Own status line theme colors
--   StatusLine   status line of current window
--  Set in init/status.cim
--  hi StatusLine   guifg=#000000 guibg=#00b000 ctermfg=015 ctermbg=000
-- 
--   StatusLineNC status lines of not-current windows
--                Note: if this is equal to "StatusLine" Vim will use "^^^" in
--                the status line of the current window.
--  Set in init/status.cim
--  hi StatusLineNC guifg=#888888 guibg=#444444 ctermfg=015 ctermbg=000

local M = {}

function M.get_palette(p, style)
    return {
        status_line_bg = "#00A000",
        _status_subtle_nc_fg = "#707070",
        _status_subtle_nc_bg = "#a0a0a0",
        _qf_status_subtle_bg = "#c0c000",
        _qf_status_subtle_fg = "#909000",
        _help_status_subtle_fg = "#000077",
        _help_status_subtle_bg = "#a000e0",
        _status_fg = "#202020",
        _status_fg_nc = "#202020",
        _status_fade1_bg = "#00BB00",
        _status_fade1_fg = "#00AD00",
        _status_fade2_bg = "#00D600",
        _status_fade2_fg = "#00C800",
        _status_fade3_bg = "#00F100",
        _status_fade3_fg = "#00E300",
        _status_file_bg = "#00FF00",
        _status_subtle_fg = "#005500",
        _status_impact_fg = "#ff0000",
        _status_emphasis_fg = "#e0e000", -- Currently only used for the branch
        _status_nc_bg = "#a0a0a0",
        _blur_status_fade1_bg = "#b0b0b0",
        _blur_status_fade1_fg = "#b0b0b0",
        _blur_status_fade2_bg = "#b8b8b8",
        _blur_status_fade2_fg = "#b8b8b8",
        _blur_status_fade3_bg = "#c8c8c8",
        _blur_status_fade3_fg = "#c0c0c0",
        _blur_status_file_bg = "#d0d0d0",
        _qf_status_fg = "#ff00ff",
        _qf_status_line_bg = "#c0c000",
        _qf_status_fade1_bg = "#d0d000",
        _qf_status_fade1_fg = "#c8c800",
        _qf_status_fade2_bg = "#e0e000",
        _qf_status_fade2_fg = "#d8d800",
        _qf_status_fade3_bg = "#f0f000",
        _qf_status_fade3_fg = "#e8e800",
        _qf_status_file_bg = "#ffff00",
        _qf_status_nc_bg = "#777700",
        _qf_status_emphasis_fg = "#000000",
        _help_status_fg = "#ff00ff",
        _help_status_line_bg = "#a000e0",
        _help_status_fade1_bg = "#b000e8",
        _help_status_fade1_fg = "#a800e4",
        _help_status_fade2_bg = "#c000f0",
        _help_status_fade2_fg = "#b800ea",
        _help_status_fade3_bg = "#e000f8",
        _help_status_fade3_fg = "#d000f4",
        _help_status_file_bg = "#ff00ff",
        _help_status_nc_bg = "#770077",
        _help_status_emphasis_fg = "#000000",
    }
end

function M.get_groups(p)
    return {
        _StatusModified = {fg = p.fg0, bg = p.bg_red},

        StatusLine = {fg = p._status_fg, bg = p.status_line_bg, nocombine = true},
        _StatusFade1 = {fg = p._status_fade1_fg, bg = p._status_fade1_bg},
        _StatusFade2 = {fg = p._status_fade2_fg, bg = p._status_fade2_bg},
        _StatusFade3 = {fg = p._status_fade3_fg, bg = p._status_fade3_bg},
        _StatusFile = {fg = p._status_fg, bg = p._status_file_bg, bold = true},
        _StatusSubtle = {fg = p._status_subtle_fg, bg = p.status_line_bg},
        _StatusImpact = {fg = p._status_impact_fg, bg = p.status_line_bg, bold = true},
        _StatusEmphasis = {fg = p._status_emphasis_fg, bg = p.status_line_bg, bold = true},

        StatusLineNC = {fg = p._status_fg, bg = p._status_nc_bg, nocombine = true},
        _blurStatusFade1 = {fg = p._blur_status_fade1_fg, bg = p._blur_status_fade1_bg},
        _blurStatusFade2 = {fg = p._blur_status_fade2_fg, bg = p._blur_status_fade2_bg},
        _blurStatusFade3 = {fg = p._blur_status_fade3_fg, bg = p._blur_status_fade3_bg},
        _blurStatusFile = {fg = p._status_fg, bg = p._blur_status_file_bg, bold = true},
        _blurStatusSubtle = {fg = p._status_subtle_nc_fg, bg = p._status_subtle_nc_bg},
        _blurStatusImpact = {fg = p._status_impact_fg, bg = p._status_subtle_nc_bg, bold = true},
        _blurStatusEmphasis = { link = "StatusLineNC" },

        _qfStatusLine = {fg = p._status_fg, bg = p._qf_status_line_bg},
        _qfStatusFade1 = {fg = p._qf_status_fade1_fg, bg = p._qf_status_fade1_bg},
        _qfStatusFade2 = {fg = p._qf_status_fade2_fg, bg = p._qf_status_fade2_bg},
        _qfStatusFade3 = {fg = p._qf_status_fade3_fg, bg = p._qf_status_fade3_bg},
        _qfStatusFile = {fg = p._status_fg, bg = p._qf_status_file_bg, bold = true},
        _qfStatusLineNC = {fg = p._qf_status_fg, bg = p._qf_status_nc_bg},
        _qfStatusSubtle = {fg = p._qf_status_subtle_fg, bg = p._qf_status_subtle_bg},
        _qfStatusEmphasis = { fg = p._qf_status_emphasis_fg, bg = p._qf_status_line_bg, bold = true },

        _helpStatusLine = {fg = p._status_fg, bg = p._help_status_line_bg},
        _helpStatusFade1 = {fg = p._help_status_fade1_fg, bg = p._help_status_fade1_bg},
        _helpStatusFade2 = {fg = p._help_status_fade2_fg, bg = p._help_status_fade2_bg},
        _helpStatusFade3 = {fg = p._help_status_fade3_fg, bg = p._help_status_fade3_bg},
        _helpStatusFile = {fg = p._status_fg, bg = p._help_status_file_bg, bold = true},
        _helpStatusLineNC = {fg = p._help_status_fg, bg = p._help_status_nc_bg},
        _helpStatusSubtle = {fg = p._help_status_subtle_fg, bg = p._help_status_subtle_bg},
        _helpStatusEmphasis = { fg = p._help_status_emphasis_fg, bg = p._help_status_line_bg, bold = true },
    }
end

return M
