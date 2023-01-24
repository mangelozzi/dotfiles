local neogit = require('neogit')

-- Map <leader>g to opening neogit
vim.api.nvim_set_keymap('n', '<leader>i', ":lua require('neogit').open({ kind = 'tab' })<CR>", {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>I', ":lua require('neogit').open({ cwd='/home/michael/.config/' })<CR>", {noremap = true})

-- Settings, refer to: https://github.com/TimUntersberger/neogit
neogit.setup {
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = true,
  -- Setting any section to `false` will make the section not render at all
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
      ["S"] = "", -- Stage all
      ["U"] = "", -- Unstage all
      ["L"] = "", -- Use L as Low
      ["Z"] = "", -- Stash
    }
  }
}



