local M = {}

--[[
given: "some/path/to/file.ext    returns {path="some/path/to", up_dir="path", dir="to", name="file.ext", base_name="file",  ext="ext"}
given: "some/path/to/file"       returns {path="some/path/to", up_dir="path", dir="to", name="file",     base_name="file",  ext=nil}
given: "some/path/to/.file"))    returns {path="some/path/to", up_dir="path", dir="to", name=".file",    base_name=".file", ext=nil}
given: "to/file.ext"))           returns {path="path/to",      up_dir=nil,    dir="to", name="file.ext", base_name="file",  ext=nil}
given: "file.ext"))              returns {path=nil,            up_dir=nil,    dir=nil,  name="file.ext", base_name="file",  ext="ext"}
given: ".file"))                 returns {path=nil,            up_dir=nil,    dir=nil,  name=".file",    base_name=".file", ext=nil}
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
given: "some/path/to/file.ext", 1        returns "some"
given: "some/path/to/file.ext", 2        returns "path"
given: "some\\path\\to\\file.ext", 2     returns "path"
given: "some/path/to/file.ext", 3        returns "to"
given: "some/path/to/file.ext", 99       returns nil
--]]
function M.get_nth_bit(path, n)
    local bits = M.split_path(path)
    if n <= #bits then
        return bits[n]
    end
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
If cwd="/home/$USER/.config/nvim":
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
-- Most used internally, just exported for testing
-- function M._split_path_with_delimiters(path)
--     local bits={}
--     local pattern="([/\\]*)([^/\\]*)"
--     for delim, part in path:gmatch(pattern) do
--         if delim ~= "" then
--             table.insert(bits, delim)
--         end
--         if part ~= "" then
--             table.insert(bits, part)
--         end
--     end
--     return bits
-- end

