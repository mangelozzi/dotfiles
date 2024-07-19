local M = {}

local function infer_sep(path)
    if path:find("\\") then
        return "\\"
    end
    return "/"
end

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

function M.get_second_to_last_extension(path)
    local extensions = {}
    for ext in string.gmatch(path, "%.[^%.\\/]+") do
        table.insert(extensions, ext:sub(2)) -- exclude the last dot
    end
    if #extensions >= 2 then
        return extensions[#extensions - 1]
    end
end


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
given: "/some/path/to/dir", true    returns {"/some", "path", "to, ""dir"}
given: "//some/path/to/dir", true   returns {"//some", "path", "to, ""dir"}
given: "some\\path\\to\\file.ext"   returns {"some", "path", "to", "file.ext"}
--]]
function M.split_path(path, keep_leading_sep)
    local bits = {}
    local leading_delim = keep_leading_sep and path:match("^([/\\]+)") or ""
    for bit in path:gmatch("([^/\\]+)") do
        table.insert(bits, bit)
    end
    bits[1] = table.concat({leading_delim, bits[1]}, "")
    return bits
end

--[[
given: "some/path/to/file.ext", 1        returns "some"
given: "some/path/to/file.ext", 2        returns "path"
given: "some\\path\\to\\file.ext", 2     returns "path"
given: "some/path/to/file.ext", 3        returns "to"
given: "some/path/to/file.ext", 99       returns nil
--]]
function M.get_nth_bit(path, n, keep_leading_sep)
    local bits = M.split_path(path, keep_leading_sep)
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
function M.get_last_nth_bit(path, n, keep_leading_sep)
    local bits = M.split_path(path, keep_leading_sep)
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
given: "some/path/app/foo/bar",   "app"   returns {found=true,  before="some/path",  bafter_w_pattern="some/path/app",  after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "/some/path/app/foo/bar",  "app"   returns {found=true,  before="/some/path", before_w_pattern="/some/path/app", after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "//some/path/app/foo/bar", "app"   returns {found=true,  before="//some/path",before_w_pattern="//some/path/app",after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "some/path/app/foo/bar/",  "app"   returns {found=true,  before="some/path",  before_w_pattern="some/path/app",  after="foo/bar/" after_w_pattern="app/foo/bar/" }
given: "/some/path/app/foo/bar/", "app"   returns {found=true,  before="/some/path", before_w_pattern="/some/path/app", after="foo/bar/" after_w_pattern="app/foo/bar/" }
given: "/some/path/app",          "app"   returns {found=true,  before="/some/path", before_w_pattern="/some/path/app", after=nil        after_w_pattern=nil            }
given: "app/foo/bar",             "app"   returns {found=true,  before=nil,          before_w_pattern=nil,              after="foo/bar"  after_w_pattern="app/foo/bar"  }
given: "app/foo/bar",             "ap"    returns {found=false} -- Must match exactly, not be a sub part
given: "app/foo/bar",             "/app/" returns {found=false} -- Must not specify delimiters
given: "/some/path/app/foo/bar/", "zzz"   returns {found=false, before=nil,          before_w_pattern=nil,              after=nil        after_w_pattern=nil            }
--]]
-- Function to find the first pattern in the path and return the detailed breakdown
function M.find_in_path(path, pattern, nth_match)
    -- Escape special characters in pattern
    local sep = infer_sep(path)
    local bits = M.split_path(path, true)

    -- Find all matches
    local matches = {}
    for i, bit in ipairs(bits) do
        if bit == pattern then
            table.insert(matches, i)
        end
    end

    -- Determine the nth match to use
    local total_matches = #matches
    if total_matches == 0 then
        return { found = false }
    end

    nth_match = nth_match or 1
    local match_index = nth_match > 0 and nth_match or total_matches + nth_match + 1
    if match_index < 1 or match_index > total_matches then
        return { found = false }
    end

    local match_pos = matches[match_index]

    -- Extract before and after parts
    local before_bits = {unpack(bits, 1, match_pos - 1)}
    local after_bits = {unpack(bits, match_pos + 1)}
    local before_w_pattern_bits = {unpack(bits, 1, match_pos)}
    local after_w_pattern_bits = {unpack(bits, match_pos)}

    -- Handle leading delimiters
    local before = table.concat(before_bits, sep):gsub(sep .. "$", "")
    local after = table.concat(after_bits, sep):gsub("^" .. sep, "")
    local before_w_pattern = table.concat(before_w_pattern_bits, sep)
    local after_w_pattern = table.concat(after_w_pattern_bits, sep)

    return {
        found = true,
        before = blank_to_nil(before),
        before_w_pattern = blank_to_nil(before_w_pattern),
        after = blank_to_nil(after),
        after_w_pattern = blank_to_nil(after_w_pattern)
    }
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

function M.offset_path(path, pattern, offset, nth_match)
    print(path.." "..offset)
    local info = M.find_in_path(path, pattern)
    if not info.found then
        return {found = false}
    end
    local sep = infer_sep(path)
    local at = pattern
    if offset == 0 then
        return {found = true, before_offset = info.before, at = pattern, after_offset = info.after}
    elseif offset > 0 then
        local after_bits = M.split_path(info.after)
        if offset > #after_bits then
            return {found = false}
        end
        at = after_bits[offset]
        local before_offset_str = info.before_w_pattern .. sep .. table.concat(after_bits, sep, 1, offset - 1)
        local after_str = table.concat(after_bits, sep, offset + 1)
        return {found = true, before_offset = blank_to_nil(before_offset_str:gsub(sep .. "$", "")), at = at, after_offset = blank_to_nil(after_str)}
    elseif offset < 0 then
        local before_bits = M.split_path(info.before)
        if -offset > #before_bits then
            return {found = false}
        end
        at = before_bits[#before_bits + offset + 1]
        local before_str = table.concat(before_bits, sep, 1, #before_bits + offset)

        -- If offset = -1, pop off 0
        -- If offset = -2, pop off 1
        -- If offset = -3, pop off 2
        local iterations = -offset - 1
        local from_before_bits = {}
        for _ = 1, iterations do
            table.insert(from_before_bits, 1, table.remove(before_bits))
        end
        local from_before_str = table.concat(from_before_bits, sep);
        local after_offset_str = concat_strings({from_before_str, info.after_w_pattern}, sep)
        return {found = true, before_offset = blank_to_nil(before_str), at = at, after_offset = blank_to_nil(after_offset_str)}
    end
    return {found = false}
end

return M

