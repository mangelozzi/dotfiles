
--[[
Utilities for switching between various app and component files.
Currently Supported:
    - Django (Apps and components)
    - Angular (components)
]] --

local M = {}


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

local function run_switch(goto_file)
    -- If already open
    local bufnr = vim.fn.bufnr(goto_file, true)
    if bufnr ~= -1 and vim.fn.buflisted(bufnr) == 1 then
        if vim.api.nvim_get_current_buf() == bufnr then
            print("already on buffer ->>> ", goto_file)
        else
            print("switch ->>> ", goto_file)
            vim.cmd("buffer " .. bufnr)
        end
        return true
    end
    -- If readable
    if vim.fn.filereadable(goto_file) == 1 then
        -- Otherwise, open the file
        print("open ->>> ", goto_file)
        vim.cmd("edit " .. goto_file)
        return true
    end
    return false
end

local function get_attempts()
    return {
        vim.fn.expand("%:p"),     -- current buf
        vim.fn.expand("%:p:h"),   -- current buf up 1
        vim.fn.expand("%:p:h:h"), -- current buf up 2
        vim.fn.expand("#:p"),     -- alt buf
        vim.fn.expand("#:p:h"),   -- alt buf up 1
        vim.fn.expand("#:p:h:h"), -- alt buf up 2
    }
end

local switcher_fns = {
    component_angular = function(goto_type, file)
       -- Angular Component
        -- GATEWAY
        local base, component_name = split_base_dir(file)
        local component_type = get_second_to_last_extension(file) or "component"
        local dir = base .. "/" .. component_name .. "/"
        if goto_type == "javascript" then
            return guess_angular_file_name(dir, component_name, nil, "ts")
        elseif goto_type == "html" then
            return guess_angular_file_name(dir, component_name, nil, "html")
        elseif goto_type == "css" then
            local extensions = {"scss", "css", "less"}
            for _, ext in ipairs(extensions) do
                local goto_file = guess_angular_file_name(dir, component_name, nil, ext)
                if vim.fn.filereadable(goto_file) == 1 then
                    return goto_file
                end
            end
        elseif goto_type == "def" then
            return guess_angular_file_name(dir, component_name, component_type, "css")
        elseif goto_type == "type" then
            return guess_angular_file_name(dir, component_name, "types", "ts")
        elseif goto_type == "other" then
            return guess_angular_file_name(dir, component_name, "sample", "ts")
        elseif goto_type == "sample" then
            return guess_angular_file_name(dir, component_name, "sample", "ts")
        elseif goto_type == "story" then
            return guess_angular_file_name(dir, component_name, "stories", "ts")
        elseif goto_type == "utils" then
            return guess_angular_file_name(dir, component_name, "utils", "ts")
        end
    end,
}

local function get_switcher_fn(context)
    if is_django_project() then
        if context == "app" then
            return switcher_fns.app_django
        elseif context == "component" then
            return switcher_fns.component_django
        end
    elseif is_angular_project() then
        if context == "component" then
            return switcher_fns.component_angular
        end
    end
end

function M.switch(context, goto_type)
    local attempts = get_attempts()
    local switcher_fn = get_switcher_fn(context)
    for _, file in ipairs(attempts) do
        if switcher_fn(goto_type, file) then return end
    end
    print("Could not find suitable switch to file for "..goto_type)
end

return M
