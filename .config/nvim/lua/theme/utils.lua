--[[
      • {val}    Highlight definition map, accepts the following keys:
                 • fg (or foreground): color name or "#RRGGBB", see note.
                 • bg (or background): color name or "#RRGGBB", see note.
                 • sp (or special): color name or "#RRGGBB"
                 • blend: integer between 0 and 100
                        :help highlight-blend
                        Override the blend level for a highlight group within the popupmenu
                        or floating windows. Only takes effect if 'pumblend' or 'winblend'
                        is set for the menu or window. See the help at the respective option.
                 • bold: boolean
                 • standout: boolean
                 • underline: boolean
                 • undercurl: boolean
                 • underdouble: boolean
                 • underdotted: boolean
                 • underdashed: boolean
                 • strikethrough: boolean
                 • italic: boolean
                 • reverse: boolean
                 • nocombine: boolean - override attributes instead of combining them
                 • link: name of another highlight group to link to, see
                   |:hi-link|.
                 • default: Don't override existing definition |:hi-default|
                 • ctermfg: Sets foreground of cterm color |ctermfg|
                 • ctermbg: Sets background of cterm color |ctermbg|
                 • cterm: cterm attribute map, like |highlight-args|. If not
                   set, cterm attributes will match those from the attribute
                   map documented above.
--]]

local calc = require("theme.calc")
local gruvbox = require("theme.gruvbox")

local M = {}

local desat_map = {
    hard = 1,
    medium = 0.8,
    soft = 0.6
}
local darken_map = {
    hard = 1,
    medium = 0.95,
    soft = 0.85
}

local function isGruvboxColor(key)
    if gruvbox.palette.hard[key] then
        return true
    end
end

-- Function to merge tables and show only changes
function M.update_palette(base_palette, new_palette, style)
    local desat = desat_map[style]
    local darken = darken_map[style]
    for k, v in pairs(new_palette) do
        if base_palette[k] then
            error("Duplicate Palette Key: " .. k .. " was " .. base_palette[k] .. " -> " .. new_palette[k])
        end
        local adj_color = isGruvboxColor(k) and v or calc.adjust_color(v, desat, darken)
        base_palette[k] = adj_color
    end
end

function M.update_groups(base_groups, new_groups)
    for group_name, props in pairs(new_groups) do
        base_groups[group_name] = props
    end
end

function M.apply_highlights(groups)
    for group_name, props in pairs(groups) do
        vim.api.nvim_set_hl(0, group_name, props)
    end
end

-- To reload the colors to check changes in real time
vim.keymap.set("n", "<leader>@", function() require("theme").reload_colors() end, {noremap = true, desc = "Reload theme"})

return M
