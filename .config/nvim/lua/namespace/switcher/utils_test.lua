-- /tmp/.mount_nvimQZPGq2/usr/share/nvim/runtime/lua/vim/shared.lua

local utils = require('namespace.switcher.utils')

Current_test_function = nil
Ignore_params = nil

local function setup_test_set(func_name, ignore_params)
    Current_test_function = func_name
    Ignore_params = ignore_params or {}
    print('TESTS - ' .. func_name)
end

local function filter_ignored_params(t, ignore_params)
    local filtered_table = {}
    for k, v in pairs(t) do
        if not vim.tbl_contains(ignore_params, k) then
            filtered_table[k] = v
        end
    end
    return filtered_table
end

local function run_test(func, input, expected)
    func(unpack(input)) -- If code fails to run, we want to know
    local status, result = pcall(func, unpack(input))
    local test_info = debug.getinfo(2, "Sl") -- Capture the calling context
    if status then
        if type(result) == "table" then
            result = filter_ignored_params(result, Ignore_params)
        end
    end
    if not status or not vim.deep_equal(result, expected) then
        local line_info = test_info.short_src .. ":" .. test_info.currentline
        print("\n==================== TEST FAILED ====================")
        print("Line:     " .. line_info .. " -> " ..Current_test_function .. "()")
        print("Input:    " .. vim.inspect(input))
        print("Expected: " .. vim.inspect(expected))
        print("Actual:   " .. vim.inspect(result))
        print("=====================================================\n")
    end
end

setup_test_set('get_file_path_info')
run_test(utils.get_file_path_info, {"some/path/to/file.ext"}, {path = "some/path/to", up_dir = "path", dir = "to", name = "file.ext", base_name = "file", ext = "ext"})
run_test(utils.get_file_path_info, {"some/path/to/file"}, {path = "some/path/to", up_dir = "path", dir = "to", name = "file", base_name = "file", ext = nil})
run_test(utils.get_file_path_info, {"some/path/to/.file"}, {path = "some/path/to", up_dir = "path", dir = "to", name = ".file", base_name = ".file", ext = nil})
run_test(utils.get_file_path_info, {"to/file.ext"}, {path = "to", up_dir = nil, dir = "to", name = "file.ext", base_name = "file", ext = "ext"})
run_test(utils.get_file_path_info, {"file.ext"}, {path = nil, up_dir = nil, dir = nil, name = "file.ext", base_name = "file", ext = "ext"})
run_test(utils.get_file_path_info, {".file"}, {path = nil, up_dir = nil, dir = nil, name = ".file", base_name = ".file", ext = nil})

setup_test_set('split_path')
run_test(utils.split_path, {"some/path/to/file.ext"}, {"some", "path", "to", "file.ext"})
run_test(utils.split_path, {"some/path/to/file"}, {"some", "path", "to", "file"})
run_test(utils.split_path, {"some\\path\\to\\file.ext"}, {"some", "path", "to", "file.ext"})

setup_test_set('get_last_nth_bit')
run_test(utils.get_last_nth_bit, {"some/path/to/file.ext", 1}, "file.ext")
run_test(utils.get_last_nth_bit, {"some/path/to/file.ext", 2}, "to")
run_test(utils.get_last_nth_bit, {"some\\path\\to\\file.ext", 2}, "to")
run_test(utils.get_last_nth_bit, {"some/path/to/file.ext", 3}, "path")
run_test(utils.get_last_nth_bit, {"some/path/to/file.ext", 99}, nil)

setup_test_set('get_cwd_includes')
print('TESTS - get_cwd_includes - CWD: ' .. vim.fn.getcwd())
run_test(utils.get_cwd_includes, {"foo", false}, false)
run_test(utils.get_cwd_includes, {"z/nvim", false}, false)
run_test(utils.get_cwd_includes, {"nvim", true}, true)
run_test(utils.get_cwd_includes, {"NVIM", true}, false)
run_test(utils.get_cwd_includes, {"/nvim/", false}, false)
run_test(utils.get_cwd_includes, {".config/nvim", false}, true)
run_test(utils.get_cwd_includes, {".config/nvim/", false}, false)

