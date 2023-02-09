-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Change Root To Global Current Working Directory
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#change-root-to-global-current-working-directory
-- local function change_root_to_global_cwd()
--      local api = require("nvim-tree.api")
--      local global_cwd = vim.fn.getcwd(-1, -1)
--      api.tree.change_root(global_cwd)
-- end

-- require("nvim-tree").setup({
--      sort_by = "case_sensitive",
--      view = {
--           width = 30,
--           mappings = {
--                list = {
--                     -- Refer to :help nvim-tree-default-mappings
--                     { key = "?", action = "toggle_help" },
--                     { key = "<CR>", action = "edit_no_picker" },
--                     { key = "<C-C>", action = "global_cwd", action_cb = change_root_to_global_cwd },
--                },
--           },
--      },
--      renderer = {
--           group_empty = true,
--           highlight_opened_files = 3,
--      },
--      filters = {
--           dotfiles = false,
--      },
-- })

require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
     auto_reload_on_write = true,
     disable_netrw = true, -- default is false
     hijack_cursor = false,
     hijack_netrw = true,
     hijack_unnamed_buffer_when_opening = false,
     ignore_buffer_on_setup = false,
     open_on_setup = false,
     open_on_setup_file = false,
     sort_by = "name",
     root_dirs = {},
     prefer_startup_root = false,
     sync_root_with_cwd = false,
     reload_on_bufenter = false,
     respect_buf_cwd = false,
     on_attach = "disable",
     remove_keymaps = true,
     select_prompts = false,
     view = {
          centralize_selection = false,
          cursorline = true,
          debounce_delay = 15,
          width = 30,
          hide_root_folder = false,
          side = "left",
          preserve_window_proportions = false,
          number = false,
          relativenumber = false,
          signcolumn = "yes",
          mappings = {
               custom_only = false,
               list = {
                    -- user mappings go here
                    { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
                    -- { key = "<C-e>",                          action = "edit_in_place" },
                    -- { key = "O",                              action = "edit_no_picker" },
                    { key = { "<C-]>", "<2-RightMouse>" },    action = "cd" }, -- cd in the directory under the cursor
                    -- { key = "<C-v>",                          action = "vsplit" },
                    -- { key = "<C-x>",                          action = "split" },
                    -- { key = "<C-t>",                          action = "tabnew" },
                    { key = "<",                              action = "prev_sibling" }, -- navigate to the previous sibling of current file/directory
                    { key = ">",                              action = "next_sibling" }, -- navigate to the next sibling of current file/directory
                    { key = "p",                              action = "parent_node" }, -- move cursor to the parent directory
                    -- { key = "<BS>",                           action = "close_node" }, -- close current opened directory or parent
                    { key = "<Tab>",                          action = "preview" }, -- open the file as a preview (keeps the cursor in the tree)
                    { key = "K",                              action = "first_sibling" }, -- navigate to the first sibling of current file/directory
                    { key = "J",                              action = "last_sibling" }, -- navigate to the last sibling of current file/directory
                    -- { key = "C",                              action = "toggle_git_clean" }, -- toggle visibility of git clean via |filters.git_clean| option
                    -- { key = "I",                              action = "toggle_git_ignored" }, -- toggle visibility of files/folders hidden via |git.ignore| option
                    -- { key = "H",                              action = "toggle_dotfiles" }, -- toggle visibility of dotfiles via |filters.dotfiles| option
                    -- { key = "B",                              action = "toggle_no_buffer" }, -- toggle visibility of files/folders hidden via |filters.no_buffer| option
                    -- { key = "U",                              action = "toggle_custom" }, -- toggle visibility of files/folders hidden via |filters.custom| option
                    { key = "r",                              action = "refresh" },
                    { key = "a",                              action = "create" }, -- add a file; leaving a trailing `/` will add a directory
                    { key = "d",                              action = "remove" }, -- delete a file (will prompt for confirmation)
                    -- { key = "D",                              action = "trash" }, -- trash a file via |trash| option
                    -- { key = "r",                              action = "rename" },
                    { key = "m",                                 action = "full_rename" }, -- rename a file and omit the filename on input
                    { key = "b",                              action = "rename_basename" }, -- rename a file with filename-modifiers ':t:r' without changing extension
                    -- { key = "x",                              action = "cut" },
                    -- { key = "c",                              action = "copy" },
                    -- { key = "p",                              action = "paste" },
                    -- { key = "y",                              action = "copy_name" },
                    -- { key = "Y",                              action = "copy_path" },
                    -- { key = "gy",                             action = "copy_absolute_path" },
                    { key = "[d",                             action = "prev_diag_item" }, -- go to prev diagnostic item
                    { key = "]d",                             action = "next_diag_item" }, -- go to next diagnostic item
                    -- { key = "[c",                             action = "prev_git_item" }, -- go to next git item
                    -- { key = "]c",                             action = "next_git_item" }, -- go to next git item
                    { key = "u",                              action = "dir_up" }, -- default: "-", navigate up to the parent directory of the current file/directory
                    { key = "x",                              action = "system_open" }, -- menomic: eXecute, open a file with default system application or a folder with default file manager, using |system_open| option
                    { key = "f",                              action = "live_filter" }, -- live filter nodes dynamically based on regex matching.
                    { key = "F",                              action = "clear_live_filter" }, -- clear live filter
                    { key = "<ESC>",                              action = "close" }, -- close tree window, default: q
                    { key = "C",                              action = "collapse_all" }, -- collapse the whole tree
                    { key = "E",                              action = "expand_all" }, -- expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder
                    { key = "S",                              action = "search_node" }, -- prompt the user to enter a path and then expands the tree to match the path
                    -- { key = ".",                              action = "run_file_command" },
                    { key = "i",                              action = "toggle_file_info" }, -- Mnemonic: Info, <C-k> used to switch windows toggle a popup with file infos about the file under the cursor
                    { key = "?",                              action = "toggle_help" },
                    { key = "s",                              action = "toggle_mark" }, -- Mnemonic: Star - Toggle node in bookmarks
                    { key = "bmv",                            action = "bulk_move" }, -- Move all bookmarked nodes into specified location
               },
          },
          float = {
               enable = false,
               quit_on_focus_loss = true,
               open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1,
               },
          },
     },
     renderer = {
          add_trailing = false,
          group_empty = false,
          highlight_git = false,
          full_name = false,
          highlight_opened_files = "all", -- default: "none",
          highlight_modified = "none",
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
                    modified = "●",
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
     hijack_directories = {
          enable = true,
          auto_open = true,
     },
     update_focused_file = {
          enable = false,
          update_root = false,
          ignore_list = {},
     },
     ignore_ft_on_setup = {},
     system_open = {
          cmd = "",
          args = {},
     },
     diagnostics = {
          enable = false,
          show_on_dirs = false,
          show_on_open_dirs = true,
          debounce_delay = 50,
          severity = {
               min = vim.diagnostic.severity.HINT,
               max = vim.diagnostic.severity.ERROR,
          },
          icons = {
               hint = "",
               info = "",
               warning = "",
               error = "",
          },
     },
     filters = {
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          custom = {},
          exclude = {},
     },
     filesystem_watchers = {
          enable = true,
          debounce_delay = 50,
          ignore_dirs = {},
     },
     git = {
          enable = true, -- default: true
          ignore = true,
          show_on_dirs = true,
          show_on_open_dirs = true,
          timeout = 400,
     },
     modified = {
          enable = false,
          show_on_dirs = true,
          show_on_open_dirs = true,
     },
     actions = {
          use_system_clipboard = true,
          change_dir = {
               enable = true,
               global = false,
               restrict_above_cwd = false,
          },
          expand_all = {
               max_folder_discovery = 300,
               exclude = {},
          },
          file_popup = {
               open_win_config = {
                    col = 1,
                    row = 1,
                    relative = "cursor",
                    border = "shadow",
                    style = "minimal",
               },
          },
          open_file = {
               quit_on_open = false,
               resize_window = true,
               window_picker = {
                    enable = true,
                    picker = "default",
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                         filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                         buftype = { "nofile", "terminal", "help" },
                    },
               },
          },
          remove_file = {
               close_window = true,
          },
     },
     trash = {
          cmd = "gio trash",
     },
     live_filter = {
          prefix = "[FILTER]: ",
          always_show_folders = true,
     },
     tab = {
          sync = {
               open = false,
               close = false,
               ignore = {},
          },
     },
     notify = {
          threshold = vim.log.levels.INFO,
     },
     ui = {
          confirm = {
               remove = true,
               trash = true,
          },
     },
     log = {
          enable = false,
          truncate = false,
          types = {
               all = false,
               config = false,
               copy_paste = false,
               dev = false,
               diagnostics = false,
               git = false,
               profile = false,
               watcher = false,
          },
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
vim.api.nvim_set_keymap("n", "<leader>nn", ":NvimTreeToggle<CR>", { noremap = true })

-- :NvimTreeFocus Open the tree if it is closed, and then focus on the tree.
-- vim.api.nvim_set_keymap("n", "<leader>no", ":NvimTreeFocus<CR>", { noremap = true })

-- :NvimTreeFindFile Move the cursor in the tree for the current buffer, opening folders if needed.
-- Find file and show within CWD
vim.api.nvim_set_keymap("n", "<leader>nf", ":NvimTreeFindFile<CR>", { noremap = true })

-- Open to current buffer dir
-- vim.api.nvim_set_keymap("n", "<leader>no", ":NvimTreeFocus<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>nd", ":NvimTreeOpen " .. vim.fn.expand('%:p:h') .. "<CR>", { noremap = true })

-- Collapses the nvim-tree recursively, but keep the directories open, which are used in an open buffer.
vim.api.nvim_set_keymap("n", "<leader>nc", ":NvimTreeCollapseKeepBuffers<CR>", { noremap = true })

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

