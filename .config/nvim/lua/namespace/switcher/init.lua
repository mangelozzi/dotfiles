--[[
Utilities for switching between various app and component files.
Currently Supported:
    - Django (Apps and components)
    - Angular (components)
]] --

local django = require("namespace.switcher.django")
local angular = require("namespace.switcher.angular")

local M = {}

local switchers = {django}

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

function M.switch(context, goto_type)
    local attempts = get_attempts()
    local original_file = vim.fn.expand("%:p")     -- current buf
    for _, switcher in ipairs(switchers) do
        local switch_fn = switcher.get_switch_fn(context, goto_type, original_file)
        if switch_fn then
            for _, file in ipairs(attempts) do
                if file ~= "" then
                    local goto_file = switch_fn(context, goto_type, file)
                print('goto_file: ', goto_file)
                    if goto_file and run_switch(goto_file) then return end
                end
            end
        end
    end
    print("Could not find suitable switch to file for "..goto_type)
end

return M