--[[
given: "some/path/app/foo/bar",   "app"   returns {found=true,  before="some/path",  bafter_w_pattern="some/path/app",  after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "some/path/app/foo/bar",   "/app"  returns {found=true,  before="some/path",  bafter_w_pattern="some/path/app",  after="foo/bar"  after_w_pattern="/app/foo/bar" }
given: "some/path/app/foo/bar",   "app/"  returns {found=true,  before="some/path",  bafter_w_pattern="some/path/app/", after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "some/path/app/foo/bar",   "/app/" returns {found=true,  before="some/path",  bafter_w_pattern="some/path/app/", after="foo/bar"  after_w_pattern="/app/foo/bar" }
given: "/some/path/app/foo/bar",  "app"   returns {found=true,  before="/some/path", before_w_pattern="/some/path/app", after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "some/path/app/foo/bar/",  "app"   returns {found=true,  before="some/path",  before_w_pattern="some/path/app",  after="foo/bar/" after_w_pattern="app/foo/bar/" }
given: "/some/path/app/foo/bar/", "app"   returns {found=true,  before="/some/path", before_w_pattern="/some/path/app", after="foo/bar/" after_w_pattern="app/foo/bar/" }
given: "/some/path/app",          "app"   returns {found=true,  before="/some/path", before_w_pattern="/some/path/app", after=nil        after_w_pattern=nil            }
given: "app/foo/bar",             "app"   returns {found=true,  before=nil,          before_w_pattern=nil,              after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "/some/path/app/foo/bar/", "zzz"   returns {found=false, before=nil,          before_w_pattern=nil,              after=nil        after_w_pattern=nil            }
--]]
-- Function to find the first pattern in the path and return the detailed breakdown
function M.find_in_path(path, pattern)
    -- Escape special characters in pattern
    local escaped_pattern = pattern:gsub("([%.%+%-%*%?%[%^%$%(%)%%])", "%%%1")

    -- Find the pattern in the path
    local start_pos, end_pos = path:find(escaped_pattern)

    -- Initialize result table
    local result = {
        found = false,
        before = nil,
        before_w_pattern = nil,
        after = nil,
        after_w_pattern = nil
    }
    if not start_pos then
        return result
    end

    -- Pattern found
    result.found = true
    -- Extract before and after parts
    local before = path:sub(1, start_pos - 1)
    local after = path:sub(end_pos + 1)
    local before_w_pattern = path:sub(1, end_pos)
    local after_w_pattern = path:sub(start_pos)
    -- Remove trailing delimiters from before
    before = before:gsub("[/\\]+$", "")
    -- Remove leading delimiters from after
    after = after:gsub("^[/\\]+", "")
    -- Assign values to result table
    result.before = before ~= "" and before or nil
    result.before_w_pattern = before_w_pattern
    result.after = after ~= "" and after or nil
    result.after_w_pattern = after_w_pattern
    return result
end

local function get_path_delimiter(path)
    if path:find("\\") then
        return "\\"
    end
    return "/"
end

--[[
given: "some/path/app/foo/bar", "app", -4   returns {found=false }
given: "some/path/app/foo/bar", "app", -3   returns {found=false }
given: "some/path/app/foo/bar", "app", -2   returns {found=true, before_offset=nil, at="some', after_offset="path/app/foo/bar"}
given: "some/path/app/foo/bar", "app", -1   returns {found=true, before_offset="some",  at="path',  after_offset="app/foo/bar"}
given: "some/path/app/foo/bar", "app",  0   returns {found=true, before_offset="some/path",  at="app",  after_offset="foo/bar"}
given: "some/path/app/foo/bar", "app",  1   returns {found=true, before_offset="some/path/app",  at="foo",  after_offset="bar"}
given: "some/path/app/foo/bar", "app",  2   returns {found=true, before_offset="some/path/app/foo", at="bar", after_offset=nil}
given: "some/path/app/foo/bar", "app",  3   returns {found=false }
given: "some/path/app/foo/bar", "app",  4   returns {found=false }
--]]
local function blank_to_nil(str)
    if str == "" then
        return nil
    end
    return str
end

local function concat_strings(array, delimiter)
    local result = {}
    for _, value in ipairs(array) do
        if value  and value ~= "" then
            table.insert(result, value)
        end
    end
    return table.concat(result, delimiter)
end

function M.offset_path(path, pattern, offset)
    print(path.." "..offset)
    local info = M.find_in_path(path, pattern)
    if not info.found then
        return {found = false}
    end
    local delimiter = get_path_delimiter(path)
    local at = pattern
    if offset == 0 then
        return {found = true, before_offset = info.before, at = pattern, after_offset = info.after}
    elseif offset > 0 then
        local after_bits = M.split_path(info.after)
        if offset > #after_bits then
            return {found = false}
        end
        at = after_bits[offset]
        local before_offset_str = info.before_w_pattern .. delimiter .. table.concat(after_bits, delimiter, 1, offset - 1)
        local after_str = table.concat(after_bits, delimiter, offset + 1)
        return {found = true, before_offset = blank_to_nil(before_offset_str:gsub(delimiter .. "$", "")), at = at, after_offset = blank_to_nil(after_str)}
    elseif offset < 0 then
        local before_bits = M.split_path(info.before)
        if -offset > #before_bits then
            return {found = false}
        end
        at = before_bits[#before_bits + offset + 1]
        local before_str = table.concat(before_bits, delimiter, 1, #before_bits + offset)

        -- If offset = -1, pop off 0
        -- If offset = -2, pop off 1
        -- If offset = -3, pop off 2
        local iterations = -offset - 1
        local from_before_bits = {}
        for _ = 1, iterations do
            table.insert(from_before_bits, 1, table.remove(before_bits))
        end
        local from_before_str = table.concat(from_before_bits, delimiter);
        local after_offset_str = concat_strings({from_before_str, info.after_w_pattern}, delimiter)
        return {found = true, before_offset = blank_to_nil(before_str), at = at, after_offset = blank_to_nil(after_offset_str)}
    end
    return {found = false}
end

function M.get_second_to_last_extension(path)
    local extensions = {}
    for ext in string.gmatch(path, "%.[^%.\\/]+") do
        table.insert(extensions, ext:sub(2)) -- exclude the last dot
    end
    if #extensions >= 2 then
        return extensions[#extensions - 1]
    end
end

return M

