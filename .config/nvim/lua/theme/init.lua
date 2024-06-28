local bonus = require("theme.bonus")
local builtin = require("theme.builtin")
local diffs = require("theme.diffs")
local gruvbox = require("theme.gruvbox")
local langs = require("theme.langs")
local plugin = require("theme.plugin")
local status = require("theme.status")
local symbols = require("theme.symbols")
local utils = require("theme.utils")

local get_palette_mods = {gruvbox, symbols, status, plugin}
local get_groups_mods = {builtin, bonus, symbols, status, langs, plugin}

local M = {}

local is_diff_mode = vim.opt.diff:get()

-- style can be 'hard', 'medium', 'soft'
local function build_palette(style)
    local p = {}
    if style == "hard" then
        utils.update_palette(p, gruvbox.get_palette_hard(p))
    elseif style == "medium" then
        utils.update_palette(p, gruvbox.get_palette_medium(p))
    elseif style == "soft" then
        utils.update_palette(p, gruvbox.get_palette_soft(p))
    end
    for k, v in ipairs(get_palette_mods) do
        if not v.get_palette then
            error("Missing get_palette function in index: " .. k)
        end
        utils.update_palette(p, v.get_palette(p))
    end
    return p
end

local function build_groups(p)
    local groups = {}
    for k, v in ipairs(get_groups_mods) do
        if not v.get_groups then
            error("Missing get_groups function in index: " .. k)
        end
        local new_groups = v.get_groups(p)
        utils.update_groups(groups, new_groups)
    end
    if is_diff_mode then
        utils.update_groups(groups, diffs.get_groups(p))
    end
    return groups
end

-- style can be 'hard', 'medium', 'soft'
function M.apply_theme(style)
    -- Baseline
    vim.cmd.colorscheme("default") -- baseline
    vim.g.gruvbox_material_background = style -- 'hard', 'medium', 'soft'
    vim.cmd.colorscheme("gruvbox-material") -- further baseline2
    -- Custom
    local p = build_palette(style)
    local groups = build_groups(p)
    utils.apply_highlights(groups)
    -- Autocmds
    require("theme/autocmds")
end

return M
