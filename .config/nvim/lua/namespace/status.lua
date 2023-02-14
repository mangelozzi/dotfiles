local function get_rel_dir()
    -- Normal buffers buftype == "", special buffers it is something else, e.g. "nofile"
    if vim.bo.filetype == "NvimTree" then
        return vim.fn.getcwd()
    elseif vim.bo.buftype ~= '' then
        return '[R]'
    end
    return vim.fn.fnamemodify(vim.fn.expand "%", ":.:h")
end

local function get_filename()
    if vim.bo.filetype == "NvimTree" then
        return '[TREE]'
    elseif vim.bo.buftype ~= '' then
        return '['..string.upper(vim.bo.buftype)..']'
    end
    return vim.fn.fnamemodify(vim.fn.expand "%", ":t")
end

local function contract_home(file)
    -- Contract "/home/michael" to "~"
    return string.gsub(file, "/home/[^/]+/", "~/")
end
local function ensure_no_slash_prefix(file)
    if string.sub(file, 1, 1) == "/" then
        file = string.sub(file, 2)
    end
    return file
end
local function ensure_slash_suffix(file)
    if file ~= "" and string.sub(file, -1) ~= "/" then
        return file .. "/"
    end
    return file
end

local function get_dirs()
    -- Returns the pair root_to_pwd, pwd to file head
    -- if file in pwd, return the pwd, then from pwd to file head
    -- else return '', the file head
    if vim.bo.buftype ~= '' then
        return '', ''
    elseif vim.bo.readonly or not vim.bo.modifiable then
        return '', '[R]'
    end
    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), "%:p")
    local file = vim.fn.expand("%:p")
    local head = vim.fn.expand("%:p:h")
    local start_idx, _ = string.find(file, cwd)
    local is_in_pwd = start_idx == 1
    ---
    local root_to_pwd
    local pwd_to_head
    if is_in_pwd then
        root_to_pwd = ensure_slash_suffix(contract_home(cwd))
        pwd_to_head = string.sub(head, string.len(cwd) + 1)
        pwd_to_head = ensure_slash_suffix(ensure_no_slash_prefix(pwd_to_head))
    else
        root_to_pwd = ''
        pwd_to_head = ensure_slash_suffix(contract_home(head))
    end
    return root_to_pwd, pwd_to_head
end

local function get_file_type()
    if vim.bo.filetype == "NvimTree" then
        return ''
    end
    return '  '.. vim.bo.filetype ..'  '
end

local function get_modified()
    -- return vim.bo.modified and ' +++ ' or '' -- Will not work, cause only updates on when switching windows
    return "%{&modified?' +++ ':''}"
end

local function change_color(hi_group)
    return "%#" .. hi_group .. "#"
end

local function get_hi_groups(is_current_window)
    local line_group = ""
    local prefix = ""
    if is_current_window then
        if vim.bo.buftype == 'quickfix' then
            line_group = "_qfStatusLine"
            prefix = "_qf"
        elseif vim.bo.buftype ==  'help' then
            line_group = "_helpStatusLine"
            prefix = "_help"
        else
            prefix = "_"
            line_group = "StatusLine"
        end
    else
    -- If not the current window, then override the colors with gray
        line_group = "StatusLineNC"
        prefix = "_blur"
    end
    return {
        col_line   = change_color(line_group),
        col_file   = change_color(prefix .. "StatusFile"),
        col_subtle = change_color(prefix .. "StatusSubtle"),
        col_fade1  = change_color(prefix .. "StatusFade1"),
        col_fade2  = change_color(prefix .. "StatusFade2"),
        col_fade3  = change_color(prefix .. "StatusFade3"),
    }
end

local function print_groups(desc, groups)
    print(desc)
    for i, v in pairs(groups) do
        print(i, v)
    end
end

local function print_status_hi_groups()
    vim.cmd("messages clear")
    print_groups('Current Window result', get_hi_groups(true))
    print_groups('Blurred Window result', get_hi_groups(false))
    vim.bo.buftype = 'quickfix'
    print_groups('QF Current Window result', get_hi_groups(true))
    vim.bo.buftype = 'help'
    print_groups('Help Current Window result', get_hi_groups(true))
    vim.cmd("messages")
