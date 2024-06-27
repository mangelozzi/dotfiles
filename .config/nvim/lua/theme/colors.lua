local builtin = require('theme.builtin')
local gruvbox = require('theme.gruvbox')
local status = require('theme.status')
local symbols = require('theme.symbols')
local utils = require('theme.utils')

local M = {}

-- style can be 'hard', 'medium', 'soft'
local function build_palette(style)
    local p = {}
    utils.update_palette(p, gruvbox.add_to_palette())
    if style == "hard" then
        utils.update_palette(p, gruvbox.add_to_palette_hard())
    elseif style == "medium" then
        utils.update_palette(p, gruvbox.add_to_palette_medium())
    elseif style == "soft" then
        utils.update_palette(p, gruvbox.add_to_palette_soft())
    end
    utils.update_palette(p, symbols.add_to_palette())
    utils.update_palette(p, status.add_to_palette())
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
