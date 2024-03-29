-- :help lua-vim-options
-- vim.opt_local for buffer local options

-- COLORS
-- vim.opt.background = "dark"
vim.opt.termguicolors = true

-- vim.opt.guicursor = ""
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver50,r-cr-o:hor25"
vim.opt.mousemodel = "extend"

-- CRITICAL
vim.opt.compatible = false      -- Must be first command. Enter the current millenium. Not required for Neovim.
vim.opt.hidden = true           -- Allows one to reuse the same window and switch without saving
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- GENERAL
vim.opt.colorcolumn = "80"      -- Colour a certain column, helps to see when one goes over 80 chars.
vim.opt.history = 10000         -- NeoVim 10000. Number of previous commands remembered.
vim.opt.inccommand = "split"    -- Neovim - See a live preview of :substitute as you type.
vim.opt.scrolloff = 4           -- When doing a search etc, always show at least n lines above and below the match
vim.opt.sidescroll = 15         -- Minimum number of columns to jump when scroll horizontall
vim.opt.sidescrolloff = 15      -- Minimum number of columns to show when going through searches (or else just see the first char on a long line like this)
vim.opt.numberwidth = 4         -- Default number column width
vim.opt.mousefocus = true       --
vim.opt.startofline = false     -- Stop certain movements going to start of line (more like modern editors)
vim.opt.wrap = false            -- Disable word wrapping
vim.opt.showcmd = true          -- Show partial commands in the last line of the screen
vim.opt.showmatch = true        -- = true bracket is inserted, briefly jump to the matching one.
vim.opt.matchtime = 3           -- 1/10ths of a second for which showmatch applies to matching a bracket
vim.opt.foldlevelstart = 99     -- How many level to show before folding. 99=zR, 0=zM
vim.opt.iskeyword:append('-')   -- Add '-' as a keyword for all filetypes

-- NOT GENERAL (i.e. for Servers)
vim.opt.list = false            -- Dont show spaces/tabs/newlines etc
vim.opt.modeline = false        -- Modelines are vimscript snippets in normal files which vim interprets, e.g. `ex:`
vim.opt.undolevels = 3000       -- Default 1000.
-- Do not show "match xx of xx and other messages during auto-completion
vim.opt.shortmess:append("c")
-- vim.opt.shortmess = vim.opt.shortmess + "c"
-- Do show echom messages during file manipulation and autocmd (like default Vim, see Neovim FAQ)
vim.opt.shortmess:remove { "F" }
vim.opt.virtualedit = "block"   -- Virtual edit is useful for visual block edit
vim.opt.joinspaces = false      -- Do not add two space after a period when joining lines or formatting texts, see https://tinyurl.com/y3yy9kov
vim.opt.synmaxcol = 500         -- Text after this column number is not highlighted
vim.opt.cursorline = true       -- High lights the line number and cusor line
-- vim.opt.timeoutlen = 1000    -- Timeout for a hotkey mapping, default is 1000ms
vim.opt.swapfile = false        -- Disable creating swapfiles, see https://goo.gl/FA6m6h

-- 'backup' 'writebackup'	action	 
--    off	     off	no backup made
--    off	     on		backup current file, deleted afterwards (DEFAULT)
--    on	     off	delete old backup, backup current file
--    on	     on		delete old backup, backup current file
vim.opt.backup = false
vim.opt.writebackup = true

-- set noshowmode               -- Disables showing which mode one is in (does not giveback any more space cause I use 2 lines for the command area)

-- Disable auto wrap lines, auto insert comment leader, other stupid magic
vim.opt.formatoptions:remove { "f", "c", "r", "o" }

-- Show white space chars. extends and precedes is for when word wrap is off
-- Get shapes from here https://www.copypastecharacter.com/graphic-shapes
vim.opt.listchars = "eol:$,tab:←‒→,trail:▪,extends:▶,precedes:◀,space:·"

-- UNSET
vim.opt.cmdheight = 2            -- Set the command bar height to 2 lines, fixed with ginit GuiTabline 0
-- vim.opt.swapfiles = false     -- Disable making swap files to indicate file is open.
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true       -- Persistent undo even after you close a file and re-open it
vim.opt.showmode = true          -- Do show mode in command window area, e.g. `-- INSERT --`
-- vim.opt.switchbuf = "usetab,newtab" -- Control how QUICKFIX ONLY window links are opened are handled and :sb
-- vim.opt.winaltkeys = "menu"   -- Default value, if a ALT+... hotkey is pressed, first let windowing system handle it, if not then vim will try
-- vim.opt.winblend = 30         -- Enables pseudo-transparency for a floating window.
-- vim.opt.splitbelow = true     -- Splitting a window will put the new window below the current one.
-- vim.opt.splitright = true     -- Splitting a window will put the new window right of the current one

