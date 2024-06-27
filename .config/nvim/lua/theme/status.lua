-- Own status line theme colors

local M = {}

function M.add_to_palette(p)
    return {
        status_line_bg = "#00A000",
        _status_subtle_nc_fg = "#707070",
        _status_subtle_nc_bg = "#a0a0a0",
        _qf_status_subtle_bg = "#c0c000",
        _qf_status_subtle_fg = "#909000",
        _help_status_subtle_fg = "#000077",
        _help_status_subtle_bg = "#a000e0",
    }
end

function M.get_groups(p)
    return {
        StatusLine = {fg = "#202020", bg = p.status_line_bg, gui = "none"}, -- WARNING! By default gui set to reverse, need to overide it with none
        _StatusFade1 = {fg = "#00AD00", bg = "#00BB00"},
        _StatusFade2 = {fg = "#00C800", bg = "#00D600"},
        _StatusFade3 = {fg = "#00E300", bg = "#00F100"},
        _StatusFile = {fg = "#000000", bg = "#00FF00", bold = true},
        _StatusSubtle = {fg = "#005500", bg = p.status_line_bg},
        _StatusImpact = {fg = "#ffb000", bg = p.status_line_bg, bold = true},
        StatusLineNC = {fg = "#000000", bg = "#a0a0a0", gui = "none"}, -- WARNING! By default gui set to reverse, need to overide it with none
        _blurStatusFade1 = {fg = "#b0b0b0", bg = "#b0b0b0"},
        _blurStatusFade2 = {fg = "#b8b8b8", bg = "#b8b8b8"},
        _blurStatusFade3 = {fg = "#c0c0c0", bg = "#c8c8c8"},
        _blurStatusFile = {fg = "#000000", bg = "#d0d0d0", bold = true},
        _blurStatusSubtle = {fg = p._status_subtle_nc_fg, bg = p._status_subtle_nc_bg},
        _blurStatusImpact = {fg = p._status_subtle_nc_fg, bg = p._status_subtle_nc_bg},
        _qfStatusLine = {fg = "#000000", bg = "#c0c000"},
        _qfStatusFade1 = {fg = "#c8c800", bg = "#d0d000"},
        _qfStatusFade2 = {fg = "#d8d800", bg = "#e0e000"},
        _qfStatusFade3 = {fg = "#e8e800", bg = "#f0f000"},
        _qfStatusFile = {fg = "#000000", bg = "#ffff00", bold = true},
        _qfStatusLineNC = {fg = "#ffff00", bg = "#777700"},
        _qfStatusSubtle = {fg = p._qf_status_subtle_fg, bg = p._qf_status_subtle_bg},
        _qfStatusImpact = {fg = p._qf_status_subtle_fg, bg = p._qf_status_subtle_bg},
        _helpStatusLine = {fg = "#000000", bg = "#a000e0"},
        _helpStatusFade1 = {fg = "#a800e4", bg = "#b000e8"},
        _helpStatusFade2 = {fg = "#b800ea", bg = "#c000f0"},
        _helpStatusFade3 = {fg = "#d000f4", bg = "#e000f8"},
        _helpStatusFile = {fg = "#000000", bg = "#ff00ff", bold = true},
        _helpStatusLineNC = {fg = "#ff00ff", bg = "#770077"},
        _helpStatusSubtle = {fg = p._help_status_subtle_fg, bg = p._help_status_subtle_bg},
        _helpStatusImpact = {fg = p._help_status_subtle_fg, bg = p._help_status_subtle_bg}
    }
end

return M
