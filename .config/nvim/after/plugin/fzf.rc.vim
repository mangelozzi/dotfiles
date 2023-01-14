" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=20m10s
" To search within a dir `:FZF [dir] <CR>`

" if has('win32') || has('win64')
"     " If installed using Homebrew
"     set rtp+=$HOME\scoop\apps\fzf\current
" else
"     " set rtp+= I dont know
" end
let $FZF_DEFAULT_OPTS='--bind ctrl-a:select-all'

"let $FZF_DEFAULT_COMMAND='rg --files . 2> nul'
" by default uses .gitignore files, but sometimes whish to find files in
" .gitignore
" let $FZF_DEFAULT_COMMAND='fdfind --type file --hidden'
" -e = extension, e.g. fd -e 'svg' -e 'html'
" -E = exclude extension, e.g. fd -E '*.py' -E '*.svg'
" --hidden = Search hidden files (for dot config files)
" Refer to: https://github.com/sharkdp/fd#excluding-specific-files-or-directories
" htmlcov = python unittest coverage reports
let $FZF_DEFAULT_COMMAND="fdfind --type file --no-ignore -E '*__pycache__*' -E '*.jpg' -E '*.png' -E '*.zip' -E 'spike/*' -E '*.git' -E '*.svg' -E '*.min.css' -E '**/htmlcov/*'"

" Don't abort the function, so if no match is found, its communicates it.
nnoremap <silent> <leader>zn :copen<CR> :call clearmatches()<CR>

" https://www.youtube.com/watch?v=fP_ckZ30gbs&t=21m42s
" CTRL+P and CTRL+N previous/next file
" TAB /SHIFT TAB to toggle marking
" CTRL+A to select all matches
" <ENTER> open all marked files in a quickfix window
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }
" When aborting fzf in Neovim, <Esc> does not work, so fix it:
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"


" Allow passing optional flags into the Rg command.
"   Example: :Rg foo -g '*.py'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

" Files
" FZF in Open buffers
nnoremap <silent> <leader><leader> :call myal#FZFOpen(":Buffers")<CR>

" FZF Search for Files
nnoremap <silent> <leader>f :call myal#FZFOpen(":Files")<CR>

" FZF Search for Files in home dir
nnoremap <silent> <leader>~ :call myal#FZFOpen(":Files ~")<CR>

" FZF Search for Files in dir one up
nnoremap <silent> <leader>. :call myal#FZFOpen(":Files ..")<CR>

" FZF Search for previous opened Files
nnoremap <silent> <leader>zh :call myal#FZFOpen(":History")<CR>

" FZF in Git files
nnoremap <silent> <leader>zg :call myal#FZFOpen(":GFiles")<CR>

" FZF in Lines in loaded buffers
nnoremap <silent> <leader>zl :call myal#FZFOpen(":Lines")<CR>

" FZF in Lines in the current buffer
nnoremap <silent> <leader>zb :call myal#FZFOpen(":BLines")<CR>

" Normal mode mappings
nnoremap <silent> <leader>zm :call myal#FZFOpen(":Maps")<CR>

" Map to FZF command, so one can type commands interactively before enter.
nnoremap <leader>zz :FZF<Space>

" Map to Rg command, so one can type commands interactively before enter.
" TODO Dont use this
nnoremap <leader>zr :Rg<Space>HighlightSearchTerm<CR>


let g:fzf_colors =
            \ { 'fg':    ['fg', '_FzfNormal'],
            \ 'bg':      ['bg', '_FzfNormal'],
            \ 'hl':      ['fg', '_FzfHl'],
            \ 'fg+':     ['fg', '_FzfPlus'],
            \ 'bg+':     ['bg', '_FzfPlus'],
            \ 'hl+':     ['fg', '_FzfHlPlus'],
            \ 'info':    ['fg', '_FzfInfo'],
            \ 'border':  ['fg', '_FzfBorder'],
            \ 'prompt':  ['fg', '_FzfPrompt'],
            \ 'pointer': ['fg', '_FzfPointer'],
            \ 'marker':  ['fg', '_FzfMarker'],
            \ 'spinner': ['fg', '_FzfSpinner'],
            \ 'header':  ['fg', '_FzfHeader']}

" Set the FZF status line
augroup Fzf_Status_Line
    autocmd!
    autocmd User FzfStatusLine setlocal statusline=%#_FzfStatusChevron#\ >\ %#_fzfStatus#fzf
augroup END

" Switch from any fzf mode to :Files on the fly and transfer the search query.
function! s:FzfFallback()
    if &filetype != 'FZF'
        return
    endif
    " Extract from first space to cursor position of previous fzf buffer prompt
    let query = getline('.')[stridx(getline('.'), ' ') : col('.') - 1]
    close
    sleep 1m
    call fzf#vim#files('.', {'options': ['-q', query]})
endfunction
tnoremap <c-space> <c-\><c-n>c:call <sid>FzfFallback()<cr>