-- setup_test_set('_split_path_with_delimiters')
-- run_test(utils._split_path_with_delimiters, {"some/path/app"}, {"some", "/", "path", "/", "app"})
-- run_test(utils._split_path_with_delimiters, {"/some/path/app"}, {"/", "some", "/", "path", "/", "app"})
-- run_test(utils._split_path_with_delimiters, {"some/path/app/"}, {"some", "/", "path", "/", "app", "/"})
-- run_test(utils._split_path_with_delimiters, {"/some/path/app/"}, {"/", "some", "/", "path", "/", "app", "/"})
-- run_test(utils._split_path_with_delimiters, {"/some/path//app/"}, {"/", "some", "/", "path", "//", "app", "/"})
-- run_test(utils._split_path_with_delimiters, {"C:\\\\some\\path\\app"}, {"C:", "\\\\", "some", "\\", "path", "\\", "app"})


setup_test_set('find_in_path', { "bits", "sep", "before_bits", "after_bits", "before_w_pattern_bits", "after_w_pattern_bits"})
run_test(utils.find_in_path, {"some/path/app/foo/bar", "app"}, {found = true, before = "some/path", before_w_pattern = "some/path/app", after = "foo/bar", after_w_pattern = "app/foo/bar"})
run_test(utils.find_in_path, {"/some/path/app/foo/bar", "app"}, {found = true, before = "/some/path", before_w_pattern = "/some/path/app", after = "foo/bar", after_w_pattern = "app/foo/bar"})
run_test(utils.find_in_path, {"//some/path/app/foo/bar", "app"}, {found = true, before = "//some/path", before_w_pattern = "//some/path/app", after = "foo/bar", after_w_pattern = "app/foo/bar"})
run_test(utils.find_in_path, {"some/path/app/foo/bar/", "app"}, {found = true, before = "some/path", before_w_pattern = "some/path/app", after = "foo/bar", after_w_pattern = "app/foo/bar"})
run_test(utils.find_in_path, {"/some/path/app/foo/bar/", "app"}, {found = true, before = "/some/path", before_w_pattern = "/some/path/app", after = "foo/bar", after_w_pattern = "app/foo/bar"})
run_test(utils.find_in_path, {"/some/path/app/foo/bar/", "/app/"}, {found = false})
run_test(utils.find_in_path, {"/some/path/app/foo/bar/", "ap"}, {found = false})
run_test(utils.find_in_path, {"/some/path/app", "app"}, {found = true, before = "/some/path", before_w_pattern = "/some/path/app", after = nil, after_w_pattern = "app"})
run_test(utils.find_in_path, {"app/foo/bar", "app"}, {found = true, before = nil, before_w_pattern = "app", after = "foo/bar", after_w_pattern = "app/foo/bar"})
run_test(utils.find_in_path, {"/some/path/app/foo/bar/", "zzz"}, {found = false, before = nil, before_w_pattern = nil, after = nil, after_w_pattern = nil})

-- nth_match not provided, should default to first occurrence
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app"},
    {found = true, before = "some", before_w_pattern = "some/app", after = "path/app/foo/bar/app", after_w_pattern = "app/path/app/foo/bar/app"})

-- nth_match = -4, out of range (negative)
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", -4},
    {found = false, before = nil, before_w_pattern = nil, after = nil, after_w_pattern = nil})

-- nth_match = -3, third last occurrence
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", -3},
    {found = true, before = "some", before_w_pattern = "some/app", after = "path/app/foo/bar/app", after_w_pattern = "app/path/app/foo/bar/app"})

-- nth_match = -2, second last occurrence
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", -2},
    {found = true, before = "some/app/path", before_w_pattern = "some/app/path/app", after = "foo/bar/app", after_w_pattern = "app/foo/bar/app"})

-- nth_match = -1, last occurrence
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", -1},
    {found = true, before = "some/app/path/app/foo/bar", before_w_pattern = "some/app/path/app/foo/bar/app", after = nil, after_w_pattern = "app"})

