--[[
# GREETER

- Shows some ASCII art and the Neovim version below it
- It auto centers the ascii art and applies a highlight group.
- Redraws if the window is resized
- Allows one to enter insert mode directly (clears the buffer)
- Refer to the `Configuration Variables` below
- Create your own ASCII art using this tool: https://patorjk.com/software/taag/
- It has no widgets/links because if I need to open old files etc, I have mappings for that.
- At the end of the file it runs the greeter, if you wish to call it at some other point
  after it has been required,  you can remove the `M.display_conditionally()`

--]]

-- Configuarion Variabales

local GAP_LINES = 2         -- Number of empty lines between ASCII art and version line
local VERTICAL_OFFSET = 2   -- Number of lines to push the art up by (centered looks a little too low)
vim.api.nvim_set_hl(0, "GreeterAsciiArt", {fg = "#305020"}) -- The ascii art color
vim.api.nvim_set_hl(0, "GreeterNvimVer", {fg = "#808080"})  -- The Neovim version color
local ascii_str = [[
 ░▒▓██████▓▒░  ░▒▓██████▓▒░ ░▒▓█▓▒░             ░▒▓███████▓▒░         ░▒▓███████▓▒░ ░▒▓███████▓▒░
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░
░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░       ░▒▓█▓▒░       ░▒▓█▓▒░
░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░             ░▒▓███████▓▒░          ░▒▓██████▓▒░ ░▒▓███████▓▒░
░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░░▒▓█▓▒░              ░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░                    ░▒▓█▓▒░░▒▓██▓▒░░▒▓█▓▒░              ░▒▓█▓▒░
 ░▒▓██████▓▒░  ░▒▓██████▓▒░ ░▒▓████████▓▒░      ░▒▓███████▓▒░         ░▒▓████████▓▒░░▒▓███████▓▒░
]]

-- Colossians 3:23 Whatever you do, work at it with all your heart, as working
-- for the Lord, not for human masters, 24since you know that you will receive
-- an inheritance from the Lord as a reward. It is the Lord Christ you are
-- serving.

-- Module
local M = {}

local ascii = vim.split(ascii_str, "\n")

local vers = vim.version()
local commit = vers.build ~= vim.NIL and ("+" .. vers.build) or ""
local is_nightly = (vers.prerelease ~= nil and vers.prerelease ~= vim.NIL)
local channel = is_nightly and "Nightly " or "Stable"
local nvim_version =
    "NVIM v" .. vers.major .. "." .. vers.minor .. "." .. vers.patch .. " (" .. channel .. ") " .. commit

local greeter_ns = vim.api.nvim_create_namespace("greeter")

local function pad_str(padding, string)
    return string.rep(" ", padding) .. string
end

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

local function set_options(buf)
    -- Don't set these values, else when opening from quickfix window it splits the greeter instead of using the greeter window
    -- vim.bo[buf].modified = false
    -- vim.bo[buf].buftype = "nofile"

    vim.bo[buf].buflisted = false
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false

    -- Slightly more ugly, but simpler code and not buggy
    -- local win = vim.api.nvim_get_current_win()
    -- vim.wo[win].colorcolumn = ""
    -- vim.wo[win].relativenumber = false
    -- vim.wo[win].number = false
    -- vim.wo[win].list = false
    -- vim.wo[win].signcolumn = "no"

    vim.api.nvim_set_current_buf(buf)
end

local function highlight_line(buf, row, hl_group)
    local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1]

    if not line or line == "" then
        return
    end

    vim.api.nvim_buf_set_extmark(buf, greeter_ns, row, 0, {
        end_col = #line,
        hl_group = hl_group,
    })
end

local function apply_highlights(buf, vertical_pad)
    vim.api.nvim_buf_clear_namespace(buf, greeter_ns, 0, -1)

    -- Apply highlight to each line of ASCII art
    for i = vertical_pad + 1, vertical_pad + #ascii do
        highlight_line(buf, i - 1, "GreeterAsciiArt")
    end

    -- Highlight version line
    highlight_line(buf, vertical_pad + #ascii + GAP_LINES, "GreeterNvimVer")
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
    local version_line = nvim_version
    local version_pad = math.floor((width - #version_line) / 2)
    table.insert(centered_ascii, pad_str(version_pad, version_line))

    return centered_ascii
end

function M.draw(buf)
    set_options(buf)

    -- width
    local screen_width = vim.api.nvim_get_option_value("columns", {})
    local draw_width = math.max(count_utf_chars(ascii[1]), #nvim_version)
    local pad_width = math.floor((screen_width - draw_width) / 2)

    -- height
    local screen_height = vim.api.nvim_get_option_value("lines", {})
    local draw_height = #ascii + GAP_LINES + 1 -- Including version line
    local pad_height = math.floor((screen_height - draw_height) / 2) - VERTICAL_OFFSET

    if not(screen_width >= draw_width + 2 and screen_height >= draw_height + 2 + VERTICAL_OFFSET) then
        -- Only display if there is enough space
        return
    end

    local centered_ascii = calc_ascii(screen_width, pad_height, pad_width)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, centered_ascii)
    apply_highlights(buf, pad_height)
    vim.bo[buf].modified = false
end

function M.replace_greeter_with_normal_buffer(greeter_buf, start_insert)
    local new_buf = vim.api.nvim_create_buf(true, false)
    local win = vim.api.nvim_get_current_win()

    vim.api.nvim_win_set_buf(win, new_buf)

    if start_insert then
        vim.cmd("startinsert")
    end

    if vim.api.nvim_buf_is_valid(greeter_buf) then
        vim.api.nvim_buf_delete(greeter_buf, {force = true})
    end
end

function M.display()
    vim.cmd("enew")
    local buf = vim.api.nvim_get_current_buf()
    M.draw(buf)

    local NamespaceGroup = vim.api.nvim_create_augroup("Greeter", {clear = true})

    vim.api.nvim_create_autocmd({"VimResized"}, {
        buffer = buf,
        desc = "Recalc and redraw greeter when window is resized",
        group = NamespaceGroup,
        callback = function() M.draw(buf) end,
    })

    vim.api.nvim_create_autocmd({"InsertEnter"}, {
        buffer = buf,
        desc = "If entering insert mode from greeter, replace it with a normal empty buffer",
        group = NamespaceGroup,
        callback = function()
            M.replace_greeter_with_normal_buffer(buf, true)
        end,
    })
end

function M.display_conditionally()
    -- Check if there were args (i.e. opened file), non-empty buffer, or started in insert mode
    if vim.fn.argc() == 0 or vim.fn.line2byte("$") ~= -1 and not vim.opt.insertmode then
        M.display()
    end
end

M.display_conditionally()

return M
