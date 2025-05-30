-- Refer :help nvim-tree-setup for `setup(opt)` options

local Plugin = {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    after = "nvim-web-devicons",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    init = function()
        -- disable netrw at the very start of your init.lua
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true
    end,
}

Plugin.config = function ()
    local api = require("nvim-tree.api")

    -- Change Root To Global Current Working Directory
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#change-root-to-global-current-working-directory
    local function change_root_to_global_cwd()
        local api = require("nvim-tree.api")
        local global_cwd = vim.fn.getcwd(-1, -1)
        api.tree.change_root(global_cwd)
    end

    local function calculate_file_type(buf_nr)
        -- Recalculate the file type, if renaming a file, the file type should change to match.
        vim.api.nvim_buf_call(buf_nr, function()
            vim.cmd('e')
        end)
    end

    local function get_path_from_user(action, default)
        -- The args of input are {prompt}, {default}, {completion}
        -- Read in the new file path using the existing file's path as the baseline.
        return vim.fn.input(action .." TO: ", default, "file")
    end

    local function copy_or_move_file_to(file_src, file_out, copy)
        -- Create any parent dirs as required
        local dir = vim.fn.fnamemodify(file_out, ":h")

        -- gitbash.exe has win32 but no move. A better check is if the system has the `mv` command
        -- Note: In windows copy is also `cp`
        local is_win = vim.fn.executable('mv') == 0

        -- Make parent dir as required
        local mkdir_cmd = is_win and {'mkdir', dir} or {'mkdir', '-p', dir}
        vim.fn.system(mkdir_cmd)
        local cmds = {
            win = {
                copy = { 'cp', file_src, file_out },
                move = { 'move', file_src, file_out },
            },
            linux = {
                copy = { 'cp', '-R', file_src, file_out },
                move = { 'mv', file_src, file_out },
            }
        }
        local cmd_arr = cmds[is_win and 'win' or 'linux'][copy and 'copy' or 'move']
        vim.fn.system(cmd_arr)
        if not copy then
            -- If a move, then associate any open buffers with the moved file with the new file path
            for _, buf in ipairs(vim.fn.getbufinfo()) do
                if buf.name == file_src then
                    -- Set the buffer's name to the new destination path
                    print(buf.name, '\n', file_src, '\n', file_out)
                    vim.api.nvim_buf_set_name(buf.bufnr, file_out)
                    calculate_file_type(buf.bufnr)
                end
            end
            vim.cmd('redraw!')
            vim.cmd('redrawstatus!') -- Doesn't work with my status line
        end
    end
    local function copy_file_to(node)
        local file_out = get_path_from_user("COPY", node.absolute_path)
        copy_or_move_file_to(node.absolute_path, file_out, true)
    end
    local function move_file_to(node)
        local file_out = get_path_from_user("MOVE", node.absolute_path)
        copy_or_move_file_to(node.absolute_path, file_out, false)
    end
    local function bak_up_file(node)
        local file_out = node.absolute_path..".bak"
        copy_or_move_file_to(node.absolute_path, file_out, true)
    end

    -- Use `o` to open a file
    -- Use `<CR>` to open a file and close the tree
    local function edit_and_close(node)
        api.node.open.edit(node, {})
        api.tree.close()
    end

    -- This function has been generated for you
    -- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
    local function on_attach(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        -- Mappings migrated from view.mappings.list
        --
        -- You will need to insert "your code goes here" for any mappings with a custom action_cb
        vim.keymap.set('n', '<leader>c', function()
            local node = api.tree.get_node_under_cursor()
            copy_file_to(node)
        end, opts('copy_file_to'))

        vim.keymap.set('n', 'm', function()
            local node = api.tree.get_node_under_cursor()
            move_file_to(node)
        end, opts('move_file_to'))

        vim.keymap.set('n', '<leader>b', function()
            local node = api.tree.get_node_under_cursor()
            bak_up_file(node)
        end, opts('back up file'))

        vim.keymap.set('n', '<C-c>', function()
            local node = api.tree.get_node_under_cursor()
            change_root_to_global_cwd()
        end, opts('global_cwd'))

        -- Open a file, and close tree
        vim.keymap.set('n', 'O', function()
            local node = api.tree.get_node_under_cursor()
            edit_and_close(node)
        end, opts('edit_and_close'))
        -- Open a file, and keep tree
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        -- vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open')) // use <CR> for leap

        vim.keymap.set('n', '<LeftRelease>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', 'K', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        vim.keymap.set('n', 'J', api.node.navigate.sibling.next, opts('Next Sibling'))
        vim.keymap.set('n', '-', api.node.navigate.parent, opts('Parent Directory'))
        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        vim.keymap.set('n', '<c-k>', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', '<c-j>', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', 'r', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        -- vim.keymap.set('n', 'm', api.fs.rename_sub, opts('Rename: Omit Filename'))
        vim.keymap.set('n', 'b', api.fs.rename_basename, opts('Rename: Basename'))
        vim.keymap.set('n', '[d', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        vim.keymap.set('n', ']d', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 'x', api.node.run.system, opts('Run System'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'C', api.tree.collapse_all, opts('Collapse'))
        vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        vim.keymap.set('n', 'i', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', '<F1>', api.tree.toggle_help, opts('Help'))
        -- vim.keymap.set('n', 's', api.marks.toggle, opts('Toggle Bookmark'))
        -- vim.keymap.set('n', 'M', api.marks.bulk.move, opts('Move Bookmarked'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))

    end

    local function getTreeColWidth()
        local current_path = vim.fn.expand('%:p:h'):lower() -- Get current file's path in lowercase
        local is_gateway = string.find(current_path, 'gateway') ~= nil or string.find(current_path, 'ioec') ~= nil
        if is_gateway then
            return 48
        else
            return 32
        end
    end

    -- Refer :help nvim-tree-setup
    require('nvim-tree').setup { -- BEGIN_DEFAULT_OPTS
        on_attach = on_attach,
        view = {
            width = getTreeColWidth(),
            signcolumn = "yes",
        },
        actions = {
            open_file = {
                resize_window = false, -- Resizes the tree when opening a file.
            },
        },
        renderer = {
            group_empty = true, -- default: true. Compact folders that only contain a single folder into one node in the file tree.
            highlight_git = false,
            full_name = false,
            highlight_opened_files = "icon", -- "none" (default), "icon", "name" or "all"
            highlight_modified = "icon",  -- "none", "name" or "all". Nice and subtle, override the open icon
            root_folder_label = ":~:s?$?/..?",
            indent_width = 2,
            indent_markers = {
                enable = false,
                inline_arrows = true,
                icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                },
            },
            icons = {
                -- webdev_colors = true,
                git_placement = "before",
                modified_placement = "after",
                padding = " ",
                symlink_arrow = " ➛ ",
                show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                        modified = true,
                },
                glyphs = {
                        default = "",
                        symlink = "",
                        bookmark = "",
                        modified = "",  -- default: ● - Rather change background color
                        folder = {
                            arrow_closed = "-", -- default: "",
                            arrow_open = "+", -- default: "",
                            default = "",
                            open = "",
                            empty = "",
                            empty_open = "",
                            symlink = "",
                            symlink_open = "",
                        },
                        git = {
                            unstaged = "✗",
                            staged = "✓",
                            unmerged = "",
                            renamed = "➜",
                            untracked = "★",
                            deleted = "",
                            ignored = "◌",
                        },
                },
            },
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
        },
        modified = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = false,
        },
        filters = {
            dotfiles = false,
            git_clean = false,
            no_buffer = false,
            custom = { "__pycache__", "\\.angular", ".vscode"},
            exclude = {},
        },
        git = {
            enable = false, -- default: true, however on large git project becomes very slow
        },
    } -- END_DEFAULT_OPTS


    -- Automatically open file upon creation
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#automatically-open-file-upon-creation
    -- local api = require("nvim-tree.api")
    -- api.events.subscribe(api.events.Event.FileCreated, function(file)
    -- vim.cmd("edit " .. file.fname)
    -- end)

    -- vim.g.nvim_tree_icons = {
    --     folder = {
    --         default = "",
    --         open = "",
    --         empty_open = "",
    --         empty = "",
    --         symlink = "",
    --     }
    -- }

    -- :NvimTreeToggle Open or close the tree. Takes an optional path argument.
    -- Toggle open tree at CWD
    vim.api.nvim_set_keymap("n", "<leader>nn", ":NvimTreeToggle<CR>", { noremap = true, desc ="NvimTree toggle pane"})

    -- :NvimTreeFocus Open the tree if it is closed, and then focus on the tree.
    -- vim.api.nvim_set_keymap("n", "<leader>no", ":NvimTreeFocus<CR>", { noremap = true, desc = "NvimTree focus"})

    -- :NvimTreeFindFile Move the cursor in the tree for the current buffer, opening folders if needed.
    -- Find file and show within CWD
    local function smart_find_file()
        -- If the file does not exist on the file system, then just show the tree
        if vim.fn.expand('%') ~= '' then
            vim.cmd('NvimTreeFindFile')
            -- vim.fn.feedkeys("$10zh")  -- Move to the end of the line, then 4 times scroll left
        else
            vim.cmd('NvimTreeToggle')
        end
    end

    -- vim.api.nvim_set_keymap("n", "<leader>nf", ":NvimTreeFindFile<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>nf", smart_find_file, { noremap = true, desc = "NvimTree find file" })

    -- Open to current buffer dir
    -- vim.api.nvim_set_keymap("n", "<leader>no", ":NvimTreeFocus<CR>", { noremap = true })
    vim.keymap.set("n", "<leader>nd", ":NvimTreeOpen " .. vim.fn.expand('%:p:h') .. "<CR>", { noremap = true, desc = "NvimTree open buffer's dir"})

    -- Collapses the nvim-tree recursively, but keep the directories open, which are used in an open buffer.
    vim.keymap.set("n", "<leader>nc", ":NvimTreeCollapseKeepBuffers<CR>", { noremap = true, desc = "NvimTree collapse except open"})

    -- Collapses the nvim-tree recursively.
    -- Use the 'W' command in Nvim-Tree
    -- vim.api.nvim_set_keymap("n", "<leader>nC", ":NvimTreeCollapse<CR>", { noremap = true })


    -- Autoclose if the tree is the last window
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
    -- vim.api.nvim_create_autocmd("BufEnter", {
    --      group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
    --      pattern = "NvimTree_*",
    --      callback = function()
    --      local layout = vim.api.nvim_call_function("winlayout", {})
    --      if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
    -- end
    -- })




    -- Open at startup
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
    local PluginNvimTreeGroup = vim.api.nvim_create_augroup("PluginNvimTreeGroup", {clear = true})

    -- Moved this to startup.lua
    -- vim.api.nvim_create_autocmd(
    --     "VimEnter" , {
    --         group = PluginNvimTreeGroup,
    --         callback = function (data)
    --             local is_actual_file = vim.fn.filereadable(data.file) == 1
    --             if not is_actual_file then
    --                 -- Only if not a real file auto show tree
    --                 require("nvim-tree.api").tree.toggle({focus = false })
    --             end
    --         end,
    --     }
    -- )

    -- Go to last used hidden buffer when deleting a buffer
    -- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#go-to-last-used-hidden-buffer-when-deleting-a-buffer
    vim.api.nvim_create_autocmd(
        "BufEnter", {
            group = PluginNvimTreeGroup,
            nested = true,
            callback = function()
                -- Only 1 window with nvim-tree left: we probably closed a file buffer
                if #vim.api.nvim_list_wins() == 1 and api.tree.is_tree_buf() then
                    -- Required to let the close event complete. An error is thrown without this.
                    vim.defer_fn(function()
                        -- close nvim-tree: will go to the last hidden buffer used before closing
                        api.tree.toggle({find_file = true, focus = true})
                        -- re-open nivm-tree
                        api.tree.toggle({find_file = true, focus = true})
                        -- nvim-tree is still the active window. Go to the previous window.
                        vim.cmd("wincmd p")
                    end, 0)
                end
            end
        }
    )

end

return Plugin