-- nth_match = 0, should be invalid and return found=false
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", 0},
    {found = false, before = nil, before_w_pattern = nil, after = nil, after_w_pattern = nil})

-- nth_match = 1, first occurrence
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", 1},
    {found = true, before = "some", before_w_pattern = "some/app", after = "path/app/foo/bar/app", after_w_pattern = "app/path/app/foo/bar/app"})

-- nth_match = 2, second occurrence
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", 2},
    {found = true, before = "some/app/path", before_w_pattern = "some/app/path/app", after = "foo/bar/app", after_w_pattern = "app/foo/bar/app"})

-- nth_match = 3, third occurrence
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", 3},
    {found = true, before = "some/app/path/app/foo/bar", before_w_pattern = "some/app/path/app/foo/bar/app", after = nil, after_w_pattern = "app"})

-- nth_match = 4, out of range (positive)
run_test(utils.find_in_path, {"some/app/path/app/foo/bar/app", "app", 4},
    {found = false, before = nil, before_w_pattern = nil, after = nil, after_w_pattern = nil})


run_test(utils.find_in_path, {"/some/app/path/app/foo/bar/app", "app"},
    {found = true, before = "/some", before_w_pattern = "/some/app", after = "path/app/foo/bar/app", after_w_pattern = "app/path/app/foo/bar/app"})

run_test(utils.find_in_path, {"app/foo/bar", "app"},
    {found = true, before = nil, before_w_pattern = "app", after = "foo/bar", after_w_pattern = "app/foo/bar"})
run_test(utils.find_in_path, {"/some/app/path/app/foo/bar/app/", "zzz"},
    {found = false, before = nil, before_w_pattern = nil, after = nil, after_w_pattern = nil})


setup_test_set('offset_path', {"sep", "bits", "before_offset_bits", "after_offset_bits", "before_offset_w_pattern_bits", "after_offset_w_pattern_bits"}
)
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", -5}, {found = false})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", -4}, {found = false})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", -3}, {
    after_offset = "longer/path/app/foo/bar/baz",
    after_offset_w_pattern = "some/longer/path/app/foo/bar/baz",
    at = "some",
    before_offset = nil,
    before_offset_w_pattern = "some",
    found = true,
})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", -2}, {
    after_offset = "path/app/foo/bar/baz",
    after_offset_w_pattern = "longer/path/app/foo/bar/baz",
    at = "longer",
    before_offset = "some",
    before_offset_w_pattern = "some/longer",
    found = true,
})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", -1}, {
    after_offset = "app/foo/bar/baz",
    after_offset_w_pattern = "path/app/foo/bar/baz",
    at = "path",
    before_offset = "some/longer",
    before_offset_w_pattern = "some/longer/path",
    found = true,
})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", 0}, {
    after_offset = "foo/bar/baz",
    after_offset_w_pattern = "app/foo/bar/baz",
    at = "app",
    before_offset = "some/longer/path",
    before_offset_w_pattern = "some/longer/path/app",
    found = true,
})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", 1}, {
    after_offset = "bar/baz",
    after_offset_w_pattern = "foo/bar/baz",
    at = "foo",
    before_offset = "some/longer/path/app",
    before_offset_w_pattern = "some/longer/path/app/foo",
    found = true,
})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", 2}, {
    after_offset = "baz",
    after_offset_w_pattern = "bar/baz",
    at = "bar",
    before_offset = "some/longer/path/app/foo",
    before_offset_w_pattern = "some/longer/path/app/foo/bar",
    found = true,
})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", 3}, {
    after_offset = nil,
    after_offset_w_pattern = "baz",
    at = "baz",
    before_offset = "some/longer/path/app/foo/bar",
    before_offset_w_pattern = "some/longer/path/app/foo/bar/baz",
    found = true,
})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", 4}, {found = false})
run_test(utils.offset_path, {"some/longer/path/app/foo/bar/baz", "app", 5}, {found = false})
