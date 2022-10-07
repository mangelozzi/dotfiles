" {{{1 DOCSTRING
" If get error ould not read Username for ... probably type the plugin name wrong

" TO TRY
" prettier handles js html json css scss etc: https://github.com/prettier/vim-prettier
" neoformat to replace own formatting: https://github.com/sbdchd/neoformat
" dkarter / bullets.vim (automated bullets in .md etc)
" bps/vim-textobj-python
" LOOK AWESOME!!! https://github.com/iamcco/markdown-preview.nvim
" https://github.com/janko/vim-test
" https://github.com/EinfachToll/DidYouMean
" https://github.com/justinmk/vim-sneak
" https://github.com/tpope/vim-repeat
" https://github.com/simnalamburt/vim-mundo
" Indicator for what was yanked
" Plug 'machakann/vim-highlightedyank'

" Aligning stuff
" Plug 'junegunn/vim-easy-align'

" ABANDONDED - Autocomplete
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Plug 'carlitux/deoplete-ternjs'
" Plug 'davidhalter/jedi-vim'
" Plug 'preservim/nerdcommenter'
" Plug 'neomake/neomake'

" {{{1 PLUGINS
" Vim-plug installation
"   Step 1. Download https://github.com/junegunn/vim-plug -> plug.vim
"   Step 2. Place vim.plug in C:\Users\Michael\AppData\Local\nvim\autoload\
"               Note: E:\Dropbox\Software\neovim\nvim\ is symlinked to C:\Users\Michael\AppData\Local\nvim\
"   Step 3. Run the command --> :PlugInstall


" Using linux app image we dont have access to $VIM
let plugdir = fnamemodify($MYVIMRC, ":p:h") . "/tmp/vim-plug"
call plug#begin(plugdir)
"call plug#begin('$VIM\vim-plug')
" Only place plug items within here or else can get weird errors with some packages

" Plug own plugin at nvim/tmp/nvim-rgflow.lua
let rgflow_local = fnamemodify($MYVIMRC, ":p:h")."/tmp/nvim-rgflow.lua"
Plug rgflow_local

" Plug own plugin at nvim/tmp/vim-wsl
let wsl_local = fnamemodify($MYVIMRC, ":p:h")."/tmp/vim-wsl"
Plug wsl_local

" Plug own plugin at nvim/tmp/vim-capesky
let capesky_local = fnamemodify($MYVIMRC, ":p:h")."/tmp/vim-capesky"
Plug capesky_local

" {{{2 OPERATOR + MOTION + TEXT-OBJECT = AWESOME
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'numToStr/Comment.nvim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/ReplaceWithRegister'
" xml attributes with x
Plug 'kana/vim-textobj-user' | Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'christoomey/vim-titlecase'
" Require it here before plug loads
let g:titlecase_map_keys = 0

" {{{2 SMALL MISC
Plug 'tpope/vim-unimpaired'
Plug 'AndrewRadev/bufferize.vim'
Plug 'osyo-manga/vim-brightest'
" Plug 'stefandtw/quickfix-reflector.vim' " BAD!! make qf window modifiable,
" maybe messes up quickfix colors
" Allows one to easily align text
Plug 'junegunn/vim-easy-align'

" {{{2 COLOR RELATED
Plug 'norcalli/nvim-colorizer.lua'
Plug 'pangloss/vim-javascript'

" codeschool.nvim
" Plug 'rktjmp/lush.nvim'
" Plug 'adisen99/codeschool.nvim'

" Plug 'zefei/vim-colortuner'
"------------------------------------------------------------------
" {{{2 SPELLCHECK EXTRAS
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-SpellCheck'

" {{{2 GIT
Plug 'nvim-lua/plenary.nvim'
Plug 'TimUntersberger/neogit'

" {{{2 FZF
" let fzfdir = fnamemodify($MYVIMRC, ":p:h") . "/tmp/fzf"
" Plug 'junegunn/fzf', { 'dir': fzfdir, 'do': './install --all' }
" Install FZF via scoop
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" {{{2 TREE BROWSER
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
" TODO: Could replace syntax tree highligthing with this:
" https://github.com/preservim/nerdtree/issues/433#issuecomment-92590696
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'kshenoy/vim-signature', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}
" Make NERDtree error Plug 'Xuyuanp/nerdtree-git-plugin'

" {{{2 Python
" Plug 'tmhedberg/SimpylFold'

" {{{2 LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
" Plug 'glepnir/lspsaga.nvim'

" {{{2 Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" {{{2 Always load the vim-devicons as the very last one.
Plug 'ryanoasis/vim-devicons', { 'on': ['NERDTreeToggle', 'NERDTreeFind']}

call plug#end()
" WARNING: https://github.com/junegunn/vim-plug/issues/379
" vim plug turn on filetype indentation afteritself
filetype indent off

" {{{2 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 0 " Preview docstring in fold text  0
let g:SimpylFold_fold_docstring    = 0 " Fold docstrings 1
let g:SimpylFold_fold_import       = 0 " Fold imports    1


" {{{2 vim-multiple-cursors
"   https://github.com/terryma/vim-multiple-cursors
"   Multicursor support
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" {{{2 inkarkat/vim-SpellCheck
" Can see a list of mispelt word with: :[range]SpellCheck

" {{{2 stefandtw/quickfix-reflector.vim
" Allows one to make changes directly in the quickfix window, also breaks rgflow

