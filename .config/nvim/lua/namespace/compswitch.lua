--[[
Utilities for switching between various component files.
Currently Supported:
    - Django
    - Angular
]]--

local M = {}

-- Function to check if the current directory contains Angular files
local function isAngularProject()
    local dir = vim.fn.getcwd()

    -- Make common fast
    if string.find(string.lower(dir), 'gateway') then return true end

    while dir ~= '/' do
        if vim.fn.filereadable(dir..'/angular.json') == 1 or vim.fn.filereadable(dir..'/package.json') == 1 then
            return true
        end
        dir = vim.fn.fnamemodify(dir, ':h')
    end
    return false
end

-- Function to check if the current directory contains Django files
local function isDjangoProject()
    local dir = vim.fn.getcwd()

    -- Make common fast
    if string.find(string.lower(dir), 'linkcube') then return true end

    while dir ~= '/' do
        if vim.fn.filereadable(dir..'/manage.py') == 1 or vim.fn.filereadable(dir..'/settings.py') == 1 then
            return true
        end
        dir = vim.fn.fnamemodify(dir, ':h')
    end
    return false
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


function M.gotoComponentFile(gotoType)
    local currentFile = vim.fn.expand("%:p")
    local gotoFile
    if isDjangoProject() then
        -- LINKCUBE
        local dir, name, ext = split_dir_name_ext(currentFile)
        if gotoType == 'javascript' then
            gotoFile = dir .. '/component.js'
        elseif gotoType == 'html' then
            gotoFile = dir .. '/template.html'
        elseif gotoType == 'css' then
            gotoFile = dir .. '/shadow.css'
        elseif gotoType == 'def' then
            gotoFile = dir .. '/__init__.py'
        elseif gotoType == 'story' then
            gotoFile = dir .. '/story.html'
        elseif gotoType == 'other' then
            gotoFile = dir .. '/dom.css'
        end
    elseif isAngularProject() then
        -- GATEWAY
        local base, component_name = split_base_dir(currentFile)
        local dir = base .. '/' .. component_name .. '/'
        if gotoType == 'javascript' then
            gotoFile = dir .. component_name .. '.component.ts'
        elseif gotoType == 'html' then
            gotoFile = dir .. component_name .. '.component.html'
        elseif gotoType == 'css' then
            local extensions = {".scss", ".css", ".less"}
            for _, ext in ipairs(extensions) do
                local f = dir .. component_name .. '.component' .. ext
                if vim.fn.filereadable(f) then
                    gotoFile = f
                    break -- Exit the loop if a readable file is found
                end
            end
        elseif gotoType == 'def' then
            gotoFile = dir .. component_name .. '.component.css'
        elseif gotoType == 'type' then
            gotoFile = dir .. component_name .. '.types.ts'
        elseif gotoType == 'other' then
            gotoFile = dir .. component_name .. '.sample.ts'
        elseif gotoType == 'sample' then
            gotoFile = dir .. component_name .. '.sample.ts'
        elseif gotoType == 'story' then
            gotoFile = dir .. component_name .. '.stories.ts'
        elseif gotoType == 'utils' then
            gotoFile = dir .. component_name .. '.utils.ts'
        end
    else
        print('Unknown project')
        return
    end
    if not gotoFile then
        print('Unknown goto type:', gotoType)
        return
    end
    if vim.fn.filereadable(gotoFile) then
        print('open ->>> ', gotoFile)
        vim.cmd("edit " .. gotoFile)
    else
        print('File does not exist:', gotoFile)
    end
end

function M.gotoLinkedFile(gotoType)
    local currentFile = vim.fn.expand("%:p")
    local gotoFile
    if isDjangoProject() then
        -- LINKCUBE
        -- TODO GET THE APP PATH from which ever sub dir
        local dir, name, ext = split_dir_name_ext(currentFile)
        if gotoType == 'models' then
            gotoFile = dir .. '/models.py'
        elseif gotoType == 'views' then
            gotoFile = dir .. '/views.py'
        elseif gotoType == 'rest' then
            gotoFile = dir .. '/rest.py'
        elseif gotoType == 'urls' then
            gotoFile = dir .. 'urls.py'
        elseif gotoType == 'serializers' then
            gotoFile = dir .. '/serializers.py'
        elseif gotoType == 'tests' then
            gotoFile = dir .. '/tests.py'
        elseif gotoType == 'other' then
            gotoFile = dir .. '/utils.py'
        end
    else
        print('Unknown project')
        return
    end
    if not gotoFile then
        print('Unknown goto type:', gotoType)
        return
    end
    if vim.fn.filereadable(gotoFile) then
        print('open ->>> ', gotoFile)
        vim.cmd("edit " .. gotoFile)
    else
        print('File does not exist:', gotoFile)
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
