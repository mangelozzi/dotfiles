-- https://github.com/sainnhe/gruvbox-material?tab=readme-ov-file
-- Using the material (less contrast) theme

local M = {}

function M.add_to_palette(p)
    return {
        orange = "#e78a4e",
        yellow = "#d8a657",
        green = "#a9b665",
        aqua = "#89b482",
        blue = "#7daea3",
        purple = "#d3869b",
        bg_green = "#a9b665",
        bg_yellow = "#d8a657",
        grey0 = "#7c6f64",
        grey1 = "#928374",
        grey2 = "#a89984",
        fg0 = "#d4be98",
        fg1 = "#ddc7a1",
        red = "#ea6962",
        bg_red = "#ea6962"
    }
end

function M.add_to_palette_hard(p)
    return {
        bg_dim = "#141617",
        bg0 = "#1d2021",
        bg1 = "#282828",
        bg2 = "#282828",
        bg3 = "#3c3836",
        bg4 = "#3c3836",
        bg5 = "#504945",
        bg_statusline1 = "#282828",
        bg_statusline2 = "#32302f",
        bg_statusline3 = "#504945",
        bg_diff_blue = "#0d3138",
        bg_visual_blue = "#2e3b3b",
        bg_visual_yellow = "#473c29",
        bg_current_word = "#32302f",
        bg_diff_green = "#32361a",
        bg_visual_green = "#333e34",
        bg_diff_red = "#3c1f1e",
        bg_visual_red = "#442e2d",
    }
end

function M.add_to_palette_medium(p)
    return {
        bg_dim = "#1b1b1b",
        bg0 = "#282828",
        bg1 = "#32302f",
        bg2 = "#32302f",
        bg3 = "#45403d",
        bg4 = "#45403d",
        bg5 = "#5a524c",
        bg_statusline1 = "#32302f",
        bg_statusline2 = "#3a3735",
        bg_statusline3 = "#504945",
        bg_diff_blue = "#0e363e",
        bg_visual_blue = "#374141",
        bg_visual_yellow = "#4f422e",
        bg_current_word = "#3c3836",
        bg_diff_green = "#34421b",
        bg_visual_green = "#3b4439",
        bg_diff_red = "#402120",
        bg_visual_red = "#4c3432",
    }
end

function M.add_to_palette_soft(p)
    return {
        bg_dim = "#252423",
        bg0 = "#32302f",
        bg1 = "#3c3836",
        bg2 = "#3c3836",
        bg3 = "#504945",
        bg4 = "#504945",
        bg5 = "#665c54",
        bg_statusline1 = "#3c3836",
        bg_statusline2 = "#46413e",
        bg_statusline3 = "#5b534d",
        bg_diff_blue = "#0f3a42",
        bg_visual_blue = "#404946",
        bg_visual_yellow = "#574833",
        bg_current_word = "#45403d",
        bg_diff_green = "#3d4220",
        bg_visual_green = "#424a3e",
        bg_diff_red = "#472322",
        bg_visual_red = "#543937",
    }
end

return M