end
-- vim.keymap.set('n', '<F9>', print_status_hi_groups, { noremap = true})


vim.g.get_status_line = function(current_window)
    local groups = get_hi_groups(current_window)
    local root_to_pwd, pwd_to_head = get_dirs()
    local s1 =  table.concat{
        --"%*"                                       " Return to default color StatusLine / StatusLineNC
        groups['col_subtle'],
        " ",
        root_to_pwd,
        groups['col_line'],
        pwd_to_head,
    }
    local s2 = table.concat{
        groups['col_line'],
        groups['col_fade1'], "▌",
        groups['col_fade2'], "▌",
        groups['col_fade3'], "▌",
        -- anything to the left of %< will be retained
        --"%>", -- Where to truncate long lines
        groups['col_file'],
        -- -- " " %t "
        " ",
        get_filename(),
        " ",
        change_color("_StatusModified"),
        get_modified(),
        groups['col_fade3'], "▐",
        groups['col_fade2'], "▐",
        groups['col_fade1'], "▐",
        -- "%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''}",
        groups['col_line'],
    }
    -- "%#_StatusModified#%{&modified?' +++ ':''}"
    -- col_fade3."%{!&modified?'▐':''}".col_fade2."%{!&modified?'▐':''}".col_fade1."%{!&modified?'▐':''}"
    -- col_line
    -- "%{exists('w:quickfix_title')? ' '.w:quickfix_title : ''}"
    local s3 = table.concat{
        "%=",                                     -- Left/Right separator
        groups['col_line'],
        get_file_type(),
        "│%-3c",                                    -- Current column number, left aligned 3 characters wide
        "▏%P ",                                     -- Percentage through the file
    }
    if vim.bo.filetype == "NvimTree" then
        return s2 .. s3
    else
        return s1 .. s2 .. s3
    end
end

local StatusLineGroup = vim.api.nvim_create_augroup("StatusLineGroup", {clear = true})

-- STATUS LINE ----------------------------------------------------------------
-- Swap between windows: WinEnter --> BufEnter
-- Swap between two windows showing the same buffer --> WinEnter
-- WinEnter    =  Required for when a new window created and pops up
-- BufEnter    =  Required for when switching between existing buffers
-- BufWinEnter =  Required when running another quickfix search when one
--                already exists
-- BufWritePost = When saving myplugins, with no window of buffer switching
--                would go blank
vim.api.nvim_create_autocmd(
    {"BufWinEnter", "BufEnter", "WinEnter"},
    {
        desc = "StatusLine colouring dependant on active window",
        callback = function()
            vim.wo.statusline = vim.g.get_status_line(true)
            -- vim.cmd("redrawstatus!") -- MAKES fzf-lua preview text hidden, see: https://github.com/ibhagwan/fzf-lua/issues/643
        end,
        group = StatusLineGroup,
        pattern = "*",
    }
)
vim.api.nvim_create_autocmd(
    {"WinLeave"},
    {
        desc = "StatusLine colouring dependant on inactive window",
        callback = function()
            vim.wo.statusline = vim.g.get_status_line(false)
            -- vim.cmd("redrawstatus!")
        end,
        group = StatusLineGroup,
        pattern = "*",
    }
)

-- Status Line - Quickfix custom colors
vim.api.nvim_create_autocmd(
    {"BufWinEnter", "BufEnter"},
    {
        desc = "Quickfix custom coloring enable",
        callback = function()
            if vim.bo.buftype == "quickfix" then
                vim.opt.winhighlight =
                    "Normal:_qfNormal,LineNr:_qfLineNr,CursorLineNr:_qfCursorLineNr,CursorLine:_qfCursorLine"
            end
        end,
        group = StatusLineGroup,
        pattern = "*"
    }
)
vim.api.nvim_create_autocmd(
    {"BufWinLeave"},
    {
        desc = "Quickfix custom coloring disable",
        callback = function()
            if vim.bo.buftype == "quickfix" then
                vim.opt.winhighlight = "Normal:Normal"
            end
        end,
        group = StatusLineGroup,
        pattern = "*"
    }
)

-- print('path is1: ', vim.fn.fnamemodify(vim.fn.expand "%", ":.:h"))
-- print('path is2: ', get_hi_groups(false)['col_fade1'])
