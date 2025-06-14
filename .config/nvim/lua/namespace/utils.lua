local wsl = require("namespace.wsl")

local M = {}


function M.map_leader_char_to_nop()
    -- If one pressed <leader>cl and its not mapped to anything, then it performs a `cl`, .. not great
    -- So before mapping any leader keys, disable all maps, then add them in
    -- for char = 97, 122 do -- loop through the alphabet
    -- Only iterate the descructive operators, so which key can grab the rest
    -- d used for DOGE and D for @type variable declaration
    for _, char in ipairs({'C'}) do -- 'c' is used for component switcher prefix
        vim.keymap.set("n", "<leader>" .. char, "<ESC>", {noremap = true, nowait = true, desc = "<nop>"})
    end
end

function M.get_is_installed(plugin_name)
    return packer_plugins and packer_plugins[plugin_name] and packer_plugins[plugin_name].loaded
end

function M.trim(s)
    -- Strip leading/trailing whitespace
    return s:gsub("^%s*(.-)%s*$", "%1")
end

function M.escape_spaces(path)
    -- Make the function idempotent
    local unescaped_path = path:gsub("\\ ", " ") -- Replace '\ ' with ' '
    local escaped_path = unescaped_path:gsub(" ", "\\ ") -- Escape all spaces
    return escaped_path
end

-- Run a bash command and return the result
-- E.g. require('namespace.utils').get_return_value('ls -la')
function M.get_return_value(cmd)
    local handle = io.popen(cmd)
    if handle then
        local result = handle:read("a")
        handle:close()
        return M.trim(result)
    else
        return "ERROR running command " .. cmd
    end
end

function M.as_string(v)
  -- v:t_blob == 5
  if vim.fn.type(v) == vim.v.t_blob then
    return vim.fn.blob2str(v)
  end
  return v
end

