local utils = require('namespace.switcher.utils')

Switcher = {}

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

local django_app_switcher function(goto_type, file)
        -- LINKCUBE
        local dir = utils.get_file_path_info(file).dir
        if goto_type == "dint" then
            return dir .. "/dint.py"
        elseif goto_type == "models" then
            return dir .. "/models.py"
        elseif goto_type == "views" then
            return dir .. "/views.py"
        elseif goto_type == "rest" then
            return dir .. "/rest.py"
        elseif goto_type == "urls" then
            return dir .. "urls.py"
        elseif goto_type == "serializers" then
            return dir .. "/serializers.py"
        elseif goto_type == "tests" then
            return dir .. "/tests.py"
        elseif goto_type == "fetcher" then
            return dir .. "/assets/" .. app_name .. "/jsapp/fetcher.js"
        elseif goto_type == "other" then
            return dir .. "/utils.py"
        end
    end
local django_component_switcher function(goto_type, file)
       -- LINKCUBE Component
       local dir, name, ext = split_dir_name_ext(file)
       if goto_type == "javascript" then
           return dir .. "/component.js"
       elseif goto_type == "html" then
           return dir .. "/template.html"
       elseif goto_type == "css" then
           local goto_file = dir .. "/shadow.css"
           if vim.fn.filereadable(goto_file) ~= 1 then
               return dir .. "/main.css"
           end
       elseif goto_type == "def" then
           return dir .. "/__init__.py"
       elseif goto_type == "story" then
           return dir .. "/story.html"
       elseif goto_type == "other" then
           return dir .. "/dom.css"
       end
    end



Switcher.get_switch_fn = function(context, goto_type)
    if is_django_project() then
        if context == "app" then
            return django_app_switcher
        elseif context == "component" then
            return django_component_switcher
        end
    end
end

return Switcher
