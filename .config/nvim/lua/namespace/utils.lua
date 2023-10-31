local M = {}

function M.map_leader_char_to_nop()
    -- If one pressed <leader>cl and its not mapped to anything, then it performs a `cl`, .. not greate
    -- So before mapping any leader keys, disable all maps, then add them in
    for char = 97, 122 do
        local lowercase = string.char(char)
        local uppercase = string.char(char - 32) -- ASCII difference between lowercase and uppercase letters is 32
        vim.keymap.set("n", "<leader>" .. lowercase, "<ESC>", {noremap = true})
        vim.keymap.set("n", "<leader>" .. uppercase, "<ESC>", {noremap = true})
    end
end

function M.get_is_installed(plugin_name)
    return packer_plugins and packer_plugins[plugin_name] and packer_plugins[plugin_name].loaded
end

function M.trim(s)
    -- Strip leading/trailing whitespace
    return s:gsub("^%s*(.-)%s*$", "%1")
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
        return 'ERROR running command ' .. cmd
    end
end

-- Auto format code
function M.format_code()
    -- Note: os.execute messes up the terminal
    -- 1. Exit insert mode (if necessart), and save file changes
    vim.cmd("stopinsert")
    vim.cmd("write")
    local file = vim.fn.expand("%:p")
    -- 2. Format the file differently depending on the file type
    if vim.bo.filetype == "python" then
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
        vim.cmd("!prettier --write " .. file)
    elseif vim.bo.filetype == "html" or vim.bo.filetype == "htmldjango" then
        -- vim.cmd("!djlint --format-css --format-js " .. file)
        vim.cmd("!prettier --write " .. file)
    elseif vim.bo.filetype == "css" then
        vim.cmd("!prettier --write " .. file)
    elseif vim.bo.filetype == "json" then
        -- The json module is included in Python's Standard Library
        -- Set filein/fileout both to be the same (replace)
        vim.cmd("!prettier --write " .. file)

    elseif vim.bo.filetype == "lua" then
        -- https://github.com/trixnz/lua-fmt
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
    elseif vim.bo.filetype == "typescript" then
        vim.cmd("!tsc --target es2015 --noImplicitAny " .. file)
    elseif vim.bo.filetype == "vim" then
        vim.cmd("source " .. file)
    elseif vim.bo.filetype == "html" or vim.bo.filetype == "markdown" then
        -- Escape spaces
        local clean_file = file:gsub(' ', '\\ ')
        vim.cmd("!google-chrome " .. clean_file)
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
    -- vim.g.cursor_position = vim.fn.winsaveview()
    -- vim.cmd(':%s/\\s\\+$//e')   -- Backslashes escaped to form :%s/\s\+$//e
    -- vim.defer_fn(function() vim.fn.winrestview(vim.g.cursor_position) end, 0)
    -- print("Trailing whitespace stripped.")
end

function M.quit_if_last_buffer()
    -- vim.fn.getbufvar(i, '&buftype') ==# 'help' then
    -- If help buftype = 'help'
    -- If NvimTree buftype = 'nofile'
    local buf_list = vim.api.nvim_list_bufs()
    for _, buf_id in pairs(buf_list) do
        if vim.api.nvim_buf_is_loaded(buf_id) then
            local empty = vim.api.nvim_buf_line_count(buf_id)
            local safe = vim.api.nvim_buf_get_option(buf_id, 'modifiable') and not vim.api.nvim_buf_get_option(buf_id, 'modified')
            local buftype = vim.api.nvim_buf_get_option(buf_id, 'buftype')
            if not safe and buftype == '' then
                return
            end
        end
    end
    vim.cmd('quit')
end
function M.close_all_buffers()
    local buf_list = vim.api.nvim_list_bufs()
    -- First close all safe buffers
    for _, buf_id in pairs(buf_list) do
        if vim.api.nvim_buf_is_loaded(buf_id) then
            local empty = vim.api.nvim_buf_line_count(buf_id)
            local safe = vim.api.nvim_buf_get_option(buf_id, 'modifiable') and not vim.api.nvim_buf_get_option(buf_id, 'modified')
            local buftype = vim.api.nvim_buf_get_option(buf_id, 'buftype')
            if safe or empty  or buftype ~= '' then
                vim.api.nvim_buf_delete(buf_id, { force = false, unload = false})
            end
        end
    end
    M.quit_if_last_buffer()
end


function M.close_buffer_keep_window()
    local file = vim.api.nvim_buf_get_name(0)
    vim.cmd('edit #')  -- switch to alternate file, like <C-^>
    local other_file = vim.api.nvim_buf_get_name(0)
    if file == other_file then
        -- If switch to alternate file results in the same file name we create a new file to switch to
        vim.cmd('enew')
    end
    -- Now delete the original buffer
    vim.cmd('bdelete #')
end


function M.reload_config()
    local loadThese = {}
    for moduleName in pairs(package.loaded) do
        if moduleName:match("^namespace") then
            loadThese[moduleName] = package.loaded[moduleName]
            package.loaded[moduleName] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    print('Reload config, but need to press it twice ... '.. os.time())
