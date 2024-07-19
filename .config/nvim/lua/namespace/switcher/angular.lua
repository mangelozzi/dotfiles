local utils = require('namespace.switcher.utils')

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
