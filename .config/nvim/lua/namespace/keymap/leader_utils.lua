
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

return M
