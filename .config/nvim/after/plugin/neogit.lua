if not require("namespace.utils").get_is_installed("neogit") then return end

-- Settings, refer to: https://github.com/TimUntersberger/neogit
require('neogit').setup {
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = true,
  -- The time after which an output console is shown for slow running commands
  console_timeout = 5000,
  -- Automatically show console if a command takes more than console_timeout milliseconds
  -- If don't send to console, get lots of popups
  auto_show_console = true,  -- Setting any section to `false` will make the section not render at all
  sections = {
    untracked = {
      folded = false
    },
    unstaged = {
      folded = false
    },
    staged = {
      folded = false
    },
    stashes = {
      folded = true
    },
    unpulled = {
      folded = true
    },
    unmerged = {
      folded = false
    },
    recent = {
      folded = false
    },
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      -- ["B"] = "BranchPopup",
      -- Removes the default mapping of "s"
      ["o"] = "GoToFile",
      ["S"] = false, -- Stage unstaged changes
      ["<C-s>"] = false, -- Stage Everything
      ["U"] = false, -- Unstage staged changes
      ["L"] = false, -- Use L as Low
      ["Z"] = false, -- Stash
      ["<ESC>"] = "Close", -- Close the status tab page
    }
  }
}

-- COLORS

vim.api.nvim_set_hl(0, 'NeogitNotificationInfo',        { fg = "#80ff80"})
vim.api.nvim_set_hl(0, 'NeogitNotificationWarning',     { fg = "#ffff00"})
vim.api.nvim_set_hl(0, 'NeogitNotificationError',       { fg = "#ff00ff"})

-- vim.api.nvim_set_hl(0, 'NeogitDiffAddHighlight', { link = "DiffAdd"})
-- vim.api.nvim_set_hl(0, 'NeogitDiffDeleteHighlight', { link = "DiffChange"})

vim.api.nvim_set_hl(0, 'NeogitDiffAddHighlight',        { fg = '#80ff80', bg = '#404040' })
vim.api.nvim_set_hl(0, 'NeogitDiffDeleteHighlight',     { fg = '#ff0000', bg = '#404040' })
vim.api.nvim_set_hl(0, 'NeogitDiffContextHighlight',    { fg = '#ffffff', bg = '#404040' })

vim.api.nvim_set_hl(0, 'NeogitHunkHeader',              { fg = '#202020', bg = '#b0b0b0' })
vim.api.nvim_set_hl(0, 'NeogitHunkHeaderHighlight',     { fg = '#202020', bg = '#ffffff' })

-- KEY MAPS TO START NEOGIT
-- Prefer '<leader>i' to '<leader>g' cause can open git review with one hand while drinking water with other
-- Map <leader>g to opening neogit
vim.api.nvim_set_keymap('n', '<leader>i', ":lua require('neogit').open({ kind = 'tab' })<CR>", {noremap = true})

-- This does not work, using for DiffView instead
-- vim.api.nvim_set_keymap('n', '<leader>I', ":lua require('neogit').open({ cwd='/home/michael/.config/' })<CR>", {noremap = true})
