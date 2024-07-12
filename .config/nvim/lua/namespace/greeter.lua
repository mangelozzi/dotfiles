-- Shows some ASCII art and the Neovim version below it

local M = {}

-- Setting highlight groups using nvim_set_hl
vim.api.nvim_set_hl(0, "GreeterAsciiArt", {fg = "#004000"})
vim.api.nvim_set_hl(0, "GreeterNvimVer", {fg = "#707070"})

local vers = vim.version()
local NVIM_VERSION =
    "NVIM v" .. vers.major .. "." .. vers.minor .. "." .. vers.patch .. "-" .. vers.prerelease .. "+" .. vers.build

local GAP_LINES = 2 -- Number of empty lines between ASCII art and version line
local VERTICAL_OFFSET = 2 -- Number of lines to push the art up by (centered looks a little too low)

local function pad_str(padding, string)
    return string.rep(" ", padding) .. string
end

-- Create your own using this tool: https://patorjk.com/software/taag/
local ascii = {
    " ░▒▓██████▓▒░  ░▒▓██████▓▒░ ░▒▓█▓▒░             ░▒▓███████▓▒░         ░▒▓███████▓▒░ ░▒▓███████▓▒░ ",
    "░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░",
    "░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░",
    "░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░             ░▒▓███████▓▒░          ░▒▓██████▓▒░ ░▒▓███████▓▒░ ",
    "░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░░▒▓█▓▒░              ░▒▓█▓▒░",
    "░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░░▒▓█▓▒░              ░▒▓█▓▒░",
    " ░▒▓██████▓▒░  ░▒▓██████▓▒░ ░▒▓████████▓▒░      ░▒▓███████▓▒░         ░▒▓████████▓▒░░▒▓███████▓▒░ "
}

local function count_utf_chars(str)
    local count = 0
    local i = 1
    local len = #str
    while i <= len do
        local byte = str:byte(i)
        if byte < 128 then
            i = i + 1 -- ASCII byte
        elseif byte < 224 then
            i = i + 2 -- 2 byte character
        elseif byte < 240 then
            i = i + 3 -- 3 byte character
        else
            i = i + 4 -- 4 byte character
        end
        count = count + 1
    end
    return count
end

local function set_options(win, buf)
    vim.api.nvim_buf_set_option(buf, "modified", false)
    vim.api.nvim_buf_set_option(buf, "buflisted", false)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
    vim.api.nvim_buf_set_option(buf, "swapfile", false)
    vim.api.nvim_win_set_option(win, "colorcolumn", "")
    vim.api.nvim_win_set_option(win, "relativenumber", false)
    vim.api.nvim_win_set_option(win, "number", false)
    vim.api.nvim_win_set_option(win, "list", false)
    vim.api.nvim_win_set_option(win, "signcolumn", "no")
    vim.api.nvim_set_current_buf(buf)
end

local function apply_highlights(buf, vertical_pad)
    -- Apply highlight to each line of ASCII art
    for i = vertical_pad + 1, vertical_pad + #ascii do
        vim.api.nvim_buf_add_highlight(buf, -1, "GreeterAsciiArt", i - 1, 0, -1)
    end

    -- Highlight version line
    vim.api.nvim_buf_add_highlight(buf, -1, "GreeterNvimVer", vertical_pad + #ascii + GAP_LINES, 0, -1)
end

local function calc_ascii(width, vertical_pad, pad_cols)
    local centered_ascii = {}

    -- Add empty lines for vertical padding
    for _ = 1, vertical_pad do
        table.insert(centered_ascii, "")
    end

    -- Add ASCII lines with padding
    for _, line in ipairs(ascii) do
        local padded_line = pad_str(pad_cols, line)
        table.insert(centered_ascii, padded_line)
    end

    -- Add Gap between ascii and version
    for _ = 1, GAP_LINES do
        table.insert(centered_ascii, "")
    end

    -- Add version line centered
    local version_line = NVIM_VERSION
    local version_pad = math.floor((width - #version_line) / 2)
    table.insert(centered_ascii, pad_str(version_pad, version_line))

    return centered_ascii
end

function M.display()
    vim.cmd("enew")
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_get_current_buf()
    set_options(win, buf)
    -- width
    local screen_width = vim.api.nvim_get_option("columns")
    local draw_width = math.max(count_utf_chars(ascii[1]), #NVIM_VERSION)
    local pad_width = math.floor((screen_width - draw_width) / 2)
    -- height
    local screen_height = vim.api.nvim_get_option("lines")
    local draw_height = #ascii + GAP_LINES + 1 -- Including version line
    local pad_height = math.floor((screen_height - draw_height) / 2) - VERTICAL_OFFSET

    -- Only display if there is enough space
    if screen_width >= draw_width + 2 and screen_height >= draw_height + 2 + VERTICAL_OFFSET then
        local centered_ascii = calc_ascii(screen_width, pad_height, pad_width)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, centered_ascii)
        apply_highlights(buf, pad_height)
    end
end

function M.display_conditionally()
    -- Check if there were args (i.e. opened file), non-empty buffer, or started in insert mode
    if vim.fn.argc() == 0 or vim.fn.line2byte("$") ~= -1 and not vim.opt.insertmode then
        M.display()
    end
end

M.display_conditionally()

return M
