local M = {}

local function infer_sep(path)
    if path:find("\\") then
        return "\\"
    end
    return "/"
end

local function blank_to_nil(str)
    if type(str) == "string" and str ~= "" then
        return str
    end
end

local function empty_to_nil(t)
    return #t == 0 and nil or t
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

-- Return the nth last extension in a filename, defualt to 2
function M.get_nth_last_ext(filename, n)
    n = n or 2
    local parts = {}
    for part in string.gmatch(filename, "[^.]+") do
        table.insert(parts, part)
    end
    if #parts >= n then
        return parts[#parts - n + 1]
    elseif #parts > 0 then
        return parts[1]
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
        after = blank_to_nil(after),
        after_bits = after_bits,
        after_w_pattern = blank_to_nil(after_w_pattern),
        after_w_pattern_bits = after_w_pattern_bits,
        before = blank_to_nil(before),
        before_bits = before_bits,
        before_w_pattern = blank_to_nil(before_w_pattern),
        before_w_pattern_bits = before_w_pattern_bits,
        bits = bits,
        found = true,
        sep = sep,
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
    local match = M.find_in_path(path, pattern, nth_match)
    if not match.found then
        return {found = false}
    end
    if offset == 0 then
        return {
            after_offset = match.after,
            after_offset_bits = match.after_bits,
            after_offset_w_pattern = match.after_w_pattern,
            after_offset_w_pattern_bits = match.after_w_pattern_bits,
            at = pattern,
            before_offset = match.before,
            before_offset_bits = match.before_bits,
            before_offset_w_pattern = match.before_w_pattern,
            before_offset_w_pattern_bits = match.before_w_pattern_bits,
            bits = match.bits,
            found = true,
            sep = match.sep,
        }
    end
    -- Check if the new position is within bounds
    local pos = #match.before_bits+ 1
    local new_pos = pos + offset
    if new_pos < 1 or new_pos > #match.bits then
        return { found = false }
    end

    local at = match.bits[new_pos]

    -- Create the new arrays
    local before_offset_bits = {}
    local before_offset_w_pattern_bits = {}
    local after_offset_bits = {}
    local after_offset_w_pattern_bits = { }

    -- Populate the new arrays
    for i = 1, #match.bits do
        local bit = match.bits[i]
        if i < new_pos then
            table.insert(before_offset_bits, bit)
        end
        if i <= new_pos then
            table.insert(before_offset_w_pattern_bits, bit)
        end
        if i > new_pos then
            table.insert(after_offset_bits, bit)
        end
        if i >= new_pos then
            table.insert(after_offset_w_pattern_bits, bit)
        end
    end

    return {
        after_offset = blank_to_nil(table.concat(after_offset_bits, match.sep)),
        after_offset_bits = after_offset_bits,
        after_offset_w_pattern = table.concat(after_offset_w_pattern_bits, match.sep),
        after_offset_w_pattern_bits = after_offset_w_pattern_bits,
        at = match.bits[new_pos],
        before_offset = blank_to_nil(table.concat(before_offset_bits, match.sep)),
        before_offset_bits = before_offset_bits,
        before_offset_w_pattern = table.concat(before_offset_w_pattern_bits, match.sep),
        before_offset_w_pattern_bits = before_offset_w_pattern_bits,
        bits = match.bits,
        found = true,
        sep = match.sep,
    }
end

return M

