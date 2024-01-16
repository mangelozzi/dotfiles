--[[
Utilities for switching between various app and component files.
Currently Supported:
    - Django (Apps and components)
    - Angular (components)
]] --

local M = {}

-- Function to check if the current directory contains Angular files
local function is_angular_project()
    local dir = vim.fn.getcwd()

    -- Make common fast
    if string.find(string.lower(dir), "gateway") then
        return true
    end

    while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/angular.json") == 1 or vim.fn.filereadable(dir .. "/package.json") == 1 then
            return true
        end
        dir = vim.fn.fnamemodify(dir, ":h")
    end
    return false
end

-- Function to check if the current directory contains Django files
local function is_django_project()
    local dir = vim.fn.getcwd()

    -- Make common fast
    if string.find(string.lower(dir), "linkcube") then
        return true
    end

    while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/manage.py") == 1 or vim.fn.filereadable(dir .. "/settings.py") == 1 then
            return true
        end
        dir = vim.fn.fnamemodify(dir, ":h")
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

-- Function to extract the path up to '/app/' and one more directory
local function get_app_dir_and_name(path)
    local _, start_index = string.find(path, "/app/")
    if start_index then
        local end_index = string.find(path, "/", start_index + 5) -- Find the next '/' after '/app/'
        if end_index then
            local app_dir = string.sub(path, 1, end_index)
            local app_dir_name = string.match(app_dir, "/([^/]+)/?$")
            return app_dir, app_dir_name
        end
    end
end

local function get_second_to_last_extension(path)
    local extensions = {}
    for ext in string.gmatch(path, "%.[^%.\\/]+") do
        table.insert(extensions, ext:sub(2)) -- exclude the last dot
    end
    if #extensions >= 2 then
        return extensions[#extensions - 1]
    end
end

local function guess_angular_file_name(dir, component_name, component_type, ext)
    local type_guesses = {"component", "dialog", "directive", ""}
    if component_type then
        -- If given the guess try it first
        table.insert(type_guesses, 1, component_type)
    end
    for _, try_type in ipairs(type_guesses) do
        local guess = dir .. component_name
        if #try_type > 1 then
            guess = guess .. "." .. try_type
        end
        guess = guess .. "." .. ext
        if vim.fn.filereadable(guess) == 1 then
            return guess
        end
    end
end

function M.goto_component_file(goto_type)
    local current_file = vim.fn.expand("%:p")
    local goto_file
    if is_django_project() then
        -- LINKCUBE
        local dir, name, ext = split_dir_name_ext(current_file)
        if goto_type == "javascript" then
            goto_file = dir .. "/component.js"
        elseif goto_type == "html" then
            goto_file = dir .. "/template.html"
        elseif goto_type == "css" then
            goto_file = dir .. "/shadow.css"
        elseif goto_type == "def" then
            goto_file = dir .. "/__init__.py"
        elseif goto_type == "story" then
            goto_file = dir .. "/story.html"
        elseif goto_type == "other" then
            goto_file = dir .. "/dom.css"
        end
    elseif is_angular_project() then
        -- GATEWAY
        local base, component_name = split_base_dir(current_file)
        local component_type = get_second_to_last_extension(current_file) or "component"
        local dir = base .. "/" .. component_name .. "/"
        if goto_type == "javascript" then
            goto_file = guess_angular_file_name(dir, component_name, nil, "ts")
        elseif goto_type == "html" then
            goto_file = guess_angular_file_name(dir, component_name, nil, "html")
        elseif goto_type == "css" then
            local extensions = {"scss", "css", "less"}
            for _, ext in ipairs(extensions) do
                local f = guess_angular_file_name(dir, component_name, nil, ext)
                if vim.fn.filereadable(f) == 1 then
                    goto_file = f
                    break -- Exit the loop if a readable file is found
                end
            end
        elseif goto_type == "def" then
            goto_file = guess_angular_file_name(dir, component_name, component_type, "css")
        elseif goto_type == "type" then
            goto_file = guess_angular_file_name(dir, component_name, "types", "ts")
        elseif goto_type == "other" then
            goto_file = guess_angular_file_name(dir, component_name, "sample", "ts")
        elseif goto_type == "sample" then
            goto_file = guess_angular_file_name(dir, component_name, "sample", "ts")
        elseif goto_type == "story" then
            goto_file = guess_angular_file_name(dir, component_name, "stories", "ts")
        elseif goto_type == "utils" then
            goto_file = guess_angular_file_name(dir, component_name, "utils", "ts")
        end
    else
        print("Unknown project")
        return
    end
    if not goto_file then
        print("Unknown goto type:", goto_type)
        return
    end
    if vim.fn.filereadable(goto_file) == 1 then
        print("open ->>> ", goto_file)
        vim.cmd("edit " .. goto_file)
    else
        print("File does not exist:", goto_file)
    end
end

function M.goto_app_file(goto_type)
    local current_file = vim.fn.expand("%:p")
    local goto_file
    if is_django_project() then
        -- LINKCUBE
        -- TODO GET THE APP PATH from which ever sub dir
        local dir, app_name = get_app_dir_and_name(current_file)
        if goto_type == "dint" then
            goto_file = dir .. "/dint.py"
        elseif goto_type == "models" then
            goto_file = dir .. "/models.py"
        elseif goto_type == "views" then
            goto_file = dir .. "/views.py"
        elseif goto_type == "rest" then
            goto_file = dir .. "/rest.py"
        elseif goto_type == "urls" then
            goto_file = dir .. "urls.py"
        elseif goto_type == "serializers" then
            goto_file = dir .. "/serializers.py"
        elseif goto_type == "tests" then
            goto_file = dir .. "/tests.py"
        elseif goto_type == "fetcher" then
            goto_file = dir .. "/assets/" .. app_name .. "/jsapp/fetcher.js"
        elseif goto_type == "other" then
            goto_file = dir .. "/utils.py"
        end
    else
        print("Unknown project")
        return
    end
    if not goto_file then
        print("Unknown goto type:", goto_type)
        return
    end
    if vim.fn.filereadable(goto_file) == 1 then
        print("open ->>> ", goto_file)
        vim.cmd("edit " .. goto_file)
    else
        print("File does not exist:", goto_file)
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
