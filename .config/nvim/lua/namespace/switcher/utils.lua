local M = {}

--[[
given: "some/path/to/file.ext    returns {path = "some/path/to", up_dir = "path", dir = "to", name = "file.ext", base_name = "file",  ext = "ext"}
given: "some/path/to/file"       returns {path = "some/path/to", up_dir = "path", dir = "to", name = "file",     base_name = "file",  ext = nil}
given: "some/path/to/.file"))    returns {path = "some/path/to", up_dir = "path", dir = "to", name = ".file",    base_name = ".file", ext = nil}
given: "to/file.ext"))           returns {path = "path/to",      up_dir = nil,    dir = "to", name = "file.ext", base_name = "file",  ext = nil}
given: "file.ext"))              returns {path = nil,            up_dir = nil,    dir = nil,  name = "file.ext", base_name = "file",  ext = "ext"}
given: ".file"))                 returns {path = nil,            up_dir = nil,    dir = nil,  name = ".file",    base_name = ".file", ext = nil}
--]]
function M.get_file_path_info(path)
    local info = {
        path = nil,
        up_dir = nil,
        dir = nil,
        name = nil,
        base_name = nil,
        ext = nil
    }
    info.name = path:match("([^/]+)$")
    info.path = path:match("(.+)/[^/]+$")
    if info.path then
        info.up_dir = info.path:match("([^/]+)/[^/]+$")
        info.dir = info.path:match("([^/]+)$")
    end
    if info.name then
        local base_name, ext = info.name:match("(.+)%.([^%.]+)$")
        if base_name then
            info.base_name = base_name
            info.ext = ext
        else
            info.base_name = info.name
        end
    end
    return info
end


--[[
given: "some/path/to/file.ext"      returns {"some", "path", "to", "file.ext"}
given: "some/path/to/dir"           returns {"some", "path", "to, ""dir"}
given: "some\\path\\to\\file.ext"   returns {"some", "path", "to", "file.ext"}
--]]
function M.split_path(path)
    local bits = {}
    for bit in path:gmatch("([^/\\]+)") do
        table.insert(bits, bit)
    end
    return bits
end

--[[
given: "some/path/to/file.ext", 1        returns "file.ext"
given: "some/path/to/file.ext", 2        returns "to"
given: "some\\path\\to\\file.ext", 2     returns "to"
given: "some/path/to/file.ext", 3        returns "path"
given: "some/path/to/file.ext", 99       returns nil
--]]
function M.get_last_nth_bit(path, n)
    local bits = M.split_path(path)
    if n <= #bits then
        return bits[#bits - n + 1]
    end
end


--[[
If cwd = "/home/$USER/.config/nvim":
given: "foo"                            returns false
given: "z/nvim"                         returns false
given: "nvim"                           returns true
given: "NVIM"                           returns true
given: "NVIM", case_sensitive: true     returns false
given: "/nvim/"                         returns false
given: "nvim/lua"                       returns "path"
given: ".config/nvim"                  returns true
given: ".config/nvim/"                 returns false
--]]
function M.get_cwd_includes(pattern, case_sensitive)
    local dir = vim.fn.getcwd()
    if not case_sensitive then
        dir = string.lower(dir)
        pattern = string.lower(pattern)
    end
    return string.find(dir, pattern) ~= nil
end

--[[
given: "some/path/app"      returns {"some", "/", "path", "/", "app"}
given: "/some/path/app"     returns {"/", "some", "/", "path", "/", "app"}
given: "some/path/app/"     returns {"some", "/", "path", "/", "app", "/"}
given: "/some/path/app/"    returns {"/", "some", "/", "path", "/", "app", "/"}
given: "C:\\\\some\\path\\app"    returns {"c:", "\\", "\\", "some", "\\", "path", "\\", "app"}
--]]
-- Function to split a path into its components, including delimiters
function M.split_path_with_delimiters(path)
    local bits = {}
    local pattern = "([/\\]*)([^/\\]*)"
    for delim, part in path:gmatch(pattern) do
        if delim ~= "" then
            table.insert(bits, delim)
        end
        if part ~= "" then
            table.insert(bits, part)
        end
    end
    return bits
end

--[[
given: "some/path/app/foo/bar",      returns {found = true,  before = "some/path",  after = "foo/bar"}
given: "/some/path/app/foo/bar",     returns {found = true,  before = "/some/path", after = "foo/bar"}
given: "some/path/app/foo/bar/",     returns {found = true,  before = "some/path",  after = "foo/bar/"}
given: "/some/path/app/foo/bar/",    returns {found = true,  before = "/some/path", after = "foo/bar/"}
given: "/some/path/app",             returns {found = true,  before = "/some/path", after = nil}
given: "app/foo/bar",                returns {found = true,  before = nil,          after = "foo/bar"}
given: "/some/path/app/foo/bar/",    returns {found = false, before = nil,          after = nil}
--]]
-- Function to find the first part in the path and return bits, index, before, and after
function M.find_in_path(path, part)
    local bits = M.split_path_with_delimiters(path)
    local before_parts = {}
    local after_parts = {}
    local found = false

    for _, bit in ipairs(bits) do
        if not found and bit == part then
            found = true
        elseif found then
            table.insert(after_parts, bit)
        else
            table.insert(before_parts, bit)
        end
    end
    if not found then
        return {found = false, before = nil, after = nil}
    end
    local before = table.concat(before_parts)
    local after = table.concat(after_parts)
    before = before:gsub("[/\\]+$", "") -- remove any trailing delimiters
    after = after:gsub("^[/\\]+", "") -- remove any leading delimiters
    return {found = found, before = before ~= "" and before or nil, after = after ~= "" and after or nil}-- make the nil props explicit
end

return M
