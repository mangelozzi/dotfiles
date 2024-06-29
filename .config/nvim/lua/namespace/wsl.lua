local M = {}

function M.escape_spaces(path)
    -- Make the function idempotent
    local unescaped_path = path:gsub("\\ ", " ") -- Replace '\ ' with ' '
    local escaped_path = unescaped_path:gsub(" ", "\\ ") -- Escape all spaces
    return escaped_path
end

function M.get_is_wsl()
    local proc_version_file = io.open("/proc/version", "r")
    if proc_version_file then
        local proc_version = proc_version_file:read("*all")
        proc_version_file:close()

        if proc_version:lower():find("microsoft") then
            -- The string "microsoft" typically indicates WSL
            return true
        else
            return false
        end
    else
        -- Unable to open /proc/version, assuming not WSL
        return false
    end
end

function M.linux_to_win_path(path)
    local clean_path = M.escape_spaces(path)
    local handle = io.popen("wslpath -w " .. clean_path)
    if not handle then
        return ''
    end
    local win_path = handle:read("*a")
    local escaped_win_path = win_path:gsub('\\', '\\\\')
    return escaped_win_path
end

return M