-- FINDING FILES
-- Use with wild menu
vim.opt.path:append { "**" }

-- WILD COMPLETION
vim.opt.wildmenu = true         -- Better command-line completion
-- The parts (stages) in completion:
--     1. longest  =  Complete until longest common string
--     2. Next tab full  =  statusline selectable options
-- vim.opt.wildmode = longest,full
-- NOTE! This value is OVERRIDDEN in myplugins.vim, see: https://github.com/nvim-lua/completion-nvim/issues/235
vim.opt.wildmode = "longest:full,full"

-- Ignore certain files and folders when globbing
vim.opt.wildignore = "*.pyc,*.zip,package-lock.json"
vim.opt.wildignore:append {"**/spike/**", "**/ignore/**", "**/temp/static/**"}
vim.opt.wildignore:append {"**/venv/**", "**/node_modules/**", "**/.git/**"}
vim.opt.pumblend = 10           -- Transparency of Pop Up Menu, 0=solid, 100=Fully Transparent

vim.opt.complete = ".,w,b,]"  -- Default auto complete, but exclude unloaded buffers
-- vim.opt.completeopt:remove { "preview" } -- Turn off annoying vsplit top preview window
-- Can vim.opt.'completeopt' to have a better completion experience
-- Refer to init file, and waiting for https://github.com/nvim-lua/completion-nvim/issues/235
vim.opt.completeopt = "menuone,noinsert,noselect"

-- SEARCHING
vim.opt.ignorecase = true       -- Use case insensitive search...
vim.opt.smartcase = true        -- ...except when using capital letters
vim.opt.wrapscan = true         -- search-next wraps back to start of file (default with neovim)
vim.opt.incsearch = true        -- Start highlighting partial match as start typing
vim.opt.hlsearch = true         -- Highlight searches, use :noh to turn off residual highlightin

-- WRAPPED LINES
vim.opt.linebreak = true        -- wrap at word breaks
vim.opt.showbreak = "↪"         -- show an ellipsis at the start of wrapped lines

-- IDENTATION
vim.opt.autoindent = true       -- When opening a new line keep indentation
vim.opt.smartindent = false     -- Testing it
vim.opt.indentexpr = ""
vim.opt.shiftround = true       -- Round indent to multiple of 'shiftwidth'. Applies to > and < commands. CTRL-T and CTRL-D in insert mode always round to a multiple of shiftwidths.

-- COPY PASTE
-- In Linux there are multiple clipboard like buffers called selections:
--   The PRIMARY (*) selection is updated every time you select text. To paste from it (in graphical programs), middle-click or use ShiftInsert. In Vim, it is accessible through the "* register.
--   The CLIPBOARD (+) selection is updated when you explicitly cut or copy anything (text or other data). In other words, it is used just like the Windows or Mac OS clipboards. To paste from it, the usual shortcut is CtrlV in grapical programs. In Vim, it is accessible through the "+ register. In Windows:
--   * is the system clipboard
--   + is NOT the system clipboard
--
-- vim.opt.clipboard = 'unnamed' -- Use "* for all yank, delete, change and put operations which would normally go to the unnamed register.
vim.opt.clipboard:append {'unnamedplus'} -- Use "+ for all yank, delete, change and put operations which would normally go to the unnamed register.


-- WORD TOOLS
-- Specify the spelling language, have to use `:vim.opt.spell` to enable it.
-- :vim.opt.spell` is set in ftplugin to enable spell checking
vim.opt.spelllang = "en_gb"

-- GUI COMPUTER
-- Sets selectmode, mousemodel, keymodel, and selection
vim.opt.mouse = 'a'             -- Enable use of the mouse for all modes
vim.opt.number = true           -- Display line numbers in the left margin (sucks for copy pasting on servers)
vim.opt.relativenumber = not vim.o.diff   -- Use relative line number in margin if not in diff mode
vim.opt.signcolumn = "yes:1"   -- "auto", a number of cols, "yes" or "no"

vim.opt.thesaurus:append {vim.g.nvim_path .. '/thesaurus/english.txt'}

