-- Consider using this Grammarly like tool plugin:
-- https://www.vim.org/scripts/script.php?script_id=3223

-- gj and gk automatically controlled via wrap
vim.opt_local.wrap = true

-- Spell checking on
vim.opt_local.spell = true

-- Add spelling words to autocomplete (i_<C-n> i_<C-p>)
vim.opt_local.complete:append('kspell')

-- Add dash to word chars
vim.opt_local.iskeyword:append('-')
