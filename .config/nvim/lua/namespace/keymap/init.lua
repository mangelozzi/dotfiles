--[[

NOTE: still have <CR> to use as a second leader

Hotkeys related to plugins are placed within those plugins configuration files.

Currently leader in nmap:
    ! = Dont recommend using c/d, cause easy to start deleting things by mistake fast
    a, b, !c, !d, e, m, o, p, q, u, v, x
    A, B, C, E, F, G, H, L, M, N, O, P, R, S, T, U, V, W, X, Y, Z
    0
    !@#$%^&*()_+
    []{}|\;,<>?

Example
vim.keymap.set("n", "<leader>a", ":Git blame<cr>", { noremap = true })
Multiple modes like this:
vim.keymap.set({"n", "x", "s"}, "<leader>a", ":Git blame<cr>", { noremap = true })

nvim_set_keymap - global mapping
nvim_buf_set_keymap - set a buffer-local mapping

Can show a list of mappings with :map
Useful to check no leader clashes
Note!!! Comments on a separate line.
CTRL (^) maps lower and uppercase to same key (by convention use lowercase)
Meta (M-?) can map lower and upper case words)

Practically available/free hotkeys
  Q (Ex mode) -> MAPPED: ^
  Z (First half of quick exit)
  ^c (Aborts pending command) (not good when SSH'ing)
  ^k -> MAPPED: Switch window
  ^l (small L, redraw screen) -> MAPPED: Switch window
  ^q (XON)
  ^s (XOFF) -> MAPPED: :save
  ,  (repeat last line search, reversing direct)
  # (always use *)

LEADER -> aeghijmqtuvwxy (g for git one day)
  j  - Comment, mneomoic (Jargon)
  k  - replace with register
  kk - replace with register line
  K  - replace with regsiter to end of line

Decided not to use Select mode
n - Normal Mode
o - Operator pending, e.g. "d..." waits for what to delete
c - Command mode
x - Visual mode
s - Select mode
v - Both visual and select mode
Map - Normal, visual, select, and operator pending
Map! - Insert & command mode

v = select and visual mode, x = visual, s = select (mouse)
s mode = allows one to select with the mouse, then type any printable
         character to replace the selection and start typing. Unfortunately
         this means any hotkeys setup in v-mode will override which keys
         actually perform this behaviour.
         DECISION: Ignore select mode, use c to change a selection. Map
                   hotkeys in v-mode so same behaviour if using the mouse or
                   keyboard to make a selection.

Comment code with built in 'gc'
--]]

-- If one pressed <leader>dd and its not mapped to anything, then it performs a `dd`... yikes, map all <leader>?? to <nop>
require("namespace.utils").map_leader_char_to_nop()

require("namespace.keymap.code")
require("namespace.keymap.command")
require("namespace.keymap.custom")
require("namespace.keymap.func")
require("namespace.keymap.leader")
require("namespace.keymap.talk")
