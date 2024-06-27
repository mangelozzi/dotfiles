local M = {}

function M.apply_highlights(highlights)
    for group, properties in pairs(highlights) do
        if properties.link then
            vim.api.nvim_set_hl(0, group, { link = properties.link })
        else
            local props = {}
            if properties.fg then
                props.foreground = properties.fg
            end
            if properties.bg then
                props.background = properties.bg
            end
            if properties.sp then
                props.sp = true
            end
            if properties.bold then
                props.bold = true
            end
            if properties.underline then
                props.underline = true
            end
            if properties.italic then
                props.italic = true
            end
            if properties.undercurl then
                props.undercurl = true
            end
            vim.api.nvim_set_hl(0, group, props)
        end
    end
end

    -- Function to merge tables and show only changes
function M.update_palette(base_groups, new_groups)
    for k, v in pairs(new_groups) do
        if base_groups[k] then
            error("Duplicate Palette Key: " .. k .. " was " .. base_groups[k] .. " -> " .. new_groups[k])
        end
        base_groups[k] = v
    end
end

return M
