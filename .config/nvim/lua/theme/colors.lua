local builtin = require('theme.builtin')
local gruvbox = require('theme.gruvbox')
local status = require('theme.status')
local symbols = require('theme.symbols')
local utils = require('theme.utils')

local M = {}

-- style can be 'hard', 'medium', 'soft'
local function build_palette(style)
    local p = {}
    utils.update_palette(p, gruvbox.get_palette(p))
    if style == "hard" then
        utils.update_palette(p, gruvbox.get_palette_hard(p))
    elseif style == "medium" then
        utils.update_palette(p, gruvbox.get_palette_medium(p))
    elseif style == "soft" then
        utils.update_palette(p, gruvbox.get_palette_soft(p))
    end
    utils.update_palette(p, symbols.get_palette(p))
    utils.update_palette(p, status.get_palette(p))
    return p
end

local function apply_groups(p) 
    local groups = {}
    utils.update_palette(groups, builtin.get_groups(p))
    utils.update_palette(groups, status.get_groups(p))
    utils.update_palette(groups, symbols.get_groups(p))
    utils.apply_highlights(groups)
end

-- style can be 'hard', 'medium', 'soft'
function M.apply_theme(style)
    -- Baseline
    vim.cmd.colorscheme('default') -- baseline
    vim.g.gruvbox_material_background = style -- 'hard', 'medium', 'soft'
    vim.cmd.colorscheme('gruvbox-material') -- further baseline2
    -- Custom
    local p = build_palette(style)
    apply_groups(p)
end

M.apply_theme('hard')
return M
