local utils = require("namespace.switcher.utils")

local Switcher = {}

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

local function django_app_switcher(context, goto_type, file)
    -- LINKCUBE
    -- get one dir to the right of `app` or `pack` dir
    -- local app_name = utils.offset_path(file, "app", 1).at
    local app_dir =
        utils.offset_path(file, "app", 1).before_offset_w_pattern or
        utils.offset_path(file, "pack", 1).before_offset_w_pattern
    local app_name = utils.get_file_path_info(app_dir).name
    if goto_type == "admin" then
        return app_dir .. "/admin.py"
    elseif goto_type == "dint" then
        return app_dir .. "/dint.py"
    elseif goto_type == "models" then
        return app_dir .. "/models.py"
    elseif goto_type == "views" then
        return app_dir .. "/views.py"
    elseif goto_type == "rest" then
        return app_dir .. "/rest.py"
    elseif goto_type == "urls" then
        return app_dir .. "/urls.py"
    elseif goto_type == "serializers" then
        return app_dir .. "/serializers.py"
    elseif goto_type == "tests" then
        return app_dir .. "/tests.py"
    elseif goto_type == "fetcher" then
        return app_dir .. "/assets/" .. app_name .. "/jsapp/fetcher.js"
    elseif goto_type == "other" then
        return app_dir .. "/assets/" .. app_name .. "/jsapp/former.js"
    elseif goto_type == "utils" then
        return app_dir .. "/utils.py"
    elseif goto_type == "index" then
        return app_dir .. "/templates/"..app_name.."/index.html"
    end
end

local function django_component_switcher(context, goto_type, file)
    -- LINKCUBE Component
    local path = utils.get_file_path_info(file).path
    if goto_type == "javascript" then
        return path .. "/component.js"
    elseif goto_type == "html" then
        return path .. "/template.html"
    elseif goto_type == "css" then
        for _, name in ipairs {"/shadow.css", "/main.css"} do
            local goto_file = path .. name
            if vim.fn.filereadable(goto_file) == 1 then
                return goto_file
            end
        end
    elseif goto_type == "def" then
        return path .. "/__init__.py"
    elseif goto_type == "story" then
        return path .. "/story.html"
    elseif goto_type == "other" then
        return path .. "/dom.css"
    end
end

-- File the user is on when calling the switcher
Switcher.get_switch_fn = function(context, goto_type, original_file)
    if is_django_project() then
        if context == "app" then
            return django_app_switcher
        elseif context == "component" then
            return django_component_switcher
        end
    end
end

return Switcher