function M.format_new_buffer_as_json_no_save()
  local buf  = 0
  local text = table.concat( vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")
  local output = vim.fn.system( { "prettier", "--parser", "json", "--tab-width", "4" }, text)
  if vim.v.shell_error ~= 0 then
    vim.notify("Prettier failed: " .. output, vim.log.levels.ERROR)
    return
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n", { plain = true }))
end

-- Auto format code
function M.format_code()
    if vim.bo.filetype == "" then
        M.format_new_buffer_as_json_no_save()
        return;
    end
    local file = vim.fn.expand("%:p")
    -- Note: os.execute messes up the terminal
    -- 1. Exit insert mode (if necessart), and save file changes
    vim.cmd("stopinsert")
    vim.cmd("write")
    -- 2. Format the file differently depending on the file type
    if vim.bo.filetype == "lua" then
        -- https://github.com/trixnz/lua-fmt
        vim.cmd("!luafmt --write-mode replace " .. file)
    elseif vim.bo.filetype == "python" then
        -- https://github.com/psf/black
        -- Black will edit the file and save it
        vim.cmd("!black -S --line-length 100 " .. file)
        if vim.v.shell_error == 0 then
            -- Only run black if isort was successful
            vim.cmd("!isort --line-length 100 --profile black " .. file)
        end
    elseif vim.bo.filetype == "javascript" or vim.bo.filetype == "typescript" then
        -- https://prettier.io/
        -- Prettier edit in place (--write)
        vim.cmd("!prettier --write --tab-width 4 " .. file)
    elseif vim.bo.filetype == "htmldjango" then
        -- vim.cmd("silent! !djlint --reformat --preserve-blank-lines " .. file)
        vim.cmd("!djlint --profile=django --reformat --format-css --format-js --preserve-blank-lines " .. file)
        vim.api.nvim_feedkeys("\\<CR>", "n", false)  -- Need a lot of enters
    elseif vim.bo.filetype == "html" then
        vim.cmd("!prettier --write --tab-width 4 " .. file)
    elseif vim.bo.filetype == "css" then
        vim.cmd("!prettier --write --tab-width 4 " .. file)
    elseif vim.bo.filetype == "json" then
        -- The json module is included in Python's Standard Library
        -- Set filein/fileout both to be the same (replace)
        vim.cmd("!prettier --write --tab-width 4 " .. file)
    else
        vim.cmd("!prettier --write --parser json --tab-width 4 " .. file)
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
    if vim.bo.filetype == "lua" then
        vim.cmd("messages clear")
        vim.cmd("luafile %")
        local keys = vim.api.nvim_replace_termcodes(':messages<cr>',true,false,true)
        vim.api.nvim_feedkeys(keys,'n',false)
    elseif vim.bo.filetype == "python" then
        vim.cmd("!python " .. file)
    elseif vim.bo.filetype == "typescript" then
        vim.cmd("!tsc --target es2015 --noImplicitAny " .. file)
    elseif vim.bo.filetype == "vim" then
        vim.cmd("source " .. file)
    elseif vim.bo.filetype == "html" or vim.bo.filetype == "markdown" then
        -- Escape spaces
        if wsl.get_is_wsl() then
            local win_path = wsl.linux_to_win_path(file)
            local win_cmd = "!/mnt/c/Program\\ Files/Google/Chrome/Application/chrome.exe " .. win_path
            vim.cmd(win_cmd)
            print("Opening in Windows Chrome: " .. win_path)
        else
            local clean_file = M.escape_spaces(file)
            vim.cmd("!google-chrome " .. clean_file)
            print("Opening in Chrome: " .. clean_file)
        end
    else
        print("No run command linked for this filetype, using system app...")
        vim.cmd("!/usr/bin/xdg-open " .. file)
    end
end

-- Insert the appropriate debugger statement
local javascript_debugger_fts = {
    ["javascript"] = true,
    ["typescript"] = true,
    ["html"] = true,
    ["htmldjango"] = true
}
function M.breakpoint()
    vim.cmd("stopinsert")
    if vim.bo.filetype == "python" then
        vim.cmd("normal Obreakpoint()")
    elseif javascript_debugger_fts[vim.bo.filetype] then
        vim.cmd("normal Odebugger;")
    else
        print("No run breakpoint defined for this file type")
    end
end

-- Text object to select the whole buffer, used in normal/visual modes
function M.text_object_all()
    vim.g.cursor_position = vim.fn.winsaveview()
    vim.cmd("normal! ggVG")
    local pattern = "[cd]" -- 'c' or 'd'
    if not string.find(vim.v.operator, pattern) then
        -- Running the command straight does not work, have to pass it through feedkeys or defer it
        vim.defer_fn(
            function()
                vim.fn.winrestview(vim.g.cursor_position)
            end,
            0
        )
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
    if vim.api.nvim_get_mode().mode == "v" then
        vim.api.nvim_command("'<,'>sort")
    else
        vim.api.nvim_command("sort")
    end
end

function M.quit_if_last_buffer()
    -- vim.fn.getbufvar(i, '&buftype') ==# 'help' then
    -- If help buftype = 'help'
    -- If NvimTree buftype = 'nofile'
    local buf_list = vim.api.nvim_list_bufs()
    for _, buf_id in pairs(buf_list) do
        if vim.api.nvim_buf_is_loaded(buf_id) then
            local empty = vim.api.nvim_buf_line_count(buf_id)
            local safe =
                vim.api.nvim_buf_get_option(buf_id, "modifiable") and
                not vim.api.nvim_buf_get_option(buf_id, "modified")
            local buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
            if not safe and buftype == "" then
                return
            end
        end
    end
    vim.cmd("quit")
end
function M.close_all_buffers()
    local buf_list = vim.api.nvim_list_bufs()
    -- First close all safe buffers
    for _, buf_id in pairs(buf_list) do
        if vim.api.nvim_buf_is_loaded(buf_id) then
            local empty = vim.api.nvim_buf_line_count(buf_id)
            local safe =
                vim.api.nvim_buf_get_option(buf_id, "modifiable") and
                not vim.api.nvim_buf_get_option(buf_id, "modified")
            local buftype = vim.api.nvim_buf_get_option(buf_id, "buftype")
            if safe or empty or buftype ~= "" then
                vim.api.nvim_buf_delete(buf_id, {force = false, unload = false})
            end
        end
    end
    M.quit_if_last_buffer()
end

function M.close_buffer_keep_window()
    local file = vim.api.nvim_buf_get_name(0)
    vim.cmd("edit #") -- switch to alternate file, like <C-^>
    local other_file = vim.api.nvim_buf_get_name(0)
    if file == other_file then
        -- If switch to alternate file results in the same file name we create a new file to switch to
        vim.cmd("enew")
    end
    -- Now delete the original buffer
    vim.cmd("bdelete #")
end

function M.reload_config()
    local loadThese = {}
    for moduleName in pairs(package.loaded) do
        if moduleName:match("^namespace") or moduleName:match("^theme") then
            loadThese[moduleName] = package.loaded[moduleName]
            package.loaded[moduleName] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print("Reload config, but need to press it twice ... " .. os.time())
end

function M.get_git_branch()
    -- :lua local parentDir = vim.fn.expand("%:p:h"); local command = "git -C " .. parentDir .. " branch --show-current 2>/dev/null"; local result = vim.fn.systemlist(command); vim.print(result)
    local parentDir = vim.fn.expand("%:p:h")
    local command
    if vim.fn.has("win32") == 1 then
        -- On Windows
        command = "git -C " .. parentDir .. " branch --show-current 2>NUL"
    else
        -- On Linux and other Unix-like systems
        command = "git -C " .. parentDir .. " branch --show-current 2>/dev/null"
    end
    local result = vim.fn.systemlist(command)
    local branch = #result > 0 and result[1] or "No Branch"
    return branch
end

function M.fd_files_populate_qf(pattern, dir)
    pattern = pattern or vim.fn.input('Enter search pattern: ')
    -- dir = dir or vim.fn.getcwd()
    local fd_command = string.format("fdfind '.*%s.*'", pattern) -- fd is an alias for fdfind
    if dir then
        fd_command = fd_command .. ' ' .. dir
    end

    local matching_files = vim.fn.systemlist(fd_command)
    if vim.v.shell_error > 0 then
        print("Error executing fd or no files found, error code: " .. vim.v.shell_error)
        return
    end

    local items = {}
    for _, file in ipairs(matching_files) do
        table.insert(items, {filename = file, lnum = 1, text = " "})
    end

    local title = pattern .. " ("..#items.." matches)"
    vim.fn.setqflist({}, "r", {title = title, items = items})
    vim.cmd('copen') -- Open the quickfix window
end

-- Function to escape HTML characters
function M.escape_html_lines(lines)
    local html_entities = {
        ["&"] = "&amp;",
        ["<"] = "&lt;",
        [">"] = "&gt;",
        -- ['"'] = "&quot;",
        -- ["'"] = "&#39;",
        ['{'] = "&#123;",
        ["}"] = "&#125;",
        ["@"] = "&#64;"
    }
    local escaped_lines = {}
    print('escape lines is')
    vim.print(lines)

    for _, line in ipairs(lines) do
        -- Replace & first to avoid double escaping, e.g. `{` -> `&#123;` -> `&amp;#123;`
        line = line:gsub("&", html_entities["&"])

        for char, entity in pairs(html_entities) do
            if char ~= "&" then
                line = line:gsub(char, entity)
            end
        end
        table.insert(escaped_lines, line)
    end
    return escaped_lines
end

--- Retrieves the visually seleceted text
-- Example mapping: vnoremap <leader>zz :<C-U>call rgflow#GetVisualSelection(visualmode())<Cr>
-- @mode - The result of `vim.fn.mode()`
-- @return - An array of lines
function M.get_selection_info(mode)
    local _, l1, c1 = unpack(vim.fn.getpos("v"))
    local _, l2, c2 = unpack(vim.fn.getpos("."))
    local line_start, line_end, start_col, end_col = l1, l2, c1, c2
    if l1 > l2 or l1 == l2 and c2 < c1 then
        line_start, line_end, start_col, end_col = l2, l1, c2, c1
    end
    line_start = line_start - 1
    end_col = end_col + 2
    -- nvim_buf_get_lines({buffer}, {start}, {end}, {strict_indexing})
    local lines = vim.api.nvim_buf_get_lines(0, line_start, line_end, true)
    local offset = 1
    if vim.api.nvim_get_option("selection") ~= "inclusive" then
        offset = 2
    end
    if mode == "v" then
        -- Must trim the end before the start, the beginning will shift left.
        lines[#lines] = string.sub(lines[#lines], 1, end_col - offset)
        lines[1] = string.sub(lines[1], start_col, -1)
    elseif mode == "V" then
        -- Line mode no need to trim start or end
    elseif mode == "\22" then
        -- <C-V> = ASCII char 22
        -- Block mode, trim every line
        for i, line in ipairs(lines) do
            lines[i] = string.sub(line, start_col, end_col - offset)
        end
    else
        error("Unknown visual mode: " .. mode)
    end
    -- vim.print('lines is', table.concat(lines, "\n"))
    -- return table.concat(lines, "\n")
    -- Names to match: nvim_buf_set_text({buffer}, {start_row}, {start_col}, {end_row}, {end_col}, {replacement})
    return {
        lines = lines,
        start_row = line_start,
        end_row = line_end,
        start_col = start_col,
        end_col = end_col
    }
end

function M.replace_selection(mode, info)
    -- nvim_buf_set_text({buffer}, {start_row}, {start_col}, {end_row}, {end_col}, {replacement})
    if mode == "v" then
        vim.api.nvim_buf_set_text(0, info.start_row, info.start_col - 1, info.end_row - 1, info.end_col, info.lines)
    elseif mode == "V" then
        vim.api.nvim_buf_set_text(0, info.start_row, 0, info.end_row - 1, -1, info.lines)
    elseif mode == "\22" then
        -- <C-V> = ASCII char 22
        -- Block mode, trim every line
        for i, line in ipairs(info.lines) do
            vim.api.nvim_buf_set_text(0, info.start_row + i - 1, info.start_col - 1, info.start_row + i - 1, info.end_col - 1, { line })
        end
    else
        error("Unknown visual mode: " .. mode)
    end
end

-- Transform a visual selection range of text
-- param `func` is a function that takes an array of lines and returns an array of lines
function M.alter_visual_range(func)
    local mode = vim.fn.mode()
    local info = M.get_selection_info(mode)
    local altered_lines = func(info.lines)
    info.lines = altered_lines
    M.replace_selection(mode, info)
end

function M.escape_html_visual_selection()
    M.alter_visual_range(M.escape_html_lines)
end

-- Set the operator function to the passed in function
-- e.g. require('namespace.utils').set_opfunc(function() print("Hello") end)
-- Refer to: https://github.com/neovim/neovim/issues/14157#issuecomment-1320787927
M.set_opfunc = vim.fn[vim.api.nvim_exec([[
  func s:set_opfunc(val)
    let &opfunc = a:val
  endfunc
  echon get(function('s:set_opfunc'), 'name')
]], true)]

return M

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
