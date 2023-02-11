local M = {}


-- Auto format code
function M.format_code()
    -- Note: os.execute messes up the terminal
    -- 1. Exit insert mode (if necessart), and save file changes
    vim.cmd("stopinsert")
    vim.cmd("write")
    local file = vim.fn.expand("%:p")
    -- 2. Format the file differently depending on the file type
    if vim.bo.filetype == "python" then
        -- Black will edit the file and save it
        vim.cmd("!black -S --line-length 100 " .. file)
        if vim.v.shell_error == 0 then
            -- Only run black if isort was successful
            vim.cmd("!isort --line-length 100 --profile black " .. file)
        end
    elseif vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
        -- Prettier edit in place (--write)
        vim.cmd("!prettier --write --print-width 100 --single-quote true --tab-width 4 --arrow-parens avoid " .. file)
    elseif vim.bo.filetype == "html" or vim.bo.filetype == "htmldjango" then
        vim.cmd("!djlint --format-css --format-js " .. file)
    elseif vim.bo.filetype == "css" then
        vim.cmd("!djlink " .. file)
    elseif vim.bo.filetype == "json" then
        -- The json module is included in Python's Standard Library
        -- Set filein/fileout both to be the same (replace)
        vim.cmd("!python -m json.tool --indent 4 " .. file .. " " .. file)
    elseif vim.bo.filetype == "lua" then
        vim.cmd("!luafmt --write-mode replace " .. file)
    end
    if vim.v.shell_error ~= 0 then
        -- If it failed to format, show the error message so can see the line/col number
        -- 'normal g<' does not make the message stay up
        vim.defer_fn(
            function()
                vim.fn.feedkeys("g<")
            end,
            0
        )
    else
        -- 3. Finally load the changes the autoformatter has made (and are saved)
        vim.api.nvim_feedkeys("\\<CR>", "n", false)
        vim.cmd("edit!")
    end
end


-- Handle how one runs various file types differently
function M.run()
    -- 1. Exit insert mode (if necessart), and save file changes
    vim.cmd("stopinsert")
    vim.cmd("write")
    local file = vim.fn.expand("%:p")
    if vim.bo.filetype == "python" then
        vim.cmd("!python " .. file)
    elseif vim.bo.filetype == "vim" then
        vim.cmd("source " .. file)
    elseif vim.bo.filetype == "html" or vim.bo.filetype == "markdown" then
        vim.cmd("!google-chrome " .. file)
    else
        print("No run command linked for this filetype, using system app...")
        vim.cmd("!/usr/bin/xdg-open " .. file)
    end
end


-- Insert the appropriate debugger statement
local javascript_debugger_fts = {
    ["javascript"] = true,
    ["html"] = true,
    ["htmldjango"] = true,
}
function M.breakpoint()
    vim.cmd("stopinsert")
    if vim.bo.filetype == "python" then
        vim.cmd('normal Obreakpoint()')
    elseif javascript_debugger_fts[vim.bo.filetype] then
        vim.cmd('normal Odebugger;')
    else
        print("No run breakpoint defined for this file type")
    end
end


-- Text object to select the whole buffer, used in normal/visual modes
function M.text_object_all()
    vim.g.cursor_position = vim.fn.winsaveview()
    vim.cmd('normal! ggVG')
    local pattern = "[cd]"  -- 'c' or 'd'
    if not string.find(vim.v.operator, pattern) then
        -- Running the command straight does not work, have to pass it through feedkeys or defer it
        vim.defer_fn(function() vim.fn.winrestview(vim.g.cursor_position) end, 0)
    end
end


-- Used by command mode mapping to make delete only delete to the right
function M.delete_to_right_only()
    if vim.fn.getcmdpos() <= #vim.fn.getcmdline() then -- # = length of string operator
        return "<DEL>"
    else
        return ""
    end
end


-- Sort operator
function M.sort_lines()
    if vim.api.nvim_get_mode().mode == 'v' then
        vim.api.nvim_command("'<,'>sort")
    else
        vim.api.nvim_command("sort")
    end
end


function M.strip_whitespace()
    vim.g.cursor_position = vim.fn.winsaveview()
    vim.cmd(':%s/\\s\\+$//e')   -- Backslashes escaped to form :%s/\s\+$//e
    vim.defer_fn(function() vim.fn.winrestview(vim.g.cursor_position) end, 0)
    print("Trailing whitespace stripped.")
end



-- Prevent FZF commands from open in none modifiable buffers
-- function M.fzf_open(cmd)
--     -- If more than 1 window, and buffer is not modifiable, or file type is
--     -- NERD tree or Quickfix type
--     local ft = vim.opt_local.filetype:get()
--     if vim.fn.winnr('$') > 1 and (not vim.opt_local.modifiable:get() or ft == 'NvimTree' or ft == 'qf') then
--         -- Move one window to the right, then up
--         vim.cmd('wincmd l')
--         vim.cmd('wincmd k')
--     end
--     vim.cmd('exe a:' .. cmd)
-- end


return M


-- function! myal#PythonVar2Dict(...)
--     " Python variable to dict (repeatable with dot)
--     " from:   foo = 'bar'
--     " to:   'foo' : 'bar',
--     " Usage: nnoremap <expr> <leader>{ myal#PythonVar2Dict()
--     if a:0
--         " perform operation
--         " let save_cursor = getcurpos()
--         execute "normal! I'\<ESC>ea'\<ESC>f=r:A,\<ESC>j^"
--     else
--         " set up
--         let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
--         return "g@\<space>"
--     endif
-- endfunction
--
-- function! myal#PythonDict2Var(...)
--     " Python dict to variable (repeatable with dot)
--     " from: 'foo' : 'bar',
--     " to:     foo = 'bar'
--     " Usage: nnoremap <expr> <leader>= myal#PythonDict2Var()
--   if a:0
--     " perform operation
--     execute "normal! ^xelxf:r=$xj"
--   else
--     " set up
--     let &operatorfunc = matchstr(expand('<sfile>'), '[^. ]*$')
--     return "g@\<space>"
--   endif
-- endfunction


-- " This function sets up the opfunc so it can be repeated with a dot.
-- " Align to Column works by moving the next none whitespace character to the
-- " desired columned. e.g. 32<hotkey> will align the next none whitespace
-- " character to column 32. Then press dot to repeat the operation.
-- function! myal#SetupAlignToColumn(col)
--     if v:count != 0
--         let w:myal_align_col = v:count
--     endif
--     set opfunc=myal#AlignToColumn
--     return 'g@l'
-- endfunction
-- function! myal#AlignToColumn(motion)
--     " Get cursor to just before next none space
--     let reg_backup_value = getreg('z')    " Backup the contents of the unnamed register
--     let reg_backup_type = getregtype('z')      " Save the type of the register as well
--     let l:winview = winsaveview()
--     let cmd = 'normal wh'.w:myal_align_col.'a'."\<SPACE>\<ESC>".'"zd'.(w:myal_align_col - 1).'|'
--     exe cmd
--     call winrestview(l:winview)
--     call setreg('z', reg_backup_value, reg_backup_value) " Restore register
--     normal j
-- endfunction