local utils = require('namespace.switcher.utils')

local function test_get_file_path_info(file_path)
    print('---')
    print('file_path: '.. file_path)
    vim.print(utils.get_file_path_info(file_path))
end

print('TESTS - get_file_path_info')
test_get_file_path_info("some/path/to/file.ext")
test_get_file_path_info("some/path/to/file")
test_get_file_path_info("some/path/to/.file")
test_get_file_path_info("to/file.ext")
test_get_file_path_info("file.ext")
test_get_file_path_info(".file")

--------------------------------------------------------------------------------

local function test_split_file(file_path)
    print('---')
    print('file_path: '.. file_path)
    vim.print(utils.split_path(file_path))
end

-- Test cases
print('TESTS - split_path')
test_split_file("some/path/to/file.ext")
test_split_file("some/path/to/file")
test_split_file("some\\path\\to\\file.ext")

--------------------------------------------------------------------------------

local function test_get_last_nth_bit(file_path, n)
    print('---')
    print('file_path: '.. file_path)
    print('n: '.. n)
    print(utils.get_last_nth_bit(file_path, n))
end

print('TESTS - get_last_nth_bit')
test_get_last_nth_bit("some/path/to/file.ext", 1)
test_get_last_nth_bit("some/path/to/file.ext", 2)
test_get_last_nth_bit("some\\path\\to\\file.ext", 2)
test_get_last_nth_bit("some/path/to/file.ext", 3)
test_get_last_nth_bit("some/path/to/file.ext", 99)

--------------------------------------------------------------------------------

print('TESTS - get_cwd_includes - CWD: ' .. vim.fn.getcwd())
local function test_get_cwd_includes(pattern, case_sensitive)
    print('---')
    local result = utils.get_cwd_includes(pattern, case_sensitive)
    print('pattern: '.. pattern .. ' case_sensitive: '.. tostring(case_sensitive) .. ' result: '.. tostring(result))
end

test_get_cwd_includes("foo")
test_get_cwd_includes("z/nvim")
test_get_cwd_includes("nvim")
test_get_cwd_includes("NVIM")
test_get_cwd_includes("NVIM", true)
test_get_cwd_includes("/nvim/")
test_get_cwd_includes(".config/nvim")
test_get_cwd_includes("/.config/nvim")


--------------------------------------------------------------------------------

print('TESTS - find_path')
local function test_find_in_path(path, part)
    print('---')
    print('path: '.. path .. ' part: '.. tostring(part))
    vim.print(utils.find_in_path(path, part))
end

test_find_in_path("some/path/app/foo/bar", "app")
test_find_in_path("/some/path/app/foo/bar", "app")
test_find_in_path("some/path/app/foo/bar/", "app")
test_find_in_path("/some/path/app/foo/bar/", "app")
test_find_in_path("/some/path/app/foo/bar/", "zzz")
