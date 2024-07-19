local utils = require('namespace.switcher.utils')

Current_test_function = nil

local function setup_test_set(func_name)
    Current_test_function = func_name
    print('TESTS - ' .. func_name)
end

local function run_test(func, input, expected)
    local status, result = pcall(func, unpack(input))
    local test_info = debug.getinfo(2, "Sl") -- Capture the calling context
    if not status or not vim.deep_equal(result, expected) then
        local line_info = test_info.short_src .. ":" .. test_info.currentline
        print("\n==================== TEST FAILED ====================")
        print("Line:     " .. line_info .. " -> " ..Current_test_function .. "()")
        print("Input:    " .. vim.inspect(input))
        print("Expected: " .. vim.inspect(expected))
        print("Actual:   " .. vim.inspect(result))
        print("=====================================================\n")
    else
        vim.api.nvim_out_write(".")
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

setup_test_set('split_path_with_delimiters')
run_test(utils.split_path_with_delimiters, {"some/path/app"}, {"some", "/", "path", "/", "app"})
run_test(utils.split_path_with_delimiters, {"/some/path/app"}, {"/", "some", "/", "path", "/", "app"})
run_test(utils.split_path_with_delimiters, {"some/path/app/"}, {"some", "/", "path", "/", "app", "/"})
run_test(utils.split_path_with_delimiters, {"/some/path/app/"}, {"/", "some", "/", "path", "/", "app", "/"})
run_test(utils.split_path_with_delimiters, {"/some/path//app/"}, {"/", "some", "/", "path", "//", "app", "/"})
run_test(utils.split_path_with_delimiters, {"C:\\\\some\\path\\app"}, {"C:", "\\\\", "some", "\\", "path", "\\", "app"})

setup_test_set('find_in_path')
run_test(utils.find_in_path, {"some/path/app/foo/bar", "app"}, {found = true, before = "some/path", after = "foo/bar"})
run_test(utils.find_in_path, {"/some/path/app/foo/bar", "app"}, {found = true, before = "/some/path", after = "foo/bar"})
run_test(utils.find_in_path, {"some/path/app/foo/bar/", "app"}, {found = true, before = "some/path", after = "foo/bar/"})
run_test(utils.find_in_path, {"/some/path/app/foo/bar/", "app"}, {found = true, before = "/some/path", after = "foo/bar/"})
run_test(utils.find_in_path, {"/some/path/app", "app"}, {found = true, before = "/some/path", after = nil})
run_test(utils.find_in_path, {"app/foo/bar/", "app"}, {found = true, before = nil, after = "foo/bar/"})
run_test(utils.find_in_path, {"C:\\some\\path\\app\\foo\\bar\\", "app"}, {found = true, before = "C:\\some\\path", after = "foo\\bar\\"})
run_test(utils.find_in_path, {"/some/path/app/foo/bar/", "zzz"}, {found = false, before = nil, after = nil})
