
local M = {}

local utils = require('namespace.utils')

-- Open current or alternate buffer in another edit window (vsp if needed)
--
-- @param isAltBuf boolean
--        true  -> open alternate buffer
--        false -> open current buffer
--
-- @param focus_new boolean|nil
--        true  (default) -> focus the target window
--        false           -> keep focus in the source window
function M.openInVsp(isAltBuf, focus_new)
    if focus_new == nil then
        focus_new = true
    end


    local src_win = vim.api.nvim_get_current_win()
    if not utils.is_edit_win(src_win) then
    src_win = utils.find_edit_window(false)
    if not src_win then
        error('No editable window found')
    end
    vim.api.nvim_set_current_win(src_win)
    end
    local src_buf = vim.api.nvim_get_current_buf()
    local buf = isAltBuf and vim.fn.bufnr('#') or src_buf
    if buf == -1 then
        error(isAltBuf and 'No alternate buffer' or 'No current buffer?')
    end

    -- Capture the correct view for the buffer we want to open
    local view
    if isAltBuf then
        vim.api.nvim_set_current_buf(buf)
        view = vim.fn.winsaveview()
        vim.api.nvim_set_current_buf(src_buf)
    else
        view = vim.fn.winsaveview()
    end

    local target_win = utils.find_edit_window(false)
    if not target_win then
        vim.cmd('vsplit')
        target_win = vim.api.nvim_get_current_win()
    end

    vim.api.nvim_set_current_win(target_win)
    vim.api.nvim_set_current_buf(buf)
    vim.fn.winrestview(view)

    if focus_new then
        vim.api.nvim_set_current_win(target_win)
    else
        vim.api.nvim_set_current_win(src_win)
    end
end

-- Clean +/- markers in the nearest contiguous +/- block around the cursor.
-- Deletes lines starting with '-'
-- Keeps lines starting with '+' (strips the '+')
-- Cursor can be anywhere in/near the block (even on a non +/- line).
function M.strip_plus_minus_block()
    local buf = 0
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-based
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)
    local n = #lines
    if n == 0 then
        return
    end

    local function getline(i0)
        -- i0 is 0-based, lines[] is 1-based
        return lines[i0 + 1] or ''
    end

    local function is_pm_line(s)
        local c = s:sub(1, 1)
        return c == '+' or c == '-'
    end

    -- Find an anchor +/- line near the cursor (prefer upwards, then downwards)
    local anchor = nil
    for i = math.min(row, n - 1), 0, -1 do
        if is_pm_line(getline(i)) then
        anchor = i
        break
        end
    end
    if not anchor then
        for i = math.max(row + 1, 0), n - 1 do
        if is_pm_line(getline(i)) then
            anchor = i
            break
        end
        end
    end
    if not anchor then
        error('No +/- lines found near cursor')
    end

    -- Expand to contiguous +/- block around anchor
    local start_row = anchor
    while start_row > 0 and is_pm_line(getline(start_row - 1)) do
        start_row = start_row - 1
    end

    local end_row = anchor
    while end_row < n - 1 and is_pm_line(getline(end_row + 1)) do
        end_row = end_row + 1
    end

    local out = {}
    for i = start_row, end_row do
        local s = getline(i)
        local c = s:sub(1, 1)
        if c == '+' then
        table.insert(out, s:sub(2))
        elseif c == '-' then
        -- drop
        else
        table.insert(out, s)
        end
    end

    vim.api.nvim_buf_set_lines(buf, start_row, end_row + 1, true, out)
    vim.api.nvim_win_set_cursor(0, { start_row + 1, 0 })
end

return M
