if not require("namespace.utils").get_is_installed("nvim-toggler") then return end
-- https://github.com/nguyenvukhang/nvim-toggler/issues/14
require('nvim-toggler').setup({
  -- your own inverses
  inverses = {
    ['true'] = 'false',
    ['True'] = 'False',
    ['TRUE'] = 'FALSE',
    ['yes'] = 'no',
    ['Yes'] = 'No',
    ['YES'] = 'NO',
    ['on'] = 'off',
    ['On'] = 'Off',
    ['ON'] = 'OFF',
    ['add'] = 'remove',
    ['setAttribute'] = 'removeAttribute',
    ['left'] = 'right',
    ['up'] = 'down',
    ['!='] = '==',
    ['!=='] = '===',
    ['black'] = 'white',
    ['Black'] = 'White',
    ['BLACK'] = 'WHITE',
    ['primary-4black'] = 'primary-4white',
    ['primary_4black'] = 'primary_4white',
    ['secondary-4black'] = 'secondary-4white',
    ['secondary_4black'] = 'secondary_4white',
    ['gray-4black'] = 'gray-4white',
    ['gray_4black'] = 'gray_4white',
    ['green-4black'] = 'green-4white',
    ['green_4black'] = 'green_4white',
    ['red-4black'] = 'red-4white',
    ['red_4black'] = 'red_4white',
    ['blue-4black'] = 'blue-4white',
    ['blue_4black'] = 'blue_4white',
  },
  -- removes the default <leader>i keymap
  remove_default_keybinds = true,
})

vim.keymap.set({"n", "x"}, "<leader>t", require('nvim-toggler').toggle, {noremap = true})
