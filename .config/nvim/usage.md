# Usage

- From <https://github.com/folke/which-key.nvim/blob/main/lua/which-key/plugins/presets/init.lua#L5> except added `gw`/`gf` operators

## OPERATORS

- `!`  = Filter through external program
- `<`  = Indent left
- `>`  = Indent right
- `V`  = Visual Line Mode
- `c`  = Change
- `d`  = Delete
- `gU` = Uppercase
- `gu` = Lowercase
- `gw` = Format text
- `gw` = Wrap text
- `g~` = Toggle case
- `v`  = Visual Character Mode
- `y`  = Yank (copy)
- `zf` = Create fold

## MOTIONS

M.motions = {
  ["h"] = "Left",
  ["j"] = "Down",
  ["k"] = "Up",
  ["l"] = "Right",
  ["w"] = "Next word",
  ["%"] = "Matching character: '()', '{}', '[]'",
  ["b"] = "Previous word",
  ["e"] = "Next end of word",
  ["ge"] = "Previous end of word",
  ["0"] = "Start of line",
  ["^"] = "Start of line (non-blank)",
  ["$"] = "End of line",
  ["f"] = "Move to next char",
  ["F"] = "Move to previous char",
  ["t"] = "Move before next char",
  ["T"] = "Move before previous char",
  ["gg"] = "First line",
  ["G"] = "Last line",
  ["{"] = "Previous empty line",
  ["}"] = "Next empty line",
}

## OBJECTS

M.objects = {
  a = { name = "around" },
  i = { name = "inside" },
  ['a"'] = [[double quoted string]],
  ["a'"] = [[single quoted string]],
  ["a("] = [[same as ab]],
  ["a)"] = [[same as ab]],
  ["a<lt>"] = [[a <> from '<' to the matching '>']],
  ["a>"] = [[same as a<]],
  ["aB"] = [[a Block from [{ to ]} (with brackets)]],
  ["aW"] = [[a WORD (with white space)]],
  ["a["] = [[a [] from '[' to the matching ']']],
  ["a]"] = [[same as a[]],
  ["a`"] = [[string in backticks]],
  ["ab"] = [[a block from [( to ]) (with braces)]],
  ["ap"] = [[a paragraph (with white space)]],
  ["as"] = [[a sentence (with white space)]],
  ["at"] = [[a tag block (with white space)]],
  ["aw"] = [[a word (with white space)]],
  ["a{"] = [[same as aB]],
  ["a}"] = [[same as aB]],
  ['i"'] = [[double quoted string without the quotes]],
  ["i'"] = [[single quoted string without the quotes]],
  ["i("] = [[same as ib]],
  ["i)"] = [[same as ib]],
  ["i<lt>"] = [[inner <> from '<' to the matching '>']],
  ["i>"] = [[same as i<]],
  ["iB"] = [[inner Block from [{ and ]}]],
  ["iW"] = [[inner WORD]],
  ["i["] = [[inner [] from '[' to the matching ']']],
  ["i]"] = [[same as i[]],
  ["i`"] = [[string in backticks without the backticks]],
  ["ib"] = [[inner block from [( to ])]],
  ["ip"] = [[inner paragraph]],
  ["is"] = [[inner sentence]],
  ["it"] = [[inner tag block]],
  ["iw"] = [[inner word]],
  ["i{"] = [[same as iB]],
  ["i}"] = [[same as iB]],
}
