-- Insert django style {% tag %}
-- <C-m> = <CR>
vim.keymap.set("i", '<M-b>', "{%  %}<Esc>hhi", { noremap = true, desc ="Django (B)lock" })
vim.keymap.set("i", '<M-c>', "{#  #}<Esc>hhi", { noremap = true, desc ="Django (C)omment" })
vim.keymap.set("i", '<M-v>', "{{  }}<Esc>hhi", { noremap = true, desc ="Django (V)ariable" })