end


function M.get_git_branch()
    -- :lua local parentDir = vim.fn.expand("%:p:h"); local command = "git -C " .. parentDir .. " branch --show-current 2>/dev/null"; local result = vim.fn.systemlist(command); vim.print(result)
    local parentDir = vim.fn.expand("%:p:h");
    local command
    if vim.fn.has('win32') == 1 then
        -- On Windows
        command = "git -C " .. parentDir .. " branch --show-current 2>NUL"
    else
        -- On Linux and other Unix-like systems
        command = "git -C " .. parentDir .. " branch --show-current 2>/dev/null"
    end
    local result = vim.fn.systemlist(command);
    local branch = #result > 0 and result[1] or "No Branch";
    return branch
end

local function split_dir_name_ext(path)
    local directory, name, ext = path:match("(.-)([^\\/]-%.?([^%.\\/]*))$")
    if directory and name and ext then
        return directory, name, ext
    else
        return path, "", "" -- Return the original path and empty strings if no match is found
    end
end
local function split_base_dir(path)
    local base, dir_name = path:match("(.+)[/\\]([^/\\]+)/[^/\\]+$")
    return base, dir_name
end
function M.gotoComponentFile(goto_type)
    local current_file = vim.fn.expand("%:p")
    local goto_file
    if string.find(string.lower(current_file), 'linkcube') then
        -- LINKCUBE
        local dir, name, ext = split_dir_name_ext(current_file)
        if goto_type == 'javascript' then
            goto_file = dir .. '/component.js'
        elseif goto_type == 'html' then
            goto_file = dir .. '/template.html'
        elseif goto_type == 'css' then
            goto_file = dir .. '/shadow.css'
        elseif goto_type == 'def' then
            goto_file = dir .. '/__init__.py'
        elseif goto_type == 'story' then
            goto_file = dir .. '/story.html'
        elseif goto_type == 'other' then
            goto_file = dir .. '/dom.css'
        end
    elseif string.find(string.lower(current_file), 'gateway') then
        -- GATEWAY
        local base, component_name = split_base_dir(current_file)
        local dir = base .. '/' .. component_name .. '/'
        if goto_type == 'javascript' then
            goto_file = dir .. component_name .. '.component.ts'
        elseif goto_type == 'html' then
            goto_file = dir .. component_name .. '.component.html'
        elseif goto_type == 'css' then
            local extensions = {".scss", ".css", ".less"}
            for _, ext in ipairs(extensions) do
                local f = dir .. component_name .. '.component' .. ext
                if vim.fn.filereadable(f) then
                    goto_file = f
                    break -- Exit the loop if a readable file is found
                end
            end
        elseif goto_type == 'def' then
            goto_file = dir .. component_name .. '.component.css'
        elseif goto_type == 'type' then
            goto_file = dir .. component_name .. '.types.ts'
        elseif goto_type == 'other' then
            goto_file = dir .. component_name .. '.sample.ts'
        elseif goto_type == 'sample' then
            goto_file = dir .. component_name .. '.sample.ts'
        elseif goto_type == 'story' then
            goto_file = dir .. component_name .. '.stories.ts'
        elseif goto_type == 'utils' then
            goto_file = dir .. component_name .. '.utils.ts'
        end
    else
        print('Unknown project')
        return
    end
    if not goto_file then
        print('Unknown goto type:', goto_type)
        return
    end
    if vim.fn.filereadable(goto_file) then
        print('open ->>> ', goto_file)
        vim.cmd("edit " .. goto_file)
    else
        print('File does not exist:', goto_file)
    end
end


-- Function to extract the path up to '/app/' and one more directory
local function get_app_dir(path)
    local _, start_index = string.find(path, "/app/")
    if start_index then
        local end_index = string.find(path, "/", start_index + 5)  -- Find the next '/' after '/app/'
        if end_index then
            return string.sub(path, 1, end_index)
        end
    end
end

function M.gotoLinkedFile(goto_type)
    local current_file = vim.fn.expand("%:p")
    local goto_file
    if string.find(string.lower(current_file), 'linkcube') then
        -- linkcube
        -- todo get the app path from which ever sub dir
        local dir = get_app_dir(current_file)
        if goto_type == 'models' then
            goto_file = dir .. '/models.py'
        elseif goto_type == 'views' then
            goto_file = dir .. '/views.py'
        elseif goto_type == 'rest' then
            goto_file = dir .. '/rest.py'
        elseif goto_type == 'urls' then
            goto_file = dir .. 'urls.py'
        elseif goto_type == 'serializers' then
            goto_file = dir .. '/serializers.py'
        elseif goto_type == 'tests' then
            goto_file = dir .. '/tests.py'
        elseif goto_type == 'other' then
            goto_file = dir .. '/utils.py'
        end
    else
        print('Unknown project')
        return
    end
    if not goto_file then
        print('Unknown goto type:', goto_type)
        return
    end
    if vim.fn.filereadable(goto_file) then
        print('open ->>> ', goto_file)
        vim.cmd("edit " .. goto_file)
    else
        print('File does not exist:', goto_file)
    end
end

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
