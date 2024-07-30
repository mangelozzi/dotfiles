local utils = require("namespace.switcher.utils")

local Switcher = {}

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

local function angular_component_switcher(context, goto_type, file)
    -- Angular Component
    -- GATEWAY
    local info = utils.get_file_path_info(file)
    local component_name = utils.get_nth_last_ext(info.name, 3) or "?" -- e.g. given "../app.component.ts" return "app"
    local component_type = utils.get_nth_last_ext(info.name, 2) or "?" -- e.g. given "app.component.ts" return "component"
    local dir = info.path .. "/" .. component_name .. "/"
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
end

Switcher.get_switch_fn = function(context, goto_type, original_file)
    if is_angular_project() then
        return angular_component_switcher
    end
end

return Switcher
