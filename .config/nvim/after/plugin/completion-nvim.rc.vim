" possible value: "length", "length_desc", "alphabet", "none"
let g:completion_sorting = "length_desc"
let g:completion_trigger_keyword_length = 3 " default = 1
let g:completion_items_priority = {
    \ 'Field': 5,
    \ 'Function': 7,
    \ 'Variables': 7,
    \ 'Method': 10,
    \ 'Interfaces': 5,
    \ 'Constant': 5,
    \ 'Class': 5,
    \ 'Keyword': 4,
    \ 'UltiSnips' : 1,
    \ 'vim-vsnip' : 0,
    \ 'Buffers' : 1,
    \ 'TabNine' : 0,
    \ 'File' : 0,
    \}
