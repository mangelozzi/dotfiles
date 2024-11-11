--[[

:help ins-special-keys

# NATIVE INSERT MODE

Exist Insert mode
    <Esc> Exit insert mode and return to normal mode.
    <C-[> Exit insert mode and return to normal mode.
    <C-C> Exit insert mode and return to normal mode (without triggering any autocommands).

Editing:
    <C-H> Move the cursor one character to the left (equivalent to Backspace).
    <C-U> Delete all text from the cursor to the beginning of the line.
    <C-J> Enter
    <C-M> Enter
    <C-W> Delete the word before the cursor.

Indentation:
    <C-T> Increase the indent of the current line or selected lines in insert mode.
    <C-D> Decrease the indent of the current line or selected lines in insert mode.
    0<C-D> Delete all indent in the cursor line

Insert Special Characters:
    <C-V> Insert the next non-digit character literally (useful for inserting control characters).
    <C-R>{register}: Insert the contents of a register.
    <C-R><C-R>{register}: Same as <C-R> but inserted literally (not as if text is typed).
    <C-R><C-O>{register}: Same as <C-R><C-R> but dont auto indent
    <C-R><C-O>{register}: Same as <C-R><C-R> but fix indent

Normal Mode Command:
    <C-O> Temporarily enter normal mode to execute one command, then return to insert mode.

Auto complete:
    <C-N> Auto-complete the word in insert mode using keywords in the current file.
    <C-P> Auto-complete the word in insert mode using keywords in the current file (previous match).

Insertion:
    <insert> toggle between insert and replace mode.
    <C-Y> Insert the character which is above the cursor.
    <C-E> Insert the character which is below the cursor.

Special Functions:
    <C-X> Enter CTRL-X mode
--]]

-- like terminal kill to end of line
vim.keymap.set("i", '<C-K>', "<Esc>lDa", { noremap = true, desc ="Kill until end of line" })

-- like terminal goto line start (not column 0)
vim.keymap.set("i", '<C-A>', "<Esc>^i", { noremap = true, desc ="Jump to line start" })

-- Add a short divider `---`
-- vim.keymap.set("i", '<C-B>', "---", { noremap = true, desc ="(b)locky - short divider" })


-- like terminal goto line start (not column 0)
-- Default <C-L> is same as <C-P> for: Completing whole lines					*compl-whole-line*
vim.keymap.set("i", '<C-L>', "<C-O><Del>", { noremap = true, desc ="Insert mode delete" })

vim.keymap.set("i", '<C-H>', "<Left>",  { noremap = true, desc ="Right" })
vim.keymap.set("i", '<C-J>', "<Down>",  { noremap = true, desc ="Down" })
vim.keymap.set("i", '<C-K>', "<Up>",    { noremap = true, desc ="Up" })
vim.keymap.set("i", '<C-L>', "<Right>", { noremap = true, desc ="Right" })

vim.keymap.set("i", '<C-B>', "<Bs>",    { noremap = true, desc ="(b)ackspace" })
vim.keymap.set("i", '<C-D>', "<Del>",   { noremap = true, desc ="(d)elete" })

vim.keymap.set("i", '<C-V>', '<C-r>+',   { noremap = true, desc ="paste (insert mode)" })
vim.keymap.set("i", '<C-Q>', '<C-v>',    { noremap = true, desc ="Insert literally, (used to be ctrl+v)" })
