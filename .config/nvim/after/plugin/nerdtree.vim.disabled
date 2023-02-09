"   See :help NERDTree
"   https://github.com/preservim/nerdtree
"   https://jdhao.github.io/2018/09/10/nerdtree_usage/
"   Hotkeys:
"     ? = show help on commands
"     u = up a level
"     c = change CWD to select dir
"     O / X = Open/Close recursively
"     J / K = Move to first/last nodes
"     ^J / ^K = Move to next/previous nodes on same level

" Show NERDTree at CWD
nnoremap <leader>nn :NERDTreeToggle<CR>

" Find file and show within CWD
nnoremap <leader>nf :NERDTreeFind<CR>

" Change NERDTree Browse - Open.browse to current buffer dir
nnoremap <leader>nd :NERDTreeToggle %:p:h<CR>

" Use `o` to open file and keep NERDTree pane.
" let NERDTreeMapActivateNode = 'o' " Default is 'o'
let NERDTreeQuitOnOpen = 0
" Use `<CR>` to open file and close NERDTree pane.
let NERDTreeMapCustomOpen = "<F13>" " Default <CR>, disabled temp cause keep hitting it
let NERDTreeCustomOpenArgs = {'file': {'where': 'p', 'keepopen':0, 'stay':0}}

" Automatically close a tab if the only remaining window is NerdTree
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif
" Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" Show hidden/dot files
" let NERDTreeShowHidden=1

" Just remember to press ? for help
let NERDTreeMinimalUI = 1

" the ignore patterns are regular expression strings and seprated by comma
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']
let g:NERDTreeDirArrowExpandable = "+"
let g:NERDTreeDirArrowCollapsible = "-"

" Highlight full name (not only icons). You need to add this if you don't have vim-devicons and want highlight.
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" Show hidden files
let NERDTreeShowHidden=1

" Map Help to H1, so can use reverse search on '?'
let NERDTreeMapHelp="<F1>"
