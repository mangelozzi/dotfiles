if not require("namespace.utils").get_is_installed("nvim-tree.lua") then return end

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local api = require("nvim-tree.api")

-- Change Root To Global Current Working Directory
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#change-root-to-global-current-working-directory
local function change_root_to_global_cwd()
     local api = require("nvim-tree.api")
     local global_cwd = vim.fn.getcwd(-1, -1)
     api.tree.change_root(global_cwd)
end

-- require("nvim-tree").setup({
--      sort_by = "case_sensitive",
--      view = {
--           width = 30,
--           mappings = {
--                list = {
--                     -- Refer to :help nvim-tree-default-mappings
--                     { key = "?", action = "toggle_help" },
--                     { key = "<CR>", action = "edit_no_picker" },
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
local function copy_file_to(node)
    local file_src = node['absolute_path']
    -- The args of input are {prompt}, {default}, {completion}
    -- Read in the new file path using the existing file's path as the baseline.
    local file_out = vim.fn.input("COPY TO: ", file_src, "file")
    -- Create any parent dirs as required
    local dir = vim.fn.fnamemodify(file_out, ":h")
    vim.fn.system { 'mkdir', '-p', dir }
    -- Copy the file
    vim.fn.system { 'cp', file_src, file_out }
end

-- Use `o` to open a file
-- Use `<CR>` to open a file and close the tree
local function edit_and_close(node)
    api.node.open.edit(node, {})
    api.tree.close()
end

-- Refer :help nvim-tree-setup
require('nvim-tree').setup { -- BEGIN_DEFAULT_OPTS
     view = {
          width = 30,
          signcolumn = "yes",
          mappings = {
               custom_only = true,  -- Disable default bindings, so can use <C-e> for say extra lines
               list = {
                    -- Namespace mappings
                    { key = "c", action = "copy_file_to", action_cb = copy_file_to },
                    { key = "<C-c>", action = "global_cwd", action_cb = change_root_to_global_cwd },
                    { key = "<CR>", action = "edit_and_close", action_cb=edit_and_close },
                    -- user mappings go here
                    { key = "o", action = "edit" },
                    -- { key = "<C-e>",                          action = "edit_in_place" },
                    -- { key = "O",                              action = "edit_no_picker" },
                    { key = "<C-]>",        action = "cd" }, -- cd in the directory under the cursor
                    -- { key = "<C-v>",        action = "vsplit" },
                    -- { key = "<C-x>",        action = "split" },
                    -- { key = "<C-t>",        action = "tabnew" },
                    { key = "<",            action = "prev_sibling" }, -- navigate to the previous sibling of current file/directory
                    { key = ">",            action = "next_sibling" }, -- navigate to the next sibling of current file/directory
                    { key = "p",            action = "parent_node" }, -- move cursor to the parent directory
                    -- { key = "<BS>",         action = "close_node" }, -- close current opened directory or parent
                    { key = "<Tab>",        action = "preview" }, -- open the file as a preview (keeps the cursor in the tree)
                    { key = "K",            action = "first_sibling" }, -- navigate to the first sibling of current file/directory
                    { key = "J",            action = "last_sibling" }, -- navigate to the last sibling of current file/directory
                    -- { key = "C",            action = "toggle_git_clean" }, -- toggle visibility of git clean via |filters.git_clean| option
                    -- { key = "I",            action = "toggle_git_ignored" }, -- toggle visibility of files/folders hidden via |git.ignore| option
                    -- { key = "H",            action = "toggle_dotfiles" }, -- toggle visibility of dotfiles via |filters.dotfiles| option
                    -- { key = "B",            action = "toggle_no_buffer" }, -- toggle visibility of files/folders hidden via |filters.no_buffer| option
                    -- { key = "U",            action = "toggle_custom" }, -- toggle visibility of files/folders hidden via |filters.custom| option
                    { key = "r",            action = "refresh" },
                    { key = "a",            action = "create" }, -- add a file; leaving a trailing `/` will add a directory
                    { key = "d",            action = "remove" }, -- delete a file (will prompt for confirmation)
                    -- { key = "D",            action = "trash" }, -- trash a file via |trash| option
                    -- { key = "r",            action = "rename" },
                    { key = "m",               action = "full_rename" }, -- rename a file and omit the filename on input
                    { key = "b",            action = "rename_basename" }, -- rename a file with filename-modifiers ':t:r' without changing extension
                    -- { key = "x",            action = "cut" },
                    -- { key = "c",            action = "copy" },
                    -- { key = "p",            action = "paste" },
                    -- { key = "y",            action = "copy_name" },
                    -- { key = "Y",            action = "copy_path" },
                    -- { key = "gy",           action = "copy_absolute_path" },
                    { key = "[d",           action = "prev_diag_item" }, -- go to prev diagnostic item
                    { key = "]d",           action = "next_diag_item" }, -- go to next diagnostic item
                    -- { key = "[c",           action = "prev_git_item" }, -- go to next git item
                    -- { key = "]c",           action = "next_git_item" }, -- go to next git item
                    { key = "u",            action = "dir_up" }, -- default: "-", navigate up to the parent directory of the current file/directory
                    { key = "x",            action = "system_open" }, -- menomic: eXecute, open a file with default system application or a folder with default file manager, using |system_open| option
                    { key = "f",            action = "live_filter" }, -- live filter nodes dynamically based on regex matching.
                    { key = "F",            action = "clear_live_filter" }, -- clear live filter
                    { key = "<ESC>",            action = "close" }, -- close tree window, default: q
                    { key = "C",            action = "collapse_all" }, -- collapse the whole tree
                    { key = "E",            action = "expand_all" }, -- expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder
                    { key = "S",            action = "search_node" }, -- prompt the user to enter a path and then expands the tree to match the path
                    -- { key = ".",            action = "run_file_command" },
                    { key = "i",            action = "toggle_file_info" }, -- Mnemonic: Info, <C-k> used to switch windows toggle a popup with file infos about the file under the cursor
                    { key = "?",            action = "toggle_help" },
                    { key = "s",            action = "toggle_mark" }, -- Mnemonic: Star - Toggle node in bookmarks
                    { key = "bmv",          action = "bulk_move" }, -- Move all bookmarked nodes into specified location
               },
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
          custom = {},
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
vim.api.nvim_set_keymap("n", "<leader>nn", ":NvimTreeToggle<CR>", { noremap = true })

-- :NvimTreeFocus Open the tree if it is closed, and then focus on the tree.
-- vim.api.nvim_set_keymap("n", "<leader>no", ":NvimTreeFocus<CR>", { noremap = true })

-- :NvimTreeFindFile Move the cursor in the tree for the current buffer, opening folders if needed.
-- Find file and show within CWD
local function smart_find_file()
    -- If the file does not exist on the file system, then just show the tree
    if vim.fn.expand('%') ~= '' then
        vim.cmd('NvimTreeFindFile')
    else
        vim.cmd('NvimTreeToggle')
    end
end
-- vim.api.nvim_set_keymap("n", "<leader>nf", ":NvimTreeFindFile<CR>", { noremap = true })
vim.keymap.set("n", "<leader>nf", smart_find_file, { noremap = true })

-- Open to current buffer dir
-- vim.api.nvim_set_keymap("n", "<leader>no", ":NvimTreeFocus<CR>", { noremap = true })
vim.keymap.set("n", "<leader>nd", ":NvimTreeOpen " .. vim.fn.expand('%:p:h') .. "<CR>", { noremap = true })

-- Collapses the nvim-tree recursively, but keep the directories open, which are used in an open buffer.
vim.keymap.set("n", "<leader>nc", ":NvimTreeCollapseKeepBuffers<CR>", { noremap = true })

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



local directory = '#ffff00'
local directory_open = directory
local directory_closed = '#d0ca50'
local directory_empty = '#c0c0c0'
local directory_root = '#00ff00'

vim.api.nvim_set_hl(0, "Directory", { fg = directory })
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = directory_closed })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderIcon", { fg = directory_open })
vim.api.nvim_set_hl(0, "NvimTreeClosedFolderIcon", { fg = directory_closed })

vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = directory_closed })
vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName", { fg = directory_empty })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = directory_open })
vim.api.nvim_set_hl(0, "NvimTreeClosedFolderName", { fg = directory_closed })
vim.api.nvim_set_hl(0, "RootFolder", { fg = directory_root })


-- Highlight color if buffer modified
-- vim.api.nvim_set_hl(0, "NvimTreeModified", { fg = "#ff0000", bg="#00ff00" })  -- Does nto seem to work, see https://github.com/nvim-tree/nvim-tree.lua/issues/1997
vim.api.nvim_set_hl(0, "NvimTreeModifiedFile", {fg="#ff0000", bg="#500000" })


-- Open at startup
-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Open-At-Startup
local PluginNvimTreeGroup = vim.api.nvim_create_augroup("PluginNvimTreeGroup", {clear = true})
vim.api.nvim_create_autocmd(
    "VimEnter" , {
        callback = function (data)
            local is_actual_file = vim.fn.filereadable(data.file) == 1
            if not is_actual_file then
                -- Only if not a real file auto show tree
                require("nvim-tree.api").tree.toggle({focus = false })
            end
        end,
        group = PluginNvimTreeGroup
})

-- NvimTreeFolderIcon xxx ctermfg=143 guifg=#a6bd5f
-- NvimTreeOpenedFolderIcon xxx ctermfg=148 guifg=#a8e519
-- NvimTreeClosedFolderIcon xxx ctermfg=143 guifg=#a6bd5f
-- NvimTreeFolderName xxx ctermfg=143 guifg=#a6bd5f
-- NvimTreeEmptyFolderName xxx ctermfg=250 guifg=#b8b8b8
-- NvimTreeOpenedFolderName xxx ctermfg=148 guifg=#a8e519
-- NvimTreeClosedFolderName xxx ctermfg=143 guifg=#a6bd5f
-- NvimTreeImageFile xxx gui=bold guifg=#d096ae
-- NvimTreeOpenedFile xxx gui=bold guifg=#4fe62d
-- NvimTreeModifiedFile xxx guifg=#ff0000 guibg=#00ff00
-- NvimTreeGitDirty xxx guifg=#8cbe17
-- NvimTreeGitDeleted xxx guifg=#8cbe17
-- NvimTreeGitStaged xxx guifg=#4fe62d
-- NvimTreeGitMerge xxx guifg=#17be49
-- NvimTreeGitRenamed xxx guifg=#d096ae
-- NvimTreeGitNew xxx guifg=#ea87b0
-- NvimTreeWindowPicker xxx gui=bold guifg=#ededed guibg=#4493c8
-- NvimTreeLiveFilterPrefix xxx gui=bold guifg=#d096ae
-- NvimTreeLiveFilterValue xxx gui=bold
-- NvimTreeBookmark xxx guifg=#4fe62d
-- NvimTreeIndentMarker xxx guifg=#8094b4
-- NvimTreeSymlink xxx gui=bold guifg=#b6e519
-- NvimTreeRootFolder xxx guifg=#d096ae
-- NvimTreeExecFile xxx gui=bold guifg=#4fe62d
-- NvimTreeSpecialFile xxx gui=bold,underline guifg=#ea87b0
-- NvimTreeFileIgnored xxx links to NvimTreeGitIgnored
-- NvimTreeGitIgnored xxx links to Comment
-- NvimTreePopup  xxx links to Normal
-- NvimTreeNormal xxx links to Normal
-- NvimTreeStatusLineNC xxx links to StatusLineNC
-- NvimTreeCursorLineNr xxx links to CursorLineNr
-- NvimTreeCursorLine xxx links to CursorLine
-- NvimTreeWinSeparator xxx links to WinSeparator
-- NvimTreeSignColumn xxx links to NvimTreeNormal
-- NvimTreeEndOfBuffer xxx links to EndOfBuffer
-- NvimTreeStatusLine xxx links to StatusLine
-- NvimTreeNormalNC xxx links to NvimTreeNormal
-- NvimTreeLineNr xxx links to LineNr
-- NvimTreeCursorColumn xxx links to CursorColumn
-- NvimTreeFileDirty xxx links to NvimTreeGitDirty
-- NvimTreeFileNew xxx links to NvimTreeGitNew
-- NvimTreeFileRenamed xxx links to NvimTreeGitRenamed
-- NvimTreeFileMerge xxx links to NvimTreeGitMerge
-- NvimTreeFileStaged xxx links to NvimTreeGitStaged
-- NvimTreeFileDeleted xxx links to NvimTreeGitDeleted
-- NvimTreeLspDiagnosticsError xxx links to DiagnosticError
-- NvimTreeLspDiagnosticsWarning xxx links to DiagnosticWarn
-- NvimTreeLspDiagnosticsInformation xxx links to DiagnosticInfo
-- NvimTreeLspDiagnosticsHint xxx links to DiagnosticHint
-- NvimTreeModified xxx guifg=#ff0000 guibg=#00ff00
-- NvimTreeFileIcon xxx cleared
