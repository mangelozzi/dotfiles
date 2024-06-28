--[[
      • {val}    Highlight definition map, accepts the following keys:
                 • fg (or foreground): color name or "#RRGGBB", see note.
                 • bg (or background): color name or "#RRGGBB", see note.
                 • sp (or special): color name or "#RRGGBB"
                 • blend: integer between 0 and 100
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

local M = {}

-- Function to merge tables and show only changes
function M.update_palette(base_palette, new_palette)
    for k, v in pairs(new_palette) do
        if base_palette[k] then
            error("Duplicate Palette Key: " .. k .. " was " .. base_palette[k] .. " -> " .. new_palette[k])
        end
        base_palette[k] = v
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

return M
