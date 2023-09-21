--[[

- If no tag specified, uses a div by default
- li*5

- Use `>` within and `+` sibling 

- E.g. expand this:
div.parent>div.foo-${child-$}*10

- HTML Boiler plate just expand an '!':
!

- If you type `img` then expand (* = cursor position)
<img src="*" alt="">
If you do emmet-move-next:
<img src="" alt="*">

## HTML Examples (abbr/expanded)

header#MAIN.light.big
<header id="MAIN" class="light big"></header>

link
<link rel="stylesheet" href="">

lorem
Amet consectetur pariatur quae dolorum suscipit. Beatae consectetur sint quae nesciunt minima Natus quaerat ducimus ex possimus odio? Ipsa ratione dolor eligendi corporis pariatur. Exercitationem quam delectus minima nihil nobis

lorem3
Elit facilis veniam

p*2>lorem5
<p>Elit consequatur voluptates asperiores cupiditate</p>
<p>Dolor voluptatibus corrupti deserunt assumenda!</p>

## CSS Examples (abbr/expanded)

m16 (only works if within a CSS selector context)
margin: 16px;

## DOCUMENATION

:help emmet-customize-key-mappings

  imap   <C-y>,   <plug>(emmet-expand-abbr)
  imap   <C-y>;   <plug>(emmet-expand-word)
  imap   <C-y>u   <plug>(emmet-update-tag)
  imap   <C-y>d   <plug>(emmet-balance-tag-inward)
  imap   <C-y>D   <plug>(emmet-balance-tag-outward)
  imap   <C-y>n   <plug>(emmet-move-next)
  imap   <C-y>N   <plug>(emmet-move-prev)
  imap   <C-y>i   <plug>(emmet-image-size)
  imap   <C-y>/   <plug>(emmet-toggle-comment)
  imap   <C-y>j   <plug>(emmet-split-join-tag)
  imap   <C-y>k   <plug>(emmet-remove-tag)
  imap   <C-y>a   <plug>(emmet-anchorize-url)
  imap   <C-y>A   <plug>(emmet-anchorize-summary)
  imap   <C-y>m   <plug>(emmet-merge-lines)
  imap   <C-y>c   <plug>(emmet-code-pretty)

]]
vim.keymap.set({"n", "i", "v"}, '<C-k>', "<plug>(emmet-expand-abbr)", { noremap = true })

-- vim.g.user_emmet_expandabbr_key = '<C-y>y'

-- Expand an abbr, e.g. 'div>p#foo$*3>a' and type '<C-y>,'.
-- vim.keymap.set({"n", "i", "v"}, '<C-y>y', "<plug>(emmet-expand-abbr)", { noremap = true })
-- vim.keymap.set({"n", "i", "v"}, '<C-y>w', "<plug>(emmet-expand-word)", { noremap = true })
--[[
-- When you want to expand word except html tokens like below, use this.
-- e.g. <html>foo  ->  <html><foo></foo>
vim.keymap.set("i", '<C-e>w', "<plug>(emmet-expand-word)", { noremap = true })

-- Add attributes using syntax like '.moo' to add the class 'moo'
vim.keymap.set("n", '<C-e>w', "<plug>(emmet-update-tag)", { noremap = true })

-- Wraps each line with abbr
vim.keymap.set("v", '<C-e>', "<plug>(emmet-expand-abbr)", { noremap = true })
]]
